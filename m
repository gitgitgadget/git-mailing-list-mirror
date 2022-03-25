Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A29C433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiCYTbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiCYTbd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:31:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2CC20C1BF
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:06:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bu29so15008294lfb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hni4kvA7GZfcyHzmeDyeZ50b2DxbfF4GyNMXf7yl5g0=;
        b=LCZVeei/xXfmB9F6dSNnU3HdbfTtr+OBNhbA7mkxGaErp/zYAV9eknpgc0IArH5QMx
         LoIDULfIfixcI1MPT1rv0Vaz7nVAmabeoQg7fjCVnsnNdQsZnIp3eG6S972k9jC7WIUe
         J6L9a8gfyOl/cwJSu7FwOmM8ih0XQ7n+3180XBLGHOUDAGHGxZekA9gmd/ZrGfEcAdOJ
         fczfESlNQ8EtAsM0Fkv1Wzk5Z8xpChSmCMM7gnkrATIgbKIXBxMLvGPvL+1VwepN+36E
         i6WZpzrkKEn7TPwAnqh5KdvomCwPyRKoHsYpAMA0VQoDwccmubo/rVTYcIcX8AePJx27
         EIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hni4kvA7GZfcyHzmeDyeZ50b2DxbfF4GyNMXf7yl5g0=;
        b=307qKhs7TKDzuFl7FzAWiteRRoaaSmv0rrDphzUfEmF4aTR7CorbFo6rehzxI4Nr96
         4XUyIvoy+1taeyjqxcAc9oREFgJITVqGv6cl/dmyj9no3nQtnygYsj5uAZ/iGwi6DdTG
         FIvBxnIaAFAGcwcdB94kWrzy7TFY3J+vE4ibnBrNl/ppfVNTjtJCBsOhWvl1PMZCtkfo
         2yo0MI+37LlXUOWBJ3eLsM70agg5AqBeQbrBcqMD0wEuCHxg0csjv3B18aPFkaEOz94n
         Ce88bME0V4o9Wi5MZ1xQXPQ3zxwmStFhJfVLI+AwqGhuVxbCSrzaZ4pJE7GwwGwA21+Q
         cTPA==
X-Gm-Message-State: AOAM5305UKxKivRlOB2dnQMFYVyP2+sJwXCQAHi6kCThX23utDDpHXsn
        JD7NsChWx2mbST4NLsyDKxLb1Y4q3dOKlg==
X-Google-Smtp-Source: ABdhPJxcuxWV9wvfXqTWaNc0e0empaRsf/kEVU3kf6oET/Jd3aUbYfaiRd0d4jDr7AiVC/5+bFAhIQ==
X-Received: by 2002:adf:eed0:0:b0:203:f2e2:197b with SMTP id a16-20020adfeed0000000b00203f2e2197bmr10817287wrp.604.1648233521410;
        Fri, 25 Mar 2022 11:38:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:40 -0700 (PDT)
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
Subject: [PATCH v2 24/25] CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
Date:   Fri, 25 Mar 2022 19:38:15 +0100
Message-Id: <patch-v2-24.25-06bf8d9f61b-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
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
index 57c9117a35a..663cbdef9d1 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -99,14 +99,6 @@ ubuntu-latest)
 
 	setenv --test GIT_TEST_HTTPD true
 	;;
-macos-latest)
-	if [ "$jobname" = osx-gcc ]
-	then
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
-	else
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
-	fi
-	;;
 esac
 
 case "$jobname" in
@@ -160,10 +152,12 @@ linux-TEST-vars)
 	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
 	;;
 osx-gcc)
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	CC=gcc
 	CC_PACKAGE=gcc-9
 	;;
 osx-clang)
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
 	CC=clang
 	;;
 linux-clang)
-- 
2.35.1.1517.g20a06c426a7

