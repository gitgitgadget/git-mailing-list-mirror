From: Zach Welch <zw@superlucidity.net>
Subject: [PATCH 2/3] rename object directory symbols
Date: Tue, 19 Apr 2005 21:32:06 -0700
Message-ID: <mailbox-1370-1113971526-296848@spoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Apr 20 06:28:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO6pM-0007Yy-No
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 06:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVDTEct (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 00:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVDTEct
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 00:32:49 -0400
Received: from guft.superlucidity.net ([63.224.205.130]:23439 "EHLO
	mail.guft.org") by vger.kernel.org with ESMTP id S261360AbVDTEcL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 00:32:11 -0400
Received: (qmail 1383 invoked by uid 5006); 19 Apr 2005 21:32:10 -0700
To: git@vger.kernel.org
In-Reply-To: mailbox-1370-1113971526-282751@spoon
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch applies on top of:
        [PATCH 1/3] add GIT_CACHE_DIRECTORY support

 cache.h      |    4 ++--
 fsck-cache.c |    2 +-
 init-db.c    |    4 ++--
 ls-tree.c    |    4 ++--
 read-cache.c |    4 ++--
 sha1_file.c  |    2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

Signed-Off-By: Zach Welch <zw@superlucidity.net>

Rename the DB_ENVIRONMENT symbols to match the newly introduced
GIT_CACHE_ENVIROMENT symbols.

cache.h: 1fca894f485471d51c6a72c16e02df6d56d0052f
--- a/cache.h
+++ b/cache.h
@@ -84,8 +84,8 @@ unsigned int active_nr, active_alloc;
 #define GIT_CACHE_ENVIRONMENT "GIT_CACHE_DIRECTORY"
 #define DEFAULT_GIT_CACHE_ENVIRONMENT ".git"
 
-#define DB_ENVIRONMENT "SHA1_FILE_DIRECTORY"
-#define DEFAULT_DB_ENVIRONMENT ".git/objects"
+#define GIT_OBJECT_ENVIRONMENT "SHA1_FILE_DIRECTORY"
+#define DEFAULT_GIT_OBJECT_ENVIRONMENT ".git/objects"
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
fsck-cache.c: cf39b7e054d9685fde7004ec767cd098b97e8ce7
--- a/fsck-cache.c
+++ b/fsck-cache.c
@@ -135,7 +135,7 @@ int main(int argc, char **argv)
 	int i, heads;
 	char *sha1_dir;
 
-	sha1_dir = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
+	sha1_dir = getenv(GIT_OBJECT_ENVIRONMENT) ? : DEFAULT_GIT_OBJECT_ENVIRONMENT;
 	for (i = 0; i < 256; i++) {
 		static char dir[4096];
 		sprintf(dir, "%s/%02x", sha1_dir, i);
init-db.c: 9e693a0a914512c5574f394222cfc75496e3453a
--- a/init-db.c
+++ b/init-db.c
@@ -33,9 +33,9 @@ int main(int argc, char **argv)
 	}	
 	safe_create_dir(git_dir);
 
-	sha1_dir = getenv(DB_ENVIRONMENT);
+	sha1_dir = getenv(GIT_OBJECT_ENVIRONMENT);
 	if (!sha1_dir) {
-		sha1_dir = DEFAULT_DB_ENVIRONMENT;
+		sha1_dir = DEFAULT_GIT_OBJECT_ENVIRONMENT;
 		fprintf(stderr, "defaulting to local storage area\n");
 	}
 	len = strlen(sha1_dir);
ls-tree.c: 936bb19a5525046a5a784d5f14c3ea7da406cc62
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -105,9 +105,9 @@ int main(int argc, char **argv)
 		usage(ls_tree_usage);
 	if (get_sha1_hex(argv[1], sha1) < 0)
 		usage(ls_tree_usage);
-	sha1_file_directory = getenv(DB_ENVIRONMENT);
+	sha1_file_directory = getenv(GIT_OBJECT_ENVIRONMENT);
 	if (!sha1_file_directory)
-		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
+		sha1_file_directory = DEFAULT_GIT_OBJECT_ENVIRONMENT;
 	if (list(sha1) < 0)
 		die("list failed");
 	return 0;
read-cache.c: 9eee23097b9406548765ec6fc77e61788317df19
--- a/read-cache.c
+++ b/read-cache.c
@@ -186,9 +186,9 @@ int read_cache(void)
 		return error("more than one cachefile");
 	errno = ENOENT;
 
-	sha1_file_directory = getenv(DB_ENVIRONMENT);
+	sha1_file_directory = getenv(GIT_OBJECT_ENVIRONMENT);
 	if (!sha1_file_directory)
-		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;
+		sha1_file_directory = DEFAULT_GIT_OBJECT_ENVIRONMENT;
 	if (access(sha1_file_directory, X_OK) < 0)
 		return error("no access to SHA1 file directory");
 
sha1_file.c: c4591cd2168ae2e42c1fc9878be8befbfa1a8afa
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -61,7 +61,7 @@ char *sha1_file_name(const unsigned char
 	static char *name, *base;
 
 	if (!base) {
-		char *sha1_file_directory = getenv(DB_ENVIRONMENT) ? : DEFAULT_DB_ENVIRONMENT;
+		char *sha1_file_directory = getenv(GIT_OBJECT_ENVIRONMENT) ? : DEFAULT_GIT_OBJECT_ENVIRONMENT;
 		int len = strlen(sha1_file_directory);
 		base = malloc(len + 60);
 		memcpy(base, sha1_file_directory, len);
