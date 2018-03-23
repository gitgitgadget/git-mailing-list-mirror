Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B875C1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeCWRVz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:21:55 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39445 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbeCWRVo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:44 -0400
Received: by mail-lf0-f68.google.com with SMTP id p142-v6so19385402lfd.6
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYB1186DPrc5M4tzjA1IXy8jcl5R/qiGEpcKhVMRXmQ=;
        b=b9LSXG6sWSYmlC4atOm8kx9qD1+shDsHrOQOHn2KrTMH1cXr19VNsiOI0ixcd6FoKM
         OChRIh5RTpLBPfHO9jk7g5etW/D7mnAgPANhRlEGDpauFODfKKEb+pKQIn2uxs2K8maJ
         tkl+awoQ9FG9Grv994O+vuam8fxTPSkeSyVUBFfnxsknrf8K3gqFE6+JeE64TW+KlChF
         4PVqKxA98Kns3BDIsv8nW+fYK+4OCuo8nqy8wxhQV1RbiQhQrUZ8kf2NPCPNMyHMeXjX
         ZW+Yp94LWe8iyd0s4Yw+27spFxJO+E3yEWyfvEUAmJdKGX/7pPDoMFXJKJ7Ta7miTInu
         jqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CYB1186DPrc5M4tzjA1IXy8jcl5R/qiGEpcKhVMRXmQ=;
        b=MOjvE6ZOy+0hU+tozItbO82AbALUisaApmwn7GGTHJyR8KjkTgd5/Cgt0j2+RkhX2m
         54c10KP3+/Ai95naxy70qGSuuIREgBFNYn6IYwjrMAlE5KmGPfMZm0Pnj/sk1c43uThC
         6N6ze6phbZFGtPC/QNGtIkOU0BYKWYN8a8/gS6uUzlnXzLFBo+DhqhnbX5y7lJU/nDoq
         lf6/GIxAI/I9FgZa0WlAAiyvr4i7GOj1KgyEfevpQgNZeTGy5Ii9sk2walJFyIVLRBCV
         bXEl0paUv7HtfGzHhRsyPn5F/kGE1GCpMC9kcdW5woBtzRqCHbmTOCsv1iXwgWiUkxZj
         pKRQ==
X-Gm-Message-State: AElRT7F1rF4epQ6TR5fdXiuprZw+YYg9qRKfwxD9ewnzuTKd3LAjOrN0
        z3HdOqE6/nRpRbF9bXWybPA=
X-Google-Smtp-Source: AG47ELuWE0YjEK2xqNHI4kblTHWzp9m53u5WU/+40gtqjh14R9OugjGmuU3u7fp1ehuh/cpIEdwdpg==
X-Received: by 10.46.152.203 with SMTP id s11mr19362444ljj.92.1521825702936;
        Fri, 23 Mar 2018 10:21:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 02/27] object-store: migrate alternates struct and functions from cache.h
