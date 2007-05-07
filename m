From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 3/6] user-manual: clean up fast-forward and dangling-objects sections
Date: Mon,  7 May 2007 01:13:59 -0400
Message-ID: <5834.3404125937$1178514859@news.gmane.org>
References: <11785148422793-git-send-email->
 <11785148433801-git-send-email->
 <11785148442263-git-send-email->
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 07:14:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkvY7-0008TI-EV
	for gcvg-git@gmane.org; Mon, 07 May 2007 07:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbXEGFOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 01:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbXEGFOL
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 01:14:11 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53663 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753993AbXEGFOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 01:14:07 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HkvXx-0005Zn-4m; Mon, 07 May 2007 01:14:05 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <11785148442263-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46412>

From: J. Bruce Fields <bfields@citi.umich.edu>

The previous commit calls attention to the fact that we have two
sections each devoted to fast-forwards and to dangling objects.  Revise
and attempt to differentiate them a bit.  Some more reorganization may
be required later....

Signed-off-by: J. Bruce Fields
---
 Documentation/user-manual.txt |   73 ++++++++++++++++++++++------------------
 1 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d353d08..03206c5 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1402,12 +1402,11 @@ differently.  Normally, a merge results in a merge commit, with two
 parents, one pointing at each of the two lines of development that
 were merged.
 
-However, if one of the two lines of development is completely
-contained within the other--so every commit present in the one is
-already contained in the other--then git just performs a
-<<fast-forwards,fast forward>>; the head of the current branch is
-moved forward to point at the head of the merged-in branch, without
-any new commits being created.
+However, if the current branch is a descendant of the other--so every
+commit present in the one is already contained in the other--then git
+just performs a "fast forward"; the head of the current branch is moved
+forward to point at the head of the merged-in branch, without any new
+commits being created.
 
 [[fixing-mistakes]]
 Fixing mistakes
@@ -1559,8 +1558,10 @@ dangling tree b24c2473f1fd3d91352a624795be026d64c8841f
 ...
 -------------------------------------------------
 
-Dangling objects are objects that are harmless, but also unnecessary;
-you can remove them at any time with gitlink:git-prune[1] or the --prune
+Dangling objects are not a problem.  At worst they may take up a little
+extra disk space.  They can sometimes provide a last-resort method of
+recovery lost work--see <<dangling-objects>> for details.  However, if
+you want, you may remove them with gitlink:git-prune[1] or the --prune
 option to gitlink:git-gc[1]:
 
 -------------------------------------------------
@@ -1571,9 +1572,6 @@ This may be time-consuming.  Unlike most other git operations (including
 git-gc when run without any options), it is not safe to prune while
 other git operations are in progress in the same repository.
 
-For more about dangling objects, see <<dangling-objects>>.
-
-
 [[recovering-lost-changes]]
 Recovering lost changes
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -1626,16 +1624,16 @@ While normal history is shared by every repository that works on the
 same project, the reflog history is not shared: it tells you only about
 how the branches in your local repository have changed over time.
 
-[[dangling-objects]]
+[[dangling-object-recovery]]
 Examining dangling objects
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-In some situations the reflog may not be able to save you.  For
-example, suppose you delete a branch, then realize you need the history
-it contained.  The reflog is also deleted; however, if you have not
-yet pruned the repository, then you may still be able to find
-the lost commits; run git-fsck and watch for output that mentions
-"dangling commits":
+In some situations the reflog may not be able to save you.  For example,
+suppose you delete a branch, then realize you need the history it
+contained.  The reflog is also deleted; however, if you have not yet
+pruned the repository, then you may still be able to find the lost
+commits in the dangling objects that git-fsck reports.  See
+<<dangling-objects>> for the details.
 
 -------------------------------------------------
 $ git fsck
@@ -1667,6 +1665,9 @@ reference pointing to it, for example, a new branch:
 $ git branch recovered-branch 7281251ddd 
 ------------------------------------------------
 
+Other types of dangling objects (blobs and trees) are also possible, and
+dangling objects can arise in other situations.
+
 
 [[sharing-development]]
 Sharing development with others
@@ -2260,18 +2261,18 @@ $ git fetch git://example.com/proj.git master:example-master
 will create a new branch named "example-master" and store in it the
 branch named "master" from the repository at the given URL.  If you
 already have a branch named example-master, it will attempt to
-"fast-forward" to the commit given by example.com's master branch.  So
-next we explain what a fast-forward is:
+<<fast-forwards,fast-forward>> to the commit given by example.com's
+master branch.  In more detail:
 
-[[fast-forwards-2]]
-Understanding git history: fast-forwards
-----------------------------------------
+[[fetch-fast-forwards]]
+git fetch and fast-forwards
+---------------------------
 
 In the previous example, when updating an existing branch, "git
 fetch" checks to make sure that the most recent commit on the remote
 branch is a descendant of the most recent commit on your copy of the
 branch before updating your copy of the branch to point at the new
-commit.  Git calls this process a "fast forward".
+commit.  Git calls this process a <<fast-forwards,fast forward>>.
 
 A fast forward looks something like this:
 
@@ -3062,7 +3063,7 @@ objects will work exactly as they did before.
 The gitlink:git-gc[1] command performs packing, pruning, and more for
 you, so is normally the only high-level command you need.
 
-[[dangling-objects-2]]
+[[dangling-objects]]
 Dangling objects
 ----------------
 
@@ -3072,11 +3073,10 @@ objects.  They are not a problem.
 The most common cause of dangling objects is that you've rebased a
 branch, or you have pulled from somebody else who rebased a branch--see
 <<cleaning-up-history>>.  In that case, the old head of the original
-branch still exists, as does obviously everything it pointed to. The
-branch pointer itself just doesn't, since you replaced it with another
-one.
+branch still exists, as does everything it pointed to. The branch
+pointer itself just doesn't, since you replaced it with another one.
 
-There are also other situations too that cause dangling objects. For
+There are also other situations that cause dangling objects. For
 example, a "dangling blob" may arise because you did a "git add" of a
 file, but then, before you actually committed it and made it part of the
 bigger picture, you changed something else in that file and committed
@@ -3098,15 +3098,22 @@ be how you recover your old tree (say, you did a rebase, and realized
 that you really didn't want to - you can look at what dangling objects
 you have, and decide to reset your head to some old dangling state).
 
-For commits, the most useful thing to do with dangling objects tends to
-be to do a simple
+For commits, you can just use:
 
 ------------------------------------------------
 $ gitk <dangling-commit-sha-goes-here> --not --all
 ------------------------------------------------
 
-For blobs and trees, you can't do the same, but you can examine them.
-You can just do
+This asks for all the history reachable from the given commit but not
+from any branch, tag, or other reference.  If you decide it's something
+you want, you can always create a new reference to it, e.g.,
+
+------------------------------------------------
+$ git branch recovered-branch <dangling-commit-sha-goes-here>
+------------------------------------------------
+
+For blobs and trees, you can't do the same, but you can still examine
+them.  You can just do
 
 ------------------------------------------------
 $ git show <dangling-blob/tree-sha-goes-here>
-- 
1.5.1.1.98.gedb4f
