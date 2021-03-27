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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B47CC433ED
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401676196B
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 23:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhC0XGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhC0XG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 19:06:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD594C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 16:06:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e18so9116186wrt.6
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SJwrcMcVlVU9K1gMSZYhPiJe5CSgbgvCjCAyXbC+Qwc=;
        b=rwZbo4w2QDjopHbsakZMKtjOIoNQEfOm/h8TVFAb+nqhhEtUL/TxgO7fQikt+5hbJe
         KL4VQsZfgGfm3ap8iHq+1tWi8OKyPTtSbZgQBWXjLPqADXc6RSoyMiL67UUl0KwYYvnX
         1IHABbso/NDQUO1kKCzXRVlcGbt34PsSW5hFKkBqCaEF95PWo7T6CdKnG2JwK16lFzI+
         ILKgXv+Buiag8CreJd+eUgdbYt6AiqpuT9Mwa0IKOiA+zre1glAubGuIRhucrgkN9sd1
         Wt+8MnvdIvQeLPYUWGxoEMssqt4ywgKMd2AUnDmKkIxhZAjAQn81aGKo64N/EHlbbmoa
         LqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SJwrcMcVlVU9K1gMSZYhPiJe5CSgbgvCjCAyXbC+Qwc=;
        b=rcfSsY5YkU8m+GZ1YOnT6dTRq99VWSIF2UB5fGQ8YFimFR2frspyg0F0WSrs6M1Fw3
         eTV3G32gniZnoMoUs6jKpjVb6eJ8alI5fkSOOr9M3K3SbHmWja+X7bQHTHraR2oyxgdr
         xcvGChTViaTyPoREXaT1Er5BO/wH3F4YfnZ0efsZZTrCScPNdORKD2btBdhhr+iDRR4X
         35J5bt3WbAGNKYe00q46hNKz+Ukit/aTcWlaCV6/VlaE6VH8tgXdirwlV3oE35AiDTXw
         xrno1cxKZajDxLLtVtH5K+NcblKGxCefVpiomme2CkYL8CqwU4zivlJvqrjODV90seY9
         7GDQ==
X-Gm-Message-State: AOAM5310GK1m36yH/wqdOswt+jhLZ1Y/hgX+yCjlhenfVRDnLArJRbDT
        WQXvmMk1duvfVkcj6uSHki8HmqeUrIk=
X-Google-Smtp-Source: ABdhPJw1dDGeA1+BPlkSCFV0cq4a4lWcXJIlxoW4Bz2/Va3eZbf3AIgcxeJT/xmvvqjFnOSRuMGmKg==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr21513047wrs.229.1616886387485;
        Sat, 27 Mar 2021 16:06:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a67sm8094364wme.33.2021.03.27.16.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 16:06:27 -0700 (PDT)
Message-Id: <pull.887.git.1616886386.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Mar 2021 23:06:21 +0000
Subject: [PATCH 0/4] cmake: learn to optionally skip linking dashed built-ins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git for Windows, we would like to make use of the fact that our
CMake-based build can also install the files into their final location. This
patch series helps with that.

Dennis Ameling (2):
  cmake(install): fix double .exe suffixes
  cmake(install): include vcpkg dlls

Johannes Schindelin (2):
  cmake: support SKIP_DASHED_BUILT_INS
  cmake: add a preparatory work-around to accommodate `vcpkg`

 .github/workflows/main.yml          |  5 +++++
 contrib/buildsystems/CMakeLists.txt | 26 +++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)


base-commit: 773e25afc41b1b6533fa9ae2cd825d0b4a697fad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-887%2Fdscho%2Fskip-dashed-built-ins-in-cmake-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-887/dscho/skip-dashed-built-ins-in-cmake-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/887
-- 
gitgitgadget