Date:   Fri, 23 Mar 2018 18:20:56 +0100
Message-Id: <20180323172121.17725-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Migrate the struct alternate_object_database and all its related
functions to the object store as these functions are easier found in
that header. The migration is just a verbatim copy, no need to
include the object store header at any C file, because cache.h includes
repository.h which in turn includes the object-store.h

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/clone.c             |  1 +
 builtin/count-objects.c     |  1 +
 builtin/fsck.c              |  1 +
 builtin/submodule--helper.c |  1 +
 cache.h                     | 51 -------------------------------------
 object-store.h              | 51 +++++++++++++++++++++++++++++++++++++
 packfile.c                  |  1 +
 sha1_name.c                 |  1 +
 submodule.c                 |  1 +
 t/helper/test-ref-store.c   |  1 +
 tmp-objdir.c                |  1 +
 transport.c                 |  1 +
 12 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 101c27a593..855947f1ab 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -27,6 +27,7 @@
 #include "connected.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "object-store.h"
 
 /*
  * Overall FIXMEs:
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 33343818c8..ced8958e43 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -11,6 +11,7 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static unsigned long garbage;
 static off_t size_garbage;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7a8a679d4f..b0eba4c3c9 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -16,6 +16,7 @@
 #include "streaming.h"
 #include "decorate.h"
 #include "packfile.h"
+#include "object-store.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b1daca995f..6d8e002be7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -16,6 +16,7 @@
 #include "revision.h"
 #include "diffcore.h"
 #include "diff.h"
+#include "object-store.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
diff --git a/cache.h b/cache.h
index 41ba67cc16..41530d5d16 100644
--- a/cache.h
+++ b/cache.h
@@ -1576,57 +1576,6 @@ extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
 
-extern struct alternate_object_database {
-	struct alternate_object_database *next;
-
-	/* see alt_scratch_buf() */
-	struct strbuf scratch;
-	size_t base_len;
-
-	/*
-	 * Used to store the results of readdir(3) calls when searching
-	 * for unique abbreviated hashes.  This cache is never
-	 * invalidated, thus it's racy and not necessarily accurate.
-	 * That's fine for its purpose; don't use it for tasks requiring
-	 * greater accuracy!
-	 */
-	char loose_objects_subdir_seen[256];
-	struct oid_array loose_objects_cache;
-
-	char path[FLEX_ARRAY];
-} *alt_odb_list;
-extern void prepare_alt_odb(void);
-extern char *compute_alternate_path(const char *path, struct strbuf *err);
-typedef int alt_odb_fn(struct alternate_object_database *, void *);
-extern int foreach_alt_odb(alt_odb_fn, void*);
-
-/*
- * Allocate a "struct alternate_object_database" but do _not_ actually
- * add it to the list of alternates.
- */
-struct alternate_object_database *alloc_alt_odb(const char *dir);
-
-/*
- * Add the directory to the on-disk alternates file; the new entry will also
- * take effect in the current process.
- */
-extern void add_to_alternates_file(const char *dir);
-
-/*
- * Add the directory to the in-memory list of alternates (along with any
- * recursive alternates it points to), but do not modify the on-disk alternates
- * file.
- */
-extern void add_to_alternates_memory(const char *dir);
-
-/*
- * Returns a scratch strbuf pre-filled with the alternate object directory,
- * including a trailing slash, which can be used to access paths in the
- * alternate. Always use this over direct access to alt->scratch, as it
- * cleans up any previous use of the scratch buffer.
- */
-extern struct strbuf *alt_scratch_buf(struct alternate_object_database *alt);
-
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
diff --git a/object-store.h b/object-store.h
index abfaae059b..5002e373cd 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,6 +1,57 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
+extern struct alternate_object_database {
+	struct alternate_object_database *next;
+
+	/* see alt_scratch_buf() */
+	struct strbuf scratch;
+	size_t base_len;
+
+	/*
+	 * Used to store the results of readdir(3) calls when searching
+	 * for unique abbreviated hashes.  This cache is never
+	 * invalidated, thus it's racy and not necessarily accurate.
+	 * That's fine for its purpose; don't use it for tasks requiring
+	 * greater accuracy!
+	 */
+	char loose_objects_subdir_seen[256];
+	struct oid_array loose_objects_cache;
+
+	char path[FLEX_ARRAY];
+} *alt_odb_list;
+void prepare_alt_odb(void);
+char *compute_alternate_path(const char *path, struct strbuf *err);
+typedef int alt_odb_fn(struct alternate_object_database *, void *);
+int foreach_alt_odb(alt_odb_fn, void*);
+
+/*
+ * Allocate a "struct alternate_object_database" but do _not_ actually
+ * add it to the list of alternates.
+ */
+struct alternate_object_database *alloc_alt_odb(const char *dir);
+
+/*
+ * Add the directory to the on-disk alternates file; the new entry will also
+ * take effect in the current process.
+ */
+void add_to_alternates_file(const char *dir);
+
+/*
+ * Add the directory to the in-memory list of alternates (along with any
+ * recursive alternates it points to), but do not modify the on-disk alternates
+ * file.
+ */
+void add_to_alternates_memory(const char *dir);
+
+/*
+ * Returns a scratch strbuf pre-filled with the alternate object directory,
+ * including a trailing slash, which can be used to access paths in the
+ * alternate. Always use this over direct access to alt->scratch, as it
+ * cleans up any previous use of the scratch buffer.
+ */
+struct strbuf *alt_scratch_buf(struct alternate_object_database *alt);
+
 struct raw_object_store {
 	/*
 	 * Path to the repository's object store.
diff --git a/packfile.c b/packfile.c
index 7dbe8739d1..c6651682a7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -13,6 +13,7 @@
 #include "tag.h"
 #include "tree-walk.h"
 #include "tree.h"
+#include "object-store.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24dd..434025bf03 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -10,6 +10,7 @@
 #include "dir.h"
 #include "sha1-array.h"
 #include "packfile.h"
+#include "object-store.h"
 
 static int get_oid_oneline(const char *, struct object_id *, struct commit_list *);
 
diff --git a/submodule.c b/submodule.c
index 47ddc9b273..b03e5f5045 100644
--- a/submodule.c
+++ b/submodule.c
@@ -21,6 +21,7 @@
 #include "remote.h"
 #include "worktree.h"
 #include "parse-options.h"
+#include "object-store.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 7120634b04..7314b5943e 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "refs.h"
 #include "worktree.h"
+#include "object-store.h"
 
 static const char *notnull(const char *arg, const char *name)
 {
diff --git a/tmp-objdir.c b/tmp-objdir.c
index b2d9280f10..fea3f55545 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -6,6 +6,7 @@
 #include "strbuf.h"
 #include "argv-array.h"
 #include "quote.h"
+#include "object-store.h"
 
 struct tmp_objdir {
 	struct strbuf path;
diff --git a/transport.c b/transport.c
index 00d48b5b56..3afc632472 100644
--- a/transport.c
+++ b/transport.c
@@ -18,6 +18,7 @@
 #include "sha1-array.h"
 #include "sigchain.h"
 #include "transport-internal.h"
+#include "object-store.h"
 
 static void set_upstreams(struct transport *transport, struct ref *refs,
 	int pretend)
-- 
2.17.0.rc0.348.gd5a49e0b6f

