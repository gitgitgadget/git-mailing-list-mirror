Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81255C4332F
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiDMTy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbiDMTye (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE0549CAC
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q8so1527368wmc.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBhnjJaPqhCQBjPju8SCWcqr1rrxxCJwBCmPDyZy8J4=;
        b=mfuClIy2L+SlHqAUvEi/SrvejCbjYoIK5VNWEl1NdvbM6tlWcU/lmJb+kIC49lzsLb
         wgm7l3aJ6d4jlF3Vw5AE+W0wwVbVevksExSKGt4Hdz2eyPxybhnHabzhqvFaUisRh7ZS
         g09SpzYbkwLHACo4XjyT0ZHrlfid0pWCai/J+vlcrfNuZ5/76/2gcCHLEu/7CaEJZXYO
         +yfNVjfKGsznGdR1cCebz1PZk164swNzEw/hD0uj45UjiLp/R44StrbEmijRH4Jer0S9
         7gjSuhSslOsuRY+xAf5EGRYYUmX2KHxW98lqnbvyP5lUY2VpzA1KJRnNv1DnqC6clDP2
         nFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBhnjJaPqhCQBjPju8SCWcqr1rrxxCJwBCmPDyZy8J4=;
        b=FiUYx5Svwr8m2KhavOX25ewq//c+3B2KBR4TSTB4O7s0gKXBe40bVT1WZjwJDe1rpJ
         S3DlLasBlKf6jmzv/2euuKrycpjbWZYseSdMNGhDTCytEuIRNFQIcjlhKkZMD5tdRIN7
         /SrvH9pmwE2j8VMV1W+p9MK6Gw+fC3CK/cb7MA8tiU9aCLwkhfmCt/A4Ltapd+3KvUCL
         rI1dsGhwAsMdhc36ti8AcmJv97AaJYVOx5rWGIIN5uJ2fiwc4Dm/n5ls2Lltnc19qD1G
         m7lwuzveSM5uFB1ShWlqRM2fSYH/xQF5RfO46fQH6CceNeRDrLsgv614nVHCGfZCVm4Z
         BGkA==
X-Gm-Message-State: AOAM533SzPse5UDLcLVJ/9U0NaKq50xEj0ZbwkL6N1Xpf3qBSngrZzmE
        O9V29qfLiQ+yn6X6TacHZ0zr4ogTab3qrg==
X-Google-Smtp-Source: ABdhPJzkZKGWU36g6kieAu6lK/eTPrLvZlvNUgWIVSEb3WCQQtGV6b00KmIaHb+nyqhwxpldDG7KPQ==
X-Received: by 2002:a05:600c:281:b0:38e:bc6e:5971 with SMTP id 1-20020a05600c028100b0038ebc6e5971mr264752wmk.111.1649879529548;
        Wed, 13 Apr 2022 12:52:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 16/29] CI: invoke "make artifacts-tar" directly in windows-build
Date:   Wed, 13 Apr 2022 21:51:29 +0200
Message-Id: <patch-v3-16.29-ac1ffe9c642-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the windows-build job to invoke the "make artifacts-tar" step
directly, instead of calling a "ci/make-test-artifacts.sh" script.

The script was needed because "ci/lib.sh" would set up various
environment variables for us, but now we can instead use the
"ci/lib.sh" in its script mode.

The "mkdir -p" added in b819f1d2cec (ci: parallelize testing on
Windows, 2019-01-29) isn't needed, the same commit added that "mkdir
-p" to the "artifacts-tar" rule itself, so we can have "make" create
the directory for us.

This also has the benefit of making the "build" step less chatty,
since it won't start with the verbose "set -x" output, that's now
contained in the "ci/lib.sh" step.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  5 ++++-
 ci/make-test-artifacts.sh  | 10 ----------
 2 files changed, 4 insertions(+), 11 deletions(-)
 delete mode 100755 ci/make-test-artifacts.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 05c5771e7f6..2c23a19eac2 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -87,12 +87,15 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - run: ci/lib.sh
+      shell: bash
     - name: build
       shell: bash
       env:
         HOME: ${{runner.workspace}}
         NO_PERL: 1
-      run: . /etc/profile && ci/make-test-artifacts.sh artifacts
+      run: . /etc/profile && make artifacts-tar ARTIFACTS_DIRECTORY=artifacts
+      if: success()
     - run: ci/check-unignored-build-artifacts.sh
       if: success()
       shell: bash
diff --git a/ci/make-test-artifacts.sh b/ci/make-test-artifacts.sh
deleted file mode 100755
index 45298562982..00000000000
--- a/ci/make-test-artifacts.sh
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-#
-# Build Git and store artifacts for testing
-#
-
-mkdir -p "$1" # in case ci/lib.sh decides to quit early
-
-. ${0%/*}/lib.sh
-
-make artifacts-tar ARTIFACTS_DIRECTORY="$1"
-- 
2.36.0.rc2.843.g193535c2aa7

