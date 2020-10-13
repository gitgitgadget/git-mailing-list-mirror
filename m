Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCE5C83002
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E77221EB
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 02:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2Ffy7ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgJMAlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 20:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgJMAlC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 20:41:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3668EC0613D2
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:41:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h7so21729428wre.4
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 17:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xM8Wm7ZazBef0bIdplkeKJTFVK5duK9p8dSVJjU6cB4=;
        b=u2Ffy7iaD99fG4M8ze0qxDJhz4crFtTBDrMX0qc04V+sYNR1AB6iAcohxOizDryaaX
         lX6Hyj0fvjen6GmB8l1DEb8h/twVZ8wpyKmpttDPVWuuOJA7UZtFGQv3vtXJKiZMR0VQ
         zm3bIzSm6tP5JCZvitW78SgXwjIlFINA5t2Xy3AwDENe7j8aBD9X35ciK7bBjYdjanbv
         eYwcxSjHK2nUG/Ct3dLAgyyuWZM546rmu8dacF/q//vE2E/8mPSeXTUX+AUX9nVyfoVt
         OOReJoBOP5tZRjn2eN6K4mXR3jogrqjl5JzxYAuUPTchY3NDHtVarCatgXSv/E4UiVRD
         4xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xM8Wm7ZazBef0bIdplkeKJTFVK5duK9p8dSVJjU6cB4=;
        b=F7kWRQeaOZPEDpQBj1C9iTdBZnjUphyMgffCR+9iVj3oiaCmSvvLNMzSDz2UZuvsO0
         /J+3+/FmVXsAw+8/wSOamfSRxQN8qQ0Q2Fy55ou0fGUJODN1FFUy2LzLjcjuPzL8aPnP
         TNZZoBDJ2vVfrKqcD4oakgkNcXhszWZ8R062Li0337mPoxW2P8MGVECYYw7lD9v/G7AY
         wQcPpksASG8INZQjYLwnQSFSOVhUSp2A7Thl+PaTsWldmTTtqYZ5WD8aNW0YoI35ER0a
         czYn6QNh3MpbqmV1q9ZWVQ4O/IwOdu/Bpuv03cdvSkjE672G+W646IztVhFHJv10g+/c
         mwRg==
X-Gm-Message-State: AOAM5331ut8C7F+wUeAZ9J42J1d2rn2ms2Yhbs1qjdHeM0PkRp2gh4cj
        nBF+HarQitbMGuf3tZu5+auMNSrpZYY=
X-Google-Smtp-Source: ABdhPJxF3LD0JQFAaABLDPo8jsLBWOD98yO+ULdtmwPZOlpaklXfjhxtq5iDDBODMrwAbVm9M8OW2g==
X-Received: by 2002:adf:f74e:: with SMTP id z14mr32081251wrp.312.1602549660809;
        Mon, 12 Oct 2020 17:41:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c130sm25015201wma.17.2020.10.12.17.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 17:41:00 -0700 (PDT)
Message-Id: <eca4f1ddbaa1cd8dc3fc64dbe9206af538cb317d.1602549650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
        <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Oct 2020 00:40:50 +0000
Subject: [PATCH v2 10/10] strmap: enable allocations to come from a mem_pool
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

For heavy users of strmaps, allowing the keys and entries to be
allocated from a memory pool can provide significant overhead savings.
Add an option to strmap_ocd_init() to specify a memory pool.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 31 ++++++++++++++++++++++---------
 strmap.h | 11 ++++++++---
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/strmap.c b/strmap.c
index d5003a79e3..83b9de961c 100644
--- a/strmap.c
+++ b/strmap.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "strmap.h"
+#include "mem-pool.h"
 
 static int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
 			    const struct hashmap_entry *entry1,
@@ -24,13 +25,15 @@ static struct strmap_entry *find_strmap_entry(struct strmap *map,
 
 void strmap_init(struct strmap *map)
 {
-	strmap_ocd_init(map, 1);
+	strmap_ocd_init(map, NULL, 1);
 }
 
 void strmap_ocd_init(struct strmap *map,
+		     struct mem_pool *pool,
 		     int strdup_strings)
 {
 	hashmap_init(&map->map, cmp_strmap_entry, NULL, 0);
+	map->pool = pool;
 	map->strdup_strings = strdup_strings;
 }
 
@@ -42,6 +45,10 @@ static void strmap_free_entries_(struct strmap *map, int free_util)
 	if (!map)
 		return;
 
+	if (!free_util && map->pool)
+		/* Memory other than util is owned by and freed with the pool */
+		return;
+
 	/*
 	 * We need to iterate over the hashmap entries and free
 	 * e->key and e->value ourselves; hashmap has no API to
@@ -52,9 +59,11 @@ static void strmap_free_entries_(struct strmap *map, int free_util)
 	hashmap_for_each_entry(&map->map, &iter, e, ent) {
 		if (free_util)
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
 
@@ -84,11 +93,13 @@ void *strmap_put(struct strmap *map, const char *str, void *data)
 		 */
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
@@ -122,9 +133,11 @@ void strmap_remove(struct strmap *map, const char *str, int free_util)
 		return;
 	if (free_util)
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
index 2ad6696950..b93b7c9fd6 100644
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
 
@@ -22,11 +24,12 @@ void strmap_init(struct strmap *map);
 
 /*
  * Same as strmap_init, but for those who want to control the memory management
- * carefully instead of using the default of strdup_strings=1.
+ * carefully instead of using the default of strdup_strings=1 and pool=NULL.
  * (OCD = Obsessive Compulsive Disorder, a joke that those who use this function
  * are obsessing over minor details.)
  */
 void strmap_ocd_init(struct strmap *map,
+		     struct mem_pool *pool,
 		     int strdup_strings);
 
 /*
@@ -126,9 +129,10 @@ static inline void strintmap_init(struct strintmap *map)
 }
 
 static inline void strintmap_ocd_init(struct strintmap *map,
+				      struct mem_pool *pool,
 				      int strdup_strings)
 {
-	strmap_ocd_init(&map->map, strdup_strings);
+	strmap_ocd_init(&map->map, pool, strdup_strings);
 }
 
 static inline void strintmap_clear(struct strintmap *map)
@@ -202,9 +206,10 @@ static inline void strset_init(struct strset *set)
 }
 
 static inline void strset_ocd_init(struct strset *set,
+				   struct mem_pool *pool,
 				   int strdup_strings)
 {
-	strmap_ocd_init(&set->map, strdup_strings);
+	strmap_ocd_init(&set->map, pool, strdup_strings);
 }
 
 static inline void strset_clear(struct strset *set)
-- 
gitgitgadget
