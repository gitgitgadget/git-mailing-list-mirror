Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D49C4742C
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3046E22268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7iVWWdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgKBSza (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgKBSz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:26 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CEEC061A4A
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:26 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id y12so15836905wrp.6
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ajkc8/WOW9jIlOT43OaYG5Cl5zTQVr0y/ErISb/22MA=;
        b=I7iVWWdZV4CmCTVvnTQ+xrBigvi73YenJgI+zCG6A3g+0TqZ1myLphjHA1FWMKMW62
         uzaoOysdCWHOlksfIjGPZHn8HzVH1t+8LKLgRT1veZYJEYBGukcYy/bWLvdXtFX6KLBm
         nJtyYZQXGhiW3GhxdJPzdqjtKNYnUgEIKQnaRZnHl3giWqxAgdwlyQVoFa6LaaItLZ23
         3UIqf5jvtrCcWC6y383+eeQg/VJEbjdieB8GR6QLgplBruOVEe29NLYHyjDsEZbl+0su
         ypRCQGWnMxQ1qSvuw/aIjVqN5nW8+iQrxOiaKVQ3MaJ6mXh4YW6jsmF7NJW26LrdBHZo
         jIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ajkc8/WOW9jIlOT43OaYG5Cl5zTQVr0y/ErISb/22MA=;
        b=FJaXxyGkevFvGEJuv7C57lg0YZ6RFjWHQBd2EAWxxzvSy2NUrY6c5YMckuDjSgepFa
         LBuVbkB3rGw+zOjJ8mx5eVPjr8rCJzkOxWmzPNsZ2w/00fcM1SdSPT25Ia6fQ4by1DM6
         ItDkuJwyGayDGI/R2iC1kODUntUAtKjl6ikABW6bvO7SpybbdgM9XncpgU/cCXnLC7LF
         /won7xfMYZKFRT03Ar4Hd/gLgeKIvtPdVe6NXq4FKpqjoxI3Peid0w6Zx4LMg2WlI3dw
         1l4HsLgcvlwo9McdOfTNgUuyosNT7ihQJydWqMuQXUVc5DhcZlWEYRdcGjFrAoPCzZHP
         0jSg==
X-Gm-Message-State: AOAM53336idTPOeKKklJ4x1VTAKGUZgOkhTIzeteKcSxpxryy0x43bAV
        j98n6V9mnMjX6hmzs9geidGx7xQE9Qo=
X-Google-Smtp-Source: ABdhPJxUWEkqv5Le40NqxKbF3VehPF9tV0zq30wljFQLU82W0+Y5+AJMinLTfs9XXkAuZ0MsApAcUw==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr20947432wrt.23.1604343324736;
        Mon, 02 Nov 2020 10:55:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d134sm358293wmd.8.2020.11.02.10.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:24 -0800 (PST)
Message-Id: <980537e877a3e690d451a574593b26f827b0d33d.1604343314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
        <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:11 +0000
Subject: [PATCH v3 11/13] strmap: enable allocations to come from a mem_pool
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
index 2aff985f40..34bca92522 100644
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
index fca1e9f639..6ffa6afb6a 100644
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
 
@@ -41,9 +43,10 @@ void strmap_init(struct strmap *map);
 
 /*
  * Same as strmap_init, but for those who want to control the memory management
- * carefully instead of using the default of strdup_strings=1.
+ * carefully instead of using the default of strdup_strings=1 and pool=NULL.
  */
 void strmap_init_with_options(struct strmap *map,
+			      struct mem_pool *pool,
 			      int strdup_strings);
 
 /*
@@ -144,9 +147,10 @@ static inline void strintmap_init(struct strintmap *map, int default_value)
 
 static inline void strintmap_init_with_options(struct strintmap *map,
 					       int default_value,
+					       struct mem_pool *pool,
 					       int strdup_strings)
 {
-	strmap_init_with_options(&map->map, strdup_strings);
+	strmap_init_with_options(&map->map, pool, strdup_strings);
 	map->default_value = default_value;
 }
 
@@ -228,9 +232,10 @@ static inline void strset_init(struct strset *set)
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

