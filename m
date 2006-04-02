From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] contrib/git-svn: documentation updates
Date: Sat, 01 Apr 2006 18:25:03 -0800
Message-ID: <1143944704805-git-send-email-normalperson@yhbt.net>
References: <11439447031422-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 02 04:25:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPsHR-0000MU-5S
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 04:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWDBCZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Apr 2006 21:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWDBCZH
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Apr 2006 21:25:07 -0500
Received: from hand.yhbt.net ([66.150.188.102]:14811 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751233AbWDBCZE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Apr 2006 21:25:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 15D232DC035;
	Sat,  1 Apr 2006 18:25:04 -0800 (PST)
To: junkio@cox.net, git@vger.kernel.org
X-Mailer: git-send-email 1.3.0.rc1.g709a5
In-Reply-To: <11439447031422-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18254>

contrib/git-svn/git-svn.txt:
	added git-repo-config key names for options
	fixed quoting of "git-svn-HEAD" in the manpage
	use preformatted text for examples

contrib/git-svn/Makefile:
	add target to generate HTML:
		http://git-svn.yhbt.net/git-svn.html

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/Makefile    |    3 +++
 contrib/git-svn/git-svn.txt |   41 ++++++++++++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 13 deletions(-)

f8198e0b9da68024f7194067eb120bbf256a6111
diff --git a/contrib/git-svn/Makefile b/contrib/git-svn/Makefile
index a330c61..d7f1643 100644
--- a/contrib/git-svn/Makefile
+++ b/contrib/git-svn/Makefile
@@ -25,6 +25,9 @@ git-svn.1 : git-svn.xml
 git-svn.xml : git-svn.txt
 	asciidoc -b docbook -d manpage \
 		-f ../../Documentation/asciidoc.conf $<
+git-svn.html : git-svn.txt
+	asciidoc -b xhtml11 -d manpage \
+		-f ../../Documentation/asciidoc.conf $<
 test:
 	cd t && $(SHELL) ./t0000-contrib-git-svn.sh
 
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index 7a6e0c4..e18fcaf 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -101,6 +101,8 @@ OPTIONS
 	cannot version empty directories.  Enabling this flag will make
 	the commit to SVN act like git.
 
+	repo-config key: svn.rmdir
+
 -e::
 --edit::
 	Only used with the 'commit' command.
@@ -108,6 +110,8 @@ OPTIONS
 	Edit the commit message before committing to SVN.  This is off by
 	default for objects that are commits, and forced on when committing
 	tree objects.
+
+	repo-config key: svn.edit
 
 -l<num>::
 --find-copies-harder::
@@ -115,6 +119,9 @@ OPTIONS
 
 	They are both passed directly to git-diff-tree see
 	git-diff-tree(1) for more information.
+
+	repo-config key: svn.l
+	repo-config key: svn.findcopiesharder
 
 ADVANCED OPTIONS
 ----------------
@@ -133,6 +140,8 @@ ADVANCED OPTIONS
 	This option may be specified multiple times, once for each
 	branch.
 
+	repo-config key: svn.branch
+
 -i<GIT_SVN_ID>::
 --id <GIT_SVN_ID>::
 	This sets GIT_SVN_ID (instead of using the environment).  See
@@ -145,7 +154,7 @@ COMPATIBILITY OPTIONS
 	Only used with the 'rebuild' command.
 
 	Run this if you used an old version of git-svn that used
-	'git-svn-HEAD' instead of 'remotes/git-svn' as the branch
+	"git-svn-HEAD" instead of "remotes/git-svn" as the branch
 	for tracking the remote.
 
 --no-ignore-externals::
@@ -161,26 +170,30 @@ COMPATIBILITY OPTIONS
 
 	Otherwise, do not enable this flag unless you know what you're
 	doing.
+
+	repo-config key: svn.noignoreexternals
 
 Basic Examples
 ~~~~~~~~~~~~~~
 
 Tracking and contributing to an Subversion managed-project:
 
-# Initialize a tree (like git init-db)::
+------------------------------------------------------------------------
+# Initialize a tree (like git init-db):
 	git-svn init http://svn.foo.org/project/trunk
-# Fetch remote revisions::
+# Fetch remote revisions:
 	git-svn fetch
-# Create your own branch to hack on::
+# Create your own branch to hack on:
 	git checkout -b my-branch remotes/git-svn
-# Commit only the git commits you want to SVN::
+# Commit only the git commits you want to SVN:
 	git-svn commit <tree-ish> [<tree-ish_2> ...]
-# Commit all the git commits from my-branch that don't exist in SVN::
+# Commit all the git commits from my-branch that don't exist in SVN:
 	git-svn commit remotes/git-svn..my-branch
-# Something is committed to SVN, pull the latest into your branch::
+# Something is committed to SVN, pull the latest into your branch:
 	git-svn fetch && git pull . remotes/git-svn
-# Append svn:ignore settings to the default git exclude file::
+# Append svn:ignore settings to the default git exclude file:
 	git-svn show-ignore >> .git/info/exclude
+------------------------------------------------------------------------
 
 DESIGN PHILOSOPHY
 -----------------
@@ -219,7 +232,7 @@ git commits with the following syntax:
 
 This allows you to tie unfetched SVN revision 375 to your current HEAD::
 
-	git-svn fetch 375=$(git-rev-parse HEAD)
+	`git-svn fetch 375=$(git-rev-parse HEAD)`
 
 Advanced Example: Tracking a Reorganized Repository
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -232,22 +245,24 @@ This is how Yann Dirson tracked the trun
 the /trunk directory of his repository was moved to /ufoai/trunk and
 he needed to continue tracking /ufoai/trunk where /trunk left off.
 
-	# This log message shows when the repository was reorganized::
+------------------------------------------------------------------------
+	# This log message shows when the repository was reorganized:
 	r166 | ydirson | 2006-03-02 01:36:55 +0100 (Thu, 02 Mar 2006) | 1 line
 	Changed paths:
 	   D /trunk
 	   A /ufoai/trunk (from /trunk:165)
 
-	# First we start tracking the old revisions::
+	# First we start tracking the old revisions:
 	GIT_SVN_ID=git-oldsvn git-svn init \
-	      https://svn.sourceforge.net/svnroot/ufoai/trunk
+			https://svn.sourceforge.net/svnroot/ufoai/trunk
 	GIT_SVN_ID=git-oldsvn git-svn fetch -r1:165
 
-	# And now, we continue tracking the new revisions::
+	# And now, we continue tracking the new revisions:
 	GIT_SVN_ID=git-newsvn git-svn init \
 	      https://svn.sourceforge.net/svnroot/ufoai/ufoai/trunk
 	GIT_SVN_ID=git-newsvn git-svn fetch \
 	      166=`git-rev-parse refs/remotes/git-oldsvn`
+------------------------------------------------------------------------
 
 BUGS
 ----
-- 
1.3.0.rc1.g709a5
