Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFE5C1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeBXAsE (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:04 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46276 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeBXAsC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:02 -0500
Received: by mail-pl0-f68.google.com with SMTP id x19so5843730plr.13
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oe54K4u+MOJS+lOsjJwKcCS3Y2Uigu6wzk6aW5UB0Oo=;
        b=J63EdXc8hqyFTsQFILejRjsm5JBXw/fWCjD5JAtzIxO699xqioU9TqqKAKfXzZlWNW
         c53BUaIK6ERyg2AG1GkNQdAfFXAMwe2n9Y11B87e6OIo++lB5TRXcc5Kg6FMTWL1XiSU
         Fts7BScgxpbk+4qi9lYb2C1HJ0YPpONxArJiIuJ3M07Z22R/r9iw1LdU7EF/Jt4c+cm0
         w5pgtCAU+aSNRyaDYAhfmXTiBZsAJoHmX/C0pkWtwvQSQUXeJGuzmPlV0cXxL9K9EeNS
         Id/BTfI9OPiLRtaHc7rU3cJYlSn9R/d0Hgc2NBGNzLzl3wPOoHvjT/1gHRgPdD+InRqi
         yc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oe54K4u+MOJS+lOsjJwKcCS3Y2Uigu6wzk6aW5UB0Oo=;
        b=SSy3RDmdqZOs4fn7RAlRqSXNnzMSspkokeRt7w9Ol2Bu6NfJRZOEFFQTBWJfGfHqs0
         yD/HvYfhwZ0JXfj3u10odxI3ZLKN1fB4OlFi/yo6Dh7ZTJdKIj5vXlKkGih3GWlLEzaZ
         amc+cHeTvcH3E/9oFjy+h7PaOxdw6xaIQbhIGWEOnr+DH/e2rVL7xYuZOLKfqFaT54IX
         QpNvlTfp4gRMTnTslUxh86FRld5eHjasat5wIwhvCw49U52bbHaiH7VBDI+zxcdzcyr+
         DeuvFLk6o8GSxBeUKUVSaNjjJWeXMWxt5AiH88ck36dqdYKkUctVxOKL8RbhVcXc43Qx
         9QIw==
X-Gm-Message-State: APf1xPAckfKvb7IQ4D2FeJwA6m9BGE9X+VOH1QHjkyr4YcsdX3hbLTiN
        3a5nTEvGXKmT7auVAGtC4262dw==
X-Google-Smtp-Source: AH8x227ruHj9mAlU/oThRzaT9B64S9qDZ11gZ0q2M1yiYy6+Z6ljhb3PtsjUc9H5drARA3WrP4b1qQ==
X-Received: by 2002:a17:902:540f:: with SMTP id d15-v6mr3421122pli.224.1519433281815;
        Fri, 23 Feb 2018 16:48:01 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id s78sm4326387pfe.162.2018.02.23.16.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:01 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com
Subject: [PATCHv4 02/27] object-store: migrate alternates struct and functions from cache.h
Date:   Fri, 23 Feb 2018 16:47:29 -0800
Message-Id: <20180224004754.129721-3-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
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
index 21fbcc24149..99eb2bdb893 100644
--- a/cache.h
+++ b/cache.h
@@ -1560,57 +1560,6 @@ extern int has_dirs_only_path(const char *name, int len, int prefix_len);
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
index cf35760ceb6..5678aa1136c 100644
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

