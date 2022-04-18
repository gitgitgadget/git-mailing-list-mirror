Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8633C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbiDRQdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbiDRQcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD9F30F71
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r19so3135231wmq.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7A/pIfHzrnaoFfhSNnoHAaP43XYJmI2qNn9+TFOhNM=;
        b=VkpQVtKtlrsdSs7Ff6brYkBXRnyDAkrKvpqn6EQcB5cchxMmWHZJ/ViQP5tqGHvq6g
         uRAPAtVBRIZoyWO+NunpaJtk1Uo2A7ngbQl28zWLevkJ1GR16f2/pbB9d3k03RswBUX7
         m49stc47VcP/DWkRM9wECwPyI60zipudy4IrMamilxIzxR3H5e33kVqnRgY4KKe+sF8R
         MRAeqUCu/cr6bUJ0TDKOMRtceuZRx5hq10t73FxxHF5l1xers0immCx7jNncmRnTk389
         cqnkq88HamciCchIsmKgEvbwCgZLP13hDjMtx5fk7lNRbcpl2kZD5numoB02SlVDLDtY
         Zsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7A/pIfHzrnaoFfhSNnoHAaP43XYJmI2qNn9+TFOhNM=;
        b=q9Vrb69XKL4sucx/QXQ29LLUVmyEyrptNvNIcKjQTsUOU0xxKnmfcOuEDC2szVn/UY
         ey5UmAgPTkg2frLlWNa4qTXSEjeJAssqertl5gcCswy3lIYjgBmLIBAbyP3qC0xzgszT
         eBVAF8pOIsOddHMedvzMUYbvL14VZCdg30snyOSf+cpV0I5dPM4BA8OnFv+NJh16x1lt
         O47FlT4Gc4NhkTa10ciCrvxQzUHkUxqYTUEripAOoE6Kqc+6ywDp0wDKmbHxHSE/q8K+
         n+05chDElRETiLfPV5bjujZnq+f/5wSVRX6Z5wishSifVgVmooWSYqVPrkyqSHJZR54D
         U8Iw==
X-Gm-Message-State: AOAM530wC76nVrnWGBv4V6KkqInAZdOMXs170wgilYTAUrMVsoe/vrV9
        Nnn+pvEV0sY4Tc319dMkhdrSNjMgJPd5Og==
X-Google-Smtp-Source: ABdhPJwjZUVM+BCs95YVgIBUKvqrXYvEjDv78IKnINzyYA6gAZlj9aGXm08vP6yl8zqPY+2cT/l8dw==
X-Received: by 2002:a05:600c:a4b:b0:37b:ea2b:5583 with SMTP id c11-20020a05600c0a4b00b0037bea2b5583mr16332535wmq.139.1650299367692;
        Mon, 18 Apr 2022 09:29:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:27 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 16/31] CI: invoke "make artifacts-tar" directly in windows-build
Date:   Mon, 18 Apr 2022 18:28:53 +0200
Message-Id: <patch-v4-16.31-5458e6dab0b-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
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
2.36.0.rc2.898.gdf6bbac50ff

