Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEABC433FE
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbiEYKHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiEYKFD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC97E703C1
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:00 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 206-20020a1c02d7000000b00397345f2c6fso365559wmc.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+RORJLNVcruhzmElFkl0dR0vyiJrvvxEsEmgxzfHyc=;
        b=GzGehHhPyF5dqR5Wu7+Z22NyFxzgLZNmodDKhpiDgQebngwzaQO7zEDuI+PyvhXZLd
         LGZoygjNtEROaVX3dth42jLvMKQJx4zfmz6n5VjXd7A+l0rb/Ah9vT6jS3BFRHYoraeH
         Wrdl7ckFQHpXrp28OgT9h/80WrrD8ywDFAqzGkjoZB3sBDpFvQRKNmQvoeHB+5eDPXfC
         TKKnNdTQbLpmr6Aaw4t1CGBkntf61vaH9IvXGhtYMjB5ne64OXGB9cnnx9/Uv/BCzntV
         OEIUNtId7sjiqvvLQPRpp8x7jL7oZxWIGMUrtpkW+EzR6kW56RuGtXOLVaSKKttRGxxc
         5m1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+RORJLNVcruhzmElFkl0dR0vyiJrvvxEsEmgxzfHyc=;
        b=HENTKFGAUA27oRPmTfglt95Z/B1QMh4oB3MatmBpY7Nv4CmMElPkKCabpT/XjklONH
         UE944Ttu681+gwI3LzybcEFjMQbT357D/aG999zTcJZigT5V8Y1mxVd8IcoxsXlfhR5L
         6Zj3+3V7/uMe8w3wXauWkLsgkB/AY0SiDuP4Dbu9JUyS+70x3WidNDy6Eyhbz6DMATCw
         6hHR0DpcxQYdj7rarGcigi/7SwshnMGly0U9GWk1nADSnODAiMyq3YVR2PkER1fajaYt
         LHLTStVIxFoT4thDfKJoL72RYeLjxi+T6ZrbGsgfiZZeYMCU92jtqCYUpG1Gu6ZfwOQv
         It5Q==
X-Gm-Message-State: AOAM532uvSERXA6szKwi1wUWEDrcA/XIZKjwo1FyQzPsQQp63iZ7eS7r
        s9MU0A0Hk0WqHm+ZEAZHsu9VhDHo40MF0w==
X-Google-Smtp-Source: ABdhPJy30RbYhu7AyK1y13hfBLA+zwL91o7nBCcSJ8E3g//DUjqKYPib1dtrljlQkC12kc6qwa01Hw==
X-Received: by 2002:a05:600c:4e41:b0:397:104:b1d3 with SMTP id e1-20020a05600c4e4100b003970104b1d3mr7339156wmq.101.1653473098820;
        Wed, 25 May 2022 03:04:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:58 -0700 (PDT)
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
Subject: [PATCH v6 16/29] CI: invoke "make artifacts-tar" directly in windows-build
Date:   Wed, 25 May 2022 12:03:55 +0200
Message-Id: <patch-v6-16.29-f89346f11eb-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
index c97fbd0f0b3..ca993afd098 100644
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
2.36.1.1045.gf356b5617dd

