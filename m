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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5D6C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D9D246AA
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vox7bE63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgKROtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgKROtK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 09:49:10 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049ECC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:49:10 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c9so3268976wml.5
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=HqMHUCoNWIPchOVdFfIuGkXNRNW8WCb8x+F7Nv5c678=;
        b=Vox7bE63mWvQS71XP4iWIDmOFs2y6cnXHF1BffuGCJK7v3nWlyOfxqnhF6Ycud+8kO
         2Yow1Zs4NdAwmdXLmqHnhYpKLuSUEV7rfma3NEbd+Ar2mpq/mZj5gM8HEKaac0qcyioC
         dMBWh64uTTa5bDH/NJ3Aa1Ot4LrcECVzOZroQ8FYxpUtauKKmG13ydu7L4bRMmj8/N3I
         qEHu9TDhzNMCtwCSF1z2VV8VOHAujzcOQ4sT6tgs0IvTvROVlb5J4NUkkPqRWug66CAV
         rQ5dXXmyGXJUt54WLDRGa4LZ/2IRWEt2ce0dxxLqMhb0/2C9nk/v4MapdQZ7cghAXtn0
         +1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HqMHUCoNWIPchOVdFfIuGkXNRNW8WCb8x+F7Nv5c678=;
        b=amV4aq+XGfDuNAcAIK8y1aPmauYOegCzdb2rLFBCMG3wD2ypYBMOUpJ0oX4sXIrxJc
         L750rXSWen+QN/nyknKokFLOQ0WVI+kpesIc7koC1mGH1wUTjE1o25ccJkLOiHN8Meey
         j5VIdhlVvGVg4SKSgeh/Dr4OtHVehhoUKM4ieLvDG0CEZmlgtwRD40UPwaLIQvBLdGpv
         91z4xLV9l6bruff5BX2lCXXwdOxA6KXBZmfzTrebPQeOpEfRgkt8L5Vyz4lylcP31/5Z
         9JXOVjKDGhgHIEywliPJ7xvS3/6rBFhkCQz/iTPioUFSDm7PR5krX6PvfYG5F8tGKReO
         qeRQ==
X-Gm-Message-State: AOAM532j6/a63diVT1B6qzHxxwruYRQkpIFVMr6ratEqh0qAlllJbvks
        ic3RTBe8LmiVoFHoTwfga72KNkJiE4E=
X-Google-Smtp-Source: ABdhPJzIX39JNKEEveeFvQ0avVmLlX6DhqyPxLereUbtK7/YYEIh2oHsIexuIB0AXKDoikQb/fQYCA==
X-Received: by 2002:a7b:cc95:: with SMTP id p21mr436901wma.92.1605710948565;
        Wed, 18 Nov 2020 06:49:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 31sm12002325wre.43.2020.11.18.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:49:08 -0800 (PST)
Message-Id: <pull.792.git.1605710947.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 14:49:04 +0000
Subject: [PATCH 0/3] t2106 vs. the default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yet another thing I noticed while working on 
https://github.com/gitgitgadget/git/pull/762.

Johannes Schindelin (3):
  t2106: adjust style to the current conventions
  t2106: make test independent of the current main branch name
  t2106: ensure that the checkout fails for the expected reason

 t/t2106-update-index-assume-unchanged.sh | 31 +++++++++++++-----------
 1 file changed, 17 insertions(+), 14 deletions(-)


base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-792%2Fdscho%2Ft2106-and-default-branch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-792/dscho/t2106-and-default-branch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/792
-- 
gitgitgadget
