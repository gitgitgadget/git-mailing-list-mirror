Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1B5C3E8C5
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E1E2078D
	for <git@archiver.kernel.org>; Sun, 29 Nov 2020 07:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu2LR1LB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgK2HoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Nov 2020 02:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2HoH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Nov 2020 02:44:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9538FC0613D1
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:26 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r3so10836111wrt.2
        for <git@vger.kernel.org>; Sat, 28 Nov 2020 23:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TzA4pPq7gC4BoLSbF7Td4y/k0iFWy9Wdrvl1GzecrsA=;
        b=hu2LR1LBdmQmFe/KwIcQH2bnBMR8ffd3ZZpxaAiWTY89VBMAnRy67No3mu9etkwXNU
         imAkwYuJ2kanlSKEF2qSDZptCLD5GP1z6pAqUvDw8SL1UaK4YZN9EjIOiDj5m1OEtmvW
         VtYrfwIk2bQwRKBZR0hh0qeHdIUbn7Ma4bmKvvjlVSOZ+HpPrHX8gxOZrS9mwNFIWxmi
         Vp0VTlsgS2xL/0V+dVqa7+3sVzz94ep9zGjeeE7a7zFi5GSVBi5NRIOU2sbS5Jv85HzS
         BrEt8LzGPTPd8cxhvfCUP0Dxl8J3XdB0N/eTplJki9lNZWV1ffKjnwV6Am+JGr0xkBTf
         63yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TzA4pPq7gC4BoLSbF7Td4y/k0iFWy9Wdrvl1GzecrsA=;
        b=NydvXS1YdTKcwyFeIZE8sbmTKfhCs2wx3pyN2lfOavdoXsoUdIm+pv+wG/ngEOzuna
         muaBmMtziC55X5FZvCCYl2383kEbloVU0BtKQM9nyBgRwfhDe0MXhMIFsQahdZljA44a
         i+oxlm19J8WW/7HjAyMaf2JFbA7AhKUWlzdhlOGPysRC2xUaTwLyIVKLhdlf+QZ+uoND
         NnCGo6vPZEYFma97iQLX6Npg6Cph4DSp5Oy7UIC7/EyMUTiW/rxwcuDKhFjY0u0SQA6w
         OyBAQUpfCwk1i2aGoB/93rKQw+mmrLN+17wX6+sZviP1Yhf5w7ybDjpGmqP/Gs9xfwrU
         FmAg==
X-Gm-Message-State: AOAM530xmAFnVGvPNU0G7HAAUGuI6MV6Jx8XzWq/w8ndyJiTB0lIxlUb
        3Hc+wJJWCCVZqgzq8WBV20IO95JLzgE=
X-Google-Smtp-Source: ABdhPJwQ/qVZd1ry0HlsFzSkQwOB/rKYkUowNXTWm8v+6v55eTdFhV5YP6zxY2htCiUqtNhdyNS1pw==
X-Received: by 2002:adf:a3c1:: with SMTP id m1mr21683617wrb.28.1606635805037;
        Sat, 28 Nov 2020 23:43:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm16343009wrp.70.2020.11.28.23.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 23:43:24 -0800 (PST)
Message-Id: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 29 Nov 2020 07:43:03 +0000
Subject: [PATCH 00/20] fundamentals of merge-ort implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is actually v3 of this series; but v2 depended on two topics that
hadn't graduated yet so I couldn't easily use gitgitgadget and get its
testing. Now that the topics have graduated, I have rebased on master. You
can see v2 and comments on it over here: 
https://lore.kernel.org/git/20201102204344.342633-1-newren@gmail.com/

The goal of this series is to show the new design and structure behind
merge-ort, particularly the bits that are completely different to how
merge-recursive operates. There are still multiple important codepaths that
die with a "Not yet implemented" message, so the new merge algorithm is
still not very usable. However, it can handle very trivial rebases or
cherry-picks at the end of the series, and the number of test failures when
run under GIT_TEST_MERGE_ALGORITHM=ort drops from 2281 down to 1453.

At a high level, merge-ort avoids unpack_trees() and the index, instead
using traverse_trees() and its own data structure. After it is done
processing each path, it writes a tree. Only after it has created a new tree
will it touch the working copy or the index. It does so by using a simple
checkout-like step to switch from head to the newly created tree. If there
are conflicted entries, it touches up the index after the checkout-like step
to record those higher order stages.

