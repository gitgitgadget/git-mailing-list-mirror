Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10CAC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbiEYKF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242153AbiEYKFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C476B6D94A
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso2270460wmq.1
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBl2S8ZK0TYIowZNmFyVVner8SL3mzEtlRBS7yrc8L0=;
        b=XnfKJ236G1bP6iymelT+eHiAEymL8hZlt1fZfrHBWe8dvPgSLAMzZCd3w8hPfdE9ZR
         H4uyAeL1ganLQ/aOedmqEZvnnZtL4KQCgnzF7vduKgqMQwA+GEPYUj0nLALyFjH6p1Q0
         P9Vu6vnIM9U77+dsiwguXjFpBe1eiC4d3TcV3ZaqtnngXOVWrlKjvG4KHC0SevzNF9dU
         yUD7l9ELtY1OIDMFhcA0nlFBYEsm822w2zEhahYA62E52tBerK5d18T4NCQl11KxWS6o
         49SiXiRItzlzw6pAvSlXiaXwffsfmXC2AcpnmQFyj5+omLTdBFx7aJJH5ZmHQBazjgUM
         pJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBl2S8ZK0TYIowZNmFyVVner8SL3mzEtlRBS7yrc8L0=;
        b=HuN2SVlz7KeckZGo7HVXpBPt+YShBr1D864fWVpXV9w5z7Dm3WY8eY+XrEqEiSs1Rh
         LRiNIUn5F935PDLvpnjqq9ErGRmlol+Aktgzu87XvSqf8MIVUFNuZ0LtSH0GH/REmk8A
         TeuALpO5a39EAPazC/DoIb/Ar9gvmTgjtWntLm03TjyW0QujTa0nEQ3xkl1Yyrnp1K+d
         jKGcNqt54VfUnD3Gem/4MAglbE52lXdBr98LxM7uDf6ut+V5TDZEBz9m6UF4XH0kYQod
         eWQco1aOli/ztD2mS4Ryb7RtoSglO/NRiEQteo713MIcbTHu2q4Xq4yIcPLKChysdQEr
         uqtA==
X-Gm-Message-State: AOAM532O9FNP40i4EcoO1vYwmhDkO3GLsT1ceiHAMhY70pLE7uneN7Ll
        /ZRj5FXml4k9hNpaTXWrHN8k+5rXPVlyzg==
X-Google-Smtp-Source: ABdhPJyjV2e2wrWU058Db/5b68BfszOZpBBVF5hsZWA0F6EcMAFt9tKX2S9JHAf01tLMwBs1C1h4Cw==
X-Received: by 2002:a7b:cf11:0:b0:397:33e3:87b2 with SMTP id l17-20020a7bcf11000000b0039733e387b2mr7411768wmg.152.1653473107148;
        Wed, 25 May 2022 03:05:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:05:06 -0700 (PDT)
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
Subject: [PATCH v6 24/29] CI: add more variables to MAKEFLAGS, except under vs-build
Date:   Wed, 25 May 2022 12:04:03 +0200
Message-Id: <patch-v6-24.29-c6f47d52823-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
index 96919882c11..16bac966d76 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -89,6 +89,13 @@ COMMON_MAKEFLAGS=--jobs=$NPROC
 # Clear MAKEFLAGS that may come from the outside world.
 MAKEFLAGS=$COMMON_MAKEFLAGS
 
+# Use common options for "make" (cmake in "vs-build" below uses the
+# intermediate variables directly)
+DEVELOPER=1
+MAKEFLAGS="$MAKEFLAGS DEVELOPER=$DEVELOPER"
+SKIP_DASHED_BUILT_INS=YesPlease
+MAKEFLAGS="$MAKEFLAGS SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
+
 case "$CI_TYPE" in
 github-actions)
 	CC="${CC_PACKAGE:-${CC:-gcc}}"
@@ -105,10 +112,8 @@ github-actions)
 	;;
 esac
 
-setenv --build DEVELOPER 1
 setenv --test DEFAULT_TEST_TARGET prove
 setenv --test GIT_TEST_CLONE_2GB true
-setenv --build SKIP_DASHED_BUILT_INS YesPlease
 
 case "$runs_on_pool" in
 ubuntu-latest)
@@ -145,6 +150,9 @@ windows-test)
 	setenv --test MAKEFLAGS "$COMMON_MAKEFLAGS"
 	;;
 vs-build)
+	setenv --build DEVELOPER $DEVELOPER
+	setenv --build SKIP_DASHED_BUILT_INS $SKIP_DASHED_BUILT_INS
+
 	setenv --build NO_PERL NoThanks
 	setenv --build NO_GETTEXT NoThanks
 	setenv --build ARTIFACTS_DIRECTORY artifacts
-- 
2.36.1.1045.gf356b5617dd

