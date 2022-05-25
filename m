Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6E0C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbiEYKFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbiEYKFO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373526D965
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u3so29410747wrg.3
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmXO/rolLNsURpmIJrB/NpDYwTwLGCY+Fd7CvzKlmRg=;
        b=YrNczV9x+sLFKHwWfmkL22NHOoIYnGpRYOln0jLdroi3IY58DZYPwImPrTln0lDbs5
         Ib5+E/izoguEI5Uf989b4pr5eCtzoo690tkCXl3kLiZvvX5qUVsaD5NBmcpWLtggYpvh
         UOIBvRoLCJm5tB2KfTHd9yRMr6G6hQciRTcpt/ZBt61mKOu34frQUY5cxyaMG+HgMose
         O9DMyV8AI4VPsl4aX6H4n0d5JxjFJ7p1Wu04+l0gAr1/AC2FEZbabChz1gLonoDQ1Hwg
         ArZT+9EFD9y+EVsxYfIaDsaCJKdi1qrhUklZtkEJ1HLOuQoRfat7zrKtFewuaYTOMvYb
         36rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmXO/rolLNsURpmIJrB/NpDYwTwLGCY+Fd7CvzKlmRg=;
        b=x7wnl887gcoZNm7/GNHTfDy+y2O1ncMLFluzFweEXH2rjJ3/XhTCEOWPeDjgWx6kJ+
         3hhCVQg205LKTIy8YDdFfuIrgs00Hf5lpBmCdKtg0oZNR/N7eN2U2GaXmyeaRFTo2Bxv
         VYWPuPZ07Y+gYOQrzkw7Zfwxq/30RShoJHG0MmITkmdrQCCVANfffVje0cTy5yJvlG/A
         ZNXJr9UQKKBDSxxk8jax1AGIHTz1LgcDhtrVJCa7ZQyGCc6KFd+jPbCd1wK+kU3NG4sN
         ru6xQEcKz2Pj0v0rT5Yubz24HR3IJP5zevc7O458h7MyfcCXrADyXD68/wJPK2L/yh+O
         V0rQ==
X-Gm-Message-State: AOAM5316cEU+8Cq2Uz8UmXoau5BMDvCGgqwvI2yetqBSz3WLAIn24A24
        +VFx5dp2492Aq4FxZi5YRzfTMh4KTKgOEw==
X-Google-Smtp-Source: ABdhPJyVR60QlE450CMMX0PZ7ORO1C/tZHbqAxjmhMTzICiJTLYY0psQZDlb3OdjmLJkF/7dpEpviw==
X-Received: by 2002:adf:fc01:0:b0:20c:ff9a:2c53 with SMTP id i1-20020adffc01000000b0020cff9a2c53mr25988875wrr.142.1653473111403;
        Wed, 25 May 2022 03:05:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:05:10 -0700 (PDT)
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
Subject: [PATCH v6 28/29] CI: don't use "set -x" in "ci/lib.sh" output
Date:   Wed, 25 May 2022 12:04:07 +0200
Message-Id: <patch-v6-28.29-7a208927819-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "set -x" from the "ci/lib.sh" output. Before preceding
commits the logic in that file was much more complex, and likely to
fail in some scenarios.

Now we only task "ci/lib.sh" with setting various variables for
subsequent steps in our jobs, so we can start emitting more tailored
debugging output, which makes what it's doing easier to read.

This change also changes the output of the "ci/print-test-failures.sh"
script, since it's the only other user of "ci/lib-ci-type.sh". In that
case it's also helpful to know what "$CI_TYPE" we're using, as that
script doesn't "set -x" and will act differently depending on the
$CI_TYPE.

It's useful when developing this script to see what variables
it *doesn't* set, but such output isn't useful to users, so let's hide
the "SKIP" output behind a --debug option.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index f2f75901a9c..9e38c893890 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-set -ex
+set -e
 
 # Helper libraries
 . ${0%/*}/lib-ci-type.sh
@@ -7,15 +7,22 @@ set -ex
 # Parse options
 mode_build=
 mode_test=
+mode_debug=
 while test $# != 0
 do
 	case "$1" in
 	--build)
+		echo "MODE: $1" >&2
 		mode_build=t
 		;;
 	--test)
+		echo "MODE: $1" >&2
 		mode_test=t
 		;;
+	--debug)
+		echo "DEBUG: $1" >&2
+		mode_debug=t
+		;;
 	-*)
 		echo "error: invalid option: $1" >&2
 		exit 1
@@ -41,21 +48,32 @@ then
 	exit 1
 fi
 
+# Show our configuration
+echo "CONFIG: CI_TYPE=$CI_TYPE" >&2
+echo "CONFIG: jobname=$jobname" >&2
+echo "CONFIG: runs_on_pool=$runs_on_pool" >&2
+if test -n "$GITHUB_ENV"
+then
+	echo "CONFIG: GITHUB_ENV=$GITHUB_ENV" >&2
+fi
+echo >&2
+
 # Helper functions
 setenv () {
+	skip=
 	while test $# != 0
 	do
 		case "$1" in
 		--build)
 			if test -z "$mode_build"
 			then
-				return 0
+				skip=t
 			fi
 			;;
 		--test)
 			if test -z "$mode_test"
 			then
-				return 0
+				skip=t
 			fi
 			;;
 		-*)
@@ -73,10 +91,21 @@ setenv () {
 	val=$2
 	shift 2
 
+	if test -n "$skip"
+	then
+		if test -n "$mode_debug"
+		then
+			echo "SKIP: '$key=$val'" >&2
+		fi
+		return 0
+	fi
+
 	if test -n "$GITHUB_ENV"
 	then
 		echo "$key=$val" >>"$GITHUB_ENV"
 	fi
+
+	echo "SET: '$key=$val'" >&2
 }
 
 # Clear variables that may come from the outside world.
-- 
2.36.1.1045.gf356b5617dd

