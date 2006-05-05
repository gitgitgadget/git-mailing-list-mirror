From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 1/2] git-svn: documentation updates
Date: Fri, 05 May 2006 12:35:39 -0700
Message-ID: <11468577403821-git-send-email-normalperson@yhbt.net>
References: <11468577402388-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 05 22:51:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc7Gy-0001mV-Uc
	for gcvg-git@gmane.org; Fri, 05 May 2006 22:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWEEUvc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWEEUvc
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 16:51:32 -0400
Received: from hand.yhbt.net ([66.150.188.102]:11206 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751773AbWEEUvb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 16:51:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 1D5412DC034;
	Fri,  5 May 2006 13:51:31 -0700 (PDT)
To: junkio@cox.net, git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
In-Reply-To: <11468577402388-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19642>

* Clarify that 'init' requires an argument
* Remove instances of 'SVN_URL' in the manpage, it's not an
  environment variable.
* Refer to 'Additional Fetch Arguments' when documenting 'fetch'
* document --authors-file / -A option

Thanks to Pavel Roskin and Seth Falcon for bringing these issues
to my attention.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |    6 ++++--
 contrib/git-svn/git-svn.txt  |   45 ++++++++++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 13 deletions(-)

f16bddd18d55404fbaa4a88020f4d58ab2b1c620
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 7c44450..e003501 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -42,7 +42,8 @@ my %fc_opts = ( 'no-ignore-externals' =>
 my %cmd = (
 	fetch => [ \&fetch, "Download new revisions from SVN",
 			{ 'revision|r=s' => \$_revision, %fc_opts } ],
-	init => [ \&init, "Initialize and fetch (import)", { } ],
+	init => [ \&init, "Initialize a repo for tracking" .
+			  " (requires URL argument)", { } ],
 	commit => [ \&commit, "Commit git revisions to SVN",
 			{	'stdin|' => \$_stdin,
 				'edit|e' => \$_edit,
@@ -220,7 +221,8 @@ when you have upgraded your tools and ha
 }
 
 sub init {
-	$SVN_URL = shift or croak "SVN repository location required\n";
+	$SVN_URL = shift or die "SVN repository location required " .
+				"as a command-line argument\n";
 	unless (-d $GIT_DIR) {
 		sys('git-init-db');
 	}
diff --git a/contrib/git-svn/git-svn.txt b/contrib/git-svn/git-svn.txt
index e18fcaf..f7d3de4 100644
--- a/contrib/git-svn/git-svn.txt
+++ b/contrib/git-svn/git-svn.txt
@@ -36,17 +36,22 @@ COMMANDS
 --------
 init::
 	Creates an empty git repository with additional metadata
-	directories for git-svn.  The SVN_URL must be specified
-	at this point.
+	directories for git-svn.  The Subversion URL must be specified
+	as a command-line argument.
 
 fetch::
-	Fetch unfetched revisions from the SVN_URL we are tracking.
-	refs/heads/remotes/git-svn will be updated to the latest revision.
+	Fetch unfetched revisions from the Subversion URL we are
+	tracking.  refs/remotes/git-svn will be updated to the
+	latest revision.
 
-	Note: You should never attempt to modify the remotes/git-svn branch
-	outside of git-svn.  Instead, create a branch from remotes/git-svn
-	and work on that branch.  Use the 'commit' command (see below)
-	to write git commits back to remotes/git-svn.
+	Note: You should never attempt to modify the remotes/git-svn
+	branch outside of git-svn.  Instead, create a branch from
+	remotes/git-svn and work on that branch.  Use the 'commit'
+	command (see below) to write git commits back to
+	remotes/git-svn.
+
+	See 'Additional Fetch Arguments' if you are interested in
+	manually joining branches on commit.
 
 commit::
 	Commit specified commit or tree objects to SVN.  This relies on
@@ -62,9 +67,9 @@ rebuild::
 	tracked with git-svn.  Unfortunately, git-clone does not clone
 	git-svn metadata and the svn working tree that git-svn uses for
 	its operations.  This rebuilds the metadata so git-svn can
-	resume fetch operations.  SVN_URL may be optionally specified if
-	the directory/repository you're tracking has moved or changed
-	protocols.
+	resume fetch operations.  A Subversion URL may be optionally
+	specified at the command-line if the directory/repository you're
+	tracking has moved or changed protocols.
 
 show-ignore::
 	Recursively finds and lists the svn:ignore property on
@@ -123,6 +128,24 @@ OPTIONS
 	repo-config key: svn.l
 	repo-config key: svn.findcopiesharder
 
+-A<filename>::
+--authors-file=<filename>::
+
+	Syntax is compatible with the files used by git-svnimport and
+	git-cvsimport:
+
+------------------------------------------------------------------------
+loginname = Joe User <user@example.com>
+------------------------------------------------------------------------
+
+	If this option is specified and git-svn encounters an SVN
+	committer name that does not exist in the authors-file, git-svn
+	will abort operation. The user will then have to add the
+	appropriate entry.  Re-running the previous git-svn command
+	after the authors-file is modified should continue operation.
+
+	repo-config key: svn.authors-file
+
 ADVANCED OPTIONS
 ----------------
 -b<refname>::
-- 
1.3.2.ge3d7
