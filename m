From: Junio C Hamano <junkio@cox.net>
Subject: Re: Edit log message after commit
Date: Wed, 28 Sep 2005 21:15:20 -0700
Message-ID: <7vr7b8pl0n.fsf@assigned-by-dhcp.cox.net>
References: <dhfjcu$36f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 06:16:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKppT-0007wp-Ag
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 06:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVI2EP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 00:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVI2EP0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 00:15:26 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:54453 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751155AbVI2EP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 00:15:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929041518.PJIH24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 00:15:18 -0400
To: Kevin Leung <hysoka@gmail.com>
In-Reply-To: <dhfjcu$36f$1@sea.gmane.org> (Kevin Leung's message of "Thu, 29
	Sep 2005 10:28:39 +0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9454>

Kevin Leung <hysoka@gmail.com> writes:

> Is there any method to edit the log message after committed? I
> couldn't find any information in Documentation and in git
> mailing list.

Undoing and re-committing can be done with the following
recipe.

There is a *big* *red* *warning*, though.  If you have already
made available the commit you are about to undo to others, and
later other people have made more commits on top of them,
merging their changes back to your repository would make the
commit history look a bit funny.  You could still do this
without damaging the repository.  This warning only applies to
the shape of the commit graph.

First, the easiest case.  Undoing and recommitting the latest
commit in the current branch.

(1) Run "git diff HEAD" and make sure that your working tree
    matches the latest commit you are about to undo.  Then:

    $ git reset --soft HEAD^

    This leaves the working tree intact (i.e. it still has what
    you to have in the commit you are "fixing").

(2) Optional.  If you wanted to make changes other than commit
    log, do your edit here in the working tree.  When done, run
    "git diff HEAD" to make sure the changes are what you want
    the "fixed" commit to have.

(3) Run:

    $ git commit -c ORIG_HEAD

    If you made changes in (2) and have not done
    "git-update-index" on them, you may want to add '-a' there.
    If you are just redoing the log message you probably would
    not.

    This gives you the editor with the log message from the
    commit you undone in step (1).  Do your edit and exit the
    editor as usual.

Look at the output in "gitk HEAD ORIG_HEAD" to understand what
happened.  You just rewound a commit, and made a different
commit.

Harder, more cumbersome case, is when you realize that you made
a mistake a several commits ago.  This is described in detail in
Documentation/howto/revert-branch-rebase.  Read it.
