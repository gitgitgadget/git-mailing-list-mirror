From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -i: mention the option to split commits in the man
 page
Date: Fri, 31 Aug 2007 18:10:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708311809510.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 31 19:11:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRA1q-0008Pc-4V
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 19:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965775AbXHaRKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 13:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965436AbXHaRKr
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 13:10:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:55854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965742AbXHaRK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 13:10:28 -0400
Received: (qmail invoked by alias); 31 Aug 2007 17:10:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 31 Aug 2007 19:10:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fD1EayQLfc8+dBoD64XUrblN7QVrQww4sA347D/
	/+kCaltpHit2P3
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57190>


The interactive mode of rebase can be used to split commits.  Tell the
interested parties about it, with a dedicated section in the man page.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I hope I got the asciidoc markup right...

 Documentation/git-rebase.txt |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a1b6dce..640ea3b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -211,7 +211,8 @@ OPTIONS
 
 -i, \--interactive::
 	Make a list of the commits which are about to be rebased.  Let the
-	user edit that list before rebasing.
+	user edit that list before rebasing.  This mode can also be used to
+	split commits (see SPLITTING COMMITS below).
 
 -p, \--preserve-merges::
 	Instead of ignoring merges, try to recreate them.  This option
@@ -325,6 +326,42 @@ sure that the current HEAD is "B", and call
 $ git rebase -i -p --onto Q O
 -----------------------------
 
+
+SPLITTING COMMITS
+-----------------
+
+In interactive mode, you can mark commits with the action "edit".  However,
+this does not necessarily mean that 'git rebase' expects the result of this
+edit to be exactly one commit.  Indeed, you can undo the commit, or you can
+add other commits.  This can be used to split a commit into two:
+
+- Start an interactive rebase with 'git rebase -i <commit>^', where
+  <commit> is the commit you want to split.  In fact, any commit range
+  will do, as long as it contains that commit.
+
+- Mark the commit you want to split with the action "edit".
+
+- When it comes to editing that commit, execute 'git reset HEAD^'.  The
+  effect is that the HEAD is rewound by one, and the index follows suit.
+  However, the working tree stays the same.
+
+- Now add the changes to the index that you want to have in the first
+  commit.  You can use gitlink:git-add[1] (possibly interactively) and/or
+  gitlink:git-gui[1] to do that.
+
+- Commit the now-current index with whatever commit message is appropriate
+  now.
+
+- Repeat the last two steps until your working tree is clean.
+
+- Continue the rebase with 'git rebase --continue'.
+
+If you are not absolutely sure that the intermediate revisions are
+consistent (they compile, pass the testsuite, etc.) you should use
+gitlink:git-stash[1] to stash away the not-yet-committed changes
+after each commit, test, and amend the commit if fixes are necessary.
+
+
 Authors
 ------
 Written by Junio C Hamano <junkio@cox.net> and
-- 
1.5.3.rc7.18.gc9b59
