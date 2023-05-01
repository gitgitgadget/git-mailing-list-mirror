Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A1CC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 18:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjEASVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEASVk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 14:21:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404A31997
        for <git@vger.kernel.org>; Mon,  1 May 2023 11:21:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso16981485e9.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682965297; x=1685557297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uQoC5i0muTdaWMNpfrPG6esO4tw7ZMQg7SXPkzI3JbM=;
        b=VyURy1mXglhk7yHiBHGsPa4C4AdHpcn280gLEWSq+cALMljVJlgqTQFGOgDAGMd7iq
         YpycScT8127NBs4PQ8BpZ6ttKlIK3ys7+0NNsFkLOyf9FczeqNLNOmuGo0DL8lgflKsP
         A3es16pdli4rf14bQhNqm+gHGuLQ71SskcSCHVTlr3PslyFtaMU3iU+Rnlgb1t84e9aP
         upfNmG5Rb3sSZYk6hAtlVKhgwJ82rhLNoFxi4l0Xezn3mqWPBjo7cmiKPlzHZIpXNAwh
         36VEKErytgoqLEryTdETb3JPD3k1gVjlr44C7wfqBAtvK1MysXvJKpE9X/vupZohA4Vl
         BFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682965297; x=1685557297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQoC5i0muTdaWMNpfrPG6esO4tw7ZMQg7SXPkzI3JbM=;
        b=OrLsMiMPo2M0VhTyH1BSqE6guJfhQjxhvf3zkExCFbFqlLKKlrAnszls1yhSy3rt6C
         8UNj2HurbypEdc2L/CE8C5KSVpn8Golhb2KkiP2TtTOkT9l+BQk/iYErzTaYyNu7QVUv
         91k48FEPXfF8Ja1AYNSDkdZMZcetzrqDxea75IQ41aoc3rfHi618Kpk/kZRtgbOgp4Zf
         bY/f+B0B6iFbt8R6E1BjF6VA2jwKrOSBhQDcx4z4evhXLoo+Bdy+7Hi+xzepICX6OC+J
         IeFtdKQHv2FWXYZSVz46GVqduYZRD5vSLaKpBhLTSFmh5E9K+bcJNYXQVW+ogjnX/A1x
         ygsg==
X-Gm-Message-State: AC+VfDy4tWof7xx/8XIBzox5agpi9P6LpfDhxotqwGi+SPYvmiu8Dqed
        yb6U4MeFGU2oZhQtIbzlLfzQJYsNdJ4=
X-Google-Smtp-Source: ACHHUZ5g4XT0ekdiuSj/cptrbhY5gsbmjTn9uVOahERoFNJxjc1QKi3dqkXK+t6y16huBt/+3phxlg==
X-Received: by 2002:adf:e341:0:b0:2fe:d540:8c8e with SMTP id n1-20020adfe341000000b002fed5408c8emr9365885wrj.19.1682965297245;
        Mon, 01 May 2023 11:21:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13-20020adfe40d000000b002f8d402b191sm28834490wrm.112.2023.05.01.11.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:21:36 -0700 (PDT)
Message-Id: <pull.1526.git.1682965295.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 May 2023 18:21:33 +0000
Subject: [PATCH 0/2] fsck: verify .bitmap checksums, cleanup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the recent work on rev-indexes [1], add checks for .bitmap files
to 'git fsck'.

Patch 1 includes the full details for .bitmap files.

Patch 2 includes a cleanup of ds/fsck-pack-revindex that I noticed while
preparing this series.

Thanks, Stolee

[1]
https://lore.kernel.org/git/pull.1512.git.1681748502.gitgitgadget@gmail.com/

Derrick Stolee (2):
  fsck: verify checksums of all .bitmap files
  fsck: use local repository

 builtin/fsck.c                | 10 +++++---
 pack-bitmap.c                 | 44 +++++++++++++++++++++++++++++++++++
 pack-bitmap.h                 |  2 ++
 t/t5326-multi-pack-bitmaps.sh | 38 ++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 3 deletions(-)


base-commit: 48d89b51b3bb8a60580c36731b96a7206ce1e5b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1526%2Fderrickstolee%2Ffsck-bitmap-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1526/derrickstolee/fsck-bitmap-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1526
-- 
gitgitgadget