In the series:

 * Patch 1 adds some basic data structures.
 * Patch 2 documents the high-level steps.
 * Patches 3-5 are some simple setup.
 * Patches 6-10 collect data from the traverse_trees() operation.
 * Patches 11-15 process the individual paths and create a tree.
 * Patches 16-19 handle checkout-and-then-write-higher-order-stages.
 * Patch 20 frees data from the merge_options_internal data structure

Changes since v2 (Thanks to Stolee and Jonathan Tan for their excellent and
detailed reviews!):

 * Add thorough code comments to data structures, to try to answer multiple
   questions the reviewers brought up.
 * Add comments in various areas of the code that were a bit tricky.
 * As per Stolee's request/suggestion, restructured accesses to
   conflict_info* to make the code document that we
 * As per Jonathan's suggestion, restructured tree writing to have
   "END_TREE" markers for directories -- namely, the directory itself.
 * Removed path_conflict field (will add it back in a later series when it
   is actually used)
 * Improved requested commit messages
 * Settled on "conflicted" instead of mix of "conflicted" and "unmerged"
 * Fixed various typos, missing words, etc.
 * Fixed various spaces around operators, missing blank lines, etc.
 * Some other small tweaks I probably forgot or overlooked while typing up
   this summary.

Things for reviewers to concentrate on:

 * Patch 1: I added lots of comments describing the data structures, based
   on reviewer questions/comments. Are they clear?
 * Patch 9: Stolee was worried about the allocation of merged_info OR
   conflict_info and whether we were safely accessing the fields. Since this
   is our primary and largest data structure and many times most entries
   only need a smaller merged_info, I really do want the space savings of
   not always allocating the larger type. I typically access as a
   merged_info* now, and added some accessor macros to document why each
   access as a conflict_info* is okay. Does this seem like a good solution
   to the concern? 
 * Patch 15: Jonathan felt the previous version of this patch was hard to
   follow. I've restructured so that we process the directories in
   opt->priv->paths directly; you can kind of view them as non-synthetic
   end-of-tree markers. They may not stand out as such, though (since they
   aren't synthetic with special names or handling), so I've added some
   pretty big comments to explain things. Does this address concerns?
 * Patches 16-20: these have not yet been reviewed, though these are easier
   patches to review than many of the first 15! A quick guide: * Patches 16,
      18, and 20 are very straightforward; patches 17 and 19 are the ones
      that would benefit more from review.
    * Patch 17 is
      basically the twoway_merge subset of merge_working_tree() from
      builtin/checkout.c. Find that bit of code and it's a direct
      comparison.
    * Patch 19
      amounts to "how do I remove stage 0 entries in the index and replace
      them with 1-3 higher order stages?".

Elijah Newren (20):
  merge-ort: setup basic internal data structures
  merge-ort: add some high-level algorithm structure
  merge-ort: port merge_start() from merge-recursive
  merge-ort: use histogram diff
  merge-ort: add an err() function similar to one from merge-recursive
  merge-ort: implement a very basic collect_merge_info()
  merge-ort: avoid repeating fill_tree_descriptor() on the same tree
  merge-ort: compute a few more useful fields for collect_merge_info
  merge-ort: record stage and auxiliary info for every path
  merge-ort: avoid recursing into identical trees
  merge-ort: add a preliminary simple process_entries() implementation
  merge-ort: have process_entries operate in a defined order
  merge-ort: step 1 of tree writing -- record basenames, modes, and oids
  merge-ort: step 2 of tree writing -- function to create tree object
  merge-ort: step 3 of tree writing -- handling subdirectories as we go
  merge-ort: basic outline for merge_switch_to_result()
  merge-ort: add implementation of checkout()
  tree: enable cmp_cache_name_compare() to be used elsewhere
  merge-ort: add implementation of record_conflicted_index_entries()
  merge-ort: free data structures in merge_finalize()

 merge-ort.c | 1207 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 tree.c      |    2 +-
 tree.h      |    2 +
 3 files changed, 1207 insertions(+), 4 deletions(-)


base-commit: e67fbf927dfdf13d0b21dc6ea15dc3c7ef448ea0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-923%2Fnewren%2Fort-basics-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-923/newren/ort-basics-v1
Pull-Request: https://github.com/git/git/pull/923
-- 
gitgitgadget
