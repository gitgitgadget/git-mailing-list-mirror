From: Guanqun Lu <guanqun.lu@gmail.com>
Subject: [PATCH 2/2] add test-dump-cache-tree in Makefile
Date: Thu,  5 Feb 2009 05:00:41 +0800
Message-ID: <1233781241-721-2-git-send-email-guanqun.lu@gmail.com>
References: <1233781241-721-1-git-send-email-guanqun.lu@gmail.com>
Cc: Guanqun Lu <guanqun.lu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 05:58:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUZqd-0008Qo-3O
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 05:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbZBDE5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 23:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbZBDE5S
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 23:57:18 -0500
Received: from mail-gx0-f26.google.com ([209.85.217.26]:40233 "EHLO
	mail-gx0-f26.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbZBDE5S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 23:57:18 -0500
Received: by gxk7 with SMTP id 7so1188004gxk.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 20:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yR1iJIq43EXOY2Xh9TlYW47pIf87FwCEfcxY06UxzcY=;
        b=sanOFFqbGR4kV+5KozeRA/hr0Y7ueOnz8ulorgrij/3ii7VIsyKEJ/tlDRjXr7fXb3
         TTVicz/kV28lCnd/aql/lpPk8YGMMFm0l12LeiQElxHRVZoHrxwbRwt0fC0X4ytO2V8E
         aA3Eq2d8k4HGX2pxhvcbp7PNZDFAYHFw4Ojyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ClvGRVxeR8sAZNZO5AFV8XrUlysEykjvlHF5t13//DatL1VEDLfqKu9Rfx1tAWcR1p
         Ce9LZUmmXuHBG2fvjvKqr/g53JlBkA2lKQ+I/yfrsP9V2fq1e0JTjLP2y4lsvS83TvqC
         95K30wrzy5lH1S3OAX1UjxgkGQTUqtsdXa4SQ=
Received: by 10.110.7.18 with SMTP id 18mr3006012tig.16.1233723435632;
        Tue, 03 Feb 2009 20:57:15 -0800 (PST)
Received: from localhost ([202.120.224.18])
        by mx.google.com with ESMTPS id 2sm2698472tif.33.2009.02.03.20.57.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Feb 2009 20:57:15 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2.321.g4a9f7
In-Reply-To: <1233781241-721-1-git-send-email-guanqun.lu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108294>

5c5ba73b21a6910ee67d97cb87a5d78409112375 tries to use
generic rule to build test programs, but it misses the file
'dump-cache-tree.c', since its name is not prefixed by 'test-'.
This commit solves this little problem by renaming this file
instead of carrying out an explicit rule in Makefile.

Signed-off-by: Guanqun Lu <guanqun.lu@gmail.com>
---
 Makefile               |    1 +
 dump-cache-tree.c      |   64 ------------------------------------------------
 test-dump-cache-tree.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 64 deletions(-)
 delete mode 100644 dump-cache-tree.c
 create mode 100644 test-dump-cache-tree.c

diff --git a/Makefile b/Makefile
index 9f3a8ab..b90ff39 100644
--- a/Makefile
+++ b/Makefile
@@ -1388,6 +1388,7 @@ TEST_PROGRAMS += test-parse-options$X
 TEST_PROGRAMS += test-path-utils$X
 TEST_PROGRAMS += test-sha1$X
 TEST_PROGRAMS += test-sigchain$X
+TEST_PROGRAMS += test-dump-cache-tree$X
 
 all:: $(TEST_PROGRAMS)
 
diff --git a/dump-cache-tree.c b/dump-cache-tree.c
deleted file mode 100644
index 1f73f1e..0000000
--- a/dump-cache-tree.c
+++ /dev/null
@@ -1,64 +0,0 @@
-#include "cache.h"
-#include "tree.h"
-#include "cache-tree.h"
-
-
-static void dump_one(struct cache_tree *it, const char *pfx, const char *x)
-{
-	if (it->entry_count < 0)
-		printf("%-40s %s%s (%d subtrees)\n",
-		       "invalid", x, pfx, it->subtree_nr);
-	else
-		printf("%s %s%s (%d entries, %d subtrees)\n",
-		       sha1_to_hex(it->sha1), x, pfx,
-		       it->entry_count, it->subtree_nr);
-}
-
-static int dump_cache_tree(struct cache_tree *it,
-			   struct cache_tree *ref,
-			   const char *pfx)
-{
-	int i;
-	int errs = 0;
-
-	if (!it || !ref)
-		/* missing in either */
-		return 0;
-
-	if (it->entry_count < 0) {
-		dump_one(it, pfx, "");
-		dump_one(ref, pfx, "#(ref) ");
-		if (it->subtree_nr != ref->subtree_nr)
-			errs = 1;
-	}
-	else {
-		dump_one(it, pfx, "");
-		if (hashcmp(it->sha1, ref->sha1) ||
-		    ref->entry_count != it->entry_count ||
-		    ref->subtree_nr != it->subtree_nr) {
-			dump_one(ref, pfx, "#(ref) ");
-			errs = 1;
-		}
-	}
-
-	for (i = 0; i < it->subtree_nr; i++) {
-		char path[PATH_MAX];
-		struct cache_tree_sub *down = it->down[i];
-		struct cache_tree_sub *rdwn;
-
-		rdwn = cache_tree_sub(ref, down->name);
-		sprintf(path, "%s%.*s/", pfx, down->namelen, down->name);
-		if (dump_cache_tree(down->cache_tree, rdwn->cache_tree, path))
-			errs = 1;
-	}
-	return errs;
-}
-
-int main(int ac, char **av)
-{
-	struct cache_tree *another = cache_tree();
-	if (read_cache() < 0)
-		die("unable to read index file");
-	cache_tree_update(another, active_cache, active_nr, 0, 1);
-	return dump_cache_tree(active_cache_tree, another, "");
-}
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
new file mode 100644
index 0000000..1f73f1e
--- /dev/null
+++ b/test-dump-cache-tree.c
@@ -0,0 +1,64 @@
+#include "cache.h"
+#include "tree.h"
+#include "cache-tree.h"
+
+
+static void dump_one(struct cache_tree *it, const char *pfx, const char *x)
+{
+	if (it->entry_count < 0)
+		printf("%-40s %s%s (%d subtrees)\n",
+		       "invalid", x, pfx, it->subtree_nr);
+	else
+		printf("%s %s%s (%d entries, %d subtrees)\n",
+		       sha1_to_hex(it->sha1), x, pfx,
+		       it->entry_count, it->subtree_nr);
+}
+
+static int dump_cache_tree(struct cache_tree *it,
+			   struct cache_tree *ref,
+			   const char *pfx)
+{
+	int i;
+	int errs = 0;
+
+	if (!it || !ref)
+		/* missing in either */
+		return 0;
+
+	if (it->entry_count < 0) {
+		dump_one(it, pfx, "");
+		dump_one(ref, pfx, "#(ref) ");
+		if (it->subtree_nr != ref->subtree_nr)
+			errs = 1;
+	}
+	else {
+		dump_one(it, pfx, "");
+		if (hashcmp(it->sha1, ref->sha1) ||
+		    ref->entry_count != it->entry_count ||
+		    ref->subtree_nr != it->subtree_nr) {
+			dump_one(ref, pfx, "#(ref) ");
+			errs = 1;
+		}
+	}
+
+	for (i = 0; i < it->subtree_nr; i++) {
+		char path[PATH_MAX];
+		struct cache_tree_sub *down = it->down[i];
+		struct cache_tree_sub *rdwn;
+
+		rdwn = cache_tree_sub(ref, down->name);
+		sprintf(path, "%s%.*s/", pfx, down->namelen, down->name);
+		if (dump_cache_tree(down->cache_tree, rdwn->cache_tree, path))
+			errs = 1;
+	}
+	return errs;
+}
+
+int main(int ac, char **av)
+{
+	struct cache_tree *another = cache_tree();
+	if (read_cache() < 0)
+		die("unable to read index file");
+	cache_tree_update(another, active_cache, active_nr, 0, 1);
+	return dump_cache_tree(active_cache_tree, another, "");
+}
-- 
1.6.1.2.321.g4a9f7
