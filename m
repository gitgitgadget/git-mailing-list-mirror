From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Thu, 17 Nov 2005 18:38:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511171828380.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org> 
 <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
  <Pine.LNX.4.63.0511180030260.18775@wbgn013.biozentrum.uni-wuerzburg.de>
 <46a038f90511171740x756b0336ib8b8937ee3a2af03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 03:40:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecw9P-0000Md-3l
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 03:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbVKRCik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 21:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVKRCik
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 21:38:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751447AbVKRCik (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 21:38:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAI2cRnO017895
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 17 Nov 2005 18:38:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAI2cNcL025880;
	Thu, 17 Nov 2005 18:38:25 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511171740x756b0336ib8b8937ee3a2af03@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12184>



On Fri, 18 Nov 2005, Martin Langhoff wrote:
> 
> That'd be even harder to define -- I'd rather have it spit out what it
> interpreted so that porcelains can display it to the user. The user
> can tell at a glance if the parser is off -- for it will be off by a
> mile.

Well, quite frankly, almost always it's pretty damn obvious.

We could make it less so: the most common mistake when it doesn't parse 
sanely is that it doesn't parse anything at all, but it saw a number 
somewhere, and thought it was a day of the month.

For example, "last janurary" will silently parse to just "1" (miss-spelled 
"january"), which will be interpreted as the "first of this month".

And we could make _that_ be an error. If you want the first of this month, 
you'd have to spell out the month, ie write "Nov 1" instead of just "1".

Apart from that parsign error, pretty much everything else will tend to 
parse correctly or just give "now" (which is pretty obvious when you ask 
for a log "since now", and get an empty answer back).

But quite frankly, I don't think the approximate date-parsing is serious 
enough to even worry about these kinds of things. I actually use it, but I 
don't think anybody _depends_ on it. It's useful to do

	gitk --since=last.week

just as a way to speed up the startup (if you're just interested in the 
top of the tree, the kernel history is so big that it's just pointless to 
do a full gitk, and doing the "since last week" is a quick way to just 
limit the history enough that it makes the graph cleaner).

And if you get that wrong, who cares? It's not a big deal. The approxidate 
parsing is one of those "hey, that's nice" features, but it's definitely 
not important.

		Linus
