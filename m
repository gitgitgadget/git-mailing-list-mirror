Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31B6C4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6335220825
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpIEXMr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbgKEAY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731539AbgKEAW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 19:22:58 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B36C0613CF
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 16:22:58 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so31192wme.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 16:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vuOmP4h42WdNvbkUSAXROh7F3ep+J+M/i0tcBU8uhpU=;
        b=GpIEXMr7hlhW1ZVz3OxdBsyAKMeMPt84EV9RYvNw6WtIDUNGuV1PMrkPxf2eKTy4yR
         8vco/8exJgqpRbuwG+pyI1uMCON+7qluVbBvcE620yJ+wA1qhFl8sCoBhufVw/FS3GJS
         AMfPVejPs4AyG+qWV9CPoG2/ijvzw/yb3xy1hKIuwLguHuUKrzuV2xMcQZANEzqCsw/5
         WJy1b6H+M3bhiTSno/5AJbheWfu3qvexEXZjRrnoVw84h9lStdJeHdQlHhvCHY8mVUO8
         MOBo8tzIjqwPxtrsETjzdV5lHE5XtxNX/fYA598pSFNcvAd1HFLG62lT9tR+EOcqqH2C
         52lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vuOmP4h42WdNvbkUSAXROh7F3ep+J+M/i0tcBU8uhpU=;
        b=s113P6CzqnxzzW0emdlLBtvGz8VRFSJqsbdGASckMMujRtDPpVYdr4l/PtNMUOThPe
         Dmri7gSdlnUgHqqvR3gsNYyBaWuC0cblA0wuWQE6mOIw3FviZqz+6fOsT1cq3SiZsI4T
         Bg+/MG/8clQP1J1UJ/qhsp0ikbB/nLSQPgMOJ9Q1BzT1C+6/44obdXsLGZKj1R0TAYmm
         wcHXii1PuL9PQVj1BEn0KInVyoq3CnCD6aZiEARXEH3tpfOUnZFapwhSqYUbKrSlBYPF
         fRTLST/lT+/OpEzURT5JLCNC3kAyYo3fjDmfOIh1N7jpmsDquGSeV8T4oT6+ImpCkrRR
         N+Lw==
X-Gm-Message-State: AOAM532V0Epb1R0uBtaVX9a/qRb1zYixJv60rAy7LB1xfANEX1nQz/Xn
        scZFiEUzvSA5H7IzOE47hQzOMYK+ekw=
X-Google-Smtp-Source: ABdhPJygVfzlgChD8iO9/EfRxmT7TjR3yZ1DGtbbFJt4Adi2Gus4wGx8ga67/yh+EeopJ4bZ5lKOrA==
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr59256wma.93.1604535776921;
        Wed, 04 Nov 2020 16:22:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm4882188wrk.28.2020.11.04.16.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:22:56 -0800 (PST)
Message-Id: <73a57045c37f50fee3a1d3912f5ed7a217142029.1604535766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
        <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 00:22:43 +0000
Subject: [PATCH v4 11/13] strmap: enable allocations to come from a mem_pool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

For heavy users of strmaps, allowing the keys and entries to be
allocated from a memory pool can provide significant overhead savings.
Add an option to strmap_init_with_options() to specify a memory pool.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 31 ++++++++++++++++++++++---------
 strmap.h | 11 ++++++++---
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/strmap.c b/strmap.c
index 0d10a884b5..f5904138e1 100644
--- a/strmap.c
+++ b/strmap.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "strmap.h"
+#include "mem-pool.h"
 
 int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
 		     const struct hashmap_entry *entry1,
