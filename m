Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C68C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbiEYKHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241970AbiEYKFG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5856E8ED
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t6so29405000wra.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j22Ozmc3VKTxAUICVuk4RP+1HJC4qIBn0TUM1cHZmAo=;
        b=EbdB4WYhgZ6X48KMRKXMfQnyIFNvcnr+2r07iWtqfSt9Ns/n6HF40m/axnvht+MKrB
         FT6GS5Fx/6cvlIl5V6LQ7+xrc4fpdDOnxuReDTOacLeZFPYJU7G7VkpccwvmUuUUj8m6
         9zfpEocFOqoB6AhDnvji4Mb8/4rmF/YNdwBhxFQkFNsoZJzr/4ONoh1HV0wELkqR7CQV
         w75fc4RG00KIV+691aK8rJVrpSa4mg0Lj4XOWnOTPFfM9I8naiWJK9UXag2hVxIs+Pc6
         vb7MGuMTj2jAT4oIwrGwWKRPuH3+zUuVSHTer/VNTAhrvl1v8d8vmQEqUcDpefH+wD79
         6uVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j22Ozmc3VKTxAUICVuk4RP+1HJC4qIBn0TUM1cHZmAo=;
        b=nMpdWUHav7TK1OT65cPSmQSfP2/z78H6nM5SDmcddyjRMF57mDBKmTvmk1lMiMpZWI
         O6TpqucsF3gDMNjdO+RMeVAUTez254LbN3bEpbPE+zfpgHiLOjzRB6ZzD0V4yMB7t6ik
         4ACaJbIp+XrhO/sbZipy33GdDzxUkpW4XCwS/qgVPcjPUXgX7v9XRMjc/q+r6X6ResnD
         Cg00ENa57NkBYBk1IEPB3CwtP4jjmPDl1L62BAHyMBmdYyf7Evq2OVXP6T+j1KLI/9sY
         Ka8JNMPl7hAvwkibC8/pykdFpny6AVpdN2nhCK8R30tstNnBa8o1Rh/fuh9fQnUaGjzv
         3kVg==
X-Gm-Message-State: AOAM530b+sItsFKfxKTdWE6FCM/WKyy0bWnyU1pxYh8bybTWVh2eIGOu
        GQLAR3u8OZ5dWYo+Qv/anoo/BKaxANFXAg==
X-Google-Smtp-Source: ABdhPJzu8o0dZ2UWDO+0pxsVxEmIni4Sih9HeGVSc5ebJVut6VW6b849kFn4s/lOgWKPNieor2PHHQ==
X-Received: by 2002:a5d:644e:0:b0:20e:7267:9ef7 with SMTP id d14-20020a5d644e000000b0020e72679ef7mr22853544wrw.520.1653473101901;
        Wed, 25 May 2022 03:05:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:05:01 -0700 (PDT)
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
Subject: [PATCH v6 19/29] CI: move "env" definitions into ci/lib.sh
Date:   Wed, 25 May 2022 12:03:58 +0200
Message-Id: <patch-v6-19.29-b00abc07637-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Have the GitHub CI jobs use the "ci/lib".sh as a source of truth for
environment variables that affect their builds and tests. This brings
them in line with the rest of the jobs, and make it easier to see the
entire CI configuration per jobname at a glance.

To do this we need to add a ci/lib.sh "step" to the remaining jobs
that didn't have it added in preceding commits.

The Makefile parameters are luckily all accepted via the environment,
so we can export these instead of adding them to MAKEFLAGS.

Let's also use the documented GIT_CONIFG_* mechanism for setting
config instead of the internal GIT_CONFIG_PARAMETERS variable. This
adjusts code added in 889cacb6897 (ci: configure GitHub Actions for
CI/PR, 2020-04-11), we could probably use the GIT_AUTHOR_NAME etc, but
let's keep setting this via config, just with the documented
mechanism.

By setting "ARTIFACTS_DIRECTORY=artifacts" once we don't need to
repeat it in various places, let's get it from the environment
instead.

Finally, the "DEVELOPER: 1" was only needed by the "sparse" job, which
wasn't using "ci/lib.sh" (and which sets DEVELOPER=1). Let's instead
have the "sparse" job use the "ci/lib.sh" and remove DEVELOPER=1 from
".github/workflows/main.yml".

