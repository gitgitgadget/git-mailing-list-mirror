Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689FB208B5
	for <e@80x24.org>; Wed,  9 Aug 2017 01:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbdHIBXg (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 21:23:36 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35702 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbdHIBXb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 21:23:31 -0400
Received: by mail-pg0-f45.google.com with SMTP id v189so21581653pgd.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 18:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BNstUlsSnAaDryEcHQ4a6IC/u/i7T/gcNL2mbT7ZYco=;
        b=BRaRmMlhC1dmEjVoJQbARF806Ijj4JPUVzehK5Tlaw4NCMBzD7Mav/LitHZR23f11Z
         THuCG08dpzHDezmiuL8Rv9PKgw9n9S8yls8uyEDaV2p04NrhQflHMqwjM1ar5LOyw1k6
         kwLwbV9gmqv9H73Z5ELaqOzdU4ECZqb7K7DOrYaf06HwLSGUNi6qOdvY+a7YtjrK6GPi
         RjAwH+YqhS+1Fo39wHAkTdPcZi80jctCHwp85AjkxSgJTvXP5BKTfZJhWJDhoGWUmeiA
         H6Q74vQ6Fmswnk80fXKZD9iBbyJUymhKBut+cMXVWwUBYSAVcmuBvzgiKGXcE3ROrahG
         wELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BNstUlsSnAaDryEcHQ4a6IC/u/i7T/gcNL2mbT7ZYco=;
        b=ZrBcqGNsbGMT73bPQ9dGS8koA32kuhmDo2/tBtMalFJp31k6JCsg7DyKScBrjpm61L
         c5kbd+IU4h/w+VHnZ93VUmQLs55yvRv/bXTOmIGCmbDPhvgsQAx9mXwkGqJPTVIWQILj
         Ah/Jzp9e+8+h0FW/R5fUNuQyceB6BlazTTF+xX2a9zOTw0CiHA0pdGoginac/s66sQyu
         0Y9M+jKqWNGYvA63l6mURURIaLkSRWIvT7Z1686Nzv14vx13HWydN372BxAbLXO+VLM4
         6weLFXe7Ct2csLQxredLP7xf1SMQ+DM9gJ0fTXppYqzn6GSQrFemK1oc7WVWfwMbmD+i
         d73w==
X-Gm-Message-State: AHYfb5hkf7Gb9bECEl16tRXE54KS8OlEe2ZvG/ER9px63ZJTHcxG2Mjd
        ufm7JmSnSdLSTETvz4iLCQ==
X-Received: by 10.99.111.73 with SMTP id k70mr5958983pgc.8.1502241810452;
        Tue, 08 Aug 2017 18:23:30 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id r5sm4479602pgn.45.2017.08.08.18.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 18:23:29 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com
Subject: [PATCH v2 25/25] pack: move for_each_packed_object()
Date:   Tue,  8 Aug 2017 18:22:57 -0700
Message-Id: <756ed31c2b9eb35d7e5f11af91bf5d1819222c14.1502241234.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502241234.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1502241234.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/cat-file.c |  1 +
 cache.h            |  7 +------
 pack.h             | 11 +++++++++++
 packfile.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 reachable.c        |  1 +
 sha1_file.c        | 40 ----------------------------------------
 6 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 96b786e48..316ef5c98 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -12,6 +12,7 @@
 #include "streaming.h"
 #include "tree-walk.h"
 #include "sha1-array.h"
+#include "pack.h"
 
 struct batch_options {
 	int enabled;
diff --git a/cache.h b/cache.h
index 656b39d51..6c3822783 100644
--- a/cache.h
+++ b/cache.h
@@ -1660,17 +1660,12 @@ int for_each_loose_file_in_objdir_buf(struct strbuf *path,
 				      void *data);
 
 /*
- * Iterate over loose and packed objects in both the local
+ * Iterate over loose objects in both the local
  * repository and any alternates repositories (unless the
  * LOCAL_ONLY flag is set).
  */
 #define FOR_EACH_OBJECT_LOCAL_ONLY 0x1
-typedef int each_packed_object_fn(const struct object_id *oid,
-				  struct packed_git *pack,
-				  uint32_t pos,
-				  void *data);
 extern int for_each_loose_object(each_loose_object_fn, void *, unsigned flags);
-extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
 
 struct object_info {
 	/* Request */
diff --git a/pack.h b/pack.h
index 2c2a347ba..905b05be5 100644
--- a/pack.h
+++ b/pack.h
@@ -227,4 +227,15 @@ extern int has_sha1_pack(const unsigned char *sha1);
 
 extern int has_pack_index(const unsigned char *sha1);
 
+/*
+ * Iterate over packed objects in both the local
+ * repository and any alternates repositories (unless the
+ * FOR_EACH_OBJECT_LOCAL_ONLY flag, defined in cache.h, is set).
+ */
+typedef int each_packed_object_fn(const struct object_id *oid,
+				  struct packed_git *pack,
+				  uint32_t pos,
+				  void *data);
+extern int for_each_packed_object(each_packed_object_fn, void *, unsigned flags);
+
 #endif
diff --git a/packfile.c b/packfile.c
index 28a16206c..031a40828 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1863,3 +1863,43 @@ int has_pack_index(const unsigned char *sha1)
 		return 0;
 	return 1;
 }
+
+static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
+{
+	uint32_t i;
+	int r = 0;
+
+	for (i = 0; i < p->num_objects; i++) {
+		struct object_id oid;
+
+		if (!nth_packed_object_oid(&oid, p, i))
+			return error("unable to get sha1 of object %u in %s",
+				     i, p->pack_name);
+
+		r = cb(&oid, p, i, data);
+		if (r)
+			break;
+	}
+	return r;
+}
+
+int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
+{
+	struct packed_git *p;
+	int r = 0;
+	int pack_errors = 0;
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+			continue;
+		if (open_pack_index(p)) {
+			pack_errors = 1;
+			continue;
+		}
+		r = for_each_object_in_pack(p, cb, data);
+		if (r)
+			break;
+	}
+	return r ? r : pack_errors;
+}
diff --git a/reachable.c b/reachable.c
index c62efbfd4..ef606ae17 100644
--- a/reachable.c
+++ b/reachable.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "progress.h"
 #include "list-objects.h"
+#include "pack.h"
 
 struct connectivity_progress {
 	struct progress *progress;
diff --git a/sha1_file.c b/sha1_file.c
index 8584f6cf2..3f3f9174f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2013,46 +2013,6 @@ int for_each_loose_object(each_loose_object_fn cb, void *data, unsigned flags)
 	return foreach_alt_odb(loose_from_alt_odb, &alt);
 }
 
-static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn cb, void *data)
-{
-	uint32_t i;
-	int r = 0;
-
-	for (i = 0; i < p->num_objects; i++) {
-		struct object_id oid;
-
-		if (!nth_packed_object_oid(&oid, p, i))
-			return error("unable to get sha1 of object %u in %s",
-				     i, p->pack_name);
-
-		r = cb(&oid, p, i, data);
-		if (r)
-			break;
-	}
-	return r;
-}
-
-int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
-{
-	struct packed_git *p;
-	int r = 0;
-	int pack_errors = 0;
-
-	prepare_packed_git();
-	for (p = packed_git; p; p = p->next) {
-		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
-			continue;
-		if (open_pack_index(p)) {
-			pack_errors = 1;
-			continue;
-		}
-		r = for_each_object_in_pack(p, cb, data);
-		if (r)
-			break;
-	}
-	return r ? r : pack_errors;
-}
-
 static int check_stream_sha1(git_zstream *stream,
 			     const char *hdr,
 			     unsigned long size,
-- 
2.14.0.434.g98096fd7a8-goog

