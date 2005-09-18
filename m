From: Junio C Hamano <junkio@cox.net>
Subject: Re: Newbie falls at first hurdle
Date: Sun, 18 Sep 2005 10:22:04 -0700
Message-ID: <7vek7m5m0z.fsf@assigned-by-dhcp.cox.net>
References: <alan@chandlerfamily.org.uk>
	<200509180135.j8I1Z34n023252@inti.inf.utfsm.cl>
	<46a038f9050918035436352f71@mail.gmail.com>
	<200509181347.11403.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 19:23:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH2rr-0001ew-O1
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 19:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVIRRWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 13:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVIRRWK
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 13:22:10 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43166 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932149AbVIRRWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 13:22:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050918172204.YSLI26890.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Sep 2005 13:22:04 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8790>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> Yes - I had increasingly believed that with all the scripts being generated 
> with git that cogito was becoming irrelevant.

That is not going to happen.

The point of git barebone Porcelain (or Porcelainish commands)
is to give minimally usable UI on top of Plumbing tools for
people who like to get their hands dirty, and sometimes to
demonstrate how to take advantage of new core features before
Porcelains start using them.  It is not about competing with
real Porcelains.

> Still struggling with how to cherry pick parts a previous
> update (between possibly two other branches) and apply them to
> a current branch - all the tutorials assume you want it all,
> and I can't really understand what the cherry pick commands do
> from their manuals.

An example to pick a couple of commits from one branch to another.

    $ git show-branch master pu
    * [mister] Improve the safety check used in fetch.c
     ! [pu] Merge branch 'nuker' of .; branch 'merge' of .
    --
     + [pu] Merge branch 'nuker' of .; branch 'merge' of .
     + [pu^3] Use git-merge instead of git-resolve in git-pull.
     + [pu^2] Add two options to diffcore.
     + [pu^2~1] Diff cleanup.
     + [pu^2~2] Retire rev-tree.
     + [pu^2~3] Retire git-export.
    ++ [mister] Improve the safety check used in fetch.c

Let's cherry-pick two commits from pu branch:

    $ git cherry-pick pu^3 ; git cherry-pick pu^2~2

Then the result looks like this:

    $ git show-branch mister pu
    * [mister] Retire rev-tree.
     ! [pu] Merge branch 'nuker' of .; branch 'merge' of .
    --
     + [pu] Merge branch 'nuker' of .; branch 'merge' of .
     + [pu^3] Use git-merge instead of git-resolve in git-pull.
     + [pu^2] Add two options to diffcore.
     + [pu^2~1] Diff cleanup.
     + [pu^2~2] Retire rev-tree.
     + [pu^2~3] Retire git-export.
    +  [mister] Retire rev-tree.
    +  [mister~1] Use git-merge instead of git-resolve in git-pull.
    ++ [pu~1] Improve the safety check used in fetch.c

Note that new two commits are _not_ the same commit objects you
cherry picked from the pu branch.  They are new commits that
introduce changes equivalent to them.
