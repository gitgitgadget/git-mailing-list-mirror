Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E6C433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391295AbiDUS1Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391305AbiDUS0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6532B4B423
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s25so2954813wrb.8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIwTifU4UCoJ7n13IFuUdN3lXAptchaCwfqeBAxUG7s=;
        b=KiksIpd5jkSWi3plEcWuwLbRsYzSbYgm9+GarAW5KCsnMdSOcZKavbTmYUZCBp73zM
         tLL/NL1zfK3CLPBOqxx69sAOAvcEQ+EL53YvvMU9INPoLt0fI2Io2O14CHcx97GocZE9
         jSWmIGFgHBsEoBwyqYIWcjw6rm/fueI5etHNLs44VOcTil5E3+yWvQYbePFVJ7oKPQUU
         /LSW0TjX5n0TRan0Z6FzjST9+Ghqz+ljt9S3gQoOB9iqfu+oo9VZ3NiNQBORbY8KbV/l
         rBqaUKDs3E5G8HEB6tzZMFDV7zJOvjJhQVTFUbXnXDlpGWV/hpmYaJv6NPj3v3M+WTst
         KkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIwTifU4UCoJ7n13IFuUdN3lXAptchaCwfqeBAxUG7s=;
        b=D43FBVrGcg3DDnSVO9OMRMfIa7MO7NDWR2jYyOJwLvjb+AP6IcNucxF0Yj/W0Ip/5D
         6JGWNJ81551+3VByfO9QhJ9gzrFWTcuIIU1klj68KC9gHqQj1STTjDyynE/Aupxe02Tg
         wMX9ozEJ8D2RiLjb5pjfaM2OWEzgsbHmyiTINQMfPGUoKwISIeRZrvlsCHmmQ6khTSXq
         hZZriHdXT7Clc0y5lx8Z70XUdCtcjgKMnQvo0x9f5ahEIfOhW+SIAZsHJoLUQbip7rou
         KMd7FRQ3UgEoJ9ZTzEa0cY2CBkRSEDpTo3U5sFeFwwCFEmt/3lXCZDiSnSfWHtx3DIcW
         eKkg==
X-Gm-Message-State: AOAM530BPbi80MP9ytPkIoVeiJEWYVFuqTgwapGDv5XO3u3dYICX3B20
        YnpfUprXBO3tNR3fSkrvEA1h9eA6SwqKfg==
X-Google-Smtp-Source: ABdhPJwng+LdrMXHkVwBbrI3ht2Lhds8zy/p8+lI4xW3bGNLhEzSpwNIknZJNgpJXAivUnYATguMYQ==
X-Received: by 2002:a5d:4cc8:0:b0:207:b601:3137 with SMTP id c8-20020a5d4cc8000000b00207b6013137mr735378wrt.652.1650565430473;
        Thu, 21 Apr 2022 11:23:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:49 -0700 (PDT)
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
Subject: [PATCH v5 16/29] CI: invoke "make artifacts-tar" directly in windows-build
Date:   Thu, 21 Apr 2022 20:23:11 +0200
Message-Id: <patch-v5-16.29-4d1a9f88c32-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
2.36.0.879.g3659959fcca

