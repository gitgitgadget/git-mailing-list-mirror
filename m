Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A431C433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F5223358
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltfB0ZX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgHOWAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgHOVvi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA9C0F26D9
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:38:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so11003958wrm.12
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2aZV65QQmMM8E78ShlHxCGl6GN39gcUCmrk87+Nqs+E=;
        b=ltfB0ZX/aOc/ZCzDvBlT5WQvifNitiFJyrSzsorblE+w3n3naYOsS1cRvyeqFo8bRG
         SNcWfI1Yv5icrg+V3upYJlJcHvTFb5sL5T+2ATJboeoA+UePdT1w4eugv1lh3ZR6GX6Y
         brSTVWVdqv9Gv2GxaeH2LKxlSTUZJ+NQUnYAU49CK7h8zk5Sl186dRwH9fiAkmp85VL7
         istZA5CQ3/vpiP3ivyRCwZNQw505maWce3wYm6Se4Uizp/WEj43QTkZfv/QfwPl+dYoc
         DssnYB65o75AfjibNorfRAxEHtOGvnF/Ojv5mCF8TM9u1OyL5U7nMz29uhTzzrfAH+LQ
         jfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2aZV65QQmMM8E78ShlHxCGl6GN39gcUCmrk87+Nqs+E=;
        b=kJQE8NLP4c4KzhwrB5XagpDXZnsfjEgEe16+SFC+5E4iSngRBsbd7+qoibsfns7z3X
         ByUFzf58llctX8V82FR4SEHj9mi27nQdpTIX6pM1Jz84PL9gOHjhaJuctZfq4IqDLQlB
         5FT5YeXrbJR8Zy+tNDEKvmtG+ciYaTv02UHvzVn1rxp+at6lxfGw9D7qK6MQsR8oK6en
         9gu+ycO7CSlp/12dqRcWhG4iYY/eUC9jIu/IgRpiIqdGd3V203oeIaEmMf72uTsEdV6B
         /skYTgMi4PZSoydsUO332hcW07phHpIKLJfe19qv4msyDq+IjVRc7Yrxj8avL5Ikz9Ut
         JXQQ==
X-Gm-Message-State: AOAM533cDCxek1HCF1KGZw6aUV2p/fdhIaPA/spzOASqyLnl9nzUb2ox
        0WZFvW0CFZQtu9YJqEeMG9UTZKiskqc=
X-Google-Smtp-Source: ABdhPJzfYibu9Sm1aQkEDBR8eey3DU6AJ7uZaqqdCCHCgXg+eIxAqhCQL3ADCq/YTiuSpnZ7HsdP+A==
X-Received: by 2002:a5d:61c8:: with SMTP id q8mr7462535wrv.160.1597513082430;
        Sat, 15 Aug 2020 10:38:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm20463734wrs.88.2020.08.15.10.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:38:01 -0700 (PDT)
Message-Id: <09976779c3b4dc47e44bb70034119548b9f51391.1597513078.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.git.1597513078.gitgitgadget@gmail.com>
References: <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
        <pull.830.v3.git.git.1597513078.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 17:37:57 +0000
Subject: [PATCH v3 3/3] mem-pool: use consistent pool variable name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

About half the function declarations in mem-pool.h used 'struct mem_pool
*pool', while the other half used 'struct mem_pool *mem_pool'.  Make the
code a bit more consistent by just using 'pool' in preference to
'mem_pool' everywhere.

No behavioral changes included; this is just a mechanical rename (though
a line or two was rewrapped as well).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 mem-pool.c | 40 +++++++++++++++++++++-------------------
 mem-pool.h |  4 ++--
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index 7659919ab2..8401761dda 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -12,11 +12,13 @@
  * `insert_after`. If `insert_after` is NULL, then insert block at the
  * head of the linked list.
  */
