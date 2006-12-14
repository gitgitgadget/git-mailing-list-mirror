X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Stop telling users we are 'defaulting to local storage area'.
Date: Thu, 14 Dec 2006 18:09:02 -0500
Message-ID: <20061214230902.GA26506@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 23:09:12 +0000 (UTC)
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34428>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzhO-0007a9-Vx for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751731AbWLNXJI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWLNXJI
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:09:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40941 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751731AbWLNXJG (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 18:09:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Guzh8-0005Lq-Ri; Thu, 14 Dec 2006 18:08:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0593320FB65; Thu, 14 Dec 2006 18:09:02 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Back in the old days of Git when people messed around with their
GIT_DIR environment variable more often it was nice to know whether
or not git-init-db created a .git directory or used GIT_DIR.

But now that we are making excuses in the documentation about why
this message gets printed by git-init-db we should just remove it
entirely.  It doesn't really help the user to understand what just
happened.  It also breaks from our normal behavior of not printing
anything if the command was successful.

Suggested by Andy Parkins in his Git 'niggles' list
(<200612132237.10051.andyparkins@gmail.com>).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/core-tutorial.txt |   14 +++-----------
 Documentation/tutorial-2.txt    |    1 -
 Documentation/tutorial.txt      |    6 ------
 builtin-init-db.c               |    4 +---
 4 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 47505aa..f90c66c 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -54,17 +54,9 @@ $ cd git-tutorial
 $ git-init-db
 ------------------------------------------------
 
-to which git will reply
-
-----------------
-defaulting to local storage area
-----------------
-
-which is just git's way of saying that you haven't been doing anything
-strange, and that it will have created a local `.git` directory setup for
-your new project. You will now have a `.git` directory, and you can
-inspect that with `ls`. For your new empty project, it should show you
-three entries, among other things:
+You will now have a `.git` directory, and you can inspect that with
+`ls`. For your new empty project, it should show you three entries,
+among other things:
 
  - a file called `HEAD`, that has `ref: refs/heads/master` in it.
    This is similar to a symbolic link and points at
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index 6389de5..f7f2e1c 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -18,7 +18,6 @@ Let's start a new project and create a small amount of history:
 $ mkdir test-project
 $ cd test-project
 $ git init-db
-defaulting to local storage area
 $ echo 'hello world' > file.txt
 $ git add .
 $ git commit -a -m "initial commit"
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 02dede3..88ace3b 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -35,12 +35,6 @@ $ cd project
 $ git init-db
 ------------------------------------------------
 
-Git will reply
-
-------------------------------------------------
-defaulting to local storage area
-------------------------------------------------
-
 You've now initialized the working directory--you may notice a new
 directory created, named ".git".  Tell git that you want it to track
 every file under the current directory with (notice the dot '.'
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 235a0ee..405b9a1 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -274,10 +274,8 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
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
-- 
