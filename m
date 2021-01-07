Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEF0C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B95DD233F6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbhAGQcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbhAGQcz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:32:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B10C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:32:14 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w5so6209801wrm.11
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=E1VVJbrHctTPZlXJfsCndqd4b3Q1NPx64O0d+tXoImc=;
        b=BP+Eh2PzifqB50+J8HcaDKdiY5+nzgCPWuYCbZD1coCCApKXxzVjU8lJ4hX/r1Cro/
         HpZZ8HGLICbIWOFczVFdvkwyUM0Pf31agkHEjiN2NvRm9VnJc7O10HCeEvTNN+3WFob/
         XJ1UNpPYmSX9DcQzx2UC4+lobN35SwpEkrcI36hYLI41gWc2ufIwHGX9BZ1+Ljsil98k
         /XdV/V8x4Cldv8omH2WT5TK8Gsm7s6m30+9ISPDx9YcaaAvY4WmFKa44dxu71BD28wFE
         Elj2eBZIBH4N/vpU2k3k5aV3ZXLKKuUF5IQq8zL5lVeOWFrKUrJUGa2eeXCFQue8auoP
         h45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=E1VVJbrHctTPZlXJfsCndqd4b3Q1NPx64O0d+tXoImc=;
        b=E5O0UO/YHCHmp2CKzu/TkzGPpy+GCmFfFQ80VmdzwrFT/AEihk9djegIUM2uDD4AHn
         kVGfoIjtf7cDMYsIPOaDkv+5AaD6P4VlOjLOYu6xRAlGYOqeAIHGJvXIQoZUr5VsUrIo
         xd8YNeD+Xss9nLRdhliL3YxZxZhW9n8U8uv5ISMSTqb+wjdRazUipK4XE2hpvNFFhGTr
         l5z+mMbKBXWsApE/lj85kRZNXGPH5SZspHf6fgNC9TCTymHR9/CDABs65lzmErDOrV06
         BlWVkv4JY9Rj/zAlMLOAQ+4KfUqqHCD1CYS2P0XKLSWpzD0psCv9K1mTS++u2BnJ8fg1
         hD1g==
X-Gm-Message-State: AOAM532v+anV+mUkqs9RO1WfEHtzfU+kwq4fVMDdbAzfp/QNK+UgKjlG
        hzezCWNhEfEqYmMuOTI/+S6f/Bau+N4=
X-Google-Smtp-Source: ABdhPJyjVRxa4H+zNEDeQ4fTxa3LWN3XHFp1L1zT/1Kfk0mXEdukNkRoWxHBFN4fmpNY+uFBimrL7Q==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr9894740wrn.296.1610037133300;
        Thu, 07 Jan 2021 08:32:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm8869421wrt.23.2021.01.07.08.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 08:32:12 -0800 (PST)
Message-Id: <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
References: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 16:32:01 +0000
Subject: [PATCH v3 00/10] Cleanups around index operations
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


UPDATES IN V3
=============

 * Added a patch that fixes previous uses of "cached tree"

 * Updated preamble patch with typos and semantic corrections.

Derrick Stolee (9):
  tree-walk: report recursion counts
  unpack-trees: add trace2 regions
  cache-tree: use trace2 in cache_tree_update()
  cache-tree: trace regions for I/O
  cache-tree: trace regions for prime_cache_tree
  index-format: use 'cache tree' over 'cached tree'
  index-format: update preamble to cache tree extension
  index-format: discuss recursion of cached-tree better
  cache-tree: speed up consecutive path comparisons

René Scharfe (1):
  cache-tree: use ce_namelen() instead of strlen()

 Documentation/technical/index-format.txt | 42 ++++++++++++++++++------
 cache-tree.c                             | 30 +++++++++++++----
 t/t7104-reset-hard.sh                    |  2 +-
 tree-walk.c                              | 33 +++++++++++++++++++
 unpack-trees.c                           |  5 +++
 5 files changed, 94 insertions(+), 18 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-829%2Fderrickstolee%2Fcache-tree%2Fbasics-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-829/derrickstolee/cache-tree/basics-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/829

