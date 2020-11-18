Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9882C56201
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE5A246CB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTWg7fu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgKRXo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgKRXoy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:44:54 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C85EC0613D6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:53 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so3280130wmd.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uFf/6xSX7E+6jNyGq0NSZ/TSaTJ/LkXm0TtRomb+Z68=;
        b=fTWg7fu2nd6zqm1nNtaa7YetZfAm54Y5Q4C7YwOaE1Z/GMDQ5bi2s/s4G2N5P4FxNB
         fsZ4rc9MsY9kngh8VOzIjIyQdnMCtNgr2NxV/KA5YVbY6jCTKfMckidvIk9hWNtSTynI
         NSZe2ayEP5gFjVpL4iRjCWdlcDYRaP0ZzbTJgxcgKtrjjkoLcKX8HjzqOSRk812eM+Me
         deZD+bh9XEUQPCNDqqxoV+X/YxmO0H6JhmDimQuiIAsMvJYCV7nIkVQSxoh+++z2d/Ny
         RTP0MJda5SmSc36XwKcwwSjHPn2wTkKwWLXuZDbLB4Cf9RpOuRvVkiic1bWO6QyOnOkh
         GxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uFf/6xSX7E+6jNyGq0NSZ/TSaTJ/LkXm0TtRomb+Z68=;
        b=E+3PlwJB1MuGxMeMoqGW6BZixaL8fcXB+wMAqfG+Kgb6/eklvzXNRTA1ZVWscP4eMQ
         VAmUfR4j7xlBAMttiv+7574AHrYRHBSK4V6bb+uebP3DWzLzRGAru+4+SylThF1rMzgp
         JxE166VE7WxNShP+ebiUQCji1RLE6LSx6A+o7ba2S8uRx0R9TpOUBVtrsfOKIHPE2iR+
         Ru09/0lfgURNtWCoh5vR0RD/qF9zNyvTRDN2Rm4RrzEifkmG+U65Oqnu7ZV/ggrvlbyT
         gy9OFekPGvEYsoJwNUn5n0zluDGlHqpQHfFGX6tzf933tIS1EqXRUuDHakDWMCwMSjM2
         M8MA==
X-Gm-Message-State: AOAM531iFUBN2WUAW4oPzwGEM3e0/EjxQbigdD+rM/iUD2ji4tDRdvqP
        zvCtzORXZIwd9F4GVOXkWQl9I5/JgC8=
X-Google-Smtp-Source: ABdhPJy15odZEVqPCwu3q8Vd+odzfCGsRMSxoFtmnzhz7C1Cr2Zjps665flXqSRzmIhRLNJZ7T55AQ==
X-Received: by 2002:a1c:208f:: with SMTP id g137mr1497072wmg.116.1605743092182;
        Wed, 18 Nov 2020 15:44:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm38792439wrv.57.2020.11.18.15.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:51 -0800 (PST)
Message-Id: <8c2e158c8f3f33257306ea188a63167b2c2ab2e5.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:20 +0000
Subject: [PATCH v3 02/28] t0060: preemptively adjust alignment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to adjust t0060 for the new default branch name `main`.
This name is two characters shorter and therefore needs two spaces more
padding to align correctly.

Adjusting the alignment before the big search-and-replace makes it
easier to verify that the final result does not leave any misaligned
lines behind.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0060-path-utils.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index b2e3cf3f4c..928eebbdc0 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -312,8 +312,8 @@ test_git_path GIT_COMMON_DIR=bar info/sparse-checkout     .git/info/sparse-check
 test_git_path GIT_COMMON_DIR=bar info//sparse-checkout    .git/info//sparse-checkout
 test_git_path GIT_COMMON_DIR=bar remotes/bar              bar/remotes/bar
 test_git_path GIT_COMMON_DIR=bar branches/bar             bar/branches/bar
-test_git_path GIT_COMMON_DIR=bar logs/refs/heads/master   bar/logs/refs/heads/master
-test_git_path GIT_COMMON_DIR=bar refs/heads/master        bar/refs/heads/master
+test_git_path GIT_COMMON_DIR=bar logs/refs/heads/master     bar/logs/refs/heads/master
+test_git_path GIT_COMMON_DIR=bar refs/heads/master          bar/refs/heads/master
 test_git_path GIT_COMMON_DIR=bar refs/bisect/foo          .git/refs/bisect/foo
 test_git_path GIT_COMMON_DIR=bar hooks/me                 bar/hooks/me
 test_git_path GIT_COMMON_DIR=bar config                   bar/config
-- 
gitgitgadget

