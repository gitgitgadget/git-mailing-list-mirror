From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix race and deadlock when sending pack
Date: Mon, 19 Dec 2005 13:01:08 -0800
Message-ID: <7vy82gg5t7.fsf@assigned-by-dhcp.cox.net>
References: <43A628F6.1060807@serice.net>
	<7vzmmxlkbq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512191236290.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Serice <paul@serice.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 22:02:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoS8B-0002Ow-5S
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 22:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVLSVBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 16:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVLSVBL
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 16:01:11 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:15080 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964968AbVLSVBK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 16:01:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051219210021.CTDB20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Dec 2005 16:00:21 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0512191236290.25300@iabervon.org> (Daniel
	Barkalow's message of "Mon, 19 Dec 2005 13:40:37 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13835>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> My immediate reaction was "do not do it then", but you are
>> right.  Hooks are run after all the protocol exchanges are done,
>> so they should be free to throw any garbage at the other end.
>
> If we extend it to transfer multiple things, wouldn't we want to run hooks 
> after each of them, rather than all at the end?

We do transfer multiple things already, and all protocol
exchange happens before everything is transferred.  And hooks
are run for each refs being updated, one by one.  What we do not
have is a reporting mechanism that says "we refused to update
this ref because of the hooks/update policy return value for
it".  Even if we later add that reporting mechanism, as I
outlined in a separate message earlier, I think it is OK to keep
running the update hooks after the pack transfer part.

> As for the policy:
>
> We definitely want to let hooks write to stdout, because git programs that 
> you might want to run in hooks write to stdout.
> ... I'd sort of like to avoid making people expect that there 
> is necessarily a path for text going back to the user directly.
> ... I 
> also think that messages are likely to be at least as useful to the owner 
> of the target repository as the person pushing, which is why I'd prefer a 
> log file.

This part I mostly agree with.  Will have to think about the
details but probably I'd punt this for now and declare it post
1.0 ;-).
