Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFACC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 03:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C2792078B
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 03:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDf8Nryy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHNDCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNDCU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 23:02:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30814C061383
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 20:02:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id m22so8375010eje.10
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 20:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iYrgsQPCqRRvg41wuz0WKoA7INv92D0AhW5p1p69vHQ=;
        b=EDf8NryynNjHbJN/tHLe5jEleTbhJMU6epHyUypc0MfPfRMVToIbieI9drawDnfyWB
         offeIinGy25MkOuOz3BNRXRxm1oYApgIICx0jKwf493NDNtuVeGBJnkSmey9zoutQ398
         OW55bMmpNRukoZW0/UqS+NifPZ4lt9e1X90Kl5fmhYafvUuDHd4pMJOrAYqQxzoGymHh
         BCztLAMRwUIIoW4CnmU9FtUyDPG9x7S60tdMMDYTPXHfL4QsSTRaiZ27tyZsSPZ/4QjR
         GrTQdGSWZwPnGItxqhgBizDhBOzqL/ucewgDlfCiJYEJj0CJuJVskgLCmBfsuaDKK53e
         Tl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iYrgsQPCqRRvg41wuz0WKoA7INv92D0AhW5p1p69vHQ=;
        b=FY67KnvDg1vfuysqoNEvGbS5SFAJ2DLaJBN7bpKLJF2WrCvkguSOuVsNXXGBOl/Seb
         sJlDD6HZa6BXLTAQFhfqAlkaGaYS6a3Hzz/SPO+fufaEyJiuY9X53GFjI06zUJFDpP2y
         zphsmXXplPd106fa5mnoy/TeojPiXpeouXWCCVcq5QjrCe1jXb1eeERU42Prjxq+3FMl
         DEt1SvCkuZ6e+2PhHfj7SwTvpnowTKojeDZAkycN5pQUtbCaubpzD/YKROImywvME9tP
         xWt0loM2ho0fZ412a2JNDFfjRyPNTCFtHGmriZdmI2HLPRTisoNpwjgDPCr0IPVf22Wt
         p+Ow==
X-Gm-Message-State: AOAM532cd/HXbMRaKzZykOzB4DjMymkK8+UTcZy29hCFcjGCeLRCOul9
        GyjV4KYteX2BMl1i6e+ZFc0E+Xr8
X-Google-Smtp-Source: ABdhPJzbkXtDajYcwtNjV0zIqHNqu16GC0s/Nw1YH0zlhLAbuJbw/nyTIo6rSxCU/ieZOKYGtlq3/g==
X-Received: by 2002:a17:906:1ccd:: with SMTP id i13mr497540ejh.424.1597374138623;
        Thu, 13 Aug 2020 20:02:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ar2sm2692044ejc.61.2020.08.13.20.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:02:18 -0700 (PDT)
Message-Id: <f13a52055cd975d457e0593cbabb70897e78024b.1597374135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
References: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 03:02:14 +0000
Subject: [PATCH 2/3] mem-pool: use more standard initialization and
 finalization
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
 mem-pool.c    | 20 +++++++-------------
 mem-pool.h    |  4 ++--
 read-cache.c  | 21 +++++++++++++--------
 split-index.c |  6 ++++--
 4 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/mem-pool.c b/mem-pool.c
index 3a8c54d9df..b7d789823e 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -33,21 +33,14 @@ static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t b
 	return p;
 }
 
-void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
+void mem_pool_init(struct mem_pool *mem_pool, size_t initial_size)
 {
-	struct mem_pool *pool;
-
-	if (*mem_pool)
-		return;
-
-	pool = xcalloc(1, sizeof(*pool));
-
-	pool->block_alloc = BLOCK_GROWTH_SIZE;
+	mem_pool->mp_block = NULL;
+	mem_pool->pool_alloc = 0;
+	mem_pool->block_alloc = BLOCK_GROWTH_SIZE;
 
 	if (initial_size > 0)
-		mem_pool_alloc_block(pool, initial_size, NULL);
-
-	*mem_pool = pool;
+		mem_pool_alloc_block(mem_pool, initial_size, NULL);
 }
 
 void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
@@ -66,7 +59,8 @@ void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
 		free(block_to_free);
 	}
 
-	free(mem_pool);
+	mem_pool->mp_block = NULL;
+	mem_pool->pool_alloc = 0;
 }
 
 void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
diff --git a/mem-pool.h b/mem-pool.h
index fcaa2d462b..30b7a8c03b 100644
--- a/mem-pool.h
+++ b/mem-pool.h
@@ -24,10 +24,10 @@ struct mem_pool {
 /*
  * Initialize mem_pool with specified initial size.
  */
-void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size);
+void mem_pool_init(struct mem_pool *mem_pool, size_t initial_size);
 
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

