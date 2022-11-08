Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351CCC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiKHWoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 17:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKHWo3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:44:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D793209A8
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:44:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p16so9705296wmc.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 14:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ev+LtMU71m7EhuSuPM5pvIKZWZ9gkkMt5VFRne6vSS8=;
        b=pZr74AbYYQ67BCMnMFNvbk6tDO8zK6YVXxWgbNIzc8CqGPROKCoqwj+fRYBZqyNy7p
         oyqqepcpRmGdzsnSyJmBLW0l0woOwM+ax09IvI1yppS2Uv0TjAISUTfiKzz/geEBRbEP
         nXb/s+435e/M2Ye4ia8dY+2W3JpcwVoygPc2Xq2lG2RKnCgP2trSjC7+MrrZadjF9mwA
         YHsHYyeleX7xAyW5CezD4UGDD2E0YI9VQvJ5KG08zV6p/eUhSk0+b6Mqy1XWmOepeRoe
         8J8TJfr3gnY72La+fxbRnakGuLpl0aMpQTCNrIg3KTp0Z46X3afOCCpFSgRQElrTFNz2
         Cbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ev+LtMU71m7EhuSuPM5pvIKZWZ9gkkMt5VFRne6vSS8=;
        b=FfmcB46VC0j95bKipIfGw/eJkbWnLaWFR5n5JEAR5Ho5e5hYiX2mGTtCSzX5bzscZf
         qYrHv7VixWRqDEJINC9pgRa8ypBUhNUebH3ONfTfzWrz7VOXwAg/N1Qywe1gPjqWQrrA
         ZenYCAA/klhOmRgNO8gAJJCsHm8Cd/oPPE1gb4Rf8Umq0lzOC2s9IDmyIZuYvPjhKDP/
         RCKU+/a5ytTTBtiVIdn2pXBd/DOsOVlAZOT7v5i0K7CBvFgQaEQYmclJmHC9ecydfeBj
         bQODOhu2ypfdkxJH67msgg/Uy4xbL+ZaQHujEBjvY1C0LMzBHDXXWXayO5VUfA2r3HsP
         IdiA==
X-Gm-Message-State: ACrzQf1zmKDZ/MS/zhbbJQ23dO8BLasOjiQxefBair6D7LCDeGCfEdDV
        qSLrnyS5Utm4yG+lkR35QMOJPlhIew8=
X-Google-Smtp-Source: AMsMyM7K3vNJKGGWzj4VjcYxMgZhgURgmQtmVZowT7aJJFLZGoKbpCUTmkjYm/cTo1aNGpadMTqL4A==
X-Received: by 2002:a05:600c:1e26:b0:3cf:a26c:40fd with SMTP id ay38-20020a05600c1e2600b003cfa26c40fdmr12741615wmb.178.1667947466439;
        Tue, 08 Nov 2022 14:44:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f66-20020a1c3845000000b003c6b70a4d69sm12322937wma.42.2022.11.08.14.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:44:26 -0800 (PST)
Message-Id: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 22:44:20 +0000
Subject: [PATCH 0/5] Skip 'cache_tree_update()' when 'prime_cache_tree()' is called immediate
 after
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following up on a discussion [1] around cache tree refreshes in 'git reset',
this series updates callers of 'unpack_trees()' to skip its internal
invocation of 'cache_tree_update()' when 'prime_cache_tree()' is called
immediately after 'unpack_trees()'. 'cache_tree_update()' can be an
expensive operation, and it is redundant when 'prime_cache_tree()' clears
and rebuilds the cache tree from scratch immediately after.

The first patch adds a test directly comparing the execution time of
'prime_cache_tree()' with that of 'cache_tree_update()'. The results show
that on a fully-valid cache tree, they perform the same, but on a
fully-invalid cache tree, 'prime_cache_tree()' is multiple times faster
(although both are so fast that the total execution time of 100 invocations
is needed to compare the results in the default perf repo).

The second patch introduces the 'skip_cache_tree_update' option for
'unpack_trees()', but does not use it yet.

The remaining three patches update callers that make the aforementioned
redundant cache tree updates. The performance impact on these callers ranges
from "negligible" (in 'rebase') to "substantial" (in 'read-tree') - more
details can be found in the commit messages of the patch associated with the
affected code path.

Thanks!

 * Victoria

[1] https://lore.kernel.org/git/xmqqlf30edvf.fsf@gitster.g/ [2]
https://lore.kernel.org/git/f4881b7455b9d33c8a53a91eda7fbdfc5d11382c.1627066238.git.jonathantanmy@google.com/

Victoria Dye (5):
  cache-tree: add perf test comparing update and prime
  unpack-trees: add 'skip_cache_tree_update' option
  reset: use 'skip_cache_tree_update' option
  read-tree: use 'skip_cache_tree_update' option
  rebase: use 'skip_cache_tree_update' option

 Makefile                           |  1 +
 builtin/read-tree.c                |  4 +++
 builtin/reset.c                    |  2 ++
 reset.c                            |  1 +
 sequencer.c                        |  1 +
 t/helper/test-cache-tree.c         | 52 ++++++++++++++++++++++++++++++
 t/helper/test-tool.c               |  1 +
 t/helper/test-tool.h               |  1 +
 t/perf/p0006-read-tree-checkout.sh |  8 +++++
 t/perf/p0090-cache-tree.sh         | 27 ++++++++++++++++
 t/perf/p7102-reset.sh              | 21 ++++++++++++
 t/t1022-read-tree-partial-clone.sh |  2 +-
 unpack-trees.c                     |  3 +-
 unpack-trees.h                     |  3 +-
 14 files changed, 124 insertions(+), 3 deletions(-)
 create mode 100644 t/helper/test-cache-tree.c
 create mode 100755 t/perf/p0090-cache-tree.sh
 create mode 100755 t/perf/p7102-reset.sh


base-commit: 3b08839926fcc7cc48cf4c759737c1a71af430c1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1411%2Fvdye%2Ffeature%2Fcache-tree-optimization-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1411/vdye/feature/cache-tree-optimization-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1411
-- 
gitgitgadget
