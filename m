Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE48C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D6020825
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 00:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWrPt88b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbgKEAY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbgKEAXA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 19:23:00 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6660C0613CF
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 16:22:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d142so26457wmd.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 16:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JPP2s9lPoramP43ojtmL2q5StsGenrMHXk4OxxxNUMs=;
        b=dWrPt88bC/6dH7c3BIvMfB80CU+43E7lmF8L5Vin7bgNhBpxkNi7Ecr0SBODrjI4i5
         xFLeEyd/nSh+KXodj9RzuQQnI9I+Kr3GeaFZnnEmt78g79FmCK2Z3VHXXCBgLZAZS95H
         I1SfcUeGoNbod5x3LZKUbPtS9focQ7TApbzpkvik1Tlsb9kBeXmQfQdJL83RgKs5beEf
         RcsfhCBJxidCpCZ+y3cvP7diBgytel+KMhDHzvsGE1RnJtiWlRaOjl6FyjFRthHx59jS
         mjJ7TiEMmI4NgNJJ71ucBR4Psivuxon4TVHU0XoAwFoyhDMg13uqXf1kWOZcz5H2rhff
         KTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JPP2s9lPoramP43ojtmL2q5StsGenrMHXk4OxxxNUMs=;
        b=Y0ipcvSoNLSBmOdx2w8YsesF3FEwRY+w9KKiB5rfpO+/VnE2yYwi3rFY8xHnUG3a3Y
         AsAqiihytCMGy1Zsc9wt33diujx6Qg2qz9urMyTqM0NrAs+HjWOD/uxPcTJlGE5EsicK
         GNe/TGbgduJLLnL9kHHL6Fq51q0Kk5qyLC672TuWpNgWr2dGqF/u+9/A7JQ9EHPIzKqC
         NMugpUGUxNolC1hYQeel2QjC6w4y/0WdebUbEHIBVLZKOIHD7GvBQk549WZjUsEwwDkt
         4KHsnQ8URa1rV7GlSfOiB93abPVs3AjoCTZSpeXEsr1OSu4IGE9dDZRMosSKNEu7TTjs
         742w==
X-Gm-Message-State: AOAM531BnkB/0IKzOVMKEz/HzA9prLUbRhZLyFugTraZUi3Vqj6GabzJ
        19xOnTmwtxpr2FtcjO7UB3SOD25HNXM=
X-Google-Smtp-Source: ABdhPJzXB4YOXsLFtiOgLmhhJ8PHW0lQAAkZz1BuAC1/cC30qP7fgX2k7cYArfcPnaAYmzzMF9q0ZQ==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr64227wmk.65.1604535777814;
        Wed, 04 Nov 2020 16:22:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5sm4839654wrw.93.2020.11.04.16.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:22:57 -0800 (PST)
Message-Id: <0352260de479e2c61d9971e6072435476ad3d620.1604535766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
References: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
        <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 05 Nov 2020 00:22:44 +0000
Subject: [PATCH v4 12/13] strmap: take advantage of FLEXPTR_ALLOC_STR when
 relevant
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

By default, we do not use a mempool and strdup_strings is true; in this
case, we can avoid both an extra allocation and an extra free by just
over-allocating for the strmap_entry leaving enough space at the end to
copy the key.  FLEXPTR_ALLOC_STR exists for exactly this purpose, so
make use of it.

Also, adjust the case when we are using a memory pool and strdup_strings
is true to just do one allocation from the memory pool instead of two so
that the strmap_clear() and strmap_remove() code can just avoid freeing
the key in all cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 48 +++++++++++++++++++++++++-----------------------
 strmap.h |  1 +
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/strmap.c b/strmap.c
index f5904138e1..98513f7d58 100644
--- a/strmap.c
+++ b/strmap.c
@@ -59,11 +59,8 @@ static void strmap_free_entries_(struct strmap *map, int free_values)
 	hashmap_for_each_entry(&map->map, &iter, e, ent) {
 		if (free_values)
 			free(e->value);
-		if (!map->pool) {
-			if (map->strdup_strings)
-				free((char*)e->key);
+		if (!map->pool)
 			free(e);
-		}
 	}
 }
 
@@ -82,26 +79,34 @@ void strmap_partial_clear(struct strmap *map, int free_values)
 void *strmap_put(struct strmap *map, const char *str, void *data)
 {
 	struct strmap_entry *entry = find_strmap_entry(map, str);
-	void *old = NULL;
 
 	if (entry) {
-		old = entry->value;
+		void *old = entry->value;
 		entry->value = data;
-	} else {
-		const char *key = str;
-
-		entry = map->pool ? mem_pool_alloc(map->pool, sizeof(*entry))
-				  : xmalloc(sizeof(*entry));
-		hashmap_entry_init(&entry->ent, strhash(str));
+		return old;
+	}
 
-		if (map->strdup_strings)
-			key = map->pool ? mem_pool_strdup(map->pool, str)
-					: xstrdup(str);
-		entry->key = key;
-		entry->value = data;
-		hashmap_add(&map->map, &entry->ent);
+	if (map->strdup_strings) {
+		if (!map->pool) {
+			FLEXPTR_ALLOC_STR(entry, key, str);
+		} else {
+			size_t len = st_add(strlen(str), 1); /* include NUL */
+			entry = mem_pool_alloc(map->pool,
+					       st_add(sizeof(*entry), len));
+			memcpy(entry + 1, str, len);
+			entry->key = (void *)(entry + 1);
+		}
+	} else if (!map->pool) {
+		entry = xmalloc(sizeof(*entry));
+	} else {
+		entry = mem_pool_alloc(map->pool, sizeof(*entry));
 	}
-	return old;
+	hashmap_entry_init(&entry->ent, strhash(str));
+	if (!map->strdup_strings)
+		entry->key = str;
+	entry->value = data;
+	hashmap_add(&map->map, &entry->ent);
+	return NULL;
 }
 
 struct strmap_entry *strmap_get_entry(struct strmap *map, const char *str)
@@ -130,11 +135,8 @@ void strmap_remove(struct strmap *map, const char *str, int free_value)
 		return;
 	if (free_value)
 		free(ret->value);
-	if (!map->pool) {
-		if (map->strdup_strings)
-			free((char*)ret->key);
+	if (!map->pool)
 		free(ret);
-	}
 }
 
 void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
diff --git a/strmap.h b/strmap.h
index b9d882a2d0..d210da5904 100644
--- a/strmap.h
+++ b/strmap.h
@@ -14,6 +14,7 @@ struct strmap_entry {
 	struct hashmap_entry ent;
 	const char *key;
 	void *value;
+	/* strmap_entry may be allocated extra space to store the key at end */
 };
 
 int cmp_strmap_entry(const void *hashmap_cmp_fn_data,
-- 
gitgitgadget

