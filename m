Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0EAC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbiEYKEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiEYKEq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E216D4EB
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z15so5563734wrg.11
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mGq2G6LCbUodDDDwZ4xSVV0PavCX1b3/qP5KUC2Weu4=;
        b=RpdrqbBPnX0zYisRHTJi/uH6COpOZV3KQu1wBGfqL0In80IkQ8C6+dLVjLgh9hTEKm
         1pncBXG/s7+rwiIvxBSVq8Fkz5z0JMwGvn/iqJ7Xjut/ajT32tmOfxQbISyQRxLBdwpT
         11xiDInGX5vIyjAn5r7densGrIWDxcQ0cjxd5aCbxbbevrZiiFz2qIzzbQ3hxskiCHht
         iOc7Vq95IabBHkeECdfzaLV7AamglrtC5t49YVsnikiAo6DgwL5LqzFYMBmEOVXuXSQE
         vZ2YMCmAGPJj1Jpa2kWVZaQYzXNZQCLzCHEEXeovjs0FD/GI7VtRn18mV07HMEzoGkv+
         kHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGq2G6LCbUodDDDwZ4xSVV0PavCX1b3/qP5KUC2Weu4=;
        b=aeQ5XETs4iToCpVQtEP6nD/bK1uAjPWQ7DGn1t2w4xOg4a/+YXHbZzTfAAou85KDRG
         0xiz0hBOVNpsY1TQ0XyQUdUvGKem6WnM0roMzgu4UwdSbNxbeUMefwyuHxY3hBDQufW6
         JHfOPeN7xBJBzy9vgzt7wKVZRrPOAzRN7YBaCTXgaSbW7YWwmU8oWzDlqHX7HVfferJw
         pcuugs7yrCidOJLL+HwT6+BLJWpBNpPU+RJOqCDPdm7zZvUyyIAXWvi5MT/084v2W66E
         JByFbP/cE7O5sAwOETxs09G9rKxpyT+tDyJ9mP0AXUn4TzvTuq1AKl1hi5hHXomJIGnJ
         uz+A==
X-Gm-Message-State: AOAM5337SiX8FWxfqogS2hCqxPT4FJEvA1payRtViZeIfRAHECpwpxRx
        HkBZPRCfBvRW673vopGcwb3kBrUdnKHSDA==
X-Google-Smtp-Source: ABdhPJz9fTNqjQgOLh86xBvf83gbOLfieVCzIjlf5A4dVlbZJPXsE/ATLBEBTT4r4FDmTeyI266Ggg==
X-Received: by 2002:adf:d1e9:0:b0:20f:d6b4:56a9 with SMTP id g9-20020adfd1e9000000b0020fd6b456a9mr13004488wrd.169.1653473083803;
        Wed, 25 May 2022 03:04:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:43 -0700 (PDT)
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
Subject: [PATCH v6 02/29] CI: make "$jobname" explicit, remove fallback
Date:   Wed, 25 May 2022 12:03:41 +0200
Message-Id: <patch-v6-02.29-1be7910c728-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the $jobname fallback last adjusted in b011fabd6e0 (ci/lib.sh:
encapsulate Travis-specific things, 2019-01-27).

This makes all of our CI jobs have an explicit $jobname, and removes
the special-case of the Windows jobs implicitly setting one (that they
don't currently use). In subsequent commits we'll use this new
$jobname explicitly.

This is a follow-up to my 25715419bf4 (CI: don't run "make test" twice
in one job, 2021-11-23), since then all the jobs except the Windows
jobs have had an explicit $jobname.

In the case of the Windows jobs we were using a jobname of windows-gcc
for both, due to picking "gcc" as a default fallback for "$CC" in
ci/lib.sh.

Since we'll need this to run ci/lib.sh it makes sense to move the
check to the top of the file. Subsequent commits will add more such
assertions to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .github/workflows/main.yml |  8 ++++++++
 ci/lib.sh                  | 12 +++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c35200defb9..309b9141249 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -79,6 +79,8 @@ jobs:
 
   windows-build:
     name: win build
+    env:
+      jobname: windows-build
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     runs-on: windows-latest
@@ -100,6 +102,8 @@ jobs:
         path: artifacts
   windows-test:
     name: win test
+    env:
+      jobname: windows-test
     runs-on: windows-latest
     needs: [windows-build]
     strategy:
@@ -131,6 +135,8 @@ jobs:
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   vs-build:
     name: win+VS build
+    env:
+      jobname: vs-build
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
     env:
@@ -183,6 +189,8 @@ jobs:
         path: artifacts
   vs-test:
     name: win+VS test
+    env:
+      jobname: vs-test
     runs-on: windows-latest
     needs: vs-build
     strategy:
diff --git a/ci/lib.sh b/ci/lib.sh
index 57121dd664a..3061de96d8f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -6,6 +6,13 @@
 # and installing dependencies.
 set -ex
 
+# Starting assertions
+if test -z "$jobname"
+then
+	echo "error: must set a CI jobname in the environment" >&2
+	exit 1
+fi
+
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
@@ -146,11 +153,6 @@ test -n "${DONT_SKIP_TAGS-}" ||
 skip_branch_tip_with_tag
 skip_good_tree
 
-if test -z "$jobname"
-then
-	jobname="$CI_OS_NAME-$CC"
-fi
-
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
 export GIT_TEST_CLONE_2GB=true
-- 
2.36.1.1045.gf356b5617dd

