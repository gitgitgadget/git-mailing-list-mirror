From: linux@horizon.com
Subject: Why are commits on detached heads good, again?
Date: 7 Feb 2007 09:26:42 -0500
Message-ID: <20070207142642.23503.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 15:26:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEnl4-0002xs-Kd
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 15:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161338AbXBGO0p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 09:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161339AbXBGO0p
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 09:26:45 -0500
Received: from science.horizon.com ([192.35.100.1]:17913 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161338AbXBGO0o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 09:26:44 -0500
Received: (qmail 23504 invoked by uid 1000); 7 Feb 2007 09:26:42 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38924>

I know I made the case for the value of detached heads in a read-only
mode.  Why should I need to think up a branch name to look at v2.6.18?
I *have* a name; it's v2.6.18.

And it got implemented.  But some people said "Hey!  Let's allow
commits on top of detached heads, too!"  Whish has led to a huge thread
about handling the resultant potential confusion.

I agree 100% that it's entirely doable and can be used safely.

But perhaps the confusion is more trouble than it's worth?  If the rules
are hard to implement, is that perhaps a clue that they're hard for the
poor user to understand?

I'd like to agitate for forbidding commits on detached heads as a
simplicity issue.  If I'm going to ask git to *remember* some work for
me, is it terribly unreasonable for me to have to think of a name for it?
I can name it "temp" or "foo" or "test" or "hackhack" or "x" if I want.

Remember, we've survived fine up to now when you can't even *look* at an
old commit without coming up with a name for it (or using git-tar-tree,
or some other tool).  And the pressure to change hasn't been *that*
strong.

Even if it's slightly more stringent than required, why not say
"you're not allowed to commit when you're not on a branch; think
of a name for your work and do 'git checkout -b <name> first'"?

Is it that onerous?  It has the great virtue of being very simple
to explain and remember.  "If you committed without being on a branch,
you're not allowed to switch away until you give that branch a name,
or you accept losing the data" is a lot more complicated.
(Never mind the arguing about the reflog and ORIG_HEAD.)

People are used to the idea that if you want to save your work, you need
to think up a file name.  Postponing that time until you switch away
from the HEAD doesn't actually save any work unless you throw away the
commits, and presumably that's a rare and unusual situation.
(And the extra work is trivial compared to the effort writing
the commits you're discarding.)


Can someone explain why committing on top of a detached head is a
killer feature and thinking up a name sooner rather than later is
a huge inconvenience?

As someone trying to document all this, it would certainly make my
life easier to just forbid it.  I can just say:

git-checkout: You may check out any commit you like.
	However, if the name you specify is in the .git/refs/heads
	directory, you are "on that branch" and can commit to it.
	If you specify the same commit by a tag or raw SHA ID,
	and do not give a name with "git checkout -b <name>", you
	are not on any branch, and a later git-commit will fail.
git-commit: If the last thing you checked out with "git-checkout"
	(with no pathname arguments) was a branch (in .git/refs/heads),
	the commit is made and the head is automatically updated to
	point to the new head.
	If you have checked out a "bare commit", git-commit will refuse
	to make the commit because it has nowhere to record it.
	You can "git checkout -b <name>" to create a new branch
	starting from the current HEAD.  This will not alter the
	contents of the index or the working directory.


I'm willing to be convinced, but could someone please explain the
virtues of committing to a detached HEAD that outweigh the virtue
of simplicity?
