Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3803C55ABD
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA1E2078E
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK1A76Jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbgKFAZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732415AbgKFAZN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9054EC0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so3267865wme.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oDqAPiMSYogqfXkQP5TzwWmT+q+GHXhCnLOLobwDf/A=;
        b=IK1A76Jx92eKd4S+5UQvvEK/p8LMpqZ+Z8WOPoRsgXpk7+sDBwnI13sI3CRLf++8g6
         +F3yUVuhJrX6rZkCmxoV+ynIzdduhzP5XP9IBHby1EZSWTDbq1j1AAQOaWpSpO6Dhwti
         2/2lukye0UmcQ+Brh/Cxzh8ZzUopKTZnWfsguT2pELr8RIqpRlpzQ553iqorfqVxTZ5x
         Q86FPOVTON0yyeQI6hZOEUAzNNmXdKjIucCqUpy1E3XGejj/c+qzYxasJI4X5u2mBmtY
         75KEX2ymPeITzDvI+8YHMLuY+h1jNGwqR/1bSmnXx+jZw4CA7zd2HVRw4xikgUXmONoM
         5CJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oDqAPiMSYogqfXkQP5TzwWmT+q+GHXhCnLOLobwDf/A=;
        b=Y1cow5PVhVzOnT7m0RVI8+GndAR2vuyrjn9qsQKwqlAvmVbFx91CyFHUOr16K0869Z
         JcidAUmGK8wvRuEoW4hNpHpexHQ3D1XkrpiAmEVlWryyXIeq4OD2g0Eabu/1n4tL3jmX
         yBFH9Eo4OA6oUKvNe16Rjc7acLyP2Uc3LGfkkLV4LZ/brOM6Yva+bK+IVRAZ1ISFVFny
         nFdAA9bQFyfnlupVpSJTVi9W9+4q2WOJnyDweY66kHwGYS45PG4AtFId0waahTnzyWrq
         y+XJgt5VNq7jqTLSseEGFan7cevtForxjtWBLgr56Hv/dYPmA1bFaFbYKe5jvsvhrtjC
         +lnA==
X-Gm-Message-State: AOAM532PSp/FAmCWyFqJc7CKfx5S31DJAlRVaiuucrN9M8MfIsFQPEiB
        awCpWdw0ftG7J6qLXL74NF5DmV76Dqc=
X-Google-Smtp-Source: ABdhPJwtGZXp53dEc2KGlFqM5+ZTAMGpA0BtyAvjCZ0HKiGcBvxoRtCWxZvZ84dWAbbUyku8tPLddQ==
X-Received: by 2002:a1c:61d4:: with SMTP id v203mr5184335wmb.1.1604622310185;
        Thu, 05 Nov 2020 16:25:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i33sm5031038wri.79.2020.11.05.16.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:09 -0800 (PST)
Message-Id: <34f542d9dd846da5fd81274966ee2ebe0660dcef.1604622299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:55 +0000
Subject: [PATCH v5 12/15] strmap: enable allocations to come from a mem_pool
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
index 3784865745..139afb9d4b 100644
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
 
@@ -77,11 +86,13 @@ static struct strmap_entry *create_entry(struct strmap *map,
 	struct strmap_entry *entry;
 	const char *key = str;
 
-	entry = xmalloc(sizeof(*entry));
+	entry = map->pool ? mem_pool_alloc(map->pool, sizeof(*entry))
+			  : xmalloc(sizeof(*entry));
 	hashmap_entry_init(&entry->ent, strhash(str));
 
 	if (map->strdup_strings)
-		key = xstrdup(str);
+		key = map->pool ? mem_pool_strdup(map->pool, str)
+				: xstrdup(str);
 	entry->key = key;
 	entry->value = data;
 	return entry;
@@ -128,9 +139,11 @@ void strmap_remove(struct strmap *map, const char *str, int free_value)
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
index c8c4d7c932..dda928703d 100644
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

