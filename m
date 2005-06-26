From: Junio C Hamano <junkio@cox.net>
Subject: [RFD] consider "git" wrapper semi-Porcelain
Date: Sat, 25 Jun 2005 18:02:54 -0700
Message-ID: <7vy88yvsjl.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
	<7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>
	<7vaclf6tw7.fsf@assigned-by-dhcp.cox.net>
	<7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 26 02:56:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmLSB-00038W-QE
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 02:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVFZBDW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 21:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVFZBDW
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 21:03:22 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31362 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261368AbVFZBC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 21:02:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050626010254.SEHI16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Jun 2005 21:02:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: Junio C. Hamano's message of "(unknown date)"
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Currently "git" wrapper suggests both low-level git-* commands
and git-*-script commands as alternatives.  Earlier I stated
that git-*-script commands, like it or not, form a perfectly
good set of barebone Porcelain, as opposed to all the other
commands that do not end with "script" are low-level Plumbing.
After reviewing the current set of commands and scripts again, I
still think this view holds true [*1*, *2*].

I would propose the following, preferably before we go 1.0:

 (1) Do not suggest low-level Plumbing commands to "git" wrapper
     users, and do not call anything but git-*-script from "git"
     wrapper.  Once *-script Porcelain matures, hopefully
     everyday workflow would not require access to low-level
     Plumbing and can be done with git-*-script Porcelain.  When
     people know the GIT way, they can also work it around
     things that git-*-script Porcelain does not support well by
     writing their own git-*-script in terms of Plumbing-ish
     git-* commands, and if it is good enough for public
     consumption, propose it for inclusion upstream.

 (2) Make an alias git-whatchanged-script that just "exec"s
     git-whatchanged, to make things consistent.

 (3) Rename some git-*-script that are misnamed in the sense
     that they are not useful standalone scripts but more of
     Plumbing that happen to be written in shell [*3*].  I do
     not particularly like this proposal, because this breaks
     existing scripts.  However, if we go this route for
     consistency, I would further suggest renaming Porcelain-ish
     things git-*-cmd or something, call and suggest them from
     "git" wrapper, regardless of which language they are
     written in [*4*].


[Footnotes]

*1* One exception is git-whatchanged.

*2* That is the reason I did not name git-cherry
"git-cherry-script".  It is not useful standalone but meant to
be useful in scripting environment.

*3* git-apply-patch-script (my fault) and
git-merge-one-file-script fall into this category.

*4* Current naming and the proposal (1) above have a problem in
that they muddy the definition of what is "script": the name
"script" were originally used because they were written in
shell, and all of the Porcelain-ish things happen to be
"script".  Writing Porcelain-ish things in shell should not be a
requirement.

