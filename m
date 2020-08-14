Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AD2C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 06:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF4A20829
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 06:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kloSSrIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgHNGA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgHNGAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 02:00:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAB0C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 23:00:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a15so7275562wrh.10
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8LqUqVEVgVicP9J80Tv6tj3ufmN52cd6R9aYCtUbcGM=;
        b=kloSSrIeiNY6xPeiUEQ66/kSSnlYzH9R0BD/uNLaiVv8e3M7FItT2K5yACGyjfcI4K
         HV6a1/ewLfJy6M/NlmLcYVWm0v1tGd2JCuqW31CdGO1F/OEkVmSgjddWyD7U9wEedTkP
         v6qOc4OBUg7ObFBrVg/KrCTY3mUwya5r0tlZCYmM8Z6lthyA4OhbTIrM2b1av5lY/Vo4
         9E75I88OE/Qg34kLvnkDNo/KiN/9b5lV2Kxr/3Cehy3qc0AdH5yC/k5Z+uykt+XFpiJh
         LGbf0inOh+HT691QWgn3nacM8Fl119mPub5JqrZ+kR2T5O/ad+yi+MOtJZRXeRSi3Ybn
         awLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8LqUqVEVgVicP9J80Tv6tj3ufmN52cd6R9aYCtUbcGM=;
        b=icFxxMAf6RA0LawHPT71TSWmRo4izlWM5OTuNoGquZV7WeA21gYpEIX3Ta6oHBcZGz
         pDXyVmv7fY+xQw9Ufc7/BCUsYhzv6+916pZNiqOxN597Mj8CXtQTCUJ6G9oBLH2ZQtzd
         zu1/6IZ0ahJ/JIHnuC7Z+miBVHLpKd/i4j4wRzqBz4/1ZMwfO+QSV6Oh85M7GCOH+FZU
         T3fXBB16JmrM4+BdNt77dYF3q16EiUOxZGxUhFBwYANO2nKRosKwmIhOFjAllpRBryA9
         avjV0A0fLbXxmMRBnQnDcM0dUhHvFm1mvEEyGkLny7S/BNQ+ReotOH+3CT1Dvcswvurd
         Df4Q==
X-Gm-Message-State: AOAM532cXygpArR6z3XwK4cCjrVxvMeHGeKjA93rO09KtC8WSC8GQdzZ
        Hip1Be9LOWEyWZbkwqHYk1FpyYBhCjE=
X-Google-Smtp-Source: ABdhPJwc90i3OjOf3sEfWQRxTFbN+jNCXQLQlbUWUyxkLZ2eZtPCGL6qtpqxrwF9xYwbxXHEo8iuTg==
X-Received: by 2002:adf:ab05:: with SMTP id q5mr1117882wrc.46.1597384823466;
        Thu, 13 Aug 2020 23:00:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g18sm13611438wru.27.2020.08.13.23.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 23:00:23 -0700 (PDT)
Message-Id: <e04ba96b227583875b2034325adfc7f5331d736f.1597384820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
References: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
        <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 06:00:19 +0000
Subject: [PATCH v2 2/3] mem-pool: use more standard initialization and
 finalization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A typical memory type, such as strbuf, hashmap, or string_list can be
stored on the stack or embedded within another structure.  mem_pool
cannot be, because of how mem_pool_init() and mem_pool_discard() are
written.  mem_pool_init() does essentially the following (simplified
for purposes of explanation here):

    void mem_pool_init(struct mem_pool **pool...)
    {
        *pool = xcalloc(1, sizeof(*pool));

It seems weird to require that mem_pools can only be accessed through a
pointer.  It also seems slightly dangerous: unlike strbuf_release() or
strbuf_reset() or string_list_clear(), all of which put the data
structure into a state where it can be re-used after the call,
mem_pool_discard(pool) will leave pool pointing at free'd memory.
read-cache (and split-index) are the only current users of mem_pools,
and they haven't fallen into a use-after-free mistake here, but it seems
likely to be problematic for future users especially since several of
the current callers of mem_pool_init() will only call it when the
mem_pool* is not already allocated (i.e. is NULL).

This type of mechanism also prevents finding synchronization
points where one can free existing memory and then resume more
operations.  It would be natural at such points to run something like
    mem_pool_discard(pool...);
and, if necessary,
    mem_pool_init(&pool...);
and then carry on continuing to use the pool.  However, this fails badly
if several objects had a copy of the value of pool from before these
commands; in such a case, those objects won't get the updated value of
pool that mem_pool_init() overwrites pool with and they'll all instead
be reading and writing from free'd memory.

Modify mem_pool_init()/mem_pool_discard() to behave more like
   strbuf_init()/strbuf_release()
or
   string_list_init()/string_list_clear()
In particular: (1) make mem_pool_init() just take a mem_pool* and have
it only worry about allocating struct mp_blocks, not the struct mem_pool
itself, (2) make mem_pool_discard() free the memory that the pool was
responsible for, but leave it in a state where it can be used to
allocate more memory afterward (without the need to call mem_pool_init()
again).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 mem-pool.c    | 15 ++++-----------
 mem-pool.h    |  4 ++--
 read-cache.c  | 21 +++++++++++++--------
 split-index.c |  6 ++++--
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index 33fda1c411..305bcd3542 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -33,21 +33,13 @@ static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t b
 	return p;
 }
 
