# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
#######################################################################################

# Database schema - this should reflect your domain model

# New domain model - adds users
DB.create_table! :events do
  primary_key :id
  String :title
  String :description, text: true
  String :body, text: true
  String :date
  String :location
  String :currency
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :event_id
  foreign_key :user_id
  Boolean :going
  String :comments, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
events_table = DB.from(:events)

events_table.insert(title: "Paris", 
                    description: "The most romantic trip we've ever experienced!",
                    body: "Paris has long been considered one of the world’s most romantic cities. In the evenings, streetlights reflect off the white limestone buildings radiating blues, pinks, and purples. Cobblestone streets coupled with the illuminated Eiffel Tower in the city’s backdrop is categorically Paris. Surveying the thousands of masterpieces housed at the Louvre on its own is enough to keep anyone busy. However, Paris has much more to offer tourists. Take the pilgrimage to Cathedrale Notre-Dame and enjoy a stroll through some of Paris’ immaculately landscaped gardens. Afterwards, waste part of the day people watching at one of the many cafés in town. In the evening, visit one of the city’s celebrated restaurants and taste the pâté. Afterwards, take in a show at the famed Moulin Rouge. You’ll be hard pressed not to keep busy while in Paris. Paris is awe inspiring and eye opening. You’ll leave Paris with a sense of enlightenment not soon to be forgotten.Paris is awe inspiring and eye opening. You’ll leave Paris with a sense of enlightenment not soon to be forgotten.",
                    date: "2013",
                    location: "Paris, France",
                    currency: "Euro")

events_table.insert(title: "Bangkok", 
                    description: "The most eventful trip we've ever experienced!",
                    body: "Serenity, peace and spirituality are words to describe the beautiful and rich country of Thailand. With its lush and vibrant countryside, to the hustle of the capital city, Thailand is an exciting and at the same time relaxing tourist destination. You can find a variety of travel deals on the Expedia website. Take a trip to Bangkok with its outdoor markets and delicious smells and visit the Royal Palace, an awe-inspiring architecture of massive proportions. Be sure not to miss out on the Reclining Buddha or the spirituality of the Buddhist monks roaming about the city. They are friendly and will love to speak to you about their lifestyle and love for their country. Bangkok at night is full of energy and vigor. Sit outdoors and eat some wonderful, aromatic Pad Thai before heading out to the beauty and massage parlors for some extremely inexpensive facials, manicures and of course, the infamous Thai massage—you will be stretched out more than any Yoga class you can take. For those wishing a tropical vacation of sitting around the beach and doing absolutely nothing, head to one of Thailand’s popular islands--maybe a week in Phuket where you will just let the sand slip between the toes and listen to the light wind rustle the trees. Adventure also awaits: try white water rafting, especially during rainy season when the waters will be flowing heavily. For all those active travelers, there is plenty of hiking within the mountains of the country. During rainy season, you will find gorgeous growth of greenery surrounding your every step.",
                    date: "2014",
                    location: "Bangkok, Thailand",
                    currency: "Thai Baht")

events_table.insert(title: "Kiliminjaro", 
                    description: "Our unforgettable honeymoon trip!",
                    body: "One of the continent's most iconic safari destinations, Tanzania is a haven for those looking to immerse themselves in the wonder of the African bush. It is home to some of East Africa's most famous game reserves – including the Serengeti National Park and the Ngorongoro Conservation Area. Many visitors travel to Tanzania to see the annual Great Migration of wildebeest and zebra, but there are many other reasons to stay. From the idyllic beaches of Zanzibar to the peaks of Kilimanjaro and Mount Meru, this is a country with limitless potential for adventure. Tanzania is located in East Africa, on the shores of the Indian Ocean. It is bordered by Kenya to the north and Mozambique to the south; and shares inland borders with Burundi, the Democratic Republic of Congo, Malawi, Rwanda, Uganda and Zambia. ",
                    date: "2016",
                    location: "Kiliminjaro, Tanzania",
                    currency: "Tanzanian Shilling")

puts "Success!"