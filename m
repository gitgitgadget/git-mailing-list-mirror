Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB54FC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiDMTzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiDMTzP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:55:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05157B545
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id x3so1745729wmj.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IumLz8zjxTQlcfRdQHq8uFmPHRTJczvPdPUKXWE7Nyo=;
        b=dn1QVVHvOEukJmmOZ9KlW14gntWtVqF2o7dFRrwT9Iq87qdVh0QduHREV87PEJJvfY
         dBPYlNLZK7lAZ/pMsJEXaeh2MEnr8k/u8nqMv7CKHPmD5JeL7fyUZMA39vvFYyw+OY3P
         5/ZXX4bUVWdbm2MV/Q+W+jx7eJgrr6FkMmP9XFg5zBNwhvNscG0bggGy9o/Npn1u/rHB
         JOVn3TbU28hi84RyGi6t4WtS5fDOMjiURqI9bsy5Uwh550fbWAlcFB1USD6RnEW4dmTt
         XfBOpZIJsMwIIwPIedRFcZFFY3Ehz3XsBVvnyedi3+N828INhUAlpiGSIu1ujZqCPHsC
         6BIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IumLz8zjxTQlcfRdQHq8uFmPHRTJczvPdPUKXWE7Nyo=;
        b=VU70AYrsNEe+r9sGD8POYLyq4A4vADlSDVs3hr4ViIgy+wbM/sugQF1jdMv4FZJZSi
         HWZ0NZNq5EQWKfGTWwwzW2Zq2mAKCvFAB0jj3t3W5qWieOUq4hS+ddWYJte51aMGPyk7
         lzXopXd5BSYPy4jLmI0AT4Be857YXyLuQVXiGLU5Rf5QmzYuA2/Uiz/Qn/PTIShxLSm8
         G0apGk72At+clz9ZhaTsrad0fWr5EsgKpJZTiAgrJt89mbb66e2Asa+bBiu1E2nbtu5x
         7kbuxofNKes4qJ3ehZPvlZhK6hFeLNMWJp1jbuv+8z6OV+A/m4YlHd2Khz1Ofk8XeUPq
         Qd6w==
X-Gm-Message-State: AOAM532BVhbh7Krwf1EUoz1LgL4M2DkBKARemCHGS4IV2U4Ur+GRII/Z
        5kEyAxHy2/dL96QH4MTrmJsdFjjnO1rqhw==
