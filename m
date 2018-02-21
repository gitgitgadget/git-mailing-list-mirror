Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8EF1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeBUByr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:54:47 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40917 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeBUByn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:54:43 -0500
Received: by mail-pl0-f65.google.com with SMTP id i6so85886plt.7
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bvB6yWUNXh/6It1du0wkNziiobVoohKgZLLIRuHd/Yw=;
        b=Oicy3CH9f88cI6mmbSaRosT2CpU/+ESQ++gVnryjoqsgrXfYo0xwY1uDr9wIdXsXKr
         TO3Amqntwp9VEFRW6TMReteUBFy63C39W7jLz3g+DwVOxw2EENpW9+w0K+DzItgE8Coz
         sFwnDE1cCxrOzYwRHbPYAQ6zVTcxRgO5lC+kX2U3x4IUKAKzfrs/drBkJf7opbXKNNvD
         Rbgjd2EUnfD5ZGb1iSrNnaiFZUiMgvO/+VzJADXkuTXkaWdaeg6WJUJ16tDW+4QwRJoO
         mWSs7VVZXzkIxuwxGLgScS8GJ8saUgJxRHiili2r3xbeuXlMhYUGcAUGTZpvOWyMHFDV
         5Ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bvB6yWUNXh/6It1du0wkNziiobVoohKgZLLIRuHd/Yw=;
        b=iUNPFkYh21hrxnevyBPu4Nt4XuvdXbPT807IH4jI/PJEuM48KCiwedA0NTlkkUyYRI
         2NtiAMFEOpELIh8jZYCTIUIhFFHXEflbbybhf7dJi5JYsghLcBNidUp1kbGe4DHFshJz
         d/59e2murWI+rLCA2Jfn/+kZ3Gj+qvnXvDPcg75sofc2nYkKXuym5ekm/YnvtIt2o1SX
         iOwQAQp12kz0wRPt097ylYhp9yc4H0QotNdvHoBb2Q3SD3+MWYL4TfPxA0SXugfdyZ+v
         bJXi6ZaGUrFo8WXgKF3wW4a5Bg1BZNRcPO/oy582IGhxpe0mdDNr68M/bvPWKYwzDceK
         NzNw==
X-Gm-Message-State: APf1xPB378G0JiLv2kt2mDrR7LmDyqqcwSLpfXo5toaUhXkpduDe+l/l
        Um46s1ch1gFidduewDy4ahiUOAJNgtY=
X-Google-Smtp-Source: AH8x227szyvtu23Gj+a4FfmQFI8UHC+px0z0ysF/EQeu5u4/A2zzKL9ja7dOJV+dyqot7wUEqYgYBw==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7-v6mr1506224plt.434.1519178082219;
        Tue, 20 Feb 2018 17:54:42 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z7sm7808657pgp.55.2018.02.20.17.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:54:41 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: [PATCH 02/27] object-store: migrate alternates struct and functions from cache.h
Date:   Tue, 20 Feb 2018 17:54:05 -0800
Message-Id: <20180221015430.96054-3-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Migrate the struct alternate_object_database and all its related
functions to the object store as these functions are easier found in
that header. The migration is just a verbatim copy, no need to
include the object store header at any C file, because cache.h includes
repository.h which in turn includes the object-store.h

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h        | 51 --------------------------------------------------
 object-store.h | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/cache.h b/cache.h
index 9cac7bb518..964873faf2 100644
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
index cf35760ceb..5678aa1136 100644
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
-- 
2.16.1.291.g4437f3f132-goog