-static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t block_alloc, struct mp_block *insert_after)
+static struct mp_block *mem_pool_alloc_block(struct mem_pool *pool,
+					     size_t block_alloc,
+					     struct mp_block *insert_after)
 {
 	struct mp_block *p;
 
-	mem_pool->pool_alloc += sizeof(struct mp_block) + block_alloc;
+	pool->pool_alloc += sizeof(struct mp_block) + block_alloc;
 	p = xmalloc(st_add(sizeof(struct mp_block), block_alloc));
 
 	p->next_free = (char *)p->space;
@@ -26,8 +28,8 @@ static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t b
 		p->next_block = insert_after->next_block;
 		insert_after->next_block = p;
 	} else {
-		p->next_block = mem_pool->mp_block;
-		mem_pool->mp_block = p;
+		p->next_block = pool->mp_block;
+		pool->mp_block = p;
 	}
 
 	return p;
@@ -42,11 +44,11 @@ void mem_pool_init(struct mem_pool *pool, size_t initial_size)
 		mem_pool_alloc_block(pool, initial_size, NULL);
 }
 
-void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
+void mem_pool_discard(struct mem_pool *pool, int invalidate_memory)
 {
 	struct mp_block *block, *block_to_free;
 
-	block = mem_pool->mp_block;
+	block = pool->mp_block;
 	while (block)
 	{
 		block_to_free = block;
@@ -58,11 +60,11 @@ void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
 		free(block_to_free);
 	}
 
-	mem_pool->mp_block = NULL;
-	mem_pool->pool_alloc = 0;
+	pool->mp_block = NULL;
+	pool->pool_alloc = 0;
 }
 
-void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
+void *mem_pool_alloc(struct mem_pool *pool, size_t len)
 {
 	struct mp_block *p = NULL;
 	void *r;
@@ -71,15 +73,15 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 	if (len & (sizeof(uintmax_t) - 1))
 		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
 
-	if (mem_pool->mp_block &&
-	    mem_pool->mp_block->end - mem_pool->mp_block->next_free >= len)
-		p = mem_pool->mp_block;
+	if (pool->mp_block &&
+	    pool->mp_block->end - pool->mp_block->next_free >= len)
+		p = pool->mp_block;
 
 	if (!p) {
-		if (len >= (mem_pool->block_alloc / 2))
-			return mem_pool_alloc_block(mem_pool, len, mem_pool->mp_block);
+		if (len >= (pool->block_alloc / 2))
+			return mem_pool_alloc_block(pool, len, pool->mp_block);
 
-		p = mem_pool_alloc_block(mem_pool, mem_pool->block_alloc, NULL);
+		p = mem_pool_alloc_block(pool, pool->block_alloc, NULL);
 	}
 
 	r = p->next_free;
@@ -87,10 +89,10 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
 	return r;
 }
 
-void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
+void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size)
 {
 	size_t len = st_mult(count, size);
-	void *r = mem_pool_alloc(mem_pool, len);
+	void *r = mem_pool_alloc(pool, len);
 	memset(r, 0, len);
 	return r;
 }
@@ -113,12 +115,12 @@ char *mem_pool_strndup(struct mem_pool *pool, const char *str, size_t len)
 	return memcpy(ret, str, actual_len);
 }
 
-int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
+int mem_pool_contains(struct mem_pool *pool, void *mem)
 {
 	struct mp_block *p;
 
 	/* Check if memory is allocated in a block */
-	for (p = mem_pool->mp_block; p; p = p->next_block)
+	for (p = pool->mp_block; p; p = p->next_block)
 		if ((mem >= ((void *)p->space)) &&
 		    (mem < ((void *)p->end)))
 			return 1;
diff --git a/mem-pool.h b/mem-pool.h
index 870161ab44..fe7507f022 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -29,7 +29,7 @@ void mem_pool_init(struct mem_pool *pool, size_t initial_size);
 /*
  * Discard all the memory the memory pool is responsible for.
  */
-void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory);
+void mem_pool_discard(struct mem_pool *pool, int invalidate_memory);
 
 /*
  * Alloc memory from the mem_pool.
@@ -58,6 +58,6 @@ void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src);
  * Check if a memory pointed at by 'mem' is part of the range of
  * memory managed by the specified mem_pool.
  */
-int mem_pool_contains(struct mem_pool *mem_pool, void *mem);
+int mem_pool_contains(struct mem_pool *pool, void *mem);
 
 #endif
-- 
gitgitgadget
