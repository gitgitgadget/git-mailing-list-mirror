Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC66C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiCYTge (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiCYTgT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:36:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B12E5192
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:09:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id o10so17237390ejd.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGcgbWXXeFd3fJYSFq7SEjDCou+YIUaGDncV22hDmNQ=;
        b=mEjp+0R1/LOzlNt+RjuUj1FW1tAaHzEWIDYYV2Lea1qzQhiLYuXoSoDYYuKztWpwqU
         PvDFkoByq33DmseL3Zh2VRn/Xro0/TBr2RQXArVKnUGjMgyZq8Qco7vTfBMaLrme4Nd8
         Sa6C66+wdIwdfKa7WjGWusHg+X/BtzXdOuDLZpvfw9EYDAI0hwYACXpnKv9rqv4v12Ej
         SsCC9qu5yj3rglX7Buw+1pEsaFLFYQ/89W3kSxeh9WFMoetYeea+c9FvKFQYS7O/0kTY
         h+oq4vjb955hn5gi8FGnz4UKdSIcPRBfyKWF7b3CfctjViLaEL4u7l38LBQYCXtG1PAu
         S20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGcgbWXXeFd3fJYSFq7SEjDCou+YIUaGDncV22hDmNQ=;
        b=Z9O6KWi5wtjcZfMqYeOiCirV0sABeVp+CmeoJGAHbLGkVw40TBxB2HHVRjgC1NXHeH
         dkv78vujvfZw5JbEIL0TjWRae5frdxil44NDK5iYwpjH2rJjglb1cQQ7pXe7z08M++WF
         Qdsdld4ucV0VxOhG+FfCE4wW1eT0g8lleYMzZCLPHESjGCxZyuZIUni9yEB4FVlSwyuM
         hjbJs+DLuRV+M+gIHwRLtd6g79i9RAHi8M6akvj3pLNqhGqRiixL/KFNtdqljDoj+Sq+
         jkrlreGSEb/56PGoUCyJkfBOdk6ykQNO+Fsl8rhIQDTrtllvNYDz3hLNC8lIE2cK3aoo
         13oA==
X-Gm-Message-State: AOAM532Rh4fTmHbMUnmhDOkGBr3L+GOe0U213Dq20KtezOVenypYPRX0
        7jrrhlxKT5BP4XXUqimKAH+V+45a5EO8cQ==
X-Google-Smtp-Source: ABdhPJwJDKpQQc4xenBI6ijByDAQXN+hwje2ASzJS5gixilG+EolV4vR6PDgO/F/5rO5iUk07WrNQw==
X-Received: by 2002:adf:f4ce:0:b0:203:fb72:8709 with SMTP id h14-20020adff4ce000000b00203fb728709mr10642284wrp.28.1648233512330;
        Fri, 25 Mar 2022 11:38:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:31 -0700 (PDT)
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
Subject: [PATCH v2 14/25] CI: invoke "make artifacts-tar" directly in windows-build
Date:   Fri, 25 Mar 2022 19:38:05 +0100
Message-Id: <patch-v2-14.25-b1b5b083389-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
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
2.35.1.1517.g20a06c426a7

