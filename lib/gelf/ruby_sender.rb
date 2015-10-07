module GELF
  # Plain Ruby UDP sender.
  class RubyUdpSender
    attr_accessor :addresses

    def initialize(addresses)
      @addresses = addresses
      @i = 0
      @socket = UDPSocket.open
    end

    def send_datagrams(datagrams)
      host, port = @addresses[@i]
      @i = (@i + 1) % @addresses.length
      datagrams.each do |datagram|
        socket = Thread.current[:gelf_socket] ||= UDPSocket.open
        socket.send(datagram, 0, host, port)
      end
    end

    def close
      @socket.close
    end
  end
end
