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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C563CC07E96
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2626145D
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhGDW55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 18:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhGDW54 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 18:57:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F70C061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 15:55:18 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso8912752wmc.1
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1u8MGfSxgCE03cekx/+oC9KGRE09BcEKKiz0MnCYhaQ=;
        b=OsLJOGqKdNcYpnS+lj4aBgHRAdgXxyY8yJ9OuSB/0ohyFHYaCGfSTX6oI04arFaHL3
         z9xiyWZOKjyB24ZF0YWiw4DUaFVHXoIXYXoIwiK/uA6luy51SzwxPeOhHyZJCCIDPhSI
         jVzZl8/kXTkl7XDkSgvYO6M57fUU6PyufX6Z0qPHYWyBNDkLY1oljKI7dovlab3vw3cS
         lOMu9PygGEubEyeKwOY3+WClv7cIDsXzkuoIFfaFLpR4zfuJFx5w0AaHcPywVAGy2bfq
         MnEQ0bByDQJnO4+nEYWxTTMZ1bSD/tUXahFx/g1IxzWR7VTDa3ZiWOFrpo/kznxyC3/z
         bsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1u8MGfSxgCE03cekx/+oC9KGRE09BcEKKiz0MnCYhaQ=;
        b=i5DbBXNViej/oPzIw9iixMpyU7w/MFPv8hPTUgo18GRjRZKa0DCdfqzt9khRB9pRbI
         Zt4zP2950wzZCy8UWZbDXBAoe9f/6EepYvhflFRh9cDZ2jjA36RZMVSBGEd0hpxfdup9
         3uFQmaO29BLLD1paCmLc7mnO+GQg/G0fUpVbKRvW4tO0DAkRh7IWQTj9LvwOC9urroEc
         byxhB7tC7TawOaS36uzyE7rNpWqbtltaq+mmRHsp7erTYIOKxpiCL0xZ8I5Kue2Ip0Is
         H8RjZ49FolDAK+WqHXXbB1JXPk+FY61koTmoAZuB82lNaYvHfZfh0H/NUoCvn1JmnzN7
         /0WA==
X-Gm-Message-State: AOAM531mYKvLOu9+H0IEp9/j7Ju3TmEGeKloxaF51zJfvH5wt/enpAN2
        HjgX3IkGZ7Wg0Vri9/QRcjVP6wDjsOE=
X-Google-Smtp-Source: ABdhPJxSaFDX9ayJtdDiVkhJ0ZyoD05tX22Q1ykHGkTwcv5VC9Z/zVCL5geoXV/kGDrwimZ8ROsvLw==
X-Received: by 2002:a05:600c:3782:: with SMTP id o2mr11442062wmr.152.1625439317568;
        Sun, 04 Jul 2021 15:55:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8sm10713764wri.91.2021.07.04.15.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:55:17 -0700 (PDT)
Message-Id: <c256bbf4b1ce5f8fc13ca3aae47618b87985a906.1625439315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
References: <pull.878.v2.git.1625347592.gitgitgadget@gmail.com>
        <pull.878.v3.git.1625439315.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 04 Jul 2021 22:55:10 +0000
Subject: [PATCH v3 3/7] ci: upgrade to using actions/{up,down}load-artifacts
 v2
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

The GitHub Actions to upload/download workflow artifacts saw a major
upgrade since Git's GitHub workflow was established. Let's use it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index d430c4e0d20..a399114c0f8 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -90,7 +90,7 @@ jobs:
         NO_PERL: 1
       run: ci/make-test-artifacts.sh artifacts
     - name: upload build artifacts
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: windows-artifacts
         path: artifacts
@@ -104,7 +104,7 @@ jobs:
     steps:
     - uses: actions/checkout@v1
     - name: download build artifacts
-      uses: actions/download-artifact@v1
+      uses: actions/download-artifact@v2
       with:
         name: windows-artifacts
         path: ${{github.workspace}}
@@ -121,7 +121,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -170,7 +170,7 @@ jobs:
         mkdir -p artifacts &&
         eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)"
     - name: upload build artifacts
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: vs-artifacts
         path: artifacts
@@ -185,7 +185,7 @@ jobs:
     - uses: actions/checkout@v1
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download build artifacts
-      uses: actions/download-artifact@v1
+      uses: actions/download-artifact@v2
       with:
         name: vs-artifacts
         path: ${{github.workspace}}
@@ -204,7 +204,7 @@ jobs:
       run: ci/print-test-failures.sh
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: failed-tests-windows
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -242,7 +242,7 @@ jobs:
       if: failure()
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
@@ -269,7 +269,7 @@ jobs:
       if: failure()
     - name: Upload failed tests' directories
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
-      uses: actions/upload-artifact@v1
+      uses: actions/upload-artifact@v2
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
-- 
gitgitgadget

