Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C076C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B1261153
	for <git@archiver.kernel.org>; Tue,  4 May 2021 16:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhEDQ2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhEDQ2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 12:28:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A09C061761
        for <git@vger.kernel.org>; Tue,  4 May 2021 09:27:45 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id k127so9115485qkc.6
        for <git@vger.kernel.org>; Tue, 04 May 2021 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ur5hg8FRpWypt+bCEOF/wmKurITqs/e16QJGxDV6pg=;
        b=TboZVtaO5pkk8xOLUoGmO20Xewt1PZFWICs5+Utft1F7v8tWHS1BiQmV8MywMbw9Vw
         5VpDacSw8Bx8QIC6cX3ffTdXDxGLQtIiHuHsxc2oaN2dEFVhGF3F6F8/xj+z/GBBetXx
         fvycsVCX/FD9cwmjFhTAdERHbUe2FRekZlvxUUzE56vYiTT3ucrU7M4qhGwn5DLAwkuI
         bAViX5KQgjiVVJI18msmBGEbp8KkSiIsxT6r0+Y76b9zMQFX/C8OlOsgrGJX2AbR30YR
         gHcTsYCxlzkKIStiIvhaY1HImIbLkw6qd05rLXpZcOWX0Oq/38ep7QRiQsgvgfivJprQ
         tUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ur5hg8FRpWypt+bCEOF/wmKurITqs/e16QJGxDV6pg=;
        b=FCCdzCTcDihtmyFYmEOtbxJvTNAfzKVEw1xRtbVHU/V14bTEUIm8GE2F96FPKqMPIe
         +NWprx7dwYa+T9pQSLzNH/V2zPzM/HRE19eD/Xe9bLbkaxYg4sqNmipn6/T/xaf/eOP4
         R+leRghPw7u1OHY5zoyDUIzJjWZQZXxxgD2jOynmht2Iw8I986E9v/q5/7PdSXgQ2VAd
         U7O0/zHBjV1S97o8+lIY60gfkvolL7/g2KUGYlAEK5aEsRKl91mZJ6Vm2YzZB+w0dHwa
         9xX+FI6ju4w7sz7HF4Bgggi0jnLr+RuSQ3kVGcmxRJyZyRReYPRQzoyRadLuBH+JCq/x
         Xw5Q==
X-Gm-Message-State: AOAM533Lk6yVzj/Hmnt4EOvdp2L/l+jkdRSG72XofQ/QqZ2FcPyRtp69
        xwIv991xmXfbYP7GncXFwdSSKfDd9z71zg==
X-Google-Smtp-Source: ABdhPJz1yaWFlRDC9StvSfWoptJ6WOaPPhRtYTaOT/dSwQb3hDX6HKSFjbO24+NMK2mym9n6TpevWw==
X-Received: by 2002:a05:620a:672:: with SMTP id a18mr14093853qkh.187.1620145663869;
        Tue, 04 May 2021 09:27:43 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id x19sm11202689qkx.107.2021.05.04.09.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:27:43 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com,
        stolee@gmail.com, tboegi@web.de
Subject: [PATCH v3 0/8] Parallel Checkout (part 3)
Date:   Tue,  4 May 2021 13:27:27 -0300
Message-Id: <cover.1620145501.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1619818517.git.matheus.bernardino@usp.br>
References: <cover.1619818517.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the last part of the parallel checkout series. It adds tests and
parallel checkout support to `git checkout-index` and
`git checkout <pathspec>`.

I rebased this version onto `master`, as part-2 was merged down to
`master`.

Changes since v2:

* Patch 1: Aligned function parameters in make_transient_cache_entry(),
  and renamed the `struct mem_pool *` argument from `mp` to
  `ce_mem_pool`. This is more consistent with the other functions using
  in read-cache.c and with how we call this function in the next patch.

* Patch 2: Removed unnecessary 'Note: ' from commit message.

* Patch 3: Rewrote commit message to better explain why we unified the
  exit paths for `checkout_all()` and `checkout_file()` modes, and
  changed `git checkout-index --all`s error code from 128 to 1.

