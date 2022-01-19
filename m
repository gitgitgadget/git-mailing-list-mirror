Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD7EC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 17:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356411AbiASR3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347255AbiASR3n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 12:29:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B62C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:29:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso15821235wmj.2
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=6UayWK0xRtvytHQXovKcUL7+xB19O4V+60whPEEAPsg=;
        b=QhGIOyvVCET05nHGBVDOZkYMH9vdPbj4FrMwz8Qqfy2A9aE0asHNg4QuGHVECaCrgi
         CFanQ3XIb1X2a7ZZJIaJZ6YJjVmKJMEax1YVftNn00So5BapXFnpMzsVEst/CS+t1TBP
         9ViG5ix8cVH0KbQ4/yAihMtnWiIJ3DeEQSy8+9TJjn8bCXpRSuDcvSmE3ECpCzqL2C06
         w17b52nJIh2iJZ7ArZWp0YHb4hsGT+VBXxGRLZrN8DvVEvFDionsd6LN6aKQGwrPGQ4a
         lSziQ7GVDu/h4MYG+08hnWkPiTalohImDhWnH4ODIR9T8pOe9iHFg0rDv0PE5TleVq7k
         3Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6UayWK0xRtvytHQXovKcUL7+xB19O4V+60whPEEAPsg=;
        b=aUeYb8I26Uk4/oiHjqzMqudPZtm7rXt3j0uLTpf6frRe3DhK6G8sAReBmuh7Um1vdV
         aPnL/TNuiYKNGHZTYKphKS0T49fX8cKRxm+mD7JT1ggtd/wEKque7Wn5ciSdvX2Ov7dl
         q3eNnrQzK78DvEbs5GyI4kYn/i+QmKQ7BN2xwvbLxvFqfrFm5LJHX3YGS6BXIB8NrZrJ
         CbstSjE5sIiROPwNbItINIdOZVHNXepTc0rZHyAuB3ydp1vdVD0BvUbNd0tE67q7m9F3
         Lekx3T42EFf2Ej8SbMelsIgwVn6Mi7K7Y/xabz7JgK/tENgf+fEmkpddOC8yQH8YAJwq
         MKQw==
X-Gm-Message-State: AOAM531Dxl0byJhFYS9LWRWP8vwstGMFwsz6YqiOs+OFoDpyX5XCdN1U
        D7PXWE1PZ95ghf6pFXRjiS2VDnt0gwQ=
X-Google-Smtp-Source: ABdhPJw4lVZ4kjj9eF91y4gio8I7eeksyZJMvXpZnKL/muz4+Uy0bakT3SsJ8YnqDleucaciCDrQ+g==
X-Received: by 2002:a7b:cc11:: with SMTP id f17mr4520482wmh.84.1642613381272;
        Wed, 19 Jan 2022 09:29:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm5358637wmh.6.2022.01.19.09.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 09:29:40 -0800 (PST)
Message-Id: <pull.1119.git.1642613379.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Jan 2022 17:29:36 +0000
Subject: [PATCH 0/3] [Non-critical]: sparse index vs split index fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We noticed split/sparse index-related issues while rebasing Microsoft's fork
of Git. These fixes are necessary for that fork's test suite to pass, but
they might not be super critical to get into upstream v2.35.0 (especially
this close to -rc2). However, the team felt that the decision should be left
to the Git maintainer whether to take these patches into v2.35.0 or not.

Johannes Schindelin (3):
  sparse-index: sparse index is disallowed when split index is active
  t1091: disable split index
  split-index: it really is incompatible with the sparse index

 read-cache.c                       |  3 ++
 sparse-index.c                     |  2 +-
 split-index.c                      |  3 ++
 t/t1091-sparse-checkout-builtin.sh | 54 ++++++++++++++----------------
 4 files changed, 33 insertions(+), 29 deletions(-)


base-commit: af4e5f569bc89f356eb34a9373d7f82aca6faa8a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1119%2Fdscho%2Fsparse-index-vs-split-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1119/dscho/sparse-index-vs-split-index-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1119
-- 
gitgitgadget
