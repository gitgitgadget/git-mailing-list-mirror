Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BF2C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 20:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356713AbiCPUNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356261AbiCPUNU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:13:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CEA6E4C7
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:12:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n31-20020a05600c3b9f00b003898fc06f1eso3847243wms.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=k7vO0cJqr9ClZcBwrseVI77pyPLM+dRV0KG1e8C1/Os=;
        b=IKg5bN3XSfABONITYnV7pmlGt+p2v/RvlkO3m2j2ZScGZyWa5fGq9HsaR9iXzNXZEk
         IsStbuv6TCufZ8NOcaZMGEJGASHCQ/jx7ZuE67eYgTkifcCop4FiTcpO3Zswh6dPTOXn
         8QSEx/oQJPnwEFurekoE0UwwMOia40KRA7d4YO6NS+BvVHbfD0gJMJGI8rp/V/ObOHG+
         UYb9vQhGb6867XUw5iWTcVa//zzu4ZZQZM+TklFCTLA2gTvNjfdSHRRtC+UNdEQf6EAY
         Sf2uGNpvKYFa6GNZ2F046SGkb3QBDSk4sYVCTwNMup4lP2jFzPwHanGWLsKuuyqIOKOd
         rCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k7vO0cJqr9ClZcBwrseVI77pyPLM+dRV0KG1e8C1/Os=;
        b=V7BbgWlN7z7uZaOKjBkfUrp1jIGJ9h1xYgS642iYMbtg73fnQ4K6ZdsRHVltRo4EhM
         Y1pHxiWZdiK31h2kHZpRMl0V17dnK4TJ7qRmbTsMsjAUIhNoU6eJ+X28WxD4tM6Pw05J
         4h3hRUa+zjOjNPGSgO85qMsOJGZETk1VTj4KdIxbRkozcO3gX/IHLfqSShv0UOuZaJsz
         B0aPFOvfAoQvUOTvSHX3JoZcf0AnETY7cUwUcxTbKtAVYytdjhq+6M/4j01QApHI8Fyk
         OrwBVjTZm+u41VaPhaJfzeeGPNfFnxy+FU0ydbcs85zfjYETcqZvi4B6E65NxS65CjWY
         azvg==
X-Gm-Message-State: AOAM533b2OzYgbBxLGNfSAlYQ9XllZVWItEXDbvQHynlCDaKaGcZWzqn
        psRxsssnwGbS/93dT5vybMyKEXBGZko=
X-Google-Smtp-Source: ABdhPJyU5K3+Z8WCIy/vpsuPIElcHhptOL9U0wJrXegD7C8Kpvtu56rH9ID/PbQn36p15L+Fw746bQ==
X-Received: by 2002:a05:600c:1988:b0:389:e789:71d8 with SMTP id t8-20020a05600c198800b00389e78971d8mr1108581wmq.146.1647461523830;
        Wed, 16 Mar 2022 13:12:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389a558670fsm5794454wmi.11.2022.03.16.13.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 13:12:03 -0700 (PDT)
Message-Id: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Mar 2022 20:11:59 +0000
Subject: [PATCH 0/3] Fix use of 'cache_bottom' in sparse index
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


Thanks! -Victoria

Victoria Dye (3):
  t1092: add sparse directory before cone in test repo
  unpack-trees: increment cache_bottom for sparse directories
  Revert "unpack-trees: improve performance of next_cache_entry"

 t/t1092-sparse-checkout-compatibility.sh |  6 +++-
 unpack-trees.c                           | 39 +++++++++---------------
 2 files changed, 19 insertions(+), 26 deletions(-)


base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1179%2Fvdye%2Fbugfix%2Fsparse-index-cache-bottom-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1179/vdye/bugfix/sparse-index-cache-bottom-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1179
-- 
gitgitgadget
