Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160C1C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378361AbiBUOsg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:48:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378322AbiBUOre (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E805FAD
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v12so27530619wrv.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btrXNaHGOrikC+owGmGo2S3bcWt3gzKHX9AgoRPRXj8=;
        b=nGpzRkqNhLx0c8b26eOLOjSWv5VPPtHB5Ecc3DbV6e0mHM2RPbcZbq+MMdqxkPhP5E
         huG28IHI18J9WmlC3lxpLwA+aVeWoZmUfmCmTruVPGGcOiMx01KLAUKMPqmTteIXjU59
         odjC2uHhfwQOWcX1VjAmQddLawHq91V0n1oCuGlHyDUngP93Uas8YLngdDxBE2nJQgY7
         dMLxjP6Xn0ZP+HKCGb9z+NSJ5+D/qbu0YB4dTFQfoYHQM0wktGsKWzgF/WJKnyIzYA9G
         4GCm3tHmuyuyVO5vp7fPNkjekRw0y7zgCJDpFaQ49OUtxbKS4aaETCmiswama9DT3oK7
         H99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btrXNaHGOrikC+owGmGo2S3bcWt3gzKHX9AgoRPRXj8=;
        b=FdSRCDbmOXW/naqjjzJZJt82ByI4+W0Hs47+RMtQnGgrVLOXtIA6PoGiONk6nF0v0h
         b6tW+uKEnPdMTCVKGh6v5YSSX/zbym2+X40quWgc+OBcxJkXffV8vbfceHeu1L5h75O3
         Q/t0DOqx/j1L3Agnc5/lNScQ+m+7XCJ8l5BgJnk4oFJMMYuIxTHGsQkqEfp+rOkDS1vp
         QJw9jdK3qChIUxE+x0ypGbDwFYhZ1cRRWhiq2rEEghysshlW3vUVCgVZyqJlne0QC5F+
         8U7PBV3nw7L/kgCJptrv264X7Z/UduDrqhP8Y1Q+JctMoIknyg8oC81EgirCriR0TEeh
         YG3A==
X-Gm-Message-State: AOAM530eX0iXzFJeYe+Nl2mnAwxPEMh6bpSMab/2BNxDR3RCoBSYMwAT
        uaRjnDTS0XmCa5FHQPEFXOGFSym3J2mlRg==
X-Google-Smtp-Source: ABdhPJyDtQd1yegqjWFVquwp91VVf0QxNAtC87rqaOPCOEUf3SSQpB2wiDubbQMzxMvDywFfJoZYTA==
X-Received: by 2002:a05:6000:178d:b0:1e8:310a:5a51 with SMTP id e13-20020a056000178d00b001e8310a5a51mr15920102wrg.642.1645454828307;
        Mon, 21 Feb 2022 06:47:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:47:07 -0800 (PST)
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
Subject: [PATCH 22/25] CI: add more variables to MAKEFLAGS, except under vs-build
Date:   Mon, 21 Feb 2022 15:46:34 +0100
Message-Id: <patch-22.25-9f4c2798a82-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's clearer that "DEVELOPER" is a flag that affects the Makefile
itself in particular if it's put into "MAKEFLAGS than" if it
generically sits in the environment. Let's move both it and
"SKIP_DASHED_BUILT_INS" to "MAKEFLAGS".

We can't do this under vs-build, since that invokes cmake. Let's have
only that job set these in the environment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 367d1ee05d5..475e9f63a74 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -55,6 +55,13 @@ setenv () {
 # Clear MAKEFLAGS that may come from the outside world.
 MAKEFLAGS=
 
+# Common make and cmake build options
+DEVELOPER=1
+SKIP_DASHED_BUILT_INS=YesPlease
+
+# Use common options for "make" (cmake in "vs-build" below)
+MAKEFLAGS="DEVELOPER=$DEVELOPER SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
+
 case "$CI_TYPE" in
 github-actions)
 	CC="${CC:-gcc}"
@@ -73,10 +80,8 @@ github-actions)
 	;;
 esac
 
-setenv --build DEVELOPER 1
 setenv --test DEFAULT_TEST_TARGET prove
 setenv --test GIT_TEST_CLONE_2GB true
-setenv --build SKIP_DASHED_BUILT_INS YesPlease
 
 case "$runs_on_pool" in
 ubuntu-latest)
@@ -110,6 +115,9 @@ windows-build)
 	setenv --build ARTIFACTS_DIRECTORY artifacts
 	;;
 vs-build)
+	setenv --build DEVELOPER $DEVELOPER
+	setenv --build SKIP_DASHED_BUILT_INS $SKIP_DASHED_BUILT_INS
+
 	setenv --build NO_PERL NoThanks
 	setenv --build NO_GETTEXT NoThanks
 	setenv --build ARTIFACTS_DIRECTORY artifacts
-- 
2.35.1.1132.ga1fe46f8690

