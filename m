From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 20:41:43 -0700
Message-ID: <7v8y0cg07c.fsf@assigned-by-dhcp.cox.net>
References: <20050708230750.GA23847@buici.com>
	<Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
	<20050711222046.GA21376@buici.com>
	<7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507111646000.17536@g5.osdl.org>
	<Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
	<7voe98g3ws.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507112010120.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Singer <elf@buici.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 05:42:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsBee-0003y3-Op
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 05:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbVGLDlw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 23:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVGLDlw
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 23:41:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:10494 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262311AbVGLDlv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 23:41:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050712034144.UISP1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 23:41:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507112010120.17536@g5.osdl.org> (Linus Torvalds's message of "Mon, 11 Jul 2005 20:18:28 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> So at least to me it makes much more sense to say "ok, I'll start
> something new, and call it xyzzy", than "ok, I'll start something new, and
> I'll save the old under 'old'".
>
> The "old" thing might not even be anything you worked on (it might be
> something you just cloned from somebody else), so you giving it a name 
> isn't very logical. In contrast, you're clearly doing something active 
> with the new thing, so naming _that_ makes sense.

What I had mind was ``If you do not care about the current
"master", just say "checkout --force"''.

When I start working on something I often do not know what the
thing I am going to work on ends up to be.  So I would start
from v2.6.12 tag, do random hacking, and when I got into a
reasonable shape, I would say ``Ok, this is worth saving.  Let's
name it "foobar" branch and continue.''  And I would probably
switch to some other subproject when an urgent bugfix comes in,
and I would not want to lose my "master" _then_.  So (the
"branch" one has been revised):

  checkout [--force] <commit-ish>

   In addition to reading the tree and updating the work tree,
   stores "<commit-ish>^0" in .git/refs/heads/master.  However,
   if the current "master" is not something that matches a
   refs/*/*, then the user will be losing the trail between
   "master" before checkout and what is recorded in refs/, so
   the user needs to allow me explicitly to do it.

  branch <branch-name>

   Save the current "master" to branch-name.  If the user makes
   a mistake and tries to store the "master" head into a wrong
   branch, that would lose development trail of the branch being
   overwritten, so if the named branch exists and "master" is
   not a descendent of it, the user needs to explicitly tell me
   that it is OK to do so.

I do not quite follow your objections.  I do not think I am
forcing anybody to name an old thing.  Do you mean that "I've
been working on A and now I want to switch to B; so I'll save
the current state in A and switch to B" is too redundant, and I
should just let the user say "I've been working on something I
do not care to remember, now I want to switch to B, so just take
me to B and you should remember where I was and save it to A
automatically"?  That sort of makes sense to me.
