Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6623DC433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 15:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiCQP45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiCQP44 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 11:56:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F8A20D888
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 08:55:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j17so8054877wrc.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SXtylKp5E7ZBhOvtr8OOd9NoA7RGu+fNW/TrtKz4tQQ=;
        b=TRCEMnGfLERANO52xfB/1/kV0md19cxlJQspvjEZfMRm1Tlch7wMFzqOYZwmIGPCc7
         KW4beivhsQyFeOWJ3DTDEAtfMf2WYhoKHNOw0CugVxIj1Q7bUVEEhyscbF813uE7++O9
         SAj9kv7v4C+PqZoNxRis0x+GsE/rXygLd8C6WWRaGKukV9IY2DO3euNmF0rcHYtawwfP
         PyeTzv6XS9keUb3aY2gNp9EpEhkxDsLqexGIPK+7pYOsjs4UxbCLmx3eBKZzpBqbdV59
         jn0V2KuhvQWq93czNzMS2d8W6JXLRG7y7vluR4GUfKMgI4yI7YR31ogRpGjdJfzJ55ux
         s1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SXtylKp5E7ZBhOvtr8OOd9NoA7RGu+fNW/TrtKz4tQQ=;
        b=iMVAFvIEvZv0PNHXZhLtVL4/PHZ1CtQiwYN9+ktx5uqCQoYfkPf1TaWPRt1mfK9DoH
         CmYep9cOJeZziuTAnb0xTbQytWNP4p73NmnNf25mJTY4MbssI+/OBeBuhxU3fAppsSNe
         Isxxif749zPVAd5ZQ0wMColZSj3c+wp5FYh3aoisauXX8MR/+gD/VjGlr14BbGBUP5a9
         M7UJxO/byI5wO27Yr7J/CKjGt7UGcS/TxVRIacvm/2tsCNOAjoMoiViWTD/IMPcaIA07
         w5xY+TUM6DE+zgbWJNaOhL2dEx8s4DfElYaBVzcTMoswSErdi91bPIVOyMlobXN7OdYN
         lKXQ==
X-Gm-Message-State: AOAM531CoJmd0dv8aieOdhNZcxo08f/iQJqb6FUyCTMXWQNYAc4bb93D
        iL9PXuxFFcZK1KTz1t/ru0keU2eRBjA=
X-Google-Smtp-Source: ABdhPJz1XILkagdbN1czou5AYrIDWXl/o+VWAwyVXnRw/mrQD5dgLTW2IBpYceLCqllTsjLH+dOoxA==
X-Received: by 2002:a05:6000:15cc:b0:203:cd66:acbb with SMTP id y12-20020a05600015cc00b00203cd66acbbmr4402491wry.712.1647532537987;
        Thu, 17 Mar 2022 08:55:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm8203225wmj.5.2022.03.17.08.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 08:55:37 -0700 (PDT)
Message-Id: <pull.1179.v2.git.1647532536.gitgitgadget@gmail.com>
In-Reply-To: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
References: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 15:55:33 +0000
Subject: [PATCH v2 0/3] Fix use of 'cache_bottom' in sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An issue was found by @stolee after experimenting with the structure of the
test repo used in 't/t1092-sparse-checkout-compatibility.sh' (patch [1/3])
and finding that certain commands (namely those that internally performed a
"cache diff") failed when a sparse directory appeared lexicographically
before the in-cone directory. The root cause was traced to the
'unpack_trees_options.cache_bottom' variable, which was not being advanced
properly for sparse directories. The result was entries being
double-unpacked or improperly unpacked by 'unpack_trees', causing failures
in tests using 'git reset -- <pathspec>' and 'git diff --staged --
<pathspec>' using pathspecs.

The 'cache_bottom' was handled differently in sparse indexes in the first
place based on the reasoning laid out in 17a1bb570b (unpack-trees: preserve
cache_bottom, 2021-07-14). In short, the 'cache_bottom' advancement in
'mark_ce_used(...)' was disabled for sparse directories because
'unpack_callback(...)' would advance the 'cache_bottom' based on the number
of index entries matching or inside the tree being unpacked. If the tree was
a sparse directory, 'cache_bottom' would appropriately advance by 1, and
therefore didn't need the extra advancement in 'mark_ce_used(...)'. However,
this was insufficient to properly advance the 'cache_bottom' for two
reasons:

 1. 'unpack_callback(...)' would only advance the 'cache_bottom' for sparse
    directories if the operation in progress was a "cache diff" (true for
    'git diff --staged' and 'git reset --mixed', but not - for instance -
    'git reset --hard' or 'git read-tree -m').
 2. If sparse directories were unpacked with 'unpack_index_entry(...)'
    (e.g., in 'git reset -- <pathspec>'), the cache tree-based advancement
    of 'cache_bottom' would not happen.

