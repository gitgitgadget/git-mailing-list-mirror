Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49D4C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 06:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A8620774
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 06:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyJybREl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHNGAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgHNGAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 02:00:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1382C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 23:00:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d190so6497981wmd.4
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 23:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z3YtZo45iGRYAJ096CebD34XS6J9nIl2b4NndzMgjLo=;
        b=XyJybREleHzn+PMDhsgb5y4anbJnAHC3Dt/QEzqw5LeVIQBBOu8lqWEVDQU/fGe0Mk
         nz+6eNnHI7xFVWT72vncCr5YSM6eJ8+VXjH920Y2IXbS6bDmhqUFww78CrcP/XS2p+uw
         B0nT5P9XDCh5zN3t77rY9hQoLouOfCuss0u+Enz5Y+RVmRkb8ydB3urBFbeGJcxhNe2d
         a93JSXGIppbM6+VI+Wkz7T0k1ycYGkgBzu/gmq4iKXxWfPp8x1KLKv2I4vs8EDb5kd8X
         v8l8E4OG1xFbxUFyOO3LiutPdYwS2n1pgJ93b7aGqNivp/fWRDaeAKEj4hQIoyalga09
         h6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z3YtZo45iGRYAJ096CebD34XS6J9nIl2b4NndzMgjLo=;
        b=FvF7dvaU39Jf5KqGjsEETMHzrdlvqSSPQaJY16WWjAdQP1Upl3+1CNQqhzrV2KC+e2
         DPda7eiJI1JxHvtq6/xn2G/6k0NtzNc4gZWRNXCvWnrM1oQpABXRSdy3cA0ppVWo/V0u
         aMuHlHRRqKStSvfzevVJQPQdxa8uCAWYJa10KddCUQHzm3SpYlxjamvFf+8Zexi3dmOy
         zlQP2yFrT99ls4OaU3Qo3Y+BFgx9r23xStqOWSEKkptDcxLPGN4SMhgNMpHadlzhbdfp
         inPN79NggDfU5cyfVyTfp7iekJ45kEAJtGWRF5YGY5CVW4eDjb4Y8E1TCsm5iAsujU6s
         e7KA==
X-Gm-Message-State: AOAM53227xXI3IesHJnf2VimfRzWYNxMC3uVcUGw9XiAUkX4imM3eqws
        dl5f78HwvTcnDhtezbSOONdMHDkGXOQ=
X-Google-Smtp-Source: ABdhPJyVfUhhQ9tKUg6yOtbxOgLNqRTPR5aZJ7PMBnFjGdlaJkVZKy/WO8AnxLIvR+4lgOadYlJ12g==
X-Received: by 2002:a1c:1f0d:: with SMTP id f13mr1031910wmf.53.1597384821897;
        Thu, 13 Aug 2020 23:00:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k15sm13470587wrp.43.2020.08.13.23.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 23:00:21 -0700 (PDT)
Message-Id: <pull.830.v2.git.git.1597384820.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
References: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Aug 2020 06:00:17 +0000
Subject: [PATCH v2 0/3] Extend and add a little more generalization to the mem_pool API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my new merge algorithm, I made use of the mem_pool API in a few
places...but I also needed to add a few more functions and also needed to
make the API a bit more general.

Changes since v1:

 * Made the error message tweaks suggested by Eric
 * Although mem_pool_init() intialized all members manually, add a memset()
   to 0 for future-proofing, as suggested by Junio.
 * Use 'pool' instead of 'mem_pool' in patch 2 so that patch 3 doesn't have
   to change as much (as suggested by Junio).

Also, Matheus said he'd rebase his parallel-checkout RFC series (next yet in
next or seen) on top of mine to avoid the semantic conflict.

Elijah Newren (3):
  mem-pool: add convenience functions for xstrdup and xstrndup
  mem-pool: use more standard initialization and finalization
  mem-pool: use consistent pool variable name

 fast-import.c | 12 ++-------
 mem-pool.c    | 74 ++++++++++++++++++++++++++++++++-------------------
 mem-pool.h    | 14 +++++++---
 read-cache.c  | 21 +++++++++------
 split-index.c |  6 +++--
 5 files changed, 75 insertions(+), 52 deletions(-)


base-commit: 7814e8a05a59c0cf5fb186661d1551c75d1299b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-830%2Fnewren%2Fmem_pool_api-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-830/newren/mem_pool_api-v2
Pull-Request: https://github.com/git/git/pull/830

