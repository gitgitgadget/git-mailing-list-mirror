Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0E3C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378359AbiBUOsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:48:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378308AbiBUOrc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162665FA8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v12so27530552wrv.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9t4ZR/XM6WuDOTGpvUba9iAvgSF5eJXl8U9AFZQJ59w=;
        b=YNb+SC86CrvxOhw08ZNBloJ9pOUEblIVphJnUIvCN3QTXJYAtplkNq+GAdD4/61THO
         nhvafzuIEgDGizHZt/QGFFhAGtgi2llztAXgJ7WTgF8CUfSEAHl2A7kjOV7R0UT36UAb
         1JbMiTcGQxOFt0NmkRJ73g04biXCMEHrSIM+FDOw5MxnpU3HmUFm4Nclnnt8CAobAmcN
         qyc00Xq4opR60VbnfYU2RNyqlSH+IwJU4xy/rE4K1pVXFTqt29K4j5DI9R4IimplHSlY
         F6mF0j7fPzAXIqhCHt9Rel4VVQWAsUv7gE2VrbhlAMliuHoWeokuMvOQr2rIBBdpCPKI
         FDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9t4ZR/XM6WuDOTGpvUba9iAvgSF5eJXl8U9AFZQJ59w=;
        b=Anag4ArM+wIn067wSn3qb6QEaNXlg4y2YqBqiRk0VsWwOFbcVBgnliisgw1EVt4Ftd
         nhQnp9KaaVkSCaXAGOnYr8A8svtrc/kU4PKqDo5owGL3iqVg4NioMkjiQBTSK1k/9okH
         D5BzISYZy9+12DvYJcCbTpDzpXdsWP94cGOxzxoWMp133GeYUqvabmfsHYwEu3E3yVgD
         4OJMVacTsxZGMlPNMayQ+pQtDnk/vWffc/l64dUHbd1AzNNl+vyNTj2P/PL9/5/3e/p8
         dlJfbsa9J00ZMMVlurq7ml1J6GAxzxUByMfm3vquKLp99HjYOh89qLQwaZQt3Rev/tG/
         3n/A==
X-Gm-Message-State: AOAM532LsBGmQkk5DjyqTZ8Yo2oWllQdiKGQETC5/5bxnb+GjW/nQ8h/
        IabxwaSvtA32HZPBJiqVRRRumQMX2z0apQ==
X-Google-Smtp-Source: ABdhPJyigpZio2J5IReMh5R8iGVxfSR/SlQ4ypg5omUSIr0Suzey9dD1Y4caqRLt/u+0+aCZDftPaw==
X-Received: by 2002:adf:9141:0:b0:1e3:1379:4cc6 with SMTP id j59-20020adf9141000000b001e313794cc6mr16210512wrj.249.1645454827410;
        Mon, 21 Feb 2022 06:47:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:47:06 -0800 (PST)
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
Subject: [PATCH 21/25] CI: narrow down variable definitions in --build and --test
Date:   Mon, 21 Feb 2022 15:46:33 +0100
Message-Id: <patch-21.25-abf9c504740-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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
2.35.1.1132.ga1fe46f8690

