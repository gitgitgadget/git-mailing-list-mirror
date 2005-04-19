From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 4/8] init-db.c: add INDEX_FILE_DIRECTORY support
Date: Tue, 19 Apr 2005 02:09:39 -0700
Message-ID: <mailbox-23311-1113901779-728644@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Apr 19 11:07:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNogw-0005bF-13
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 11:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVDSJKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 05:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDSJKm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 05:10:42 -0400
Received: from guft.superlucidity.net ([63.224.205.130]:50574 "EHLO
	mail.guft.org") by vger.kernel.org with ESMTP id S261320AbVDSJJt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 05:09:49 -0400
Received: (qmail 23333 invoked by uid 5006); 19 Apr 2005 02:09:47 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-23311-1113901779-711084@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch give init-db the ability for the index directory to be 
overridden by the INDEX_FILE_DIRECTORY environment variable.

This patch applies on top of:
        [PATCH 0/8] init-db.c cleanup, add INDEX_FILE_DIRECTORY support
        [PATCH 1/8] init-db.c: [RESEND] remove redundant getenv call
        [PATCH 2/8] init-db.c: [RESEND] make init-db work with common objects
        [PATCH 3/8] init-db.c: refactor directory creation
 cache.h   |    3 +++
 init-db.c |    5 +----
 2 files changed, 4 insertions(+), 4 deletions(-)
Signed-Off-By: Zach Welch <zw@superlucidity.net>


--- a/cache.h	2005-04-18 21:13:36.000000000 -0700
+++ b/cache.h	2005-04-18 21:13:44.000000000 -0700
@@ -81,6 +81,9 @@
 struct cache_entry **active_cache;
 unsigned int active_nr, active_alloc;
 
+#define INDEX_ENVIRONMENT "INDEX_FILE_DIRECTORY"
+#define DEFAULT_INDEX_ENVIRONMENT ".git"
+
 #define DB_ENVIRONMENT "SHA1_FILE_DIRECTORY"
 #define DEFAULT_DB_ENVIRONMENT ".git/objects"
 
--- a/init-db.c	2005-04-18 21:21:02.000000000 -0700
+++ b/init-db.c	2005-04-18 21:15:14.000000000 -0700
@@ -42,10 +42,7 @@
 	char *sha1_dir, *path;
 	int len, i;
 
-	if (mkdir(".git", 0755) < 0) {
-		perror("unable to create .git directory");
-		exit(1);
-	}
+	(void) init_dir(INDEX_ENVIRONMENT, DEFAULT_INDEX_ENVIRONMENT, "index", NULL);
 	sha1_dir = init_dir(DB_ENVIRONMENT, DEFAULT_DB_ENVIRONMENT, "storage", &len);
 	
 	path = malloc(len + 40);
