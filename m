Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA48CC4321E
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiCYTka (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbiCYTjy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:39:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E31546B8
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:12:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r204-20020a1c44d5000000b0038ccb70e239so141691wma.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9dV7fr/jgaSG9b9aqnDQmgcdirx2MCayz5KXa/4his=;
        b=WxIkDQKVV2Wh1iqNzs/T/LxsC5vm4Kliz/3ZiqRS338iOhevbDBWLp8NHRAo32zPAQ
         xWJdnIsLI6TECRnjvWFMrKi7zm2XYT1c0VBX79cWy1d/qHgPlQ14wzVna6mWDpRSc2v4
         LJED+SAl1tvKnoDOdPm89ZvME+lkh/Y52bKTAaE/otCVyKUc8xSimEkpTo3Z9gESJKle
         3A65FnZ92nTdNwVYoeuA7xEieIGzMGa91CabRKWrLIWOVuG20pOUp96ut8RaLUsjhOR/
         u1I+bsyulRwyUxw7L6TN0kvcCq/PrqkLnbVyG9J3NfR7Of+POlmz0zPv3jt5zyVkYW9C
         xgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9dV7fr/jgaSG9b9aqnDQmgcdirx2MCayz5KXa/4his=;
        b=Q2+f7HvsZUeUZCOeBTLqXSLImhxU+x9HF9fLK8Z2f2AwMTQYfsAzpJlgp3QDbleJNQ
         ny7+hVdzuZGvczVqwCfpY/RGiNtMmPxnd86iHbBGzLcbaB5oV6Gv6phUGzwbPetTIw/H
         LfxbRD9ojgIR78CgtP6IXTW4IfryrZlcUIHEqmCMwlWFJmclwR8vSOTI/xpkewyc79xN
         LJ8tPEoMYa6JfXxQ3ziTjHJmtMihmd4/UXcxUpHJ2o8tB6ykSwX98UxlVju0RTTECMng
         EOISjx8Hx++0sekLd2jjeHa6fzIoiyoq6UzoeTjkengbH4/9OwbxBmEJP5oEmE/7VYTv
         wsOg==
X-Gm-Message-State: AOAM533X2gdDNc4YA9qvu4WecoYoFoMEZAOnJ64fHVEyHYLZ/YOlTdq/
        SLiFz9pm0WiG3x08+DlsGyy5nMNe8QA7WA==
X-Google-Smtp-Source: ABdhPJwt6UdTieG2YzYF1bx+ew0drWS4yZ5dMo/3PPlyUnYmK1G8PVECmiFPk7DwdVkjtHY3vq8JCQ==
X-Received: by 2002:a05:600c:4ec8:b0:38c:90fb:d3bf with SMTP id g8-20020a05600c4ec800b0038c90fbd3bfmr11230760wmq.0.1648233518619;
        Fri, 25 Mar 2022 11:38:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:38 -0700 (PDT)
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
Subject: [PATCH v2 21/25] CI: narrow down variable definitions in --build and --test
Date:   Fri, 25 Mar 2022 19:38:12 +0100
Message-Id: <patch-v2-21.25-44e3ace5fbe-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a preceding step the "setvar" function was made to take a
"--build", "--test" or "--all" argument to indicate where the
variables it sets were used.

Let's make use of that by having the relevant parts of
".github/workflows/main.yml" invoke "ci/lib.sh" with those options.

By doing this the set of variables shown in build-only steps will be
fewer, which makes diagnosing anything going on there easier, as we
won't have to look at a deluge of e.g. GIT_TEST_* variables.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml | 20 +++++++++++---------
 ci/lib.sh                  | 17 +++++++++++++++++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 1e13718b989..0787cadc76b 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -84,7 +84,7 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
       shell: bash
     - name: build
       shell: bash
@@ -122,7 +122,7 @@ jobs:
       shell: bash
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
-    - run: ci/lib.sh
+    - run: ci/lib.sh --test
       shell: bash
     - name: select tests
       run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
@@ -169,7 +169,7 @@ jobs:
     - name: copy dlls to root
       shell: cmd
       run: compat\vcbuild\vcpkg_copy_dlls.bat release
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
       shell: bash
     - name: generate Visual Studio solution
       shell: bash
@@ -211,7 +211,7 @@ jobs:
     - name: extract tracked files and build artifacts
       shell: bash
       run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
-    - run: ci/lib.sh
+    - run: ci/lib.sh --test
       shell: bash
     - name: select tests
       run: . /etc/profile && ci/select-test-slice.sh ${{matrix.nr}} 10
@@ -275,8 +275,9 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make
+    - run: ci/lib.sh --test
     - run: make test
       if: success()
     - run: ci/print-test-failures.sh
@@ -310,8 +311,9 @@ jobs:
     steps:
     - uses: actions/checkout@v1
     - run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make
+    - run: ci/lib.sh --test
     - run: make test
       if: success() && matrix.vector.skip-tests != 'no'
     - run: ci/print-test-failures.sh
@@ -331,7 +333,7 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make ci-static-analysis
   sparse:
     needs: ci-config
@@ -352,7 +354,7 @@ jobs:
     - uses: actions/checkout@v2
     - name: Install other dependencies
       run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make sparse
   documentation:
     name: documentation
@@ -364,7 +366,7 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
-    - run: ci/lib.sh
+    - run: ci/lib.sh --build
     - run: make check-docs
     - run: "make doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)"
       shell: bash
diff --git a/ci/lib.sh b/ci/lib.sh
index 5eadc96de29..367d1ee05d5 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -5,6 +5,13 @@ set -ex
 . ${0%/*}/lib-ci-type.sh
 
 # Starting assertions
+mode=$1
+if test -z "$mode"
+then
+	echo "need a $0 mode, e.g. --build or --test"
+	exit 1
+fi
+
 if test -z "$jobname"
 then
 	echo "must set a CI jobname" >&2
@@ -13,9 +20,14 @@ fi
 
 # Helper functions
 setenv () {
+	skip=
 	varmode=
 	case "$1" in
 	--*)
+		if test "$1" != "$mode" && test "$1" != "--all"
+		then
+			skip=t
+		fi
 		varmode=$1
 		shift
 		;;
@@ -25,6 +37,11 @@ setenv () {
 	val=$2
 	shift 2
 
+	if test -n "$skip"
+	then
+		return 0
+	fi
+
 	if test -n "$GITHUB_ENV"
 	then
 		echo "$key=$val" >>"$GITHUB_ENV"
-- 
2.35.1.1517.g20a06c426a7

