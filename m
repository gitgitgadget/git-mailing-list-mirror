Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648E9C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 20:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiBXUjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiBXUjL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 15:39:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF0F179A0E
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so551160wmj.0
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=oDBOAOb2bSm8paQp0/YrUTyBx1yEpQrYOOs9Py4CYyU=;
        b=kXHij01ML5xNoAeLow+3qvrp3+GfwGVi/TzxcPoHpFmqXN2db3+dm8YVuqXgHFuWOE
         RgEHMZsLeUDA8St7EKAwU/FquuCVcOW9DuouCSyN70xb8PMioyX5Rvoj44wiCZYbLYwk
         6dzMY/h7qFaqpsyEXhOGQSuvBKVhXLYdE8H4zRvfd8AHsSSmpa8knj2mG1RnM+/9VUqw
         vSGAJQiICCvvwX1tVWe1AmYErq47qt4FHODWRn6MGzHm4vrW/CB8rPNUnrBIyKrBfsqe
         PCSyZdFcr/vkbK7U6aUjrRkX5z9A19Bq0EAWyiNg8fHFlnIhMziDVO1XbSbFiKub7gwZ
         ItYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=oDBOAOb2bSm8paQp0/YrUTyBx1yEpQrYOOs9Py4CYyU=;
        b=Jkhl4bNevqVKoXwZ5elDuXyVvzMVnahJa1tlj0Tt5jdIdS2lRGpU19pgNbE4l5R56b
         QvyQrWa0Mq9vXgTerwAtDRtX/P3Kv9+VUoFKC5KD5Xq8BhC9i1YSVEpEeKO4h1Iz08Kc
         7nrs2UM/fZGFGzYhXvIgYMFXxraD6obCOUPiFzRvy+GJGjG1ygHaLE4SZPEh87B/p9KN
         cJFX3lbH0Tla8V+kteHYcjYoEL3I6fJYyEDPFjIY6tBcaM3N8Um5p0kz+AL4/Wcvctx8
         08R9bmJeI1CnH2SuXCvH4eAy1MB4iJp/j5saPlPSMV+6kZEyUXBNPHkAgbiud9/zPdOk
         V6YA==
X-Gm-Message-State: AOAM533cCNqIIkS4F6NQm7TJ6TmL2IGfQDdCysOJYrIig8l4pfpNXYEm
        qaPClkesJ+PaU6c0F/VdmCiP99fcLYQ=
X-Google-Smtp-Source: ABdhPJxjT1ansqWrQOlskiLT8sBmzOfcQDm17Cnd3Jx3/Vs8APXN7w4wFX9gdRvsfKeq6dVf3BsHdA==
X-Received: by 2002:a05:600c:3d98:b0:352:cdcf:ef7f with SMTP id bi24-20020a05600c3d9800b00352cdcfef7fmr3789414wmb.28.1645735118195;
        Thu, 24 Feb 2022 12:38:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d4d81000000b001e6993398e2sm323714wru.75.2022.02.24.12.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:38:37 -0800 (PST)
Message-Id: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 20:38:29 +0000
Subject: [PATCH 0/7] Commit-graph: Generation Number v2 Fixes, v3 implementation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series includes two distinct, but similarly-motivated parts:

 * Patches 1-4 fix some bugs in the commit-graph generation number v2.
 * Patches 5-7 add a new generation number v3 by incrementing the
   commit-graph file format.

I had been thinking about generation number v3, which is the same corrected
commit date as generation number v2, but it is stored in the Commit Data
chunk, requiring a new commit-graph file format version. This breaks
compatibility with older versions of Git, so it requires opt-in via the
commitGraph.generationVersion config value. The only improvement over
version 2 is that the commit-graph file is smaller, so I/O time is reduced.

However, while exploring this idea I found bugs in generation number v2. In
particular, Git has been ignoring them since shortly after they were
introduced. This is due to a bug I introduced when trying to make split
commit-graphs safer with mixed generation number versions. I also noticed an
issue with the offset overflows that I only noticed after writing generation
number v3 using a smaller offset size, actually triggering the bug in the
test suite.

I'm submitting these two things together so we can see them all at once, but
I'd be happy to split this into two series. The first four patches are
important bug fixes, so we can consider them as higher-priority.

Thanks, -Stolee

Derrick Stolee (7):
  test-read-graph: include extra post-parse info
  commit-graph: fix ordering bug in generation numbers
  commit-graph: start parsing generation v2 (again)
  commit-graph: fix generation number v2 overflow values
  commit-graph: document file format v2
  commit-graph: parse file format v2
  commit-graph: write file format v2

 Documentation/config/commitgraph.txt          |  4 +-
 .../technical/commit-graph-format.txt         | 22 ++++-
 commit-graph.c                                | 98 +++++++++++++++----
 commit-graph.h                                |  6 ++
 commit.h                                      |  1 +
 t/helper/test-read-graph.c                    | 13 +++
 t/t4216-log-bloom.sh                          |  1 +
 t/t5318-commit-graph.sh                       | 65 ++++++++++--
 t/t5324-split-commit-graph.sh                 | 10 ++
 9 files changed, 189 insertions(+), 31 deletions(-)


base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1163%2Fderrickstolee%2Fgen-v3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1163/derrickstolee/gen-v3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1163
-- 
gitgitgadget
