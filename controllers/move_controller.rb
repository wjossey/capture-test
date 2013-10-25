class MoveController < ApplicationController
  def index
    #Inputs Location
    #N:, E:, S:, W:
    @location = JSON.parse(params["data"]).symbolize_keys!
    @location.symbolize_keys!
    Rails.logger.info "Params is:::: #{@location}"

    render :json => {team:"4", nextCommand:"#{move}"}
  end

private 
  def move
    if @location[:x] > 0
      x_intent = -1
    elsif @location[:x] < 0
      x_intent = 1
    else
      x_intent = (rand * 10) - 5
    end

    if @location[:y] > 0
      y_intent = -1
    elsif @location[:y] < 0
      y_intent = +1
    else
      y_intent = (rand * 10) - 5
    end

    Rails.logger.info "Y INTENT: #{y_intent}"

    tiles = @location.except(:x, :y, :hp)
    Rails.logger.info "Tiles::: #{tiles}"
    lonely_move = tiles.select { |k,v| !%w{OOB WALL}.include?(v)  }

    Rails.logger.info "Lonely move: #{lonely_move}"
    Rails.logger.info "X intent: #{x_intent}"
    if lonely_move.length == 1
      Rails.logger.info "I'M IN THE LONELY INTENT"
      return lonely_move.keys.first.to_s
    end

    if x_intent && rand(2) > 0
      if x_intent > 0 && !%w{OOB WALL}.include?(@location[:E])
        return move_right
      elsif y_intent > 0 && !%w{OOB WALL}.include?(@location[:N])
        return move_up
      elsif y_intent < 0 && !%w{OOB WALL}.include?(@location[:S])
        return move_down
      elsif x_intent < 0 && !%w{OOB WALL}.include?(@location[:W])
        return move_left
      end
    end
    if y_intent > 0 && !%w{OOB WALL}.include?(@location[:N])
      return move_up
    elsif x_intent > 0 && !%w{OOB WALL}.include?(@location[:E])
      return move_up
    elsif x_intent < 0 && !%w{OOB WALL}.include?(@location[:W])
      return move_down
    elsif y_intent < 0 && !%w{OOB WALL}.include?(@location[:S])
      return move_down
    end

    return lonely_move.keys.shuffle.first
  end

  def move_up
    "N"
  end

  def move_down
    "S"
  end

  def move_left
    "W"
  end

  def move_right
    "E"
  end

end


# def move
#     if params[:location][:x] > 0
#       x_intent = -1
#     elsif params[:location][:x] < 0
#       x_intent = 1
#     else
#       x_intent = (rand * 10) - 5
#     end


#     if params[:location][:y] > 0
#       y_intent = -1
#     elsif params[:location][:y] < 0
#       y_intent = +1
#     else
#       y_intent = (rand * 10) - 5
#     end


#     if lonely_move = params[:location].select { |k,v| !%w{OOB WALL}.include?(v) }.length == 1
#       return lonely_move.keys.first.to_s
#     end

#     if x_intent && rand(2)
#       if x_intent > 0 && !%w{OOB WALL}.include?(params[:E])
#         return move_right
#       elsif y_intent > 0 && !%w{OOB WALL}.include?(params[:N])
#         return move_up
#       elsif y_intent < 0 && !%w{OOB WALL}.include?(params[:S])
#         return move_down
#       elsif x_intent < 0 !%w{OOB WALL}.include?(params[:S])
#         return move_left
#       end
#     end
#     if y_intent > 0 && !%w{OOB WALL}.include?(params[:N])
#       return move_up
#     elsif y_intent > 0 && !%w{OOB WALL}.include?(params[:N])
#       return move_up
#     elsif y_intent < 0 && !%w{OOB WALL}.include?(params[:S])
#       return move_down
#     elsif y_intent < 0 && !%w{OOB WALL}.include?(params[:S])
#       return move_down
#     end
#   end

#   def move_up
#     "N"
#   end

#   def move_down
#     "S"
#   end

#   def move_left
#     "W"
#   end

#   def move_right
#     "E"
#   end








#37 x 37

#-18x,0,+18



# def index
#     return render :json => {"team":4,"nextCommand":"#{move}"}
#   end

#   def move
#     if params[:location][:x] > 0
#       x_intent = -1
#     elsif params[:location][:x] < 0
#       x_intent = 1
#     else # it is 0
#       x_intent = nil
#     end


#     if params[:location][:y] > 0
#       y_intent = -1
#     elsif params[:location][:y] < 0
#       y_intent = +1
#     else # it is 0
#       # delegate to x action
#     end

#     if x_intent && x_intent > y_intent
#       if x_intent > 0 && !%w{OOB WALL}.include?(params[:E])
#         move_right
#       elsif y_intent > 0 && !%w{OOB WALL}.include?(params[:N])
#         move_up
#       elsif y_intent < 0 && !%w{OOB WALL}.include?(params[:S])
#         move_down
#       else
#         move_left
#       end
#     elsif y_intent > 0 && !%w{OOB WALL}.include?(params[:N])
#       move_up
#     elsif y_intent < 0 && !%w{OOB WALL}.include?(params[:S])
#       move_down
#     end
#   end

#   def move_up
#     "N"
#   end

#   def move_down
#     "S"
#   end

#   def move_left
#     "W"
#   end

#   def move_right
#     "E"
#   end