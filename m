Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02249C433E8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41AD2065E
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 20:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMs0S8EK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgG1Upo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729165AbgG1Upm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 16:45:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65044C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 13:45:42 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a14so19573131wra.5
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Z/R8khSVpm6EZBUGXJXbw6UpSUVN0768UI+WY5RGhgU=;
        b=VMs0S8EKtw7tSykItPqQfUaCUft4jV3BNs2bgQUt4/w7ADkf7AC4lsHFJCNcAj8sh3
         1SIt47WAKPgxrEeNNjkKPtTcAHmR2V3u6Dnpj0U0EUyJooCopokMUL0Sjb2osWAXSa++
         mUHU1iSzcjA86LRgtapYhyV5tRs5D4S3t9lljthZojYMFNyFGuTqso7gBNZc21xSyPav
         jApts6vFJz5zO1rNt6MIYmYZ4GeYaMwRQ40x3AeaYCFwZ9J9KAI9Bl8Kb7b18fWF4A89
         6VB5rie+u85qC+hMSwiu6YAgmaxu/YFm2xUomzIHCam+NM8MWgTyh2VbtTZfBQ2hzHZg
         0b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z/R8khSVpm6EZBUGXJXbw6UpSUVN0768UI+WY5RGhgU=;
        b=AJUmWaDR6KE60rU4iJsVvAZMV3usQQemJpdyJChMPOZPM6IZaWv+EOh0qclo/8OStB
         VVBvHc8UaJo2z2OFK6Kmx9D/n+lh8VmxvcSdLz8URX694UFelvE7Kbg61LQQdJL/yc0S
         vCLw/JxH12kcYUTsAUw5wBAd+/hhLL9xjhay2oToqY+5f5v9twuHgpI2yM1c/XEk7avM
         JM0h6Cbml+beYOnMC9NoG7gbCioVwoccGQn2xTdVSjglqCyjSQvdOHiPmM4+FsaKKYW2
         J3jXStUl5lOhZsd45ien4hfCDyRcBNTnC7pht3YFspSSG0EeuQeb/cRuFKqbJkCjfbZo
         0PLw==
X-Gm-Message-State: AOAM531kN063M6LpIjSCwCr8ZC5qXHpGoUlwMD69AYb/BvYV2aXE7NEq
        M+C/ZQhqKDOH62nNWPuM78CPSBr/
X-Google-Smtp-Source: ABdhPJzq1nLUJmxkuR/fQOfGhz4ySu+2yShfwQfBoTNPX8YhurGnwYK+wr39yTIZ8fi2orVwO586OA==
X-Received: by 2002:adf:e9cd:: with SMTP id l13mr28469767wrn.340.1595969140944;
        Tue, 28 Jul 2020 13:45:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm7131410wmb.28.2020.07.28.13.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 13:45:40 -0700 (PDT)
Message-Id: <pull.824.git.git.1595969139.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 20:45:37 +0000
Subject: [PATCH 0/2] Typo fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix some simple typos: doubled words, and character swapping

Elijah Newren (2):
  Remove doubled words in various comments
  hashmap: fix typo in usage docs

 fsmonitor.c                            | 2 +-
 hashmap.h                              | 2 +-
 t/t5510-fetch.sh                       | 2 +-
 t/t6046-merge-skip-unneeded-updates.sh | 2 +-
 t/t8014-blame-ignore-fuzzy.sh          | 2 +-
 wt-status.c                            | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)


base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-824%2Fnewren%2Ftypo-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-824/newren/typo-fixes-v1
Pull-Request: https://github.com/git/git/pull/824
-- 
gitgitgadget