@@ -24,13 +25,15 @@ static struct strmap_entry *find_strmap_entry(struct strmap *map,
 
 void strmap_init(struct strmap *map)
 {
-	strmap_init_with_options(map, 1);
+	strmap_init_with_options(map, NULL, 1);
 }
 
 void strmap_init_with_options(struct strmap *map,
+			      struct mem_pool *pool,
 			      int strdup_strings)
 {
 	hashmap_init(&map->map, cmp_strmap_entry, NULL, 0);
+	map->pool = pool;
 	map->strdup_strings = strdup_strings;
 }
 
@@ -42,6 +45,10 @@ static void strmap_free_entries_(struct strmap *map, int free_values)
 	if (!map)
 		return;
 
+	if (!free_values && map->pool)
+		/* Memory other than util is owned by and freed with the pool */
+		return;
+
 	/*
 	 * We need to iterate over the hashmap entries and free
 	 * e->key and e->value ourselves; hashmap has no API to
@@ -52,9 +59,11 @@ static void strmap_free_entries_(struct strmap *map, int free_values)
 	hashmap_for_each_entry(&map->map, &iter, e, ent) {
 		if (free_values)
 			free(e->value);
-		if (map->strdup_strings)
-			free((char*)e->key);
-		free(e);
+		if (!map->pool) {
+			if (map->strdup_strings)
+				free((char*)e->key);
+			free(e);
+		}
 	}
 }
 
@@ -81,11 +90,13 @@ void *strmap_put(struct strmap *map, const char *str, void *data)
 	} else {
 		const char *key = str;
 
-		entry = xmalloc(sizeof(*entry));
+		entry = map->pool ? mem_pool_alloc(map->pool, sizeof(*entry))
+				  : xmalloc(sizeof(*entry));
 		hashmap_entry_init(&entry->ent, strhash(str));
 
 		if (map->strdup_strings)
-			key = xstrdup(str);
+			key = map->pool ? mem_pool_strdup(map->pool, str)
+					: xstrdup(str);
 		entry->key = key;
 		entry->value = data;
 		hashmap_add(&map->map, &entry->ent);
@@ -119,9 +130,11 @@ void strmap_remove(struct strmap *map, const char *str, int free_value)
 		return;
 	if (free_value)
 		free(ret->value);
-	if (map->strdup_strings)
-		free((char*)ret->key);
-	free(ret);
+	if (!map->pool) {
+		if (map->strdup_strings)
+			free((char*)ret->key);
+		free(ret);
+	}
 }
 
 void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
diff --git a/strmap.h b/strmap.h
index 22df987644..b9d882a2d0 100644
--- a/strmap.h
+++ b/strmap.h
@@ -3,8 +3,10 @@
 
 #include "hashmap.h"
 
+struct mempool;
 struct strmap {
 	struct hashmap map;
+	struct mem_pool *pool;
 	unsigned int strdup_strings:1;
 };
 
@@ -37,9 +39,10 @@ void strmap_init(struct strmap *map);
 
 /*
  * Same as strmap_init, but for those who want to control the memory management
- * carefully instead of using the default of strdup_strings=1.
+ * carefully instead of using the default of strdup_strings=1 and pool=NULL.
  */
 void strmap_init_with_options(struct strmap *map,
+			      struct mem_pool *pool,
 			      int strdup_strings);
 
 /*
@@ -137,9 +140,10 @@ static inline void strintmap_init(struct strintmap *map, int default_value)
 
 static inline void strintmap_init_with_options(struct strintmap *map,
 					       int default_value,
+					       struct mem_pool *pool,
 					       int strdup_strings)
 {
-	strmap_init_with_options(&map->map, strdup_strings);
+	strmap_init_with_options(&map->map, pool, strdup_strings);
 	map->default_value = default_value;
 }
 
@@ -221,9 +225,10 @@ static inline void strset_init(struct strset *set)
 }
 
 static inline void strset_init_with_options(struct strset *set,
+					    struct mem_pool *pool,
 					    int strdup_strings)
 {
-	strmap_init_with_options(&set->map, strdup_strings);
+	strmap_init_with_options(&set->map, pool, strdup_strings);
 }
 
 static inline void strset_clear(struct strset *set)
-- 
gitgitgadget