Range-diff vs v2:

  1:  0e500c86f39 =  1:  0e500c86f39 tree-walk: report recursion counts
  2:  4157b91acf8 =  2:  4157b91acf8 unpack-trees: add trace2 regions
  3:  8959d57abdd =  3:  8959d57abdd cache-tree: use trace2 in cache_tree_update()
  4:  1d8a797ee26 =  4:  1d8a797ee26 cache-tree: trace regions for I/O
  5:  2b2e70bb77c =  5:  2b2e70bb77c cache-tree: trace regions for prime_cache_tree
  -:  ----------- >  6:  2d7b18c2e0b index-format: use 'cache tree' over 'cached tree'
  6:  75b51483d3c !  7:  c5cffb5956e index-format: update preamble to cached tree extension
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    index-format: update preamble to cached tree extension
     +    index-format: update preamble to cache tree extension
      
     -    I had difficulty in my efforts to learn about the cached tree extension
     +    I had difficulty in my efforts to learn about the cache tree extension
          based on the documentation and code because I had an incorrect
          assumption about how it behaved. This might be due to some ambiguity in
          the documentation, so this change modifies the beginning of the cached
     @@ Commit message
      
          3. When exactly are "new" trees created?
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/technical/index-format.txt ##
      @@ Documentation/technical/index-format.txt: Git index format
       
     - === Cached tree
     + === Cache tree
       
     --  Cached tree extension contains pre-computed hashes for trees that can
     +-  Cache tree extension contains pre-computed hashes for trees that can
      -  be derived from the index. It helps speed up tree object generation
      -  from index for a new commit.
      -
     @@ Documentation/technical/index-format.txt: Git index format
      +  Since the index does not record entries for directories, the cache
      +  entries cannot describe tree objects that already exist in the object
      +  database for regions of the index that are unchanged from an existing
     -+  commit. The cached tree extension stores a recursive tree structure that
     ++  commit. The cache tree extension stores a recursive tree structure that
      +  describes the trees that already exist and completely match sections of
      +  the cache entries. This speeds up tree object generation from the index
      +  for a new commit by only computing the trees that are "new" to that
     -+  commit.
     ++  commit. It also assists when comparing the index to another tree, such
     ++  as `HEAD^{tree}`, since sections of the index can be skipped when a tree
     ++  comparison demonstrates equality.
      +
      +  The recursive tree structure uses nodes that store a number of cache
      +  entries, a list of subnodes, and an object ID (OID). The OID references
     -+  the exising tree for that node, if it is known to exist. The subnodes
     -+  correspond to subdirectories that themselves have cached tree nodes. The
     ++  the existing tree for that node, if it is known to exist. The subnodes
     ++  correspond to subdirectories that themselves have cache tree nodes. The
      +  number of cache entries corresponds to the number of cache entries in
      +  the index that describe paths within that tree's directory.
      +
     -+  Note that the path for a given tree is part of the parent node in-memory
     -+  but is part of the child in the file format. The root tree has an empty
     -+  string for its name and its name does not exist in-memory.
     ++  The extension tracks the full directory structure in the cache tree
     ++  extension, but this is generally smaller than the full cache entry list.
      +
      +  When a path is updated in index, Git invalidates all nodes of the
     -+  recurisive cached tree corresponding to the parent directories of that
     ++  recursive cache tree corresponding to the parent directories of that
      +  path. We store these tree nodes as being "invalid" by using "-1" as the
     -+  number of cache entries. To create trees corresponding to the current
     -+  index, Git only walks the invalid tree nodes and uses the cached OIDs
     -+  for the valid trees to construct new trees. In this way, Git only
     -+  constructs trees on the order of the number of changed paths (and their
     -+  depth in the working directory). This comes at a cost of tracking the
     -+  full directory structure in the cached tree extension, but this is
     -+  generally smaller than the full cache entry list in the index.
     ++  number of cache entries. Invalid nodes still store a span of index
     ++  entries, allowing Git to focus its efforts when reconstructing a full
     ++  cache tree.
       
         The signature for this extension is { 'T', 'R', 'E', 'E' }.
       
  7:  b2bb141a254 =  8:  97c06c80a85 index-format: discuss recursion of cached-tree better
  8:  5298694786e =  9:  2532f5cc189 cache-tree: use ce_namelen() instead of strlen()
  9:  72edd7bb427 = 10:  7c1c206a0bc cache-tree: speed up consecutive path comparisons

-- 
gitgitgadget