Luckily, the first did not appear to have any behavioral impact. However,
the latter led to incorrect values being returned by 'next_cache_entry(...)'
depending on the structure of the index, causing the test failures observed
in 't1092'.

To fix this, the 'cache_bottom' advancement is reinstated in
'mark_ce_used(...)', and instead it is disabled in 'unpack_callback(...)' if
the tree in question is a sparse directory. This corrects both the
non-"cache diff" cases and the 'unpack_index_entry(...)' cases while
preventing the double-advancement 17a1bb570b originally intended to avoid
(patch [2/3]).

Finally, now that the cache bottom is advanced properly, we can revert the
"performance improvement" introduced in f2a454e0a5 (unpack-trees: improve
performance of next_cache_entry, 2021-11-29) that mitigated performance
issues arising in 'next_cache_entry(...)' from the non-advancing
'cache_bottom' (patch [3/3]). The performance results in
'p2000-sparse-operations.sh' showed expected variability around 0% change in
execution time (+/= 0.04s, depending on the command), with example results
for potentially-affected commands below.

'git reset'                      master            this_series                  
------------------------------------------------------------------------
full-v3                          0.51(0.21+0.27)   0.50(0.21+0.25) -2.0%
full-v4                          0.51(0.22+0.27)   0.50(0.21+0.24) -2.0%
sparse-v3                        0.30(0.04+0.55)   0.28(0.04+0.50) -6.7%
sparse-v4                        0.31(0.04+0.51)   0.29(0.04+0.51) -6.5%

'git reset -- does-not-exist'    master            this_series                  
------------------------------------------------------------------------
full-v3                          0.54(0.23+0.27)   0.55(0.22+0.28) +1.9%
full-v4                          0.56(0.25+0.26)   0.54(0.24+0.26) -3.6%
sparse-v3                        0.31(0.04+0.54)   0.31(0.04+0.50) +0.0%
sparse-v4                        0.31(0.04+0.52)   0.31(0.04+0.50) +0.0%

'git diff --cached'              master            this_series    
-------------------------------------------------------------------------
full-v3                          0.09(0.04+0.04)   0.09(0.04+0.04) +0.0%
full-v4                          0.09(0.04+0.04)   0.09(0.04+0.04) +0.0%
sparse-v3                        0.05(0.01+0.02)   0.05(0.01+0.03) +0.0%
sparse-v4                        0.04(0.01+0.02)   0.04(0.01+0.02) +0.0%



Changes since V1
================

 * Rebase on top of 'master' (to take changes from 'vd/sparse-read-tree')
 * Add 'before/' to expected index results in 't1092' test 'root directory
   cannot be sparse'

Thanks! -Victoria

Victoria Dye (3):
  t1092: add sparse directory before cone in test repo
  unpack-trees: increment cache_bottom for sparse directories
  Revert "unpack-trees: improve performance of next_cache_entry"

 t/t1092-sparse-checkout-compatibility.sh |  7 ++++-
 unpack-trees.c                           | 39 +++++++++---------------
 2 files changed, 20 insertions(+), 26 deletions(-)


base-commit: 74cc1aa55f30ed76424a0e7226ab519aa6265061
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1179%2Fvdye%2Fbugfix%2Fsparse-index-cache-bottom-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1179/vdye/bugfix/sparse-index-cache-bottom-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1179

Range-diff vs v1:

 1:  726b947bcbf ! 1:  d1491d299a9 t1092: add sparse directory before cone in test repo
     @@ Commit message
          'unpack_trees'. This will be corrected in a future patch; in the meantime,
          mark the tests with 'test_expect_failure'.
      
     -    Finally, update the 'ls-files' test to include the 'before/' directory in
     -    its expected results.
     +    Finally, update the 'ls-files' and 'root directory cannot be sparse' tests
     +    to include the 'before/' directory in their expected index contents.
      
          Co-authored-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Victoria Dye <vdye@github.com>
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'setup' '
       		mkdir deep/deeper1 deep/deeper2 deep/before deep/later &&
       		mkdir deep/deeper1/deepest &&
       		mkdir deep/deeper1/deepest2 &&
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'root directory cannot be sparse' '
     + 
     + 	# Verify sparse directories still present, root directory is not sparse
     + 	cat >expect <<-EOF &&
     ++	before/
     + 	folder1/
     + 	folder2/
     + 	x/
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'deep changes during checkout' '
       	test_all_match git checkout base
       '
 2:  8ebfebcc347 = 2:  cf8dc50c300 unpack-trees: increment cache_bottom for sparse directories
 3:  ec6b9686e8f = 3:  d74b304f560 Revert "unpack-trees: improve performance of next_cache_entry"

-- 
gitgitgadget
