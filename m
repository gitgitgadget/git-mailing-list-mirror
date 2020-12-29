Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F46C433E0
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 23:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B4720825
	for <git@archiver.kernel.org>; Tue, 29 Dec 2020 23:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL2XzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 18:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgL2XzW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 18:55:22 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33324C06179F
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 15:54:41 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o13so34284562lfr.3
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 15:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x04hAF1LnPBjYXyrCT7VnaPDxI0erCSgqNJbdyKtwiM=;
        b=UkJuJh/ue/eg1yIEyENbNRr/BFygy06Rb4kmv27zGUEl3r8v03DcQekTtww37NOv/b
         my9lOpmz8BIkaZzIVvNohd4Rpb89lQyCBvfeX5sDjIEIUrnqQrTIku6y8TCNeyT7+JgG
         J1ZgEcJoZ8tdEd33RHTU2vNHVe459gZYEmp4wxb5do9EfE5txYVhDryvQ/gAhEe5amA+
         avPeWXU3MYzcRHW4BeIJAd7nYQn6lSoinadznxWTZqpX3diu2S8u+XibsdUNoCv0ebe6
         X1LHRA4HtzADVgna68XXljgPWzrJS98c0wWYYlpAI+ypKb3Iyb7QMS1uQXeyxY+nhn0z
         uS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x04hAF1LnPBjYXyrCT7VnaPDxI0erCSgqNJbdyKtwiM=;
        b=WZK1mmBlsXs4Nby/lzyBAfOVm6Rvgni3KXMQehMuT2J3elyTpKvOwIsxVBZWXDv17s
         6CCVXMH7zK0iNGEEk/uoi2ewB/Pe46DsZkpT4lKVty4UdGpCe5goHg/MQt1eUEhacxBz
         vh7SGlNqGFhmi9NJJ2Mwu3RTDuQNEWSEEbIs2GP2DXcleIDfKv8+1wNpBgdQCDEFN6Ia
         6D4vlkmynfBWlgWCoQCos6dmL1i3iTZVBgneO+9NdOq0NuE5joixhicThxnx1vvBdOqr
         tDWZMareVqMsxzM2NFWR1IH+BJC+rQxl6q6FjmGyhe5itu1u+8MuT92mb0IWK98lySwf
         jOwQ==
X-Gm-Message-State: AOAM532dFxCKVg/oNyu0VIdFqhb/7ht73fLhgydCOlZppUjNAu3R1wv7
        AqZn91EmEI09lROZjNsVxILCygXc2DM=
X-Google-Smtp-Source: ABdhPJy8QuIcD0wE4r6hnFEm5sl4f7qlWO1rgMLfdLHydVHvRpryGRkN/s//ojH79k3j4kO63u5jeQ==
X-Received: by 2002:a2e:bc15:: with SMTP id b21mr25727680ljf.350.1609286079442;
        Tue, 29 Dec 2020 15:54:39 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id q25sm5777240lfd.282.2020.12.29.15.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 15:54:39 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 4/4] hash-lookup: rename from sha1-lookup
Date:   Wed, 30 Dec 2020 00:53:00 +0100
Message-Id: <afee01047425f2434c9d155acbb59c4ec9dbc89e.1609282997.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609282997.git.martin.agren@gmail.com>
References: <cover.1609282997.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change all remnants of "sha1" in hash-lookup.c and .h and rename them to
reflect that we're not just able to handle SHA-1 these days.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 sha1-lookup.h => hash-lookup.h |  8 ++++----
 bisect.c                       |  2 +-
 builtin/name-rev.c             |  2 +-
 commit-graph.c                 |  2 +-
 commit.c                       |  2 +-
 sha1-lookup.c => hash-lookup.c | 14 +++++++-------
 midx.c                         |  2 +-
 object-file.c                  |  2 +-
 oid-array.c                    |  2 +-
 pack-bitmap-write.c            |  2 +-
 packfile.c                     |  2 +-
 patch-ids.c                    |  2 +-
 rerere.c                       |  2 +-
 Makefile                       |  2 +-
 14 files changed, 23 insertions(+), 23 deletions(-)
 rename sha1-lookup.h => hash-lookup.h (82%)
 rename sha1-lookup.c => hash-lookup.c (90%)

diff --git a/sha1-lookup.h b/hash-lookup.h
similarity index 82%
rename from sha1-lookup.h
rename to hash-lookup.h
index 79973d4785..005795f4a3 100644
--- a/sha1-lookup.h
+++ b/hash-lookup.h
@@ -9,12 +9,12 @@ int hash_pos(const unsigned char *hash,
 	     hash_access_fn fn);
 
 /*
- * Searches for sha1 in table, using the given fanout table to determine the
+ * Searches for hash in table, using the given fanout table to determine the
  * interval to search, then using binary search. Returns 1 if found, 0 if not.
  *
  * Takes the following parameters:
  *
- *  - sha1: the hash to search for
+ *  - hash: the hash to search for
  *  - fanout_nbo: a 256-element array of NETWORK-order 32-bit integers; the
  *    integer at position i represents the number of elements in table whose
  *    first byte is less than or equal to i
@@ -23,10 +23,10 @@ int hash_pos(const unsigned char *hash,
  *    GIT_MAX_RAWSZ or greater)
  *  - result: if not NULL, this function stores the element index of the
  *    position found (if the search is successful) or the index of the least
- *    element that is greater than sha1 (if the search is not successful)
+ *    element that is greater than hash (if the search is not successful)
  *
  * This function does not verify the validity of the fanout table.
  */
