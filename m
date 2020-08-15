Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4EEC433DF
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0F92053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R16nPcD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgHOWC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgHOVvY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4FC0F26D7
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:38:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a15so11007374wrh.10
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HihR3MXTCuXZyJFhlu8zx4dmvSHubtDxD8SCsfS341s=;
        b=R16nPcD4S9O5hVpKab4udUFuxAn43Ve4OQ4KcbW/i01kJNIbK0YUlg6pPulQE57U7M
         G/s7gMT4XqRLIQBlg0+Urz7WiZHmjTGIe8eamGNwIY2B4+IVKXymnFoi2GTKQHz8P517
         VqrdLycp/LQfgQ/TIHKmej6I2leXtCOuUbbdYDf2bF5PlGWCwdU0zD9789IbBTIGqH+K
         0Uj7KHFk/0QyELL5hCdarJ8w368LEkblr+xof8OxwzphhQ3mmK7g5ob3MYSZ5v8Bb75L
         aPKNu3igkvgiAnFIi6OxZzdGdoCp3xdExx3aQUh2NXHtR2axjnD5/mh0+/quT/UfF6Tp
         35Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HihR3MXTCuXZyJFhlu8zx4dmvSHubtDxD8SCsfS341s=;
        b=q0mZzPsFegdFAtiV4BCzWPgQqTUWUt7YVG1xKUc4BSAG3XkJCezDxPlA1n05V13ojv
         8Xpm0WImMp7ELnuZQUJJu/LNmgTbzn1v+O024z4ugqWNv4g5bjVwUaKkj2rf4h+rd34C
         V4yBNEAc8b0jyAxAfq24Y1NogW5eeukrfQGg/P3Kmf/pRJnr+4XMx+PJmUHZABgS7Ue2
         U/dOYf0CPdy4IG56t+vGFDWLtG9RxjbaDbaFR9FtqYCXR+qRKPxJ2XFyw7G4GzSuxZR3
         o13BnQX5+64chdhAjoNzbWgLEYVbzwJoeeoPV/u4VN+BUVPV3dkblPKkTF2QWmUMHv0J
         MJQA==
X-Gm-Message-State: AOAM531CQKVNaG5/83usrNyDkrG5gUMuCY32rSaJxWLNHOcrtLYyz3On
        dHpVzrkCnVCkvIPkxXX67Wa9pogwB7c=
X-Google-Smtp-Source: ABdhPJw4oSJea+qK25TqesZl3p1gBmfl/c3d0b0I62v5m6IY6k5gajCWDmCuQScFXrLJlZkh34b1ow==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr7683445wrv.331.1597513081334;
        Sat, 15 Aug 2020 10:38:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm24105810wrw.91.2020.08.15.10.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:38:00 -0700 (PDT)
Message-Id: <65f334f5cfe7dd99e74d48f2b16b61ae84182c9d.1597513078.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.git.1597513078.gitgitgadget@gmail.com>
References: <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
        <pull.830.v3.git.git.1597513078.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Aug 2020 17:37:56 +0000
Subject: [PATCH v3 2/3] mem-pool: use more standard initialization and
 finalization
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
index 020b51e0c5..7659919ab2 100644
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
index ca062c9070..870161ab44 100644
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

