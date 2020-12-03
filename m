Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA10C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B30020658
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgLCQRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgLCQRi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:17:38 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E314C061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:16:58 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so2475997wrt.0
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=sDQTLEgiBNeHC8QAXlS/I931b3YzOILAZD77LgEXA0E=;
        b=ks+0LAFTmPdcAoArMs9d9prUY7jcnQyUDpYmaZZTEw78+PRXimcFxwZIFK3BVsSBf3
         PBuI/RsG6oaV/uXoEEVIFfAyd70QXuxt5tHofAKoX+zVDxpUsS0aYaFH+nB9FThhvghm
         oJBeECG7XsRy/P/557yWSxryhd3cSfF/vHu4kDMFBVdCd46K6AXU6O3S1JQxCK5517MY
         O0mSYjwi8lfsoCkAQaI2aA8chRlTRP5juAGkAt6N0gaAx/wHREukChm8goIyb7XXYu6t
         boPGwn41RA79IB+DVje6Ri4CnqxloSqru5KpLLRr9xGEv5vLGm5C1M7g4osTq/Q0MvhY
         y9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sDQTLEgiBNeHC8QAXlS/I931b3YzOILAZD77LgEXA0E=;
        b=G8YxMOXhfXnmekJvNuXsJCRzdBcAy2mkw5B1EH6aNof7kz6l/RnYm8aHkoTfeNUvv8
         p9z3i8PEiWTxSKOMVlZAsm1JgZ5szt6wGYYzcwZE5UiCejSQ/gIbPs0CI65TsvAwT5+y
         AONs+RSwaZ11+BdlsAKW65o1jCIKQts3lNGOelggjZNSqOOW62vTnkWPgmP1DOOFE2fn
         byT6k1tydjJdy1ti+z0WKCEJxznrGHypxgFRcGZ9sAR2HoLXWTi6uJKuWJl4sbZLSLXS
         DglLzkJMgsckjxF6xkRSnntw883zloIGJ0bkV14+ayePFe/Wwq0p8zMCYbxOcD3TLD6C
         rHhQ==
X-Gm-Message-State: AOAM531SerEwapVNLsu6Ui1F3IvBiPnjda3M9nDpMi9JJdZ3MEPtrMGo
        U3cSuMKo3p+2aa4Uv2YlWb+RKt1JrDM=
X-Google-Smtp-Source: ABdhPJwtT0FViS9QMSSQkT7I3+eQ0QpsC8kEnlI+K5WSJs661IkBECCCiDNWS9SV9ljcJWWo02ahfg==
X-Received: by 2002:adf:ba91:: with SMTP id p17mr4580707wrg.328.1607012216627;
        Thu, 03 Dec 2020 08:16:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11sm1795993wmj.42.2020.12.03.08.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:16:56 -0800 (PST)
Message-Id: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:39 +0000
Subject: [PATCH 00/15] Refactor chunk-format into an API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was thinking about file formats recently and realized that the "chunks"
that are common to the commit-graph and multi-pack-index could inform future
file formats. To make that process easier, let's combine the process of
writing and reading chunks into a common API that both of these existing
formats use.

There is some extra benefit immediately: the writing and reading code for
each gets a bit cleaner. Also, there were different checks in each that made
the process more robust. Now, these share a common set of checks.

In particular, Szeder made some updates to the commit-graph writing process
that forms the model for this API.

Thanks, -Stolee

Derrick Stolee (15):
  commit-graph: anonymize data in chunk_write_fn
  chunk-format: add API for writing table of contents
  midx: rename pack_info to write_midx_context
  midx: use context in write_midx_pack_names()
  midx: add entries to write_midx_context
  midx: add pack_perm to write_midx_context
  midx: add num_large_offsets to write_midx_context
  midx: convert chunk write methods to return int
  midx: drop chunk progress during write
  midx: use chunk-format API in write_midx_internal()
  midx: use 64-bit multiplication for chunk sizes
  chunk-format: create write_chunks()
  chunk-format: create chunk reading API
  commit-graph: restore duplicate chunk checks
  chunk-format: add technical docs

 Documentation/technical/chunk-format.txt      |  54 ++
 .../technical/commit-graph-format.txt         |   3 +
 Documentation/technical/pack-format.txt       |   3 +
 Makefile                                      |   1 +
 chunk-format.c                                | 105 ++++
 chunk-format.h                                |  69 +++
 commit-graph.c                                | 298 ++++++-----
 midx.c                                        | 466 ++++++++----------
 t/t5318-commit-graph.sh                       |   2 +-
 t/t5319-multi-pack-index.sh                   |   6 +-
 10 files changed, 623 insertions(+), 384 deletions(-)
 create mode 100644 Documentation/technical/chunk-format.txt
 create mode 100644 chunk-format.c
 create mode 100644 chunk-format.h


base-commit: 72ffeb997eaf999f6938b2a7e0d9a75dcceaa311
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-804%2Fderrickstolee%2Fchunk-format%2Frefactor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-804/derrickstolee/chunk-format/refactor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/804
-- 
gitgitgadget