Range-diff vs v1:

 1:  eae8b2923f ! 1:  6d679c5b46 mem-pool: add convenience functions for xstrdup and xstrndup
     @@ mem-pool.c: void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_
      +	char *ret = mem_pool_alloc(pool, len);
      +
      +	if (!ret)
     -+		die("Out of memory, mem_pool_xstrdup failed");
     ++		die(_("mem_pool_xstrdup: out of memory"));
      +
      +	return memcpy(ret, str, len);
      +}
     @@ mem-pool.c: void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_
      +	char *ret = mem_pool_alloc(pool, minlen+1);
      +
      +	if (!ret)
     -+		die("Out of memory, mem_pool_xstrndup failed");
     ++		die(_("mem_pool_xstrndup: out of memory"));
      +
      +	ret[minlen] = '\0';
      +	return memcpy(ret, str, minlen);
 2:  f13a52055c ! 2:  e04ba96b22 mem-pool: use more standard initialization and finalization
     @@ mem-pool.c: static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_po
       }
       
      -void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
     -+void mem_pool_init(struct mem_pool *mem_pool, size_t initial_size)
     ++void mem_pool_init(struct mem_pool *pool, size_t initial_size)
       {
      -	struct mem_pool *pool;
      -
     @@ mem-pool.c: static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_po
      -
      -	pool = xcalloc(1, sizeof(*pool));
      -
     --	pool->block_alloc = BLOCK_GROWTH_SIZE;
     -+	mem_pool->mp_block = NULL;
     -+	mem_pool->pool_alloc = 0;
     -+	mem_pool->block_alloc = BLOCK_GROWTH_SIZE;
     ++	memset(pool, 0, sizeof(*pool));
     + 	pool->block_alloc = BLOCK_GROWTH_SIZE;
       
       	if (initial_size > 0)
     --		mem_pool_alloc_block(pool, initial_size, NULL);
     + 		mem_pool_alloc_block(pool, initial_size, NULL);
      -
      -	*mem_pool = pool;
     -+		mem_pool_alloc_block(mem_pool, initial_size, NULL);
       }
       
       void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
     @@ mem-pool.h: struct mem_pool {
        * Initialize mem_pool with specified initial size.
        */
      -void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size);
     -+void mem_pool_init(struct mem_pool *mem_pool, size_t initial_size);
     ++void mem_pool_init(struct mem_pool *pool, size_t initial_size);
       
       /*
      - * Discard a memory pool and free all the memory it is responsible for.
 3:  62c2479fe6 ! 3:  616402c64e mem-pool: use consistent pool variable name
     @@ mem-pool.c: static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_po
       	}
       
       	return p;
     - }
     - 
     --void mem_pool_init(struct mem_pool *mem_pool, size_t initial_size)
     -+void mem_pool_init(struct mem_pool *pool, size_t initial_size)
     - {
     --	mem_pool->mp_block = NULL;
     --	mem_pool->pool_alloc = 0;
     --	mem_pool->block_alloc = BLOCK_GROWTH_SIZE;
     -+	pool->mp_block = NULL;
     -+	pool->pool_alloc = 0;
     -+	pool->block_alloc = BLOCK_GROWTH_SIZE;
     - 
     - 	if (initial_size > 0)
     --		mem_pool_alloc_block(mem_pool, initial_size, NULL);
     -+		mem_pool_alloc_block(pool, initial_size, NULL);
     +@@ mem-pool.c: void mem_pool_init(struct mem_pool *pool, size_t initial_size)
     + 		mem_pool_alloc_block(pool, initial_size, NULL);
       }
       
      -void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
     @@ mem-pool.c: char *mem_pool_xstrndup(struct mem_pool *pool, const char *str, size
       			return 1;
      
       ## mem-pool.h ##
     -@@ mem-pool.h: struct mem_pool {
     - /*
     -  * Initialize mem_pool with specified initial size.
     -  */
     --void mem_pool_init(struct mem_pool *mem_pool, size_t initial_size);
     -+void mem_pool_init(struct mem_pool *pool, size_t initial_size);
     - 
     +@@ mem-pool.h: void mem_pool_init(struct mem_pool *pool, size_t initial_size);
       /*
        * Discard all the memory the memory pool is responsible for.
        */

-- 
gitgitgadget