-void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
+void mem_pool_init(struct mem_pool *pool, size_t initial_size)
 {
-	struct mem_pool *pool;
-
-	if (*mem_pool)
-		return;
-
-	pool = xcalloc(1, sizeof(*pool));
-
+	memset(pool, 0, sizeof(*pool));
 	pool->block_alloc = BLOCK_GROWTH_SIZE;
 
 	if (initial_size > 0)
 		mem_pool_alloc_block(pool, initial_size, NULL);
-
-	*mem_pool = pool;
 }
 
 void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
@@ -66,7 +58,8 @@ void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
 		free(block_to_free);
 	}
 
-	free(mem_pool);
+	mem_pool->mp_block = NULL;
+	mem_pool->pool_alloc = 0;
 }
 
 void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
diff --git a/mem-pool.h b/mem-pool.h
index fcaa2d462b..a55ee4bc38 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -24,10 +24,10 @@ struct mem_pool {
 /*
  * Initialize mem_pool with specified initial size.
  */
-void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size);
+void mem_pool_init(struct mem_pool *pool, size_t initial_size);
 
 /*
- * Discard a memory pool and free all the memory it is responsible for.
+ * Discard all the memory the memory pool is responsible for.
  */
 void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory);
 
diff --git a/read-cache.c b/read-cache.c
index 8ed1c29b54..fa291cdbee 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -89,8 +89,10 @@ static struct mem_pool *find_mem_pool(struct index_state *istate)
 	else
 		pool_ptr = &istate->ce_mem_pool;
 
-	if (!*pool_ptr)
-		mem_pool_init(pool_ptr, 0);
+	if (!*pool_ptr) {
+		*pool_ptr = xmalloc(sizeof(**pool_ptr));
+		mem_pool_init(*pool_ptr, 0);
+	}
 
 	return *pool_ptr;
 }
@@ -2006,11 +2008,12 @@ static unsigned long load_all_cache_entries(struct index_state *istate,
 {
 	unsigned long consumed;
 
+	istate->ce_mem_pool = xmalloc(sizeof(*istate->ce_mem_pool));
 	if (istate->version == 4) {
-		mem_pool_init(&istate->ce_mem_pool,
+		mem_pool_init(istate->ce_mem_pool,
 				estimate_cache_size_from_compressed(istate->cache_nr));
 	} else {
-		mem_pool_init(&istate->ce_mem_pool,
+		mem_pool_init(istate->ce_mem_pool,
 				estimate_cache_size(mmap_size, istate->cache_nr));
 	}
 
@@ -2070,7 +2073,8 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
 	if (istate->name_hash_initialized)
 		BUG("the name hash isn't thread safe");
 
-	mem_pool_init(&istate->ce_mem_pool, 0);
+	istate->ce_mem_pool = xmalloc(sizeof(*istate->ce_mem_pool));
+	mem_pool_init(istate->ce_mem_pool, 0);
 
 	/* ensure we have no more threads than we have blocks to process */
 	if (nr_threads > ieot->nr)
@@ -2097,11 +2101,12 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
 		nr = 0;
 		for (j = p->ieot_start; j < p->ieot_start + p->ieot_blocks; j++)
 			nr += p->ieot->entries[j].nr;
+		istate->ce_mem_pool = xmalloc(sizeof(*istate->ce_mem_pool));
 		if (istate->version == 4) {
-			mem_pool_init(&p->ce_mem_pool,
+			mem_pool_init(p->ce_mem_pool,
 				estimate_cache_size_from_compressed(nr));
 		} else {
-			mem_pool_init(&p->ce_mem_pool,
+			mem_pool_init(p->ce_mem_pool,
 				estimate_cache_size(mmap_size, nr));
 		}
 
@@ -2358,7 +2363,7 @@ int discard_index(struct index_state *istate)
 
 	if (istate->ce_mem_pool) {
 		mem_pool_discard(istate->ce_mem_pool, should_validate_cache_entries());
-		istate->ce_mem_pool = NULL;
+		FREE_AND_NULL(istate->ce_mem_pool);
 	}
 
 	return 0;
diff --git a/split-index.c b/split-index.c
index e6154e4ea9..c0e8ad670d 100644
--- a/split-index.c
+++ b/split-index.c
@@ -79,8 +79,10 @@ void move_cache_to_base_index(struct index_state *istate)
 	if (si->base &&
 		si->base->ce_mem_pool) {
 
-		if (!istate->ce_mem_pool)
-			mem_pool_init(&istate->ce_mem_pool, 0);
+		if (!istate->ce_mem_pool) {
+			istate->ce_mem_pool = xmalloc(sizeof(struct mem_pool));
+			mem_pool_init(istate->ce_mem_pool, 0);
+		}
 
 		mem_pool_combine(istate->ce_mem_pool, istate->split_index->base->ce_mem_pool);
 	}
-- 
gitgitgadget

