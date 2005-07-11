From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: Re: [PATCH 3/6] git-gnu-progs-Makefile: git Makefile update
Date: Mon, 11 Jul 2005 15:21:33 -0400
Message-ID: <42D2C6BD.4050107@yahoo.com>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>	<20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local> <7vk6jxupxs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bryan.larsen@gmail.com, torvalds@osdl.org, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 21:27:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds3u4-0004FR-QW
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 21:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVGKTYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 15:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVGKTXY
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 15:23:24 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:41094 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262447AbVGKTVn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 15:21:43 -0400
Received: (qmail 14227 invoked from network); 11 Jul 2005 19:21:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HhJ+7CckqoTa5ydGZXP/bl9bPrpAR1BQTOzBVUJz3EfwyZeehLhyOz1eO0SlvoachzRoawjHE4FaDu+Zs9+bVzs+KPW4mYl64ajST3cdz98n0wnV+szznccn5ea1LoY4fkB5Uazt2P3bJenKSF1FcIhQoKlmcyM1mPc0l2DKxSg=  ;
Received: from unknown (HELO ?192.168.2.80?) (bryanlarsen@69.159.204.165 with plain)
  by smtp107.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 19:21:35 -0000
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6jxupxs.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Bryan Larsen <bryanlarsen@yahoo.com> writes:
>>+	for file in $(SCRIPTS); do \
>>+		sed -e "s/DATE\=date/DATE=$${DATE}/" -e "s/CP\=cp/CP=$${CP}/" -e "s/XARGS\=xargs/XARGS=$${XARGS}/" -e "s/STAT\=stat/STAT=$${STAT}/" $$file > $$file.new; \
>>+		cat $$file.new > $$file; rm $$file.new; \
>>+	done
> 
> 
> I am not yet convinced "one variable per GNU program" is the
> right way to do 

My first thought was to have some type of "prefix" argument that could 
either be "g" or "".  But xargs is called "gnuxargs" instead of 
"gxargs".  I'm not sure where that braindamage comes from, but I have to 
deal with it.

To me, one variable per program makes sense: we do it in Makefiles all 
the time $(CC), $(LD), et cetera.

 > (I do agree it is a problem and I appreciate
> your trying to solving it; an obvious alternative cop-out would
> be to fix this in the user's environment, but there might be a
> saner solution). 

If we can move the solution into the Portfile somehow, it probably 
wouldn't bother me.

> Assuming that this is the way to go, wouldn't
> it be saner if this sed munging is done in only one place, say
> git-sh-setup-script, and have everybody include that?  If we
> want to have some scripts usable not at the top-level GIT
> directory, then git-sh-setup-script may not be a good place; in
> which case introduce git-sh-compat-script and have everybody
> include _that_ instead?
> 

That's the way it's done in cogito:  it's in cg-Xlib and nowhere else. 
This isn't obvious from the Makefile: perhaps I should have made it so.

I was very tempted to put it in git-sh-setup-script, but realized that 
was inappropriate.  Introducing a gid-sh-compat-script seems more sane.

Bryan
