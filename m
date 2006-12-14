X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Update git-diff documentation
Date: Thu, 14 Dec 2006 00:09:43 -0800
Message-ID: <7vr6v2aofs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 08:09:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34284>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gulf3-0006Rt-7N for gcvg-git@gmane.org; Thu, 14 Dec
 2006 09:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751868AbWLNIJq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 03:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbWLNIJq
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 03:09:46 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48081 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751905AbWLNIJp (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 03:09:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214080944.VPWE22053.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Thu, 14
 Dec 2006 03:09:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id yY951V0051kojtg0000000; Thu, 14 Dec 2006
 03:09:05 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Porcelain documentation should talk in terms of end-user workflow, not
in terms of implementation details.  Do not suggest update-index, but
git-add instead.  Explain differences among 0-, 1- and 2-tree cases
not as differences of number of trees given to the command, but say
why user would want to give these number of trees to the command in
what situation.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * The same idea as the previous "git commit" documentation.

 Documentation/git-diff.txt |   55 ++++++++++++++++++++++++++++---------------
 1 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 228c4d9..8888e0d 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -12,32 +12,49 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Show changes between two trees, a tree and the working tree, a
-tree and the index file, or the index file and the working tree.
-The combination of what is compared with what is determined by
-the number of trees given to the command.
+This command shows changes between four combinations of states.
 
-* When no <tree-ish> is given, the working tree and the index
-  file are compared, using `git-diff-files`.
+'git-diff' [--options] [--] [<path>...]::
 
-* When one <tree-ish> is given, the working tree and the named
-  tree are compared, using `git-diff-index`.  The option
-  `--cached` can be given to compare the index file and
-  the named tree.
+	This form is to view the changes you made relative to
+	the index (staging area for the next commit).  In other
+	words, the differences are what you _could_ tell git to
+	further add to the index but you still haven't.  You can
+	stage these changes by using gitlink:git-add[1].
+
+'git-diff' [--options] --cached [<commit>] [--] [<path>...]::
+
+	This form is to view the changes you staged for the next
+	commit relative to the named <tree-ish>.  Typically you
+	would want comparison with the latest commit, so if you
+	do not give <commit>, it defaults to HEAD.
+
+'git-diff' [--options] <commit> -- [<path>...]::
+
+	This form is to view the changes you have in your
+	working tree relative to the named <commit>.  You can
+	use HEAD to compare it with the latest commit, or a
+	branch name to compare with the tip of a different
+	branch.
+
+* 'git-diff' [--options] <commit> <commit> -- [<path>...]
+
+	This form is to view the changes between two <commit>,
+	for example, tips of two branches.
+
+Just in case if you are doing something exotic, it should be
+noted that all of the <commit> in the above description can be
+any <tree-ish>.
 
-* When two <tree-ish>s are given, these two trees are compared
-  using `git-diff-tree`.
 
 OPTIONS
 -------
---diff-options::
-	'--diff-options' are passed to the `git-diff-files`,
-	`git-diff-index`, and `git-diff-tree` commands.  See the
-	documentation for these commands for description.
+include::diff-options.txt[]
 
 <path>...::
-	The <path> arguments are also passed to `git-diff-\*`
-	commands.
+	The <paths> parameters, when given, are used to limit
+	the diff to the named paths (you can give directory
+	names and get diff for all files under them).
 
 
 EXAMPLES
@@ -51,7 +68,7 @@ $ git diff --cached   <2>
 $ git diff HEAD       <3>
 ------------
 +
-<1> changes in the working tree since your last git-update-index.
+<1> changes in the working tree not yet staged for the next commit.
 <2> changes between the index and your last commit; what you
 would be committing if you run "git commit" without "-a" option.
 <3> changes in the working tree since your last commit; what you
-- 
1.4.4.2.g86bd

