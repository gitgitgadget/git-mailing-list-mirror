From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] "init-db" can really be just "init"
Date: Sun, 07 Jan 2007 12:31:29 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701071216190.4964@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 18:31:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3brz-0000Uv-0D
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 18:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbXAGRbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 12:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbXAGRbb
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 12:31:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15133 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932611AbXAGRbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 12:31:31 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBI00B0LE0HFW60@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 07 Jan 2007 12:31:30 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36179>


Make "init" the equivalent of "init-db". This should make first GIT 
impression a little more friendly.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

I'm resending this as I think this is still pertinent and I cannot 
remember what the initial issue against this was and whether it is still 
valid.

This would be a nice rule of thumb to try to have all porcelainish 
commands not have any hyphen in their name, like "diff", "commit", 
"add", "rm", "checkout", etc. ?

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 2105a3d..4e83994 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -25,7 +25,7 @@ Basic Repository[[Basic Repository]]
 
 Everybody uses these commands to maintain git repositories.
 
-  * gitlink:git-init-db[1] or gitlink:git-clone[1] to create a
+  * gitlink:git-init[1] or gitlink:git-clone[1] to create a
     new repository.
 
   * gitlink:git-fsck-objects[1] to check the repository for errors.
@@ -107,7 +107,7 @@ Use a tarball as a starting point for a new repository.::
 ------------
 $ tar zxf frotz.tar.gz
 $ cd frotz
-$ git-init-db
+$ git-init
 $ git add . <1>
 $ git commit -m 'import of frotz source tree.'
 $ git tag v2.43 <2>
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index ca7d09d..bc3ba14 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -74,6 +74,7 @@ Running `git-init-db` in an existing repository is safe. It will not overwrite
 things that are already there. The primary reason for rerunning `git-init-db`
 is to pick up newly added templates.
 
+Note that `git-init` is the same as `git-init-db`.
 
 
 EXAMPLES
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 36b2126..5662cdc 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -353,6 +353,7 @@ gitlink:git-hash-object[1]::
 gitlink:git-index-pack[1]::
 	Build pack idx file for an existing packed archive.
 
+gitlink:git-init[1]::
 gitlink:git-init-db[1]::
 	Creates an empty git object database, or reinitialize an
 	existing one.
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index 60e5477..f48894c 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -17,7 +17,7 @@ Let's start a new project and create a small amount of history:
 ------------------------------------------------
 $ mkdir test-project
 $ cd test-project
-$ git init-db
+$ git init
 Initialized empty Git repository in .git/
 $ echo 'hello world' > file.txt
 $ git add .
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 01d4a47..d2bf0b9 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -32,7 +32,7 @@ can place it under git revision control as follows.
 ------------------------------------------------
 $ tar xzf project.tar.gz
 $ cd project
-$ git init-db
+$ git init
 ------------------------------------------------
 
 Git will reply
diff --git a/Makefile b/Makefile
index 80c2c65..9376be2 100644
--- a/Makefile
+++ b/Makefile
@@ -210,7 +210,7 @@ EXTRA_PROGRAMS =
 
 BUILT_INS = \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
-	git-get-tar-commit-id$X \
+	git-get-tar-commit-id$X git-init$X \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
 # what 'all' will build and 'install' will install, in gitexecdir
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 97fd82f..bbef820 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -259,7 +259,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 }
 
 static const char init_db_usage[] =
-"git-init-db [--template=<template-directory>] [--shared]";
+"git-init [--template=<template-directory>] [--shared]";
 
 /*
  * If you want to, you can share the DB area with any number of branches.
diff --git a/git.c b/git.c
index c82ca45..bf55499 100644
--- a/git.c
+++ b/git.c
@@ -231,6 +231,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP },
 		{ "help", cmd_help },
+		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