X-Google-Smtp-Source: ABdhPJy27FRXpU1n2VCyaFOkW6FHv4dfHdh0s2c8N35g9Icf0nNPw1q+4C1X5l4cF5BE2RmqAdAQzw==
X-Received: by 2002:a05:600c:3547:b0:38c:ac1c:53e9 with SMTP id i7-20020a05600c354700b0038cac1c53e9mr256766wmq.159.1649879542272;
        Wed, 13 Apr 2022 12:52:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:21 -0700 (PDT)
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
Subject: [PATCH v3 29/29] CI: make it easy to use ci/*.sh outside of CI
Date:   Wed, 13 Apr 2022 21:51:42 +0200
Message-Id: <patch-v3-29.29-2e3c02fa0df-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits the ci/.sh scripts have lost most of their
CI-specific assumptions. Let's go even further and explicitly support
running ci/lib.sh outside of CI.

This was possible before by faking up enough CI-specific variables,
but as shown in the new "help" output being added here using the
ci/lib.sh to provide "CI-like" has now become trivial.

The ci/print-test-failures.sh scripts can now be used outside of CI as
well, the only GitHub CI-specific part is now guarded by a check that
we'll pass if outside of GitHub CI.

There's also a special-case here to not clobber $MAKEFLAGS in the
environment if we're outside of CI, in case the user has e.g. "jN" or
other flags to "make" that they'd prefer configured already.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib-ci-type.sh         |  3 --
 ci/lib.sh                 | 61 ++++++++++++++++++++++++++++++++++++---
 ci/print-test-failures.sh | 11 ++-----
 3 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/ci/lib-ci-type.sh b/ci/lib-ci-type.sh
index 6f01fd9e5d9..09acab7aaec 100644
--- a/ci/lib-ci-type.sh
+++ b/ci/lib-ci-type.sh
@@ -3,7 +3,4 @@
 if test "$GITHUB_ACTIONS" = "true"
 then
 	CI_TYPE=github-actions
-else
-	echo "Could not identify CI type" >&2
-	exit 1
 fi
diff --git a/ci/lib.sh b/ci/lib.sh
index 94f83069884..3fd5291bc80 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,6 +1,30 @@
 #!/bin/sh
 set -e
 
+#  Usage
+CI_TYPE_HELP_COMMANDS='
+	# run "make all test" like the "linux-leaks" job
+	(eval $(jobname=linux-leaks ci/lib.sh --all) && make test)
+
+	# run "make all test" like the "linux-musl" job
+	(eval $(jobname=linux-musl ci/lib.sh --all) && make test)
+
+	# run "make test" like the "linux-TEST-vars" job (uses various GIT_TEST_* modes)
+	make && (eval $(jobname=linux-TEST-vars ci/lib.sh --test) && make test)
+
+	# run "make test" like the "linux-sha256" job
+	make && (eval $(jobname=linux-sha256 ci/lib.sh --test) && make test)
+'
+
+CI_TYPE_HELP="
+running $0 outside of CI? You can use ci/lib.sh to set up your
+environment like a given CI job. E.g.:
+$CI_TYPE_HELP_COMMANDS
+
+note that some of these (e.g. the linux-musl one) may not work as
+expected due to the CI job configuring a platform that may not match
+yours."
+
 # Helper libraries
 . ${0%/*}/lib-ci-type.sh
 
@@ -9,6 +33,10 @@ mode=$1
 if test -z "$mode"
 then
 	echo "need a $0 mode, e.g. --build or --test" >&2
+	if test -z "$CI_TYPE"
+	then
+		echo "$CI_TYPE_HELP" >&2
+	fi
 	exit 1
 fi
 
@@ -35,7 +63,7 @@ setenv () {
 	do
 		case "$1" in
 		--build | --test)
-			if test "$1" != "$mode"
+			if test "$1" != "$mode" && test "$mode" != "--all"
 			then
 				skip=t
 			fi
@@ -65,6 +93,10 @@ setenv () {
 	if test -n "$GITHUB_ENV"
 	then
 		echo "$key=$val" >>"$GITHUB_ENV"
+	elif test -z "$CI_TYPE"
+	then
+		echo "$key=\"$val\""
+		echo "export $key"
 	fi
 
 	echo "SET: '$key=$val'" >&2
@@ -76,10 +108,29 @@ CC_PACKAGE=
 
 # How many jobs to run in parallel?
 NPROC=10
+case "$CI_TYPE" in
+'')
+	if command -v nproc >/dev/null
+	then
+		NPROC=$(nproc)
+	else
+		NPROC=1
+	fi
+
+	if test -n "$MAKEFLAGS"
+	then
+		COMMON_MAKEFLAGS="$MAKEFLAGS"
+	else
+		COMMON_MAKEFLAGS=--jobs=$NPROC
+	fi
+	;;
+*)
+	# For "--test" we carry the MAKEFLAGS over from earlier steps, except
+	# in stand-alone jobs which will use $COMMON_MAKEFLAGS.
+	COMMON_MAKEFLAGS=--jobs=$NPROC
+	;;
+esac
 
-# For "--test" we carry the MAKEFLAGS over from earlier steps, except
-# in stand-alone jobs which will use $COMMON_MAKEFLAGS.
-COMMON_MAKEFLAGS=--jobs=$NPROC
 
 # Clear MAKEFLAGS that may come from the outside world.
 MAKEFLAGS=$COMMON_MAKEFLAGS
@@ -99,6 +150,8 @@ github-actions)
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 	setenv --test GIT_TEST_OPTS "$GIT_TEST_OPTS"
 	;;
+'')
+	;;
 *)
 	echo "Unhandled CI type: $CI_TYPE" >&2
 	exit 1
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 2405f65650a..ba8428ad484 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -38,19 +38,14 @@ do
 		test_name="${TEST_EXIT%.exit}"
 		test_name="${test_name##*/}"
 		trash_dir="trash directory.$test_name"
-		case "$CI_TYPE" in
-		github-actions)
+		if test "$CI_TYPE" = "github-actions"
+		then
 			mkdir -p failed-test-artifacts
 			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
 			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
 			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
 			continue
-			;;
-		*)
-			echo "Unhandled CI type: $CI_TYPE" >&2
-			exit 1
-			;;
-		esac
+		fi
 		trash_tgz_b64="trash.$test_name.base64"
 		if [ -d "$trash_dir" ]
 		then
-- 
2.36.0.rc2.843.g193535c2aa7

