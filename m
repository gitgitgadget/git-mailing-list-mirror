Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1D7C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 14:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A882422B37
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 14:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgLDOfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgLDOfF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 09:35:05 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D1DC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 06:34:25 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h21so7244643wmb.2
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 06:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dMm5AUMW9+MiqdCFutLG2+KUb66SazBab8P06sKo4qw=;
        b=TALeCUAfVxYi7IlJyndKA8b8W6o2Mug9EiORdbpcRQ/mpgh4HbFV5Ll0JqTEavSuTL
         FHkwQEiR/4i4wfgG0H1As4VasQoOJCyqzd9zp/4U6TeyfdYPJf8vZ/7IJa8FgXmtmVwG
         GUVcoqG3oRh0bb1CXda46u4ivDwr6knvaVq9UQHCpBaRlGyplRTAobD/A+tirYKVTzY8
         ZbiLoWI2k4mC88DOkItM6UGtKOOfXDb6+3CgmaGuAu/QUcTjgoSLHqF9eNq/vbWJY2ln
         0GhiYUDaGxi0f7FnPWLbiMVozqZaK22uJRKGuPyUe6igNX8Yv3av9Vhf1GxEuPEc5Qyn
         Negw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dMm5AUMW9+MiqdCFutLG2+KUb66SazBab8P06sKo4qw=;
        b=eaaGsH+zPS/7Org1Ju4JB8LM2RUKjyeNwiFVfKYyWoMTd6fBcJkA/afHYWl7s24/WK
         7r+coUl/RqzyAqhxJk8BVQanXCe/B/EMdez9TKsGC4iI9/zpBJY/8Geb50OJ+d/H11N2
         AYiLwRAat3jA2K2dgUsysX9hkfjxPaDi3GwsjjS+ADdkCTtP1hrhLA0tFFqogvBG8CJA
         f8NuHBa0uLYPyVJWmFIJ6PDvjvk1yvvkFMil/QrVnMWzqzn969abL78cAydN5vWAkR9N
         pGz4hI5llBhQWnG4rXOi9aGM11HtS5LdZ4OrQGAo43RsTfm14OzRuwXxGl0S/iPAOYAd
         RXBw==
X-Gm-Message-State: AOAM530U+FEwhstgRdTRICrkJCZC/cMSotrBJIXnXf3ceF8/kEs/3Diw
        pVJdu4mPV3kqBI0LB2YSj8DtM3AkmLY=
X-Google-Smtp-Source: ABdhPJxk1UDo1z1rqGeK1Vn//7AaRMwlXf6MgaNbEXZTIawK4ZQm7O4ftE/5uBw5UloLZKJtnwQOHw==
X-Received: by 2002:a1c:b684:: with SMTP id g126mr4534936wmf.135.1607092463778;
        Fri, 04 Dec 2020 06:34:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z64sm97097wme.10.2020.12.04.06.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:34:23 -0800 (PST)
Message-Id: <pull.806.git.1607092462.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 14:34:20 +0000
Subject: [PATCH 0/2] Make t5526 independent of the default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quite a few test cases in t5526 were marked with the PREPARE_FOR_MAIN_BRANCH 
prerequisite, in preparation for changing the fall-back of 
init.defaultBranch to main. However, in the meantime concerns were raised
that I moved too fast on this.

As a consequence, t5526 is largely inactive.

This patch series addresses that by overriding the initial branch names
explicitly in t5526, and then removing the no-longer-needed prerequisite.
With this, we have full test coverage in t5526 again, no matter how long the
effort to rename the default branch name will take.

Johannes Schindelin (2):
  t5526: avoid depending on a specific default branch name
  t5526: drop the prereq expecting the default branch name `main`

 t/t5526-fetch-submodules.sh | 83 +++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 40 deletions(-)


base-commit: fbc64c5ab5e1e73a56689d2270e7f27ab7cb29c1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-806%2Fdscho%2Ft5526-and-the-default-branch-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-806/dscho/t5526-and-the-default-branch-name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/806
-- 
gitgitgadget
