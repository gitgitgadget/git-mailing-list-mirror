Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B97C433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D994720E65
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbhADDKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbhADDKC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 22:10:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000FBC061574
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 19:09:21 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r4so17984436wmh.5
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 19:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Bx3UsVXRkv2Ic5dwHzfUHg5+gl9TW/Ik+xxr3fZ66cg=;
        b=t9VodDNZljL9qTdenBXGTkNl09qkmQzjXgSsTV8Jr6867AjDyFPvY6BFCPxgRH4Gh8
         SlvrY6s5Pj8uk6oHAJR7NxnJcpu3BNDojVvcgZ66ktXn/IPqQkwe8jdhdmDGNj543Am1
         B58DO5eLDcFxYxZq5Bk+25dxgYrXXKkOPXfAECObE0OS5lmrvMFOuxNLHbU5a+Szoo2q
         qWqbQM+V5jClf2aFG56pT1WEnhqikpSowabTl81swy0XrcCVf9164yMZkwc832eCKPlZ
         /RDHsO52vTU2vwKWMUhX/dopFLBkq9LA/4PGaaUgqzZykaqW7Y+t+UCQL7R/CrVRGPQ1
         51eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Bx3UsVXRkv2Ic5dwHzfUHg5+gl9TW/Ik+xxr3fZ66cg=;
        b=WdjhrzlxCQ0hvDuYUzFT6tEN6pfYmdRhbX/ZiNBIXKSal095e931E03472yB4fwKyE
         oCttnzjd8nF812yx/MUcp/P16Tnqots7mXVOg507DEjjetKoIjipIo4IOLhJVuwjIlOT
         PabtETREIzjFsq/Og2/UtvGC475jrNSbU4161cLth1ZpH8h7+ovvH8sRu3UXSHH7ZZAi
         4uAvvKaAyKqUbZ94277qFaFGxXL/mZj7Pp+HngpXV3Svxg5dWPtCmOWIQeE5xKiEorbW
         cAXYfhL4SjQH0kTg4lRvH36NFMruEQGDXCtJTKGAWvvxI7axFmCjG21VUEYnljd8dqdy
         ZgUg==
X-Gm-Message-State: AOAM531NY2VOX0WZyTUnCYqEPKQpoIABP7dtr/oIog5w+ISjMA4PqiSh
        7rqcTF4TxzFHchhOn4ehV5grIVFSWaU=
X-Google-Smtp-Source: ABdhPJybIzav246cdgZdR01LTV0LO3zC0yE5YTyHFLIM4/cD3zZ9GivuU6R+/uTSfxVH5jcZYYgVOA==
X-Received: by 2002:a1c:e10b:: with SMTP id y11mr25454405wmg.65.1609729760380;
        Sun, 03 Jan 2021 19:09:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm29401089wmc.44.2021.01.03.19.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 19:09:19 -0800 (PST)
Message-Id: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.1609356413.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jan 2021 03:09:09 +0000
Subject: [PATCH v2 0/9] Cleanups around index operations
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've taken a professional interest in the index lately, and I've been trying
mostly to learn about it and measure different operations. Along the way,
I've seen some possible improvements in documentation, behavior, and
tracing.

This series collects most of my thoughts so far, including:

 1. Adding extra trace2 regions and statistics (similar to [1]) (Patches
    1-5).
 2. Update documentation about the cached tree extension (Patches 6-7).
 3. Improved the performance of verify_cache() (Patches 8-9).

Thanks, -Stolee

[1]
https://lore.kernel.org/git/pull.828.git.1609302714183.gitgitgadget@gmail.com/


UPDATES IN V2
=============

 * Instead of completely dropping the second loop in verify_cache(), improve
   the performance. I include René's patch (unaltered except for my
   sign-off) in this series for clarity.

 * Fixed the unnecessary whitespace change in patch 1. Updated the commit
   message to refer to a similar effort in changed-path Bloom filters.

 * The range enter/leave block in patch 5 now spans the entire method.

Derrick Stolee (8):
  tree-walk: report recursion counts
  unpack-trees: add trace2 regions
  cache-tree: use trace2 in cache_tree_update()
  cache-tree: trace regions for I/O
  cache-tree: trace regions for prime_cache_tree
  index-format: update preamble to cached tree extension
  index-format: discuss recursion of cached-tree better
  cache-tree: speed up consecutive path comparisons

René Scharfe (1):
  cache-tree: use ce_namelen() instead of strlen()

 Documentation/technical/index-format.txt | 39 +++++++++++++++++++-----
 cache-tree.c                             | 30 +++++++++++++-----
 tree-walk.c                              | 33 ++++++++++++++++++++
 unpack-trees.c                           |  5 +++
 4 files changed, 93 insertions(+), 14 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-829%2Fderrickstolee%2Fcache-tree%2Fbasics-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-829/derrickstolee/cache-tree/basics-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/829

Range-diff vs v1:

  1:  f727880add6 !  1:  0e500c86f39 tree-walk: report recursion counts
     @@ Metadata
       ## Commit message ##
          tree-walk: report recursion counts
      
     -    The traverse_trees() method recusively walks through trees, but also
     +    The traverse_trees() method recursively walks through trees, but also
          prunes the tree-walk based on a callback. Some callers, such as
          unpack_trees(), are quite complicated and can have wildly different
          performance between two different commands.
     @@ Commit message
          instances of traverse_trees(), but they provide reproducible values for
          demonstrating improvements to the pruning algorithm when possible.
      
     +    This change is modeled after a similar statistics reporting in 42e50e78
     +    (revision.c: add trace2 stats around Bloom filter usage, 2020-04-06).
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## tree-walk.c ##
     @@ tree-walk.c: int traverse_trees(struct index_state *istate,
       	return error;
       }
       
     -
     - ## unpack-trees.c ##
     -@@ unpack-trees.c: static void populate_from_existing_patterns(struct unpack_trees_options *o,
     - 	free(sparse);
     - }
     - 
     --
     - static int verify_absent(const struct cache_entry *,
     - 			 enum unpack_trees_error_types,
     - 			 struct unpack_trees_options *);
  2:  6923e6211aa =  2:  4157b91acf8 unpack-trees: add trace2 regions
  3:  802718084a7 =  3:  8959d57abdd cache-tree: use trace2 in cache_tree_update()
  4:  65feaa497b2 =  4:  1d8a797ee26 cache-tree: trace regions for I/O
  5:  5d1c9c8a356 !  5:  2b2e70bb77c cache-tree: trace regions for prime_cache_tree
     @@ Commit message
      
       ## cache-tree.c ##
      @@ cache-tree.c: void prime_cache_tree(struct repository *r,
     + 		      struct index_state *istate,
     + 		      struct tree *tree)
       {
     ++	trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
       	cache_tree_free(&istate->cache_tree);
       	istate->cache_tree = cache_tree();
      +
     -+	trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);
       	prime_cache_tree_rec(r, istate->cache_tree, tree);
     -+	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
       	istate->cache_changed |= CACHE_TREE_CHANGED;
     ++	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
       }
       
     + /*
  6:  fb9d5468184 =  6:  75b51483d3c index-format: update preamble to cached tree extension
  7:  65fb9f72251 =  7:  b2bb141a254 index-format: discuss recursion of cached-tree better
  8:  20ea7050324 <  -:  ----------- cache-tree: avoid path comparison loop when silent
  -:  ----------- >  8:  5298694786e cache-tree: use ce_namelen() instead of strlen()
  -:  ----------- >  9:  72edd7bb427 cache-tree: speed up consecutive path comparisons

-- 
gitgitgadget
