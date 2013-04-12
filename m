From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH 2/3] Add size parameter to read_index_data()
Date: Fri, 12 Apr 2013 19:26:12 +0200
Message-ID: <1365787573-597-3-git-send-email-git@cryptocrack.de>
References: <1365787573-597-1-git-send-email-git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 12 19:26:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQhkA-0004WE-Vl
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 19:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901Ab3DLR0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 13:26:22 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:17947 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab3DLR0R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 13:26:17 -0400
Received: from localhost (p57B41A7F.dip.t-dialin.net [87.180.26.127])
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id f847db5d
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128)
	for <git@vger.kernel.org>; Fri, 12 Apr 2013 19:26:16 +0200 (CEST)
X-Mailer: git-send-email 1.8.2.675.gda3bb24.dirty
In-Reply-To: <1365787573-597-1-git-send-email-git@cryptocrack.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221005>

This allows for optionally getting the size of the returned data and
will be used in a follow-up patch.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
 attr.c       | 2 +-
 cache.h      | 2 +-
 read-cache.c | 5 ++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/attr.c b/attr.c
index 2e1ce7b..e5af3c6 100644
--- a/attr.c
+++ b/attr.c
@@ -387,7 +387,7 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	char *buf, *sp;
 	int lineno = 0;
 
-	buf = read_index_data(path, use_index);
+	buf = read_index_data(path, use_index, NULL);
 	if (!buf)
 		return NULL;
 
diff --git a/cache.h b/cache.h
index a71e443..b281bbf 100644
--- a/cache.h
+++ b/cache.h
@@ -471,7 +471,7 @@ extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 extern int index_name_is_other(const struct index_state *, const char *, int);
-extern void *read_index_data(const char *path, struct index_state *use_index);
+extern void *read_index_data(const char *path, struct index_state *use_index, unsigned long *size);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
diff --git a/read-cache.c b/read-cache.c
index 39e3424..32dc471 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1900,7 +1900,8 @@ int index_name_is_other(const struct index_state *istate, const char *name,
 	return 1;
 }
 
-void *read_index_data(const char *path, struct index_state *use_index)
+void *read_index_data(const char *path, struct index_state *use_index,
+		      unsigned long *size)
 {
 	int pos, len;
 	unsigned long sz;
@@ -1930,5 +1931,7 @@ void *read_index_data(const char *path, struct index_state *use_index)
 		free(data);
 		return NULL;
 	}
+	if (size)
+		*size = sz;
 	return data;
 }
-- 
1.8.2.675.gda3bb24.dirty