Matheus Tavares (8):
  make_transient_cache_entry(): optionally alloc from mem_pool
  builtin/checkout.c: complete parallel checkout support
  checkout-index: add parallel checkout support
  parallel-checkout: add tests for basic operations
  parallel-checkout: add tests related to path collisions
  t0028: extract encoding helpers to lib-encoding.sh
  parallel-checkout: add tests related to .gitattributes
  ci: run test round with parallel-checkout enabled

 builtin/checkout--worker.c              |   2 +-
 builtin/checkout-index.c                |  24 ++-
 builtin/checkout.c                      |  20 ++-
 builtin/difftool.c                      |   2 +-
 cache.h                                 |  14 +-
 ci/run-build-and-tests.sh               |   1 +
 parallel-checkout.c                     |  18 ++
 read-cache.c                            |  14 +-
 t/README                                |   4 +
 t/lib-encoding.sh                       |  25 +++
 t/lib-parallel-checkout.sh              |  45 +++++
 t/t0028-working-tree-encoding.sh        |  25 +--
 t/t2080-parallel-checkout-basics.sh     | 229 ++++++++++++++++++++++++
 t/t2081-parallel-checkout-collisions.sh | 162 +++++++++++++++++
 t/t2082-parallel-checkout-attributes.sh | 194 ++++++++++++++++++++
 unpack-trees.c                          |   2 +-
 16 files changed, 732 insertions(+), 49 deletions(-)
 create mode 100644 t/lib-encoding.sh
 create mode 100644 t/lib-parallel-checkout.sh
 create mode 100755 t/t2080-parallel-checkout-basics.sh
 create mode 100755 t/t2081-parallel-checkout-collisions.sh
 create mode 100755 t/t2082-parallel-checkout-attributes.sh

Range-diff against v2:
1:  f870040bfb ! 1:  bf6c7114aa make_transient_cache_entry(): optionally alloc from mem_pool
    @@ cache.h: struct cache_entry *make_empty_cache_entry(struct index_state *istate,
     - * Create a cache_entry that is not intended to be added to an index.
     - * Caller is responsible for discarding the cache_entry
     - * with `discard_cache_entry`.
    -+ * Create a cache_entry that is not intended to be added to an index. If `mp`
    -+ * is not NULL, the entry is allocated within the given memory pool. Caller is
    -+ * responsible for discarding "loose" entries with `discard_cache_entry()` and
    -+ * the mem_pool with `mem_pool_discard(mp, should_validate_cache_entries())`.
    ++ * Create a cache_entry that is not intended to be added to an index. If
    ++ * `ce_mem_pool` is not NULL, the entry is allocated within the given memory
    ++ * pool. Caller is responsible for discarding "loose" entries with
    ++ * `discard_cache_entry()` and the memory pool with
    ++ * `mem_pool_discard(ce_mem_pool, should_validate_cache_entries())`.
       */
      struct cache_entry *make_transient_cache_entry(unsigned int mode,
      					       const struct object_id *oid,
      					       const char *path,
     -					       int stage);
    -+					       int stage, struct mem_pool *mp);
    ++					       int stage,
    ++					       struct mem_pool *ce_mem_pool);
      
     -struct cache_entry *make_empty_transient_cache_entry(size_t name_len);
    -+struct cache_entry *make_empty_transient_cache_entry(size_t len, struct mem_pool *mp);
    ++struct cache_entry *make_empty_transient_cache_entry(size_t len,
    ++						     struct mem_pool *ce_mem_pool);
      
      /*
       * Discard cache entry.
    @@ read-cache.c: struct cache_entry *make_empty_cache_entry(struct index_state *ist
      }
      
     -struct cache_entry *make_empty_transient_cache_entry(size_t len)
    -+struct cache_entry *make_empty_transient_cache_entry(size_t len, struct mem_pool *mp)
    ++struct cache_entry *make_empty_transient_cache_entry(size_t len,
    ++						     struct mem_pool *ce_mem_pool)
      {
    -+	if (mp)
    -+		return mem_pool__ce_calloc(mp, len);
    ++	if (ce_mem_pool)
    ++		return mem_pool__ce_calloc(ce_mem_pool, len);
      	return xcalloc(1, cache_entry_size(len));
      }
      
    @@ read-cache.c: struct cache_entry *make_cache_entry(struct index_state *istate,
     -					       const char *path, int stage)
     +struct cache_entry *make_transient_cache_entry(unsigned int mode,
     +					       const struct object_id *oid,
    -+					       const char *path, int stage,
    -+					       struct mem_pool *mp)
    ++					       const char *path,
    ++					       int stage,
    ++					       struct mem_pool *ce_mem_pool)
      {
      	struct cache_entry *ce;
      	int len;
    @@ read-cache.c: struct cache_entry *make_transient_cache_entry(unsigned int mode,
      
      	len = strlen(path);
     -	ce = make_empty_transient_cache_entry(len);
    -+	ce = make_empty_transient_cache_entry(len, mp);
    ++	ce = make_empty_transient_cache_entry(len, ce_mem_pool);
      
      	oidcpy(&ce->oid, oid);
      	memcpy(ce->name, path, len);
2:  e2d82c4337 ! 2:  e898889787 builtin/checkout.c: complete parallel checkout support
    @@ Commit message
         checkout_entry() directly, instead of unpack_trees(). Let's add parallel
         checkout support for this code path too.
     
    -    Note: the transient cache entries allocated in checkout_merged() are now
    +    The transient cache entries allocated in checkout_merged() are now
         allocated in a mem_pool which is only discarded after parallel checkout
         finishes. This is done because the entries need to be valid when
         run_parallel_checkout() is called.
    @@ builtin/checkout.c: static int checkout_worktree(const struct checkout_opts *opt
      	enable_delayed_checkout(&state);
     +	if (pc_workers > 1)
     +		init_parallel_checkout();
    - 	for (pos = 0; pos < active_nr; pos++) {
    - 		struct cache_entry *ce = active_cache[pos];
    - 		if (ce->ce_flags & CE_MATCHED) {
    + 
    + 	/* TODO: audit for interaction with sparse-index. */
    + 	ensure_full_index(&the_index);
     @@ builtin/checkout.c: static int checkout_worktree(const struct checkout_opts *opts,
      						       &nr_checkouts, opts->overlay_mode);
      			else if (opts->merge)
