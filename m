Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF24C2D0F0
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369BC20848
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h99HEP99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgCaMsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:48:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41132 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730819AbgCaMsj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 08:48:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id v1so24936925edq.8
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zyZpUA8nBfjC2evyD5TpTCHzkcm56ucjOIO2HYjnuq8=;
        b=h99HEP99zCcBX5co/Q2xOUMEr9LJ7IM9/EtVPDdol9eaenSzLE1PtT6Hr7xX835MIg
         jaykDAGz5BjJRgNpiY00WYaAZIKKSc5ZSEd3uuFOaoFMdh+QvANsYX7IwAPRVj+fABAV
         KudxBexToQ3jI78bgDV3nPV1oc4oSka5nF/mEb4Fu8o+WbTVD9HyyPoN3dV15WQFEsCD
         fYnbmNO5W4xRhTfxMTj0suRJdZIMetQVg6d4q8ra9Nr0G58WPTBn0JerEOfXziIEoBBe
         YKhx4Gfj5ZQUhejUgbVsiXPzkf+K2pdqrP6X1FqEdLsDWxjrH0hH+qsrxByn+YI60rIz
         M76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zyZpUA8nBfjC2evyD5TpTCHzkcm56ucjOIO2HYjnuq8=;
        b=mxLchFN06+XUYkcz48HIe7sa7y/yk3WBA3sjSqye+1UimRq4iRt4B1A4521AUfsCEO
         wmc6crpNeJJ2J7JVosj4I3JlqlFyXw9NKf6mmjIQm1w+rYNRzZxfCZj6FI9otWoYKKtk
         i3OuTD1UyjzKUMrENopWJBETVOhFjUxKfxl322EsLAReQ90OMqO8sA6Zqi/1hbUmxqei
         b54aEWaTrllNaHkhbac0mJfs88OKD/keUZvtWB4oLScmYI1lWuw6edzGGBEBjvWx/j0I
         Vglh6hzqR75IpNcpz8bPIkwSa0QD9pXdR2pQroOZMZA2FpiwjW4jp+xYCRDgOaSMvFhO
         DzWg==
X-Gm-Message-State: ANhLgQ0QlsaS8O39SSfqajnISTVD1pmZfMn41GDUhUa9q5dBSGUJPkYD
        I0EdTSKUxUlElv5HBzjTJHu6Ozom
X-Google-Smtp-Source: ADFU+vuP3Zqlrw/X/Hdc+KMAjRons3AD1+Ek4WnFKoDJwxS9a+ewF73kQDpu4CbT/cHA2eBe+4f0VQ==
X-Received: by 2002:a17:906:5952:: with SMTP id g18mr15842106ejr.208.1585658917213;
        Tue, 31 Mar 2020 05:48:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4sm2279781edq.28.2020.03.31.05.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:48:36 -0700 (PDT)
Message-Id: <a30419dca111d161b4f28b6ce55084654e02140c.1585658913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Mar 2020 12:48:32 +0000
Subject: [PATCH 4/5] README: add a build badge for the GitHub Actions runs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README.md b/README.md
index 9d4564c8aa1..e2e00ae2495 100644
--- a/README.md
+++ b/README.md
@@ -1,3 +1,4 @@
+[![Build status](https://github.com/git/git/workflows/CI/PR/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
 [![Build Status](https://dev.azure.com/git/git/_apis/build/status/git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=11)
 
 Git - fast, scalable, distributed revision control system
-- 
gitgitgadget

