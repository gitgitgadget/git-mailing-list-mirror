Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8323BC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378349AbiBUOsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:48:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378303AbiBUOra (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E4A6312
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m27so15712661wrb.4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8iuq08/hgZpKBlsobR/vQylO/sPOU3RAd1XaudbFbSk=;
        b=Nr7dLjCSEwwYki2a8GNaLDl9kWMLZv52fFYpl/2t2eqb/RzNSMLZahvZzv6tdZDQze
         n/4vvo0ua+xxUA7Ok2DxKGNXOauxIxL+q1pBaW8EahEccCMMDAgEBKI0yZjdrIH2VeN7
         0TftW+XpmZjLfdGB6Jy2pxBgG5PYtNWMSonb1X1clkOR/I4Cb8Rmuu9s2cSiv0CmWIEk
         gmC+54/eltO+ahzCnmDkobUC+EXq+jBISHWH2k857EVfkB4sHgmcig7WvdEsv+Xip8lx
         KW96rkSG9Krbv9dXkwtZo6GtAC4b++1NVw7lo3/Qzs61S5VDwRrVTAoRZ1OlVNoNSOlX
         OBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8iuq08/hgZpKBlsobR/vQylO/sPOU3RAd1XaudbFbSk=;
        b=Lc3QGfVqQWReqls8RKL4Rt1BLvd8tNk/kjql6gcG90SrEgKO+8Fa6/SQH8ri6+9YkC
         /aeawispq49in1Ao+4GHmK5DU7b0Vh8K+Jwy56WdJqv8CwXBVk9EFb+19SH2XRnh73kI
         YPuCU+uXJwK+qYERor1gCB1JcKTPsaIMF9YJCsnjwShS74T2P0rbMhjVW+hceNTUzyj3
         +VEXBCJJrBwIl56ewiLfSsR7w7g6NZwMPBaDE1NFiQP0QGBPOfvj7/ZGbqLfU9MqC0DR
         A2M9mXZGlJoX4PwxmcaYXbYj0OPoLcuO9vqqdLaMQq1QAKk11MK9nUNQ0HOub1C+Mo6W
         HInw==
X-Gm-Message-State: AOAM530o8CpvNYhKeqBNtbhoRJRpbxuNvnJyomHZw8n5c9NS9aTiUng+
        2rtl+lArfSgnE61Kmzja8bJPt3pu7PDRnw==
X-Google-Smtp-Source: ABdhPJy1iQ8nmacHT8ys2WiLY5QGh61fFFO4Ul3a648lObgHnUkDsyWvq2zclRZ08ekJqlngqDKiDA==
X-Received: by 2002:adf:dc90:0:b0:1e4:a5fe:9b42 with SMTP id r16-20020adfdc90000000b001e4a5fe9b42mr15977832wrj.98.1645454823588;
        Mon, 21 Feb 2022 06:47:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:47:03 -0800 (PST)
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
Subject: [PATCH 17/25] CI: move "env" definitions into ci/lib.sh
Date:   Mon, 21 Feb 2022 15:46:29 +0100
Message-Id: <patch-17.25-5d854e8ff36-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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
index 3fd3e4f873c..fe37e0f1b36 100644
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
index fc6ce4d3e04..b882849ed5d 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -95,6 +95,27 @@ macos-latest)
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
2.35.1.1132.ga1fe46f8690

