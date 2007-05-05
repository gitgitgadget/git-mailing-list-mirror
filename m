From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Make --color available to git-status
Date: Sat,  5 May 2007 19:37:49 +0200
Message-ID: <11783866694076-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 05 19:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkOCh-0005el-Dt
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934120AbXEERhw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 13:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934121AbXEERhw
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:37:52 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:52332 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934120AbXEERhv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 13:37:51 -0400
Received: from localhost (mut38-2-82-224-179-211.fbx.proxad.net [82.224.179.211])
	by smtp1-g19.free.fr (Postfix) with ESMTP id CD32FB94C4;
	Sat,  5 May 2007 19:37:49 +0200 (CEST)
Received: from moy by localhost with local (Exim 4.67)
	(envelope-from <moy@imag.fr>)
	id 1HkOCb-00039b-Ay; Sat, 05 May 2007 19:37:49 +0200
X-Mailer: git-send-email 1.5.2.rc1.20.g86b9-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46271>

Git has a nice colored output for status, using

$ git runstatus --color

However, this --color is not made available to git-status itself. In
my understanding, runstatus is plumbing, while status is porcelain,
which the average user wants to use.

This patch makes --color available to git-status itself, and documents
it.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-commit.txt |    4 ++++
 Documentation/git-status.txt |    5 ++++-
 git-commit.sh                |   10 ++++++++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 53a7bb0..2895225 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -118,6 +118,10 @@ but can be used to amend a merge commit.
 -q|--quiet::
 	Suppress commit summary message.
 
+--color::
+	Ignored by git-commit, but present for compatibility with
+	gitlink:git-status[1]. Show colored output for git-status.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index e9e193f..1d6a240 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -23,9 +23,12 @@ If there is no path that is different between the index file and
 the current HEAD commit, the command exits with non-zero
 status.
 
+
+OPTIONS
+-------
 The command takes the same set of options as `git-commit`; it
 shows what would be committed if the same options are given to
-`git-commit`.
+`git-commit`.  If --color is used, show a colored output.
 
 
 OUTPUT
diff --git a/git-commit.sh b/git-commit.sh
index f28fc24..47f006f 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i | -o] <path>...]'
+USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [--color] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
@@ -50,7 +50,7 @@ run_status () {
 	fi
 
 	case "$status_only" in
-	t) color= ;;
+	t) ;;
 	*) color=--nocolor ;;
 	esac
 	git-runstatus ${color} \
@@ -87,6 +87,8 @@ signoff=
 force_author=
 only_include_assumed=
 untracked_files=
+color=
+
 while case "$#" in 0) break;; esac
 do
 	case "$1" in
@@ -262,6 +264,10 @@ $1"
 		untracked_files=t
 		shift
 		;;
+	--c|--co|--col|--colo|--color)
+                color=--color
+                shift
+                ;;
 	--)
 		shift
 		break
-- 
1.5.1.3
