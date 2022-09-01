Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E3BECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 09:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiIAJlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbiIAJlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 05:41:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF92B1257F5
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 02:41:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b5so21543397wrr.5
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 02:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=b8WNqcNKqvrw09nff21rznW4dOQBtRsnsSCQwRmjjsU=;
        b=XDbrf4A6T1Xr/uLqaIGOeonICa31hObEQ7eezLZxjdycAsh12gnsT62gbtrQ9QJkAC
         CSiC8w6Kgfp7pRwh6+8oKS+25dlzZobBHFbvwxuldSYIhj8bVpLykHwR3656PE5aTrtP
         jbNZR2Yz/gKzeh5rWQhQb0DEEjTR7QCVj4zsyggcwk7tQfeONiSRw0S+h/PvmjQUD3xO
         ybtbMfrNS6bWdf4y1UwxDjSbmwYZ6+/1idds0HDyu5lfLoL/z89FdG44Wq0WUxhVAiL3
         c3Hw2z6T9cPTqR7SHWNTxL0Wlh9Vh0yMu0gqeF0Bf4tXKZ2pS8X4fYYnc6MTxSFxRZ9H
         QAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=b8WNqcNKqvrw09nff21rznW4dOQBtRsnsSCQwRmjjsU=;
        b=VKYgbP39Zwx/JAhejGYC4XpA+7qw0aPX+7tOqnpurlLJp/Kvk1qQA82NDMIabyIob3
         ScXUja3ruzY5BlxfH8Y2P9iCvObA3jINMv347js2ONQQrWZkX//TnO8im9eYp3LPWkVU
         2l9o5JJdcV8WO4dMRc9YNSZtQv2nCiH1NOmOQBCPO6gaSERdT3QP/IavJrPIl7gI5ey9
         LR8kyJXRVTlTY1p9Yuxxo/YnkzmbqkagA+9ARxDWr3LVk9g62IDI/S5G46cSiHJxduoX
         N2sBJM7f/fOulWGY2bKoXaakRl9oLhBXJlkHzaMV0+TfyfcFMGP9QgHvUsQETvx/cP7U
         d84g==
X-Gm-Message-State: ACgBeo3stJorRfChLmoUozNfux6u/STpQ+7se99T76t4R3G9ZVWVv5lt
        cfT5yVxLyi3aRHMYx0NAPCgCUPHFPek=
X-Google-Smtp-Source: AA6agR7YlcieFmZwBEo9d8m2WblpwwfxwDg89+OkQQsvYBbVAfHK61c1P0NxXp7tTWCg7wWM+F+YHg==
X-Received: by 2002:a5d:6da8:0:b0:225:3c60:cc49 with SMTP id u8-20020a5d6da8000000b002253c60cc49mr13985875wrs.164.1662025273983;
        Thu, 01 Sep 2022 02:41:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d508c000000b0022571d43d32sm8686249wrt.21.2022.09.01.02.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 02:41:13 -0700 (PDT)
Message-Id: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 09:41:09 +0000
Subject: [PATCH 0/3] list-object-filter: introduce depth filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch let partial clone have the similar capabilities of the shallow
clone git clone --depth=<depth>.

Disadvantages of git clone --depth=<depth> --filter=blob:none: we must call
git fetch --unshallow to lift the shallow clone restriction, it will
download all history of current commit.

Disadvantages of git clone --filter=blob:none with git sparse-checkout: The
git client needs to send a lot of missing objects' id to the server, this
can be very wasteful of network traffic.

Now we can use git clone --filter="depth=<depth>" to omit all commits whose
depth is >= <depth>. By this way, we can have the advantages of both shallow
clone and partial clone: Limiting the depth of commits, get other objects on
demand.

Unfinished business for now:

 1. Git fetch has not yet learned the depth filter, if we can solve this
    problem, we may can have a better "batch fetch" for some needed commits
    (see [1]).
 2. Sometimes we may want to partial clone to avoid automatic downloads
    missing objects, e.g. when running git log, we might want to have
    similar results of shallow clone (without commit graft).

[1]:
https://lore.kernel.org/git/16633d89-6ccd-859d-8533-9861ad831c45@github.com/

ZheNing Hu (3):
  commit-graph: let commit graph respect commit graft
  list-object-filter: pass traversal_context in filter_init_fn
  list-object-filter: introduce depth filter

 Documentation/rev-list-options.txt  |   6 ++
 builtin/clone.c                     |  10 ++-
 commit-graph.c                      |  36 +++++++--
 list-objects-filter-options.c       |  30 +++++++
 list-objects-filter-options.h       |   6 ++
 list-objects-filter.c               |  78 ++++++++++++++++++-
 list-objects-filter.h               |   2 +
 list-objects.c                      |  10 +--
 list-objects.h                      |   8 ++
 shallow.c                           |  16 ++++
 shallow.h                           |   2 +
 t/t5616-partial-clone.sh            | 116 ++++++++++++++++++++++++++++
 t/t6112-rev-list-filters-objects.sh |  14 ++++
 upload-pack.c                       |  14 ----
 upload-pack.h                       |  14 ++++
 15 files changed, 330 insertions(+), 32 deletions(-)


base-commit: d42b38dfb5edf1a7fddd9542d722f91038407819
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1343%2Fadlternative%2Fzh%2Ffilter_depth-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1343/adlternative/zh/filter_depth-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1343
-- 
gitgitgadget
