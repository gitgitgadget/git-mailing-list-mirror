From: Junio C Hamano <junkio@cox.net>
Subject: Re: LCA06 Cogito/GIT workshop - (Re: git-whatchanged: exit out early on errors)
Date: Sun, 29 Jan 2006 12:15:16 -0800
Message-ID: <7vhd7mkcyz.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<Pine.LNX.4.64.0601280047240.2909@evo.osdl.org>
	<20060129101225.GA4815@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, keithp@keithp.com
X-From: git-owner@vger.kernel.org Sun Jan 29 21:15:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3IxJ-0000Ov-Sw
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 21:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWA2UPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWA2UPT
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 15:15:19 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:29147 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751152AbWA2UPS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 15:15:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129201523.HAVX25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 Jan 2006 15:15:23 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15239>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> Would it make sense to add an optional
>
>    mergeresult <tree>
>
> line to merge commit objects?

Two issues and a half.

(1) Not all conflicting merge cases can write a sensible
    "conflicted intermediate auto-merge result".  Look for cases
    where we punt in git-merge-one-file.

(2) Modulo issue (1), it can be re-computed if and when needed,
    so this is akin to "storing rename information in the commit
    by detecting renames while merging".

(3) Depending on the direction you pull, you would have
    logically the same "conflicted auto-merge result" that has
    <<< === >>> delimited hunks in reverse.  Which one should
    you record?

And annotate would not be helped much -- if it is needed you
could recompute it at that point.  Annotate needs to look at the
diff from each parent _anyway_ to assign blames.

By the way, I brought up the issue (3) because it relates to how
my latest toy "git rerere" works ;-).
