Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B419C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73932087D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrCiN4bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgKKUCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgKKUCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:35 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ADAC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:35 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so3368050wmg.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GU/E3guLHF3z1WLOtDxPFbXkx6dKo4kaIDYqJPTUC/U=;
        b=jrCiN4bC30rYesflq0erThhFwXPj4loITRIGnAY4bmntmi7dHz26hGUJvZAHToafm9
         UL74Ol/FSMoREKINUt+mbfVGV2GIpIYPW9b1OcFVN6/1wJtu8IMkeMR/QLBW7v5bDaZP
         vN8tF4dM00y6kWjxVBYBWGgbKds9TUMMHOX0U4b/e3FilWd/d++HzWwZi6eK8pv+7WNk
         RkJYGEbpKQh5AUDYqh8rr2wraHTDmhIduG3oOuJmjFRAY+HOvANg5nPENdw0mmrpEfOH
         PtdevIbHFtquqKaWNayzvwij9T9Z5Ij/0dYPKmuda44SFpk/jCFXRoSH+5rbCkBAgCO+
         12fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GU/E3guLHF3z1WLOtDxPFbXkx6dKo4kaIDYqJPTUC/U=;
        b=CZ7CHFdUBR4JfwrVktVSAOGfyKm6ohgENqaG4KupnmMpsE23EUJ9u2oZvVVlGVRko6
         chYAXTwdT8abROsm8iZl+ghvPOGGdKyWrlnLPXkcDPIYRjWs3dEaV9OpsIAvhi6rUCAy
         /4iRo/g3o6oOYQJ2AZQ1dVjHJ8UB6b+AuwAOBnW/7OKH+C2vNSwGwdfXvo9MT7Ilpp1T
         knwPy51vY4tAChnknnuN58S0zXsQf1W9idwoeSNy3L2Nu7QQJbrZH82yK8BGGtMUViCG
         v8L9ebZJPGCZMA3SPmvmbhpY48WutXKviUhZnEdqk9OJ29Zip59O1KgXY0pVR/nbKYr5
         EF2g==
X-Gm-Message-State: AOAM531GOGQ42lG+e9M2ZlxMRQ1TEelar+RocFtaW7kb9u5Ag1cOnnWI
        AQd+5UrCioIGDbeAd2GiPWOb9M2hcrM=
X-Google-Smtp-Source: ABdhPJyl928VUYFDhWz670MdFmyeb4d4+C+Ylf0RJhIhqXAOErauNYhIuhUW3plt4HyCpwKQV9MAyA==
X-Received: by 2002:a1c:df89:: with SMTP id w131mr5626797wmg.164.1605124953587;
        Wed, 11 Nov 2020 12:02:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5sm3890652wrg.32.2020.11.11.12.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:02:33 -0800 (PST)
Message-Id: <3926c4c97bd08aac93d3f521273db9d76b4d5cd3.1605124942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
References: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
        <pull.835.v6.git.git.1605124942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 20:02:18 +0000
Subject: [PATCH v6 12/15] strmap: enable allocations to come from a mem_pool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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
index c8c4d7c932..8745b7ceb1 100644
--- a/strmap.h
+++ b/strmap.h
@@ -3,8 +3,10 @@
 
 #include "hashmap.h"
 
+struct mem_pool;
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

