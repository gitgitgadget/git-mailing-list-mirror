Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DD2C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391353AbiDUS2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391381AbiDUS1S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:27:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F594BB8C
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y21so3716324wmi.2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fzZfrtxis8Ant9G/3l523Eo/Io6+LmmRdUb5KEOYm3U=;
        b=b53wub/vu+pDpp+hxXmae0tyfnUTIRRDHznXdF9zVLEflyiQ195Blmf8o6VUQUdVI4
         EVbXe0+QyqMBleotbFhEMtJR6gU/ToCVISSDWAskAgiu7xLxAyofFgia268ck3j2wsg1
         jZN12ASbHTGR1PdIKK/cn9dXbWcoZiyOG2KSyWcExQqJAzt7FCq+cgMYbZtszpo/O/yb
         ExkLTeC58zbBeMmBjIkTodw95HvMDKk8oqe/qoPzBPMk4Nx/AFYduDRmsH3HUBis+w1Y
         tX8/zp9c91XVJ7GQvmDTKpcaSRwqPYUMoApmsUmHKZ+OWWZWFiRX3QwI087e9ZCUvIKm
         fOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fzZfrtxis8Ant9G/3l523Eo/Io6+LmmRdUb5KEOYm3U=;
        b=un/CIG11ioLX1xm365IYwy+u7THVoHjljzC1rW6aW2XzE9Q56q+vH6O6BuVwLGMGJE
         9VgnrvPuBBsOQMxDpEplDQXHa2H+QANWpr2/pGDrM/X/jJM1hFI0FT8IHluq4SYquG0C
         qkDrphdyFaVXTQUrC/aqHjOu4YgE/p6Fd29gGgXZWdmVFM8i/MEVRhP3dWDmpBQqXpOg
         qPU2oofwoY8Fx99CyCC5ZV4FG3UjJc0kD8FK3r2CeExca5pL3WFqJVGk0NRYvfTapu84
         Pdp0oq+fprza9XZea6fStHNKe6sVtztN3Q56+s/FUMYsIBjsyUb4uIdk64W5E4j/eZ1v
         yhgA==
X-Gm-Message-State: AOAM5307Fjsivezsu62VAeuRL0rVHY7jijgh0Gli2qByMwdvhra6rW6k
        D81IvQCyMR5c9xvBzyEvJL/kqPu4G3tKwQ==
X-Google-Smtp-Source: ABdhPJyGYnt+BKEIWnqjBl87onruYjaNvbYgrOdJ0ySHnfFQmRzSc1hoIfbXXDUlfxGc7CC/ZXAhEQ==
X-Received: by 2002:a05:600c:6020:b0:38e:c006:f55f with SMTP id az32-20020a05600c602000b0038ec006f55fmr552007wmb.123.1650565442294;
        Thu, 21 Apr 2022 11:24:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:24:01 -0700 (PDT)
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
Subject: [PATCH v5 28/29] CI: don't use "set -x" in "ci/lib.sh" output
Date:   Thu, 21 Apr 2022 20:23:23 +0200
Message-Id: <patch-v5-28.29-e35dff2bef3-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
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
2.36.0.879.g3659959fcca