3:  0fe1a5fabc ! 3:  916f391a46 checkout-index: add parallel checkout support
    @@ Metadata
      ## Commit message ##
         checkout-index: add parallel checkout support
     
    -    Note: previously, `checkout_all()` would not return on errors, but
    -    instead call `exit()` with a non-zero code. However, it only did that
    -    after calling `checkout_entry()` for all index entries, thus not
    -    stopping on the first error, but attempting to write the maximum number
    -    of entries possible. In order to maintain this behavior we now propagate
    -    `checkout_all()`s error status to `cmd_checkout_index()`, so that it can
    -    call `run_parallel_checkout()` and attempt to write the queued entries
    -    before exiting with the error code.
    +    Allow checkout-index to use the parallel checkout framework, honoring
    +    the checkout.workers configuration.
    +
    +    There are two code paths in checkout-index which call
    +    `checkout_entry()`, and thus, can make use of parallel checkout:
    +    `checkout_file()`, which is used to write paths explicitly given at the
    +    command line; and `checkout_all()`, which is used to write all paths in
    +    the index, when the `--all` option is given.
    +
    +    In both operation modes, checkout-index doesn't abort immediately on a
    +    `checkout_entry()` failure. Instead, it tries to check out all remaining
    +    paths before exiting with a non-zero exit code. To keep this behavior
    +    when parallel checkout is being used, we must allow
    +    `run_parallel_checkout()` to try writing the queued entries before we
    +    exit, even if we already got an error code from a previous
    +    `checkout_entry()` call.
    +
    +    However, `checkout_all()` doesn't return on errors, it calls `exit()`
    +    with code 128. We could make it call `run_parallel_checkout()` before
    +    exiting, but it makes the code easier to follow if we unify the exit
    +    path for both checkout-index modes at `cmd_checkout_index()`, and let
    +    this function take care of the interactions with the parallel checkout
    +    API. So let's do that.
    +
    +    With this change, we also have to consider whether we want to keep using
    +    128 as the error code for `git checkout-index --all`, while we use 1 for
    +    `git checkout-index <path>` (even when the actual error is the same).
    +    Since there is not much value in having code 128 only for `--all`, and
    +    there is no mention about it in the docs (so it's unlikely that changing
    +    it will break any existing script), let's make both modes exit with code
    +    1 on `checkout_entry()` errors.
     
         Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
     
4:  f604c50dba = 4:  667777053a parallel-checkout: add tests for basic operations
5:  eae6d3a1c1 = 5:  dcb3acab1d parallel-checkout: add tests related to path collisions
6:  9161cd1503 = 6:  6141c46051 t0028: extract encoding helpers to lib-encoding.sh
7:  bc584897e6 = 7:  5350689a30 parallel-checkout: add tests related to .gitattributes
8:  1bc5c523c5 ! 8:  7b2966c488 ci: run test round with parallel-checkout enabled
    @@ parallel-checkout.c: static const int DEFAULT_NUM_WORKERS = 1;
      	else if (*num_workers < 1)
     
      ## t/README ##
    -@@ t/README: and "sha256".
    - GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
    - 'pack.writeReverseIndex' setting.
    +@@ t/README: GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
    + GIT_TEST_SPARSE_INDEX=<boolean>, when true enables index writes to use the
    + sparse-index format by default.
      
     +GIT_TEST_CHECKOUT_WORKERS=<n> overrides the 'checkout.workers' setting
     +to <n> and 'checkout.thresholdForParallelism' to 0, forcing the
-- 
2.30.1

