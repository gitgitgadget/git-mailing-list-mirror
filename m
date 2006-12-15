X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Provide more meaningful output from 'git init-db'.
Date: Fri, 15 Dec 2006 00:44:58 -0500
Message-ID: <20061215054458.GA27750@spearce.org>
References: <Pine.LNX.4.64.0612142141420.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 05:45:21 +0000 (UTC)
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612142141420.18171@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34472>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv5sj-0001z1-2A for gcvg-git@gmane.org; Fri, 15 Dec
 2006 06:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750725AbWLOFpG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 00:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWLOFpG
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 00:45:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56462 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750725AbWLOFpE (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 00:45:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gv5sS-0001mz-9U; Fri, 15 Dec 2006 00:45:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8B76B20FB65; Fri, 15 Dec 2006 00:44:58 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Back in the old days of Git when people messed around with their
GIT_DIR environment variable more often it was nice to know whether
or not git-init-db created a .git directory or used GIT_DIR.
As most users at that time were rather technical UNIXy folk the
message "defaulting to local storage area" made sense to some and
seemed reasonable.

But it doesn't really convey any meaning to the new Git user,
as they don't know what a 'local storage area is' nor do they
know enough about Git to care.  It also really doesn't tell the
experienced Git user a whole lot about the command they just ran,
especially if they might be reinitializing an existing repository
(e.g. to update hooks).

So now we print out what we did ("Initialized empty" or
"Reinitialized existing"), what type of repository ("" or "shared"),
and what location the repository will be in ("$GIT_DIR").

Suggested in part by Andy Parkins in his Git 'niggles' list
(<200612132237.10051.andyparkins@gmail.com>).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/core-tutorial.txt |    2 +-
 Documentation/tutorial-2.txt    |    2 +-
 Documentation/tutorial.txt      |    2 +-
 builtin-init-db.c               |   21 ++++++++++++++-------
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 47505aa..abe74a7 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -57,7 +57,7 @@ $ git-init-db
 to which git will reply
 
 ----------------
-defaulting to local storage area
+Initialized empty Git repository in .git/
 ----------------
 
 which is just git's way of saying that you haven't been doing anything
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index 6389de5..7a692d7 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -18,7 +18,7 @@ Let's start a new project and create a small amount of history:
 $ mkdir test-project
 $ cd test-project
 $ git init-db
-defaulting to local storage area
+Initialized empty Git repository in .git/
 $ echo 'hello world' > file.txt
 $ git add .
 $ git commit -a -m "initial commit"
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 02dede3..cb808d9 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -38,7 +38,7 @@ $ git init-db
 Git will reply
 
 ------------------------------------------------
-defaulting to local storage area
+Initialized empty Git repository in .git/
 ------------------------------------------------
 
 You've now initialized the working directory--you may notice a new
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 235a0ee..8f2b750 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -164,13 +164,14 @@ static void copy_templates(const char *git_dir, int len, const char *template_di
 	closedir(dir);
 }
 
-static void create_default_files(const char *git_dir, const char *template_path)
+static int create_default_files(const char *git_dir, const char *template_path)
 {
 	unsigned len = strlen(git_dir);
 	static char path[PATH_MAX];
 	unsigned char sha1[20];
 	struct stat st1;
 	char repo_version_string[10];
+	int reinit;
 
 	if (len > sizeof(path)-50)
 		die("insane git directory %s", git_dir);
@@ -218,7 +219,8 @@ static void create_default_files(const char *git_dir, const char *template_path)
 	 * branch, if it does not exist yet.
 	 */
 	strcpy(path + len, "HEAD");
-	if (read_ref("HEAD", sha1) < 0) {
+	reinit = !read_ref("HEAD", sha1);
+	if (!reinit) {
 		if (create_symref("HEAD", "refs/heads/master") < 0)
 			exit(1);
 	}
@@ -239,6 +241,8 @@ static void create_default_files(const char *git_dir, const char *template_path)
 		git_config_set("core.filemode",
 			       filemode ? "true" : "false");
 	}
+
+	return reinit;
 }
 
 static const char init_db_usage[] =
@@ -256,7 +260,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *sha1_dir;
 	const char *template_dir = NULL;
 	char *path;
-	int len, i;
+	int len, i, reinit;
 
 	for (i = 1; i < argc; i++, argv++) {
 		const char *arg = argv[1];
@@ -274,10 +278,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	 * Set up the default .git directory contents
 	 */
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-	if (!git_dir) {
+	if (!git_dir)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
-		fprintf(stderr, "defaulting to local storage area\n");
-	}
 	safe_create_dir(git_dir, 0);
 
 	/* Check to see if the repository version is right.
@@ -287,7 +289,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	 */
 	check_repository_format();
 
-	create_default_files(git_dir, template_dir);
+	reinit = create_default_files(git_dir, template_dir);
 
 	/*
 	 * And set up the object store.
@@ -314,5 +316,10 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
+	printf("%s%s Git repository in %s/\n",
+		reinit ? "Reinitialized existing" : "Initialized empty",
+		shared_repository ? " shared" : "",
+		git_dir);
+
 	return 0;
 }
-- 
