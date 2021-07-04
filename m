Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAE9C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478B861405
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhGDW6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 18:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhGDW55 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 18:57:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D0EC061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 15:55:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a13so19688067wrf.10
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AmkW7Q+V0k3KySWrKmjRcqCcZBaZb/9eiscfQtg3q8M=;
        b=Q9xWxnAaMI+AcxVTFvLBHiDRmcy0WsMXHht+YceSaV0EwNNQhgf5eI7etuhVk2K+ZJ
         m6qrACBMIdUmMv6itAFu7bx+mnPgqzSggtxLZFpDRw56Gx1GuwOmkIa8RbFo8PtmVbn+
         fkIEZi0AlzHbfK3LedDLB60oHkdF+jvMBMVm/Jv7DAmNdn9/Ae2aULJl1OziBs61H8i6
         Cd0OwVm1dBLOo2ZP8qlA12KPgSvAP30mQ7fmoQIUb/g+cRN8wG9/JrK6sLP3ECnfj0aJ
         I6z5ZwvOzgeuaFpkSa9lzZTCMpWWvsl0Dp8CIDvpU511SJYqcX8aSV1pTP4P9oFCoFrc
         7pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AmkW7Q+V0k3KySWrKmjRcqCcZBaZb/9eiscfQtg3q8M=;
        b=Po0FE+/IJCA9yzMJ0YEK6O7H4cdZpl4Umo/VdqO/EM4ccUg+6F/4Ik2kxDist9LYTR
         3UXVU6SjyFZftqrEWDhRuGukiiKFyeksifSQ2hcsCn2ZXitj8usxfbPws795LuJ3ZbOl
         xJrPFf1n2f4Kz8RQrs7NW6va+YX22TuIoEM+A18RtJefh4gURnHcj9G7uT429Wsm/J7M
         YDnRuNdkwvVZKLiKbivzPHETAOyKbiaCKN2G9jFWF/F6VPte6/v/YUWVrsuPo9uCLxSX
         XWrwHnYTp8/W7BNFYeqXrRCxRc4ppMbhRirwP/PapSlT2vGYjr88sLQk8zKysOwow1yY
         8clA==
X-Gm-Message-State: AOAM532Ky648KTTNTyA+HIDE66r2e2BWNtxaCaEuEOCh+pa9QlL3kLOr
        xSxqb4wOK6gUzOFb+k2br778OjsSQZ8=
X-Google-Smtp-Source: ABdhPJwEkwZPzJ2/uUJwTYxfDmcY1+7BNVo3RLb5da4z/XbJeMolme2cve0TxMoEsNaB7OZ/Hx9F9A==
X-Received: by 2002:a5d:400a:: with SMTP id n10mr12278447wrp.268.1625439319962;
        Sun, 04 Jul 2021 15:55:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm11422182wru.78.2021.07.04.15.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:55:19 -0700 (PDT)
Message-Id: <db54bf9a779e168fcf87f2f9f4e5e43f6ccf7645.1625439315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
        <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 04 Jul 2021 22:55:14 +0000
Subject: [PATCH v3 7/7] ci: accelerate the checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By upgrading from v1 to v2 of `actions/checkout`, we avoid fetching all
the tags and the complete history: v2 only fetches one revision by
default. This should make things a lot faster.

Note that `actions/checkout@v2` seems to be incompatible with running in
containers: https://github.com/actions/checkout/issues/151. Therefore,
we stick with v1 there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c99628681ef..e6f99e29a3d 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -81,7 +81,7 @@ jobs:
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
     steps:
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: build
       shell: bash
@@ -134,7 +134,7 @@ jobs:
       GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
     runs-on: windows-latest
     steps:
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: initialize vcpkg
       uses: actions/checkout@v2
@@ -237,7 +237,7 @@ jobs:
       jobname: ${{matrix.vector.jobname}}
     runs-on: ${{matrix.vector.pool}}
     steps:
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-build-and-tests.sh
     - run: ci/print-test-failures.sh
@@ -282,7 +282,7 @@ jobs:
       jobname: StaticAnalysis
     runs-on: ubuntu-18.04
     steps:
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
   documentation:
@@ -292,6 +292,6 @@ jobs:
       jobname: Documentation
     runs-on: ubuntu-latest
     steps:
-    - uses: actions/checkout@v1
+    - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/test-documentation.sh
-- 
gitgitgadget
