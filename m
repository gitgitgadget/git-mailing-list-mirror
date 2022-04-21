Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05F8C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391378AbiDUS2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391380AbiDUS1S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:27:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074FF4BB84
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so7858447wrg.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dzKGPpsweXetdh8icuSxBnF8XbGz6Oc+HLv24lUro1c=;
        b=EhOSSe4IStKkXoBVUP+gm3/Weg+pXVR0i9X0XY9gX6D0IzUBaGlJz/znGxJrxtBkFx
         N4PCoSgzcjF2sMtTwODDokhTiMLXAhEVZKdTJ0NCtbDTBWrWTSLg6WUnTPm8ekqvrCx9
         L+NsXxhVnsxFi5BWFZ1eoQWWLZ8DTUmwl5ZMrQ+jm7nAJhw5e3mQgGlSoTGiY4mmP3gq
         BeuYDJvxBzF5iLeHNXiemc11OBeFV2RzmcfWMprkljkMQR553mFhqUV0SRoXNHhT+XJE
         VT2Y+rUsFZdkVWXYWvU3QL1j6FE+rb4x4qSjST0rihpA09vtpI6CWHx4JTyPJPQ7ZfX3
         7NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dzKGPpsweXetdh8icuSxBnF8XbGz6Oc+HLv24lUro1c=;
        b=D8lKspBkPt0SsyvthEwtDMfvoYd1ENBO+JQg9P4AHKK20jyIMfVfnYQ/rDVE3yDI1R
         lz2m2tmm8lKV2royzedDC/S9WCHNSCxZCB+OKFrp5TKQOpmwpbYasd3kXpCdxGhKU46x
         R2Rut/kHn9AGkVkznSqBw08BxLI6c0Zfj5q7oWlh2GGpoVQ3e1hPGRfKnXA3Js4ZevMR
         uHtl3T/b/x/Q/KtVoArag6+3TwfOGx/e7vCZQ7KMLD/4I1zHjSXHunL79nDX38bagX6+
         3zYTFjVF5kIsaQK1epQdhK7zhllVMihDSwFUlvxqFBtaKKPxUchI0CgEb0PugZIYxcdE
         l0eg==
X-Gm-Message-State: AOAM532kgm1j6/FEvTonlkeE2br/KToYdfTvTK1vz12bEpNuMaKwnfOs
        5/zaLM8aRE/J9rMZFj7JBcZWLR9v3h9raA==
X-Google-Smtp-Source: ABdhPJxINUEVvy57XxZ3vdO0sjq9E0FhsKPXMhpYBIh8oHM6eooJ/dlj/YWvd5/t0BSOZ19Jbf2G/g==
X-Received: by 2002:a5d:6488:0:b0:203:b628:70d2 with SMTP id o8-20020a5d6488000000b00203b62870d2mr731970wri.83.1650565441224;
        Thu, 21 Apr 2022 11:24:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:24:00 -0700 (PDT)
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
Subject: [PATCH v5 27/29] CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
Date:   Thu, 21 Apr 2022 20:23:22 +0200
Message-Id: <patch-v5-27.29-50f21ffdffe-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the setting of "PYTHON_PATH=[...]" to the "$jobname" case
statement. This partially backs out of my 707d2f2fe86 (CI: use
"$runs_on_pool", not "$jobname" to select packages & config,
2021-11-23), now that we have a "osx-{clang,gcc}" anyway for setting
"$CC" we might as well do away with this part of the "$runs_on_pool"
case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index b6e7a6647bb..f2f75901a9c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -132,14 +132,6 @@ ubuntu-latest)
 
 	setenv --test GIT_TEST_HTTPD true
 	;;
-macos-latest)
-	if test "$jobname" = osx-gcc
-	then
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
-	else
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
-	fi
-	;;
 esac
 
 case "$jobname" in
@@ -195,9 +187,11 @@ linux-TEST-vars)
 	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
 	;;
 osx-gcc)
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	CC=gcc
 	;;
 osx-clang)
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
 	CC=clang
 	;;
 linux-clang)
-- 
2.36.0.879.g3659959fcca

