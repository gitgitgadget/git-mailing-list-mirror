From: Petr Baudis <pasky@suse.cz>
Subject: Re: Bottlenecks in git merge
Date: Wed, 1 Feb 2006 01:50:35 +0100
Message-ID: <20060201005035.GD31278@pasky.or.cz>
References: <20060131213314.GA32131@ebar091.ebar.dtu.dk> <7vk6cgq9ny.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601311533040.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Peter Eriksen <s022018@student.dtu.dk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 01:50:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F46CV-0005Rs-1G
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 01:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWBAAuT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 19:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWBAAuT
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 19:50:19 -0500
Received: from w241.dkm.cz ([62.24.88.241]:39588 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932322AbWBAAuS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 19:50:18 -0500
Received: (qmail 22805 invoked by uid 2001); 1 Feb 2006 01:50:35 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601311533040.7301@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15370>

Dear diary, on Wed, Feb 01, 2006 at 12:45:27AM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> It would be interesting to see how big the "resolve 850 files" part is vs 
> the "check out 10k+ files" is.

See my other mail.

> In particular, if the "resolve 850 files" is a noticeable portion of it, 
> then the right thing to do may be to just re-write git-merge-one-file.sh 
> in C. Right now, almost _all_ of the expense of that thing is just the 
> shell interpreter startup. The actual actions it does are usually fairly 
> cheap.

Nope.

xpasky@machine[0:0]~/linux-2.6.git$ echo -e '#!/bin/sh\n/bin/true' >r && chmod a+x r
xpasky@machine[0:0]~/linux-2.6.git$ time git-merge-index -o ./r -a

real    0m3.827s
user    0m1.788s
sys     0m2.004s
xpasky@machine[0:0]~/linux-2.6.git$ time git-merge-index -o ~/git-pb/git-merge-one-file -a
[lots of "Removing"]

real    1m21.773s
user    0m30.806s
sys     0m13.248s

The costs are apparently in git-update-index, not in the shell.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
