Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2962EC48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23CC611CD
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 11:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhFLLSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 07:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFLLSx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 07:18:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5F2C061574
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 04:16:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g8so8497412ejx.1
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 04:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sp/RxO+jxC82QU1ZVPfjNFh8jILcfZ1RO9zWHVeWBQ8=;
        b=G4nWXWPfLpRoo9G/kV2q20mx8NVco7XAT4fBoKJ7dYAzUYTexQtcOnwLOIkZUaKwfO
         nRDiioRoGPn748qlAmMfsULobtKknV8gzCfuZblYXAxCHr3bYoyT/NWsiOfYMs/uuUse
         SKRE0aFNKrfm1B3WRQU4xhrNrkH8FGeu9Ny92udBumg0JJTC1gPnut3Oqaj1cRbtWpsK
         NYaxQPyuACvf4yGtLyvdDTgtqcByzyR/qVaMsNeKmgg822kW4Erg0dn2R3lpFm/dkm6j
         Tczrz4L8BmLoWmLKwss2c02haKSgmmV/QH3ZzV5YuOkjgt8v4bFrszcOoLD74g8aAJcT
         5PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sp/RxO+jxC82QU1ZVPfjNFh8jILcfZ1RO9zWHVeWBQ8=;
        b=qr8naK5c2/wCGvEaACOW4ac0hcqPWvLnG8dpEC5hjFmkGeRXtZR6P2lhy5CtrMRNrg
         /89fE4kM3wRZ181t9uVYMe3IrrjZwj/NBoTckePfFFMsfaWfLbnng81OYnzbpm4nLps4
         K1WKNjXcrlo1O/wA4xkpyn7lbXuYRmvMQ2jk4e3nIvO2RtP8fBdC3yltWABSKRNL75TM
         SjDXAAdS2OKb1hUu046QiSSL4wV8OV/O4Q8sFcM4tfsfqw+9H0SNfGxFtPx0cNQvwvdA
         TQJJCvkGeM0DdcAS7b0fIfLaJQz353zxB01YXDazCV7aT01uMuq0AuUjyh+KHUqiZXYw
         5URw==
X-Gm-Message-State: AOAM532sA4cwn9tFQ9TYpYX1D8S5XgSzXH3XVJWos5A88KcELKmtyIQT
        5dMNWti9SKLodit32pFr6jvkO6kr6rwdgb7C
X-Google-Smtp-Source: ABdhPJwSwwZhkK1Nu8MSJVVahB6LoZ7vMzT02k0XbIPfKQZdbIZUMuU8d1B/rWb2fB3311M42vu54A==
X-Received: by 2002:a17:906:19d0:: with SMTP id h16mr7602897ejd.193.1623496611984;
        Sat, 12 Jun 2021 04:16:51 -0700 (PDT)
Received: from localhost.localdomain ([138.199.18.64])
        by smtp.gmail.com with ESMTPSA id rl12sm2987898ejb.94.2021.06.12.04.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 04:16:50 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] RelNotes/2.33.0: fix typos
Date:   Sat, 12 Jun 2021 13:16:48 +0200
Message-Id: <20210612111648.4064002-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/RelNotes/2.33.0.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RelNotes/2.33.0.txt b/Documentation/RelNotes/2.33.0.txt
index 6795a2734f..4db830eed6 100644
--- a/Documentation/RelNotes/2.33.0.txt
+++ b/Documentation/RelNotes/2.33.0.txt
@@ -9,7 +9,7 @@ UI, Workflows & Features
 Performance, Internal Implementation, Development Support etc.
 
 
-Fixes since v2.31
+Fixes since v2.32
 -----------------
 
  * We historically rejected a very short string as an author name
@@ -19,7 +19,7 @@ Fixes since v2.31
  * The parallel checkout codepath did not initialize object ID field
    used to talk to the worker processes in a futureproof way.
 
- * Rewrite code that triggers undefined behaiour warning.
+ * Rewrite code that triggers undefined behaviour warning.
    (merge aafa5df0df jn/size-t-casted-to-off-t-fix later to maint).
 
  * The description of "fast-forward" in the glossary has been updated.
-- 
2.31.1

