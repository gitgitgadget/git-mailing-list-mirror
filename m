Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FBEC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378334AbiBUOsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:48:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378340AbiBUOrt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:49 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243AF5FCF
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:12 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o34so9675276wms.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8sLgltdoLSDmb9EA6S3lYN1W6z0r8071szxt0gXE1Lw=;
        b=A678aGf0BkJTmnjOXBUx0VMYyECZbfGM4MFqFbQNYtOrO7PB4wjsTVObgGOqBrvHfM
         Q4G0D6L/D0DvYupYlCvoDqA0xMLgkDrIlTdXoHdujjU/gLn0Bzx8mCHf7yflomlX5WUA
         9wgGd39vDO/HTCYOOeGwMvy68BnjLtxqhEmmh/uA6cpbksi3i38EpyEGNeidaW+IdiUq
         iK8l3dOW2lx/uZY3Azqexfkn2qjoXOQ3Ql9gPMiKhjX6VQRUz8uDzB2p8D32iXqDDe/Y
         RojZCc/56q7j07Qkq2waJOwrSg6Bd28LpeD9lHLt+QwgOgWOnD1OqW3FYD37HbNt7X+0
         +ijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8sLgltdoLSDmb9EA6S3lYN1W6z0r8071szxt0gXE1Lw=;
        b=uRXOYa8hvUxXwdNx6NbszI9udHZG1x0DhMy1C7zrLoVmWtBXSu2MekbuWZS39RtKnM
         Kzj0dCvNOb7FB12+BLosDs6QimiJbwtZ9JQHqb6XwHRf3OsYJwbiBWxgx6JmHdtqw8of
         2Q5Emege64/EFBK44prctemFRfauxr36v2Cex3Nf8mmSsSWah4+eJXWnEmLi59ogHYMD
         ot0TSfsxO0aLxcH1pja0hZD36GtXUpglZftAczD9LTb6wfA9Rsnz/GHg5dA8q4uC4j88
         1cZtrND71K3am1UUJc0mtYkwHNRoDTJOznJF6Rt3BTptqXfEWEwx1zx8OuJhJpRL1XAg
         zhNQ==
X-Gm-Message-State: AOAM5322swIF/eBUtfV5YJjXpJahHbKykkXc0obglSeuBf2KzfWt+bRN
        C3xcHn3qkfmwH6QViwMh02virrVp8tm+iw==
X-Google-Smtp-Source: ABdhPJyMAHQ5fbL2fKQe5TD3hBOD5W6L0EK65MZUV3w8bn3nrRUv1gL8tZxPJefRmlEsdd40LgD6Qw==
X-Received: by 2002:a1c:a1c2:0:b0:37b:aa06:9c51 with SMTP id k185-20020a1ca1c2000000b0037baa069c51mr22037007wme.114.1645454830418;
        Mon, 21 Feb 2022 06:47:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:47:09 -0800 (PST)
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
Subject: [PATCH 24/25] CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
Date:   Mon, 21 Feb 2022 15:46:36 +0100
Message-Id: <patch-24.25-d7b472b4a52-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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
index 7064a17cfeb..36f79eb6a65 100755
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
2.35.1.1132.ga1fe46f8690

