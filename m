From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/7] git_dir holds pointers to local strings, hence MUST be const.
Date: Wed, 23 Aug 2006 12:39:11 +0200
Message-ID: <11563295562422-git-send-email-madcoder@debian.org>
References: 200608231238.10963.madcoder@debian.org <11563295562072-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Aug 23 12:41:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFq99-0007TY-D8
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 12:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWHWKje (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 06:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWHWKjZ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 06:39:25 -0400
Received: from rudy.intersec.eu ([88.191.20.202]:33953 "EHLO mx2.intersec.fr")
	by vger.kernel.org with ESMTP id S964829AbWHWKjU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 06:39:20 -0400
Received: from localhost.localdomain (beacon-free1.intersec.eu [81.57.219.236])
	by mx1.intersec.eu (Postfix) with ESMTP id 23E88D81BA;
	Wed, 23 Aug 2006 12:39:17 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1003)
	id EE8433FFEE; Wed, 23 Aug 2006 12:39:16 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.g4caa
In-Reply-To: <11563295562072-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25912>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 cache.h       |    2 +-
 environment.c |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 08d6a91..3044794 100644
--- a/cache.h
+++ b/cache.h
@@ -123,7 +123,7 @@ #define DB_ENVIRONMENT "GIT_OBJECT_DIREC
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 
-extern char *get_git_dir(void);
+extern const char *get_git_dir(void);
 extern char *get_object_directory(void);
 extern char *get_refs_directory(void);
 extern char *get_index_file(void);
diff --git a/environment.c b/environment.c
index e6bd003..5fae9ac 100644
--- a/environment.c
+++ b/environment.c
@@ -25,8 +25,9 @@ int zlib_compression_level = Z_DEFAULT_C
 int pager_in_use;
 int pager_use_color = 1;
 
-static char *git_dir, *git_object_dir, *git_index_file, *git_refs_dir,
-	*git_graft_file;
+static const char *git_dir;
+static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
+
 static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
@@ -49,7 +50,7 @@ static void setup_git_env(void)
 		git_graft_file = strdup(git_path("info/grafts"));
 }
 
-char *get_git_dir(void)
+const char *get_git_dir(void)
 {
 	if (!git_dir)
 		setup_git_env();
-- 
1.4.1.1
