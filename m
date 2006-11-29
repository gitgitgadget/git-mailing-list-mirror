X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/3] git-svn: documentation updates
Date: Tue, 28 Nov 2006 18:51:41 -0800
Message-ID: <11647687042130-git-send-email-normalperson@yhbt.net>
References: <1164768702941-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Wed, 29 Nov 2006 02:52:11 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g22a08
In-Reply-To: <1164768702941-git-send-email-normalperson@yhbt.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32609>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpFY6-0006gY-Hb for gcvg-git@gmane.org; Wed, 29 Nov
 2006 03:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756344AbWK2Cvr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 21:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756405AbWK2Cvr
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 21:51:47 -0500
Received: from hand.yhbt.net ([66.150.188.102]:12418 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1755795AbWK2Cvp (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 21:51:45 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 3D3D12DC03D; Tue, 28 Nov 2006 18:51:44 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 28 Nov 2006
 18:51:44 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Eliminate 'commit' from some places and plug 'dcommit' more.
Also update the section --id (GIT_SVN_ID) usage since we
have multi-init/multi-fetch now.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |   40 +++++++++++++++++++---------------------
 1 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index a764d1f..a45067e 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -49,7 +49,7 @@ latest revision.
 
 Note: You should never attempt to modify the remotes/git-svn
 branch outside of git-svn.  Instead, create a branch from
-remotes/git-svn and work on that branch.  Use the 'commit'
+remotes/git-svn and work on that branch.  Use the 'dcommit'
 command (see below) to write git commits back to
 remotes/git-svn.
 
@@ -274,7 +274,7 @@ ADVANCED OPTIONS
 
 -b<refname>::
 --branch <refname>::
-Used with 'fetch' or 'commit'.
+Used with 'fetch', 'dcommit' or 'commit'.
 
 This can be used to join arbitrary git branches to remotes/git-svn
 on new commits where the tree object is equivalent.
@@ -368,7 +368,7 @@ SVN was very wrong.
 Basic Examples
 ~~~~~~~~~~~~~~
 
-Tracking and contributing to an Subversion managed-project:
+Tracking and contributing to a Subversion-managed project:
 
 ------------------------------------------------------------------------
 # Initialize a repo (like git init-db):
@@ -377,10 +377,9 @@ Tracking and contributing to an Subversi
 	git-svn fetch
 # Create your own branch to hack on:
 	git checkout -b my-branch remotes/git-svn
-# Commit only the git commits you want to SVN:
-	git-svn commit <tree-ish> [<tree-ish_2> ...]
-# Commit all the git commits from my-branch that don't exist in SVN:
-	git-svn commit remotes/git-svn..my-branch
+# Do some work, and then commit your new changes to SVN, as well as
+# automatically updating your working HEAD:
+	git-svn dcommit
 # Something is committed to SVN, rebase the latest into your branch:
 	git-svn fetch && git rebase remotes/git-svn
 # Append svn:ignore settings to the default git exclude file:
@@ -404,26 +403,24 @@ which can lead to merge commits reversin
 DESIGN PHILOSOPHY
 -----------------
 Merge tracking in Subversion is lacking and doing branched development
-with Subversion is cumbersome as a result.  git-svn completely forgoes
-any automated merge/branch tracking on the Subversion side and leaves it
-entirely up to the user on the git side.  It's simply not worth it to do
-a useful translation when the original signal is weak.
+with Subversion is cumbersome as a result.  git-svn does not do
+automated merge/branch tracking by default and leaves it entirely up to
+the user on the git side.
 
 [[tracking-multiple-repos]]
 TRACKING MULTIPLE REPOSITORIES OR BRANCHES
 ------------------------------------------
-This is for advanced users, most users should ignore this section.
-
 Because git-svn does not care about relationships between different
 branches or directories in a Subversion repository, git-svn has a simple
 hack to allow it to track an arbitrary number of related _or_ unrelated
-SVN repositories via one git repository.  Simply set the GIT_SVN_ID
-environment variable to a name other other than "git-svn" (the default)
-and git-svn will ignore the contents of the $GIT_DIR/svn/git-svn directory
-and instead do all of its work in $GIT_DIR/svn/$GIT_SVN_ID for that
-invocation.  The interface branch will be remotes/$GIT_SVN_ID, instead of
-remotes/git-svn.  Any remotes/$GIT_SVN_ID branch should never be modified
-by the user outside of git-svn commands.
+SVN repositories via one git repository.  Simply use the --id/-i flag or
+set the GIT_SVN_ID environment variable to a name other other than
+"git-svn" (the default) and git-svn will ignore the contents of the
+$GIT_DIR/svn/git-svn directory and instead do all of its work in
+$GIT_DIR/svn/$GIT_SVN_ID for that invocation.  The interface branch will
+be remotes/$GIT_SVN_ID, instead of remotes/git-svn.  Any
+remotes/$GIT_SVN_ID branch should never be modified by the user outside
+of git-svn commands.
 
 [[fetch-args]]
 ADDITIONAL FETCH ARGUMENTS
@@ -486,7 +483,8 @@ If you are not using the SVN::* Perl lib
 conflicting changeset to SVN at a bad moment (right before you commit)
 causing a conflict and your commit to fail, your svn working tree
 ($GIT_DIR/git-svn/tree) may be dirtied.  The easiest thing to do is
-probably just to rm -rf $GIT_DIR/git-svn/tree and run 'rebuild'.
+probably just to rm -rf $GIT_DIR/git-svn/tree and run 'rebuild'.   You
+can avoid this problem entirely by using 'dcommit'.
 
 We ignore all SVN properties except svn:executable.  Too difficult to
 map them since we rely heavily on git write-tree being _exactly_ the
-- 
1.4.4.1.g22a08