This substantially speeds up the "sparse" job, since it'll now pick up
the "--jobs" setting in MAKEFLAGS that we use everywhere else. Before
it ran in around 4m30s, now in around 2m30s.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 29 +++++++++++------------------
 ci/lib.sh                  | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 42944020436..5f167ac5be6 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -2,9 +2,6 @@ name: CI
 
 on: [push, pull_request]
 
-env:
-  DEVELOPER: 1
-
 jobs:
   ci-config:
     name: config
@@ -93,8 +90,7 @@ jobs:
       shell: bash
       env:
         HOME: ${{runner.workspace}}
-        NO_PERL: 1
-      run: . /etc/profile && make artifacts-tar ARTIFACTS_DIRECTORY=artifacts
+      run: . /etc/profile && make artifacts-tar
       if: success()
     - run: ci/check-unignored-build-artifacts.sh
       if: success()
@@ -105,7 +101,7 @@ jobs:
       uses: actions/upload-artifact@v2
       with:
         name: windows-artifacts
-        path: artifacts
+        path: ${{env.ARTIFACTS_DIRECTORY}}
   windows-test:
     name: win test
     env:
@@ -126,6 +122,8 @@ jobs:
       shell: bash
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
+    - run: ci/lib.sh
+      shell: bash
     - name: test
       shell: bash
       run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
@@ -145,9 +143,6 @@ jobs:
       jobname: vs-build
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
-    env:
-      NO_PERL: 1
-      GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
     runs-on: windows-latest
     steps:
     - uses: actions/checkout@v2
@@ -171,6 +166,8 @@ jobs:
     - name: copy dlls to root
       shell: cmd
       run: compat\vcbuild\vcpkg_copy_dlls.bat release
+    - run: ci/lib.sh
+      shell: bash
     - name: generate Visual Studio solution
       shell: bash
       run: |
@@ -181,21 +178,16 @@ jobs:
     - name: bundle artifact tar
       shell: bash
       env:
-        MSVC: 1
         VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
       run: |
-        mkdir -p artifacts &&
-        eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts NO_GETTEXT=YesPlease 2>&1 | grep ^tar)"
-    - run: ci/check-unignored-build-artifacts.sh
-      if: success()
-      shell: bash
+        eval "$(make -n artifacts-tar 2>&1 | grep -e ^mkdir -e ^tar)"
     - name: zip up tracked files
       run: git archive -o artifacts/tracked.tar.gz HEAD
     - name: upload tracked files and build artifacts
       uses: actions/upload-artifact@v2
       with:
         name: vs-artifacts
-        path: artifacts
+        path: ${{env.ARTIFACTS_DIRECTORY}}
   vs-test:
     name: win+VS test
     env:
@@ -216,10 +208,10 @@ jobs:
     - name: extract tracked files and build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
+    - run: ci/lib.sh
+      shell: bash
     - name: test
       shell: bash
-      env:
-        NO_SVN_TESTS: 1
       run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
     - name: ci/print-test-failures.sh
       if: failure()
@@ -354,6 +346,7 @@ jobs:
     - uses: actions/checkout@v2
     - name: Install other dependencies
       run: ci/install-dependencies.sh
+    - run: ci/lib.sh
     - run: make sparse
   documentation:
     name: documentation
diff --git a/ci/lib.sh b/ci/lib.sh
index 5141de85024..de61914134e 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -104,6 +104,27 @@ macos-latest)
 esac
 
 case "$jobname" in
+windows-build)
+	setenv --build NO_PERL NoThanks
+	setenv --build ARTIFACTS_DIRECTORY artifacts
+	;;
+vs-build)
+	setenv --build NO_PERL NoThanks
+	setenv --build NO_GETTEXT NoThanks
+	setenv --build ARTIFACTS_DIRECTORY artifacts
+	setenv --build INCLUDE_DLLS_IN_ARTIFACTS YesPlease
+	setenv --build MSVC YesPlease
+
+	setenv --build GIT_CONFIG_COUNT 2
+	setenv --build GIT_CONFIG_KEY_0 user.name
+	setenv --build GIT_CONFIG_VALUE_0 CI
+	setenv --build GIT_CONFIG_KEY_1 user.emailname
+	setenv --build GIT_CONFIG_VALUE_1 ci@git
+	setenv --build GIT_CONFIG_VALUE_1 ci@git
+	;;
+vs-test)
+	setenv --test NO_SVN_TESTS YesPlease
+	;;
 linux-gcc)
 	setenv --test GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME main
 	;;
-- 
2.36.1.1045.gf356b5617dd