-int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,
+int bsearch_hash(const unsigned char *hash, const uint32_t *fanout_nbo,
 		 const unsigned char *table, size_t stride, uint32_t *result);
 #endif
diff --git a/bisect.c b/bisect.c
index d8c2c8f7a7..75ea0eb57f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -6,7 +6,7 @@
 #include "refs.h"
 #include "list-objects.h"
 #include "quote.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 #include "run-command.h"
 #include "log-tree.h"
 #include "bisect.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 4939ceb2e5..3fe71a8c01 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -7,7 +7,7 @@
 #include "refs.h"
 #include "parse-options.h"
 #include "prio-queue.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 #include "commit-slab.h"
 
 /*
diff --git a/commit-graph.c b/commit-graph.c
index c672feee91..e9124d4a41 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -7,7 +7,7 @@
 #include "object.h"
 #include "refs.h"
 #include "revision.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 #include "commit-graph.h"
 #include "object-store.h"
 #include "alloc.h"
diff --git a/commit.c b/commit.c
index 0b7bace022..cb119ebdf2 100644
--- a/commit.c
+++ b/commit.c
@@ -14,7 +14,7 @@
 #include "mergesort.h"
 #include "commit-slab.h"
 #include "prio-queue.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 #include "wt-status.h"
 #include "advice.h"
 #include "refs.h"
diff --git a/sha1-lookup.c b/hash-lookup.c
similarity index 90%
rename from sha1-lookup.c
rename to hash-lookup.c
index 45489edfe8..1191856a32 100644
--- a/sha1-lookup.c
+++ b/hash-lookup.c
@@ -1,9 +1,9 @@
 #include "cache.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 
-static uint32_t take2(const unsigned char *sha1)
+static uint32_t take2(const unsigned char *hash)
 {
-	return ((sha1[0] << 8) | sha1[1]);
+	return ((hash[0] << 8) | hash[1]);
 }
 
 /*
@@ -100,17 +100,17 @@ int hash_pos(const unsigned char *hash, void *table, size_t nr,
 	return index_pos_to_insert_pos(lo);
 }
 
-int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,
+int bsearch_hash(const unsigned char *hash, const uint32_t *fanout_nbo,
 		 const unsigned char *table, size_t stride, uint32_t *result)
 {
 	uint32_t hi, lo;
 
-	hi = ntohl(fanout_nbo[*sha1]);
-	lo = ((*sha1 == 0x0) ? 0 : ntohl(fanout_nbo[*sha1 - 1]));
+	hi = ntohl(fanout_nbo[*hash]);
+	lo = ((*hash == 0x0) ? 0 : ntohl(fanout_nbo[*hash - 1]));
 
 	while (lo < hi) {
 		unsigned mi = lo + (hi - lo) / 2;
-		int cmp = hashcmp(table + mi * stride, sha1);
+		int cmp = hashcmp(table + mi * stride, hash);
 
 		if (!cmp) {
 			if (result)
diff --git a/midx.c b/midx.c
index 79c282b070..f9d9b832bb 100644
--- a/midx.c
+++ b/midx.c
@@ -5,7 +5,7 @@
 #include "lockfile.h"
 #include "packfile.h"
 #include "object-store.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 #include "midx.h"
 #include "progress.h"
 #include "trace2.h"
diff --git a/object-file.c b/object-file.c
index b0c47b02bd..0f9b81c91a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -20,7 +20,7 @@
 #include "tree-walk.h"
 #include "refs.h"
 #include "pack-revindex.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 #include "bulk-checkin.h"
 #include "repository.h"
 #include "replace-object.h"
diff --git a/oid-array.c b/oid-array.c
index fb4c3dd795..889b311f22 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -1,6 +1,6 @@
 #include "cache.h"
 #include "oid-array.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 
 void oid_array_append(struct oid_array *array, const struct object_id *oid)
 {
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 27ece05ec7..ae6d1475f9 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -9,7 +9,7 @@
 #include "pack-revindex.h"
 #include "pack.h"
 #include "pack-bitmap.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 #include "pack-objects.h"
 #include "commit-reach.h"
 
diff --git a/packfile.c b/packfile.c
index 86f5c8dbf6..62d92e0c7c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -7,7 +7,7 @@
 #include "packfile.h"
 #include "delta.h"
 #include "streaming.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 #include "commit.h"
 #include "object.h"
 #include "tag.h"
diff --git a/patch-ids.c b/patch-ids.c
index 21973e4933..cf5e8045b7 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "commit.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 #include "patch-ids.h"
 
 static int patch_id_defined(struct commit *commit)
diff --git a/rerere.c b/rerere.c
index 9fc76eb756..d6928c1b5c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -10,7 +10,7 @@
 #include "attr.h"
 #include "pathspec.h"
 #include "object-store.h"
-#include "sha1-lookup.h"
+#include "hash-lookup.h"
 
 #define RESOLVED 0
 #define PUNTED 1
diff --git a/Makefile b/Makefile
index 224a1c6940..7a141facc7 100644
--- a/Makefile
+++ b/Makefile
@@ -901,6 +901,7 @@ LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
 LIB_OBJS += grep.o
+LIB_OBJS += hash-lookup.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
@@ -995,7 +996,6 @@ LIB_OBJS += sequencer.o
 LIB_OBJS += serve.o
 LIB_OBJS += server-info.o
 LIB_OBJS += setup.o
-LIB_OBJS += sha1-lookup.o
 LIB_OBJS += shallow.o
 LIB_OBJS += sideband.o
 LIB_OBJS += sigchain.o
-- 
2.30.0

