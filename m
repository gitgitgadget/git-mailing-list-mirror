From: Brad Roberts <braddr@gameboy2.puremagic.com>
Subject: [PATCH 18/19] rename cache_match_stat to ce_match_stat to match other cache_entry related functions/macros
Date: Thu, 21 Apr 2005 11:39:06 -0700
Message-ID: <200504211839.j3LId6eV027844@gameboy2.puremagic.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:36:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOgWZ-0008Rn-0a
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 20:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVDUSj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 14:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVDUSj7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 14:39:59 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:20873 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261684AbVDUSjU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 14:39:20 -0400
Received: from gameboy2.puremagic.com (root@gameboy2.puremagic.com [209.189.198.109])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3LId4Up028237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:39:05 -0700
Received: from gameboy2.puremagic.com (braddr@localhost [127.0.0.1])
	by gameboy2.puremagic.com (8.13.3/8.13.3/Debian-3) with ESMTP id j3LId6Zx027846
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 11:39:06 -0700
Received: (from braddr@localhost)
	by gameboy2.puremagic.com (8.13.3/8.13.3/Submit) id j3LId6eV027844
	for git@vger.kernel.org; Thu, 21 Apr 2005 11:39:06 -0700
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree f8dd454f774d42526149193970b612a46f3ddd26
parent 058c25fd81e5949354d96f2aad222ae73a6c1dee
author Brad Roberts <braddr@puremagic.com> 1114088345 -0700
committer Brad Roberts <braddr@gameboy2.puremagic.com> 1114088345 -0700

[PATCH] rename cache_match_stat to ce_match_stat to match other cache_entry related functions/macros

Signed-off-by: Brad Roberts <braddr@puremagic.com>
---

 cache.h          |    3 ++-
 check-files.c    |    2 +-
 checkout-cache.c |    2 +-
 diff-cache.c     |    2 +-
 read-cache.c     |    2 +-
 show-diff.c      |    2 +-
 update-cache.c   |    2 +-
 7 files changed, 8 insertions(+), 7 deletions(-)

Index: cache.h
===================================================================
--- 058c25fd81e5949354d96f2aad222ae73a6c1dee:1/cache.h  (mode:100644 sha1:a3018f9e12bfdd1a5273b20fcab5062667c6caec)
+++ 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/cache.h  (mode:100644 sha1:c64969602d80a0e9d7137b2716fb808c912b075c)
@@ -52,6 +52,8 @@
 #define CE_STAGEMASK (0x3000)
 #define CE_STAGESHIFT 12
 
+extern int ce_match_stat(struct cache_entry *ce, struct stat *st);
+
 #define create_ce_flags(len, stage) htons((len) | ((stage) << CE_STAGESHIFT))
 #define ce_namelen(ce) (CE_NAMEMASK & ntohs((ce)->ce_flags))
 #define ce_size(ce) cache_entry_size(ce_namelen(ce))
@@ -76,7 +78,6 @@
 extern int cache_name_pos(const char *name, int namelen);
 extern int add_cache_entry(struct cache_entry *ce, int ok_to_add);
 extern int remove_file_from_cache(char *path);
-extern int cache_match_stat(struct cache_entry *ce, struct stat *st);
 extern int get_num_cache_entries();
 extern struct cache_entry * get_cache_entry(int pos);
 extern void set_cache_entry(struct cache_entry *ce, int pos);
Index: check-files.c
===================================================================
--- 058c25fd81e5949354d96f2aad222ae73a6c1dee:1/check-files.c  (mode:100644 sha1:919e418b5f0f85220445c876a37bf4cf61d26525)
+++ 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/check-files.c  (mode:100644 sha1:0973e81fbbc0f9f98031fb249254bd89d8088889)
@@ -31,7 +31,7 @@
 	if (fstat(fd, &st) < 0)
 		die("fstat(%s): %s", path, strerror(errno));
 
-	changed = cache_match_stat(ce, &st);
+	changed = ce_match_stat(ce, &st);
 	if (changed)
 		die("preparing to update file '%s' not uptodate in cache", path);
 }
Index: checkout-cache.c
===================================================================
--- 058c25fd81e5949354d96f2aad222ae73a6c1dee:1/checkout-cache.c  (mode:100644 sha1:bf9cd0572c883219d37f2788ec5f5553a136df2b)
+++ 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/checkout-cache.c  (mode:100644 sha1:27b559d5bcc5831eda441bcd1fd88d687f2567b8)
@@ -100,7 +100,7 @@
 	struct stat st;
 
 	if (!stat(ce->name, &st)) {
-		unsigned changed = cache_match_stat(ce, &st);
+		unsigned changed = ce_match_stat(ce, &st);
 		if (!changed)
 			return 0;
 		if (!force) {
Index: diff-cache.c
===================================================================
--- 058c25fd81e5949354d96f2aad222ae73a6c1dee:1/diff-cache.c  (mode:100644 sha1:548211944fc00594bfc06b9ab90f0cb476688285)
+++ 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/diff-cache.c  (mode:100644 sha1:5ae6d5de5ed5ad34f72267904ff8eb6288855fc5)
@@ -125,7 +125,7 @@
 			show_file("-", path1, mode1, sha1, base);
 			return -1;
 		}
-		changed = cache_match_stat(ce, &st);
+		changed = ce_match_stat(ce, &st);
 		close(fd);
 		if (changed) {
 			mode2 = st.st_mode;
Index: read-cache.c
===================================================================
--- 058c25fd81e5949354d96f2aad222ae73a6c1dee:1/read-cache.c  (mode:100644 sha1:31e293a3686622c9ec180d41aa37d85ce49325e8)
+++ 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/read-cache.c  (mode:100644 sha1:8837d27ab683bf07d38aee33c62a90f5a7221588)
@@ -44,7 +44,7 @@
 	cache = NULL;
 }
 
-int cache_match_stat(struct cache_entry *ce, struct stat *st)
+int ce_match_stat(struct cache_entry *ce, struct stat *st)
 {
 	unsigned int changed = 0;
 
Index: show-diff.c
===================================================================
--- 058c25fd81e5949354d96f2aad222ae73a6c1dee:1/show-diff.c  (mode:100644 sha1:6e04e9182667cbb79afa4c878a31b685fdea3229)
+++ 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/show-diff.c  (mode:100644 sha1:4a0902f50b3120b7791a4d4627a9a4f729afdcf7)
@@ -193,7 +193,7 @@
 			}
 			continue;
 		}
-		changed = cache_match_stat(ce, &st);
+		changed = ce_match_stat(ce, &st);
 		if (!changed)
 			continue;
 		if (!machine_readable)
Index: update-cache.c
===================================================================
--- 058c25fd81e5949354d96f2aad222ae73a6c1dee:1/update-cache.c  (mode:100644 sha1:8328975cb726f5e06a413a9f0099bfa2f81d3381)
+++ 0a556dc01b8e48f684ce6e0c26f8c00b5e39c4ac:1/update-cache.c  (mode:100644 sha1:3f251552283667c42797835088a4922ef865fe4a)
@@ -179,7 +179,7 @@
 	if (stat(ce->name, &st) < 0)
 		return NULL;
 
-	changed = cache_match_stat(ce, &st);
+	changed = ce_match_stat(ce, &st);
 	if (!changed)
 		return ce;
 

