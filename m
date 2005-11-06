From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Cogito: Support for implicit remote branches in cloned repositories
Date: Sun, 06 Nov 2005 01:11:10 -0800
Message-ID: <7v8xw216q9.fsf@assigned-by-dhcp.cox.net>
References: <200511041701.48881.Josef.Weidendorfer@gmx.de>
	<7vvez8wbpz.fsf@assigned-by-dhcp.cox.net>
	<20051104210820.GM1431@pasky.or.cz>
	<7voe50rskh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511041359050.28804@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 10:11:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYgYW-0000aV-Pp
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 10:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVKFJLN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 04:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVKFJLN
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 04:11:13 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:42486 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932344AbVKFJLL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 04:11:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106091047.JUMI4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 04:10:47 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511041359050.28804@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 4 Nov 2005 14:07:48 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11198>

Linus Torvalds <torvalds@osdl.org> writes:

> I don't like the dot idea, but it certainly _would_ make sense to have a 
> local prefix.
>
> We could even make it a _totally_ different namespace:
>
> 	.git/refs/local/heads
> 	.git/refs/local/tags
>
> which means that even if you call a local head the same thing as a global 
> one, both can still exist.
>
> Then, make "origin" always be a local head.

While that is logically the right thing to do, it is somewhat
confusing to see all those branch heads we obtained from the
remote side stored as our "local" branches -- meaning they are
private to us.

Just for discussion, I'd suggest a less structured approach as
an alternative, and making it just a convention.

 - clone by default [*1*] creates .git/refs/heads/origin/*
   heads; your "master" becomes my "origin/master".
   Interestingly but logically, if your repository was cloned
   from somewhere else, you would have "origin/master", which
   would become my "origin/origin/master".

 - clone creates remotes/origin that knows all branches from the
   origin as copied by the above process, as suggested by Daniel
   in the other thread.

Then we would have a recommended workflow example that uses
origin/* as reference branches after they are set up.  After
becoming familiar with this setup, when people fetch/pull from
more than one repository, they can configure things correctly by
emulating what clone did to the "origin" remote repository for
them.

[Footnote]

*1* I say "by default" here; I think there should be an
operating mode for git clone that acts as a straight copy, not
even the current "HEAD" -> "origin" renaming.  In fact that is
what you do with low-level git-clone-pack.
