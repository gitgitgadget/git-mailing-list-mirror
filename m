From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH v2 2/3] Add size parameter to read_blob_data_from_index_path()
Date: Sat, 13 Apr 2013 15:28:31 +0200
Message-ID: <1365859712-8400-2-git-send-email-git@cryptocrack.de>
References: <1365787573-597-1-git-send-email-git@cryptocrack.de>
 <1365859712-8400-1-git-send-email-git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 13 15:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR0Vj-00028h-Q9
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 15:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab3DMN2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 09:28:52 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:18563 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab3DMN2h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 09:28:37 -0400
Received: from localhost (p57B40B0C.dip.t-dialin.net [87.180.11.12])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 5d8e9e95
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128)
	for <git@vger.kernel.org>; Sat, 13 Apr 2013 15:28:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.675.gda3bb24.dirty
In-Reply-To: <1365859712-8400-1-git-send-email-git@cryptocrack.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221060>

This allows for optionally getting the size of the returned data and
will be used in a follow-up patch.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
 attr.c       | 2 +-
 cache.h      | 2 +-
 read-cache.c | 5 ++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 08347b6..17338c8 100644
--- a/attr.c
+++ b/attr.c
@@ -387,7 +387,7 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	char *buf, *sp;
 	int lineno = 0;
 
-	buf = read_blob_data_from_index_path(path, use_index);
+	buf = read_blob_data_from_index_path(path, use_index, NULL);
 	if (!buf)
 		return NULL;
 
diff --git a/cache.h b/cache.h
index 2a206aa..a5272f2 100644
--- a/cache.h
+++ b/cache.h
@@ -471,7 +471,7 @@ extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 extern int index_name_is_other(const struct index_state *, const char *, int);
-extern void *read_blob_data_from_index_path(const char *path, struct index_state *use_index);
+extern void *read_blob_data_from_index_path(const char *path, struct index_state *use_index, unsigned long *size);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/read-cache.c b/read-cache.c
index 964ae26..547e98a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1901,7 +1901,8 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 }
 
 void *read_blob_data_from_index_path(const char *path,
-				     struct index_state *use_index)
+				     struct index_state *use_index,
+				     unsigned long *size)
 {
 	int pos, len;
 	unsigned long sz;
@@ -1931,5 +1932,7 @@ void *read_blob_data_from_index_path(const char *path,
 		free(data);
 		return NULL;
 	}
+	if (size)
+		*size = sz;
 	return data;
 }
-- 
1.8.2.675.gda3bb24.dirty
