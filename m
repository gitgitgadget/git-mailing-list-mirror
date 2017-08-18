Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD39B208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbdHRWVN (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:13 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38330 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdHRWVL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:21:11 -0400
Received: by mail-pg0-f44.google.com with SMTP id t80so44561465pgb.5
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=p6dR+9wWagAxWx2tRicGAhRriw28l8zCG5rujv1nnC8=;
        b=v/PtMhJLVccX0fsvzIBJ9LxURLnju+lKE81LcidwkbE0PL4baZDmTAdS8pW0Vy7zfH
         ZwsoNEtv7aA8CDf8y31ujKHoVOot8dFAAE/lnOp005VCRGkg3ty2vGkq2qeoPKT2v3Jh
         BT5uUiRffyHHLPGdyQdfI+TXCjuEDiQbhSNPUEjzz8kA/oVgDJUvnGG+VueD9BQNFDF4
         dI1uqiItRTXX/cVkPhvEboKxoSzrAfdbGxvWomuT5/hIXXQlYwoyAMhMtQXbQmZWHpPa
         lcUdBx5wWF4H1pXsT2tRMEVx9tgNKf0fx+jQCap8tV43wrrm+DIQKWCy6Liu+8aTR69X
         4rOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=p6dR+9wWagAxWx2tRicGAhRriw28l8zCG5rujv1nnC8=;
        b=DZghfhoyk3O6Cb2tX6Cpy01Qo+dfIKcQi6TJal9F75IWGrlyj+jfVDt0x/1BCdze20
         S/Iob7vwdBbwoz5UtJ2hupSm+iE/FFqOdjUzeqfADhLhuQDHBl1IImcQxig+X/7p4OhZ
         1G6rhuhIBwsVNF3htrPVQoDtc93OVBdwPp0Xj06suIzci7l2jhwhFnRcrLlwNofBYoyE
         xas1/EB7ehwaXwsc3Flm+C7Yzq0tfxqzmuS9vZDu93s155jvlhQE5ByfsTLeXXLL5NVu
         LMnHwyNymIZZYX5p0GEFdeflqKXGimW3T14XmAmv9b72z+Z3cWKiZC710xZ6sEI45e7g
         ZkLQ==
X-Gm-Message-State: AHYfb5gvqD7r64MidebCAok0vQFDlyEIMu9T6Rcv3VkS7yfoE7vLrNp+
        dHRq84g6V7qZAOjyqk0Scw==
X-Received: by 10.98.149.215 with SMTP id c84mr10106974pfk.95.1503094870744;
        Fri, 18 Aug 2017 15:21:10 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:21:10 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 23/23] pack: move for_each_packed_object()
Date:   Fri, 18 Aug 2017 15:20:38 -0700
Message-Id: <6c007cc77fc1a8ba5ebbf3b349571fb5c8ebda1e.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/cat-file.c |  1 +
 cache.h            |  7 +------
 packfile.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 packfile.h         | 11 +++++++++++
 reachable.c        |  1 +
 sha1_file.c        | 40 ----------------------------------------
 6 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 96b786e48..be5936017 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -12,6 +12,7 @@
 #include "streaming.h"
 #include "tree-walk.h"
 #include "sha1-array.h"
+#include "packfile.h"
 
 struct batch_options {
 	int enabled;
diff --git a/cache.h b/cache.h
index dcbe37a3f..2eeb21b02 100644
--- a/cache.h
+++ b/cache.h
@@ -1668,17 +1668,12 @@ int for_each_loose_file_in_objdir_buf(struct strbuf *path,
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
diff --git a/packfile.c b/packfile.c
index 7e293761b..1f11ef5b8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1854,3 +1854,43 @@ int has_pack_index(const unsigned char *sha1)
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
diff --git a/packfile.h b/packfile.h
index 1b6ea832c..ca4cc3b97 100644
--- a/packfile.h
+++ b/packfile.h
@@ -124,4 +124,15 @@ extern int has_sha1_pack(const unsigned char *sha1);
 
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
diff --git a/reachable.c b/reachable.c
index c62efbfd4..d1ac5d97e 100644
--- a/reachable.c
+++ b/reachable.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "progress.h"
 #include "list-objects.h"
+#include "packfile.h"
 
 struct connectivity_progress {
 	struct progress *progress;
diff --git a/sha1_file.c b/sha1_file.c
index fa422435f..0bb2343f8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2014,46 +2014,6 @@ int for_each_loose_object(each_loose_object_fn cb, void *data, unsigned flags)
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
2.14.1.480.gb18f417b89-goog

