Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DE9C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbiDMTz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238556AbiDMTzO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:55:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F27D7B107
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id q20so1757925wmq.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXDlyatyKqavNyZNG9G6Gr1854moB/y55bDXwPw41KQ=;
        b=eCF6H0PcvfgyYL8Al2Loptb9SlQbcAlUWNQbjJRf2yuAY+MTmnYWiKKCOxEMgyJHMV
         qzas4TomXg69YEvsyG8oI+3CMu2x74Jph/uLthe8W2l21UEXcy+xDSd06Nxm/kWilWPi
         1oC6jdqcvr0Z1m2mH+utlKP3oASMBjOjpBcxA/Y2xS0pb+LkIwLvWP+l7p4lgGyhgfdF
         ocurAzJnMxeqjWDNgt1/+QiRVpCQ7OtqPZwPbtPDdZLd3Mo2cVltBGY8d50wKHqUIbq7
         b6or58Lk5h/knn4nDvdn8mDrXF9fXWn++oJDu16mskHQQeL9gXF6db1xVnBFNiyUno4S
         vV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXDlyatyKqavNyZNG9G6Gr1854moB/y55bDXwPw41KQ=;
        b=1Olle0c1gkoeZr1LSQudMnbaAtOibEWYg0P2e4EKrSe74C3EwojGqWgSm1o470GfyF
         UjzQD62MygHFpr6Of1rzLsGeQ/RCpmFQamrFzZXA1qZJd0Q82xnPc7LuM0FwVVUq1WsT
         l36oDelFN/RroDgaiR8Na2Tc70q32+ZlLMDxEETKsa3E49SHA2QpSx85PFRu6FLtSd6M
         pfCE/leXAIIDZbL0x/c1CdM2OyZ7IRhR1pwrs93o5zaXvhJOgzi79P6HKei/2bgKbiDP
         NrleKl6gPY+MkS+B5z1PM2oPYK+si9jeEFesGVPKVJEqhnTQtrm99Qyw1kr8K/0xNbdK
         pyXA==
X-Gm-Message-State: AOAM5331legjg+VKVhMUFs7xPgYtOrNwLOki4h+R++YEmgTsxZMrIXQH
        0rz7PwyPRF64tUcmrgiAzUhtcOnhxZ74jw==
X-Google-Smtp-Source: ABdhPJwK1n83pBhsliuHZ9+m9JiqfvCi8FqgwflpZWT4w+slZk6A3bC5o3hcsDzUIVxCfWp/RrLliQ==
X-Received: by 2002:a1c:e916:0:b0:37c:f44f:573 with SMTP id q22-20020a1ce916000000b0037cf44f0573mr259034wmc.179.1649879540479;
        Wed, 13 Apr 2022 12:52:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:19 -0700 (PDT)
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
Subject: [PATCH v3 27/29] CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
Date:   Wed, 13 Apr 2022 21:51:40 +0200
Message-Id: <patch-v3-27.29-0508777c68e-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
index b439c1a4f82..d62cd757ef4 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -105,14 +105,6 @@ ubuntu-latest)
 
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
@@ -170,10 +162,12 @@ linux-TEST-vars)
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
2.36.0.rc2.843.g193535c2aa7

