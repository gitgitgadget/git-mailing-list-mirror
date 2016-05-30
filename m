From: Adam Spiers <git@adamspiers.org>
Subject: RFC: new git-transplant subcommand for non-interactively moving
 commits between branches
Date: Mon, 30 May 2016 01:34:48 +0100
Message-ID: <20160530003448.GF11256@pacific.linksys.moosehall>
References: <20160527140811.GB11256@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 02:34:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7BAV-0006EZ-Sm
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 02:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbcE3Aew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2016 20:34:52 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:50622 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbcE3Aev (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 20:34:51 -0400
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id E16162E041
	for <git@vger.kernel.org>; Mon, 30 May 2016 01:34:48 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20160527140811.GB11256@pacific.linksys.moosehall>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295849>

On Fri, May 27, 2016 at 03:08:11PM +0100, Adam Spiers wrote:
> Hi all,
>
> I finally got around to implementing a new git subcommand which I've
> wanted for quite a while.  I've called it git-splice.

[snipped]

> Next steps, and the future
> --------------------------
>
> Obviously, I'd welcome thoughts on whether it would make sense to
> include this in the git distribution.
>
> In the longer term however, I'd like to write two more subcommands:
>
>   - git-transplant(1) which wraps around git-splice(1) and enables
>     easy non-interactive transplanting of a range of commits from
>     one branch to another.  This should be pretty straightforward
>     to implement.

I've now written git-transplant too (and in the process of doing so,
made many more enhancements to git-splice).


Usage
-----

Examples:

    # Move commits A..B from the current branch onto branch X
    git transplant A..B X

    # Move commits A..B from the current branch into branch X after commit C
    git transplant --after=C A..B X

    # Create a new branch X starting at ref Y, then
    # move commits A..B from the current branch onto X
    git transplant --new-from=Y C A..B X

    # Abort a transplant which failed during cherry-pick or rebase
    git transplant --abort

    # Resume a transplant after manually fixing conflicts caused by
    # cherry-pick or rebase
    git transplant --continue

N.B. this command rewrites history, since after splicing the commits
into the target branch, it removes them from the current branch.  As
with git rebase, you should be aware of all the implications of
history rewriting before using it.


Motivation
----------

See the rest of this mail thread.


Code
----

> Currently this is in alpha state:
>
>   https://github.com/git/git/compare/master...aspiers:splice
>
> and I reserve the right to rewrite the history of that branch in the
> near future ;-)

This still holds for git-splice, but also now for git-transplant too:
the same branch now contains git-transplant and its test suite.


Next steps
----------

- Wait for feedback.  (Ideally I hope people will actually try both tools.)

- If there is any appetite for eventually moving this into the
  distribution, it will still need quite a few things cleaning up first,
  e.g. making the coding style consistent with git's, getting rid of
  bashisms ...

- (Eventually) write git-explode, as explained elsewhere in this thread.


Cheers!
Adam
