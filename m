Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F099C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 03:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0B120716
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 03:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo0jbEsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHNDCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgHNDCV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 23:02:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E2C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 20:02:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so8373182ejb.11
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 20:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ms+Sz4Uhn67ieoWyWfXaUOw5+wXjv/qK6vxQpnPAkSo=;
        b=Wo0jbEsYJO2DYKXQXyOEfl+11v8WHXVSL+Bp4yVCk49W6t+yZplLtDyOdOqaKPmLGt
         IhjZ8fwjfAC9ikNfx2k9a27f/rzbk8Xpbssl3o/p0SwoRIVoGwAV3tqjx3Iv3OalE8sf
         uGlFnmRdIDgxpf4q+Cjp1mKTy/pgONUmnGVYzn/g++m+aVeKstQx6T5Qxxr+7j07ovmY
         WqqaPbcDfJHD1KbLbgyxQwtBKoDz55O6RsEd4CzeD5uUVhJBhnQFw/84mS+kD+Nkxluy
         eyJpaCbDmc07WI7T8rNxMk2DrPiEbpsF9mleUG3+mcctqyxVJiH08bRwMbAqORDY5LT+
         hf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ms+Sz4Uhn67ieoWyWfXaUOw5+wXjv/qK6vxQpnPAkSo=;
        b=mazi+xs6U8q7wTDA2ulVxBMxG2oH8xHBa0D6PVAGWdzACLq3oRH2XlKbsVsuxzRjPs
         epvRgJ6ZsTHrBLb0I3icWAow/qyIVKOJfDqD/ypxWlwsjDpQ+SlnACuM+18KvVb0yXKX
         PAIClIyU5YbLduq8CEnNDxPv5D+PeC7LztYc0Q2pepEYQ4hkSlUIm9O5jkvPZzsuoXx/
         86Y8Mh3UubQ1gubDR8KDxNV1JQyKfSEhfNEnD7ALz21DA6TBtmoJrasKKqfu4R9pmj6N
         L9EYZRbhvpJP3LI+SA0AtFTztD1Le8PWkW5ity4nNBVEoqTy0BiFZgGsOHlBTVhuI1v1
         Ziug==
X-Gm-Message-State: AOAM530B0Li3cGGe972JtxLvWmj5X3FaRadzZCF0TDRohL+49hknttQk
        SlOn1mXROeUGFdPQ+MnSrfIhJP0Z
X-Google-Smtp-Source: ABdhPJxhThYDslTSmX/mbhJYLZ3coa5zZWsK43iIfiTjmq7xO9aSuorBJipXfubcuVTDOBT/yDTUcQ==
X-Received: by 2002:a17:906:8316:: with SMTP id j22mr488614ejx.20.1597374139339;
        Thu, 13 Aug 2020 20:02:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc9sm5626237edb.14.2020.08.13.20.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:02:18 -0700 (PDT)
Message-Id: <62c2479fe6068f31c3cae1b1a13d67527121a15b.1597374135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
References: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 03:02:15 +0000
Subject: [PATCH 3/3] mem-pool: use consistent pool variable name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
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
 mem-pool.c | 50 ++++++++++++++++++++++++++------------------------
 mem-pool.h |  6 +++---
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index b7d789823e..08039ed069 100644
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
@@ -26,28 +28,28 @@ static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t b
 		p->next_block = insert_after->next_block;
 		insert_after->next_block = p;
 	} else {
-		p->next_block = mem_pool->mp_block;
-		mem_pool->mp_block = p;
+		p->next_block = pool->mp_block;
+		pool->mp_block = p;
 	}
 
 	return p;
 }
 
-void mem_pool_init(struct mem_pool *mem_pool, size_t initial_size)
+void mem_pool_init(struct mem_pool *pool, size_t initial_size)
 {
-	mem_pool->mp_block = NULL;
-	mem_pool->pool_alloc = 0;
-	mem_pool->block_alloc = BLOCK_GROWTH_SIZE;
+	pool->mp_block = NULL;
+	pool->pool_alloc = 0;
+	pool->block_alloc = BLOCK_GROWTH_SIZE;
 
 	if (initial_size > 0)
-		mem_pool_alloc_block(mem_pool, initial_size, NULL);
+		mem_pool_alloc_block(pool, initial_size, NULL);
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
@@ -59,11 +61,11 @@ void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
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
@@ -72,15 +74,15 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
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
@@ -88,10 +90,10 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
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
@@ -119,12 +121,12 @@ char *mem_pool_xstrndup(struct mem_pool *pool, const char *str, size_t len)
 	return memcpy(ret, str, minlen);
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
index 30b7a8c03b..022b3097e9 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -24,12 +24,12 @@ struct mem_pool {
 /*
  * Initialize mem_pool with specified initial size.
  */
-void mem_pool_init(struct mem_pool *mem_pool, size_t initial_size);
+void mem_pool_init(struct mem_pool *pool, size_t initial_size);
 
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
