Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7188AC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241932AbiEYKFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbiEYKEw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4616D6D94A
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p10so10760695wrg.12
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSj37EzJPLuDRfP7HEYqYWfn15WSak6aOwmxzbPZScs=;
        b=GNKhmju+fsuA9uS/tOk4E4oEuxPHVPBQ4s43KGDiqgI0AX7Dhs9cOs5fvf8JOAr3AG
         OV8sjyKevLfZo1542iTRZYVS5W1Z7vu4fPwyw7bX07kY3FxyOgY3jK3613xcv0C5+ePH
         8t54SgtiPBQosFJ6QB9ltULz7f50Q/CmUiMgpo70k5enRs5CIRqTq2E/OCPWSCdWA93i
         /QA2NKm1bftFNn6ihDHe3KD4nUwgYVPqeplgbQep1pvb8TKPWzb07gtpGycttgijyOUo
         I0JcR4rNrPqrp89i16kMhNvlHR6IKx2PA4y/GII6KGIRFt3QeEozy8sRUJIJbCPHEEmY
         JtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSj37EzJPLuDRfP7HEYqYWfn15WSak6aOwmxzbPZScs=;
        b=41AuVZTk4cMemEgFSA4LZ2iRrCcvN1W1OfJ8BHnfQm07YJ94mG98dArzD/SJkRPLrT
         MsDT88NfaFJ1dSzukQVBH3yoIoNsZEo7sC0yuDvqP3Rud5wvLl4s2WhiM/8/DZZXpYFl
         /zwkI9fTU3PrY/iUuqVUWrPiQRfCI9ZBQlmgYZftE2NucgPJgkp6r+i+3Oj83gmO1CVe
         2oQWS4a9bmsxTaGBKSbUOAzgLv7yTLYfIQCw/+Ex21Y6IGO8+b7HD/FgutoAmpV8T0F/
         QZDEJ2fr33jkql6JpKhdgNHW/Vz7Khy2SmHFKE4Wt5uhG2EQ8Sg1jTImwviJQ/C7BRuN
         egyw==
X-Gm-Message-State: AOAM532XfcRELtZwYLe3oFvDq9Av83YAE851bmESpsML+e+ZDIfIYoQf
        dG6W9iEiU9UAE2wZPntKoaDMQ3/o0Y+Hfg==
X-Google-Smtp-Source: ABdhPJzCD8J2rkS86payY+olU1jL5WM8V3Dcp7Gw53PCA3cOGCZDAfJD2FRSSrYQCalDKcv4BRF+3Q==
X-Received: by 2002:a5d:5641:0:b0:20d:c15:1b33 with SMTP id j1-20020a5d5641000000b0020d0c151b33mr25646195wrw.66.1653473088305;
        Wed, 25 May 2022 03:04:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:47 -0700 (PDT)
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
Subject: [PATCH v6 06/29] CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
Date:   Wed, 25 May 2022 12:03:45 +0200
Message-Id: <patch-v6-06.29-d96333c1bd8-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a8c51f77d16 (ci: clear and mark MAKEFLAGS exported just once,
2019-02-07) the assignment of MAKEFLAGS was done up-front to
future-proof this code for the bug fixed in 406f93ae488 (ci: make sure
we build Git parallel, 2019-02-07).

But since 4a6e4b96026 (CI: remove Travis CI support, 2021-11-23) the
--jobs=10 has been an invariant here, so let's assign --jobs=$NPROC to
the MAKEFLAGS right away, this gets rid of the leading whitespace from
the $MAKEFLAGS variable, as it would previously be empty on the first
assignment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index ebb9461ff42..5f95f55a147 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -26,17 +26,19 @@ check_unignored_build_artifacts ()
 # GitHub Action doesn't set TERM, which is required by tput
 export TERM=${TERM:-dumb}
 
+# How many jobs to run in parallel?
+NPROC=10
+
 # Clear MAKEFLAGS that may come from the outside world.
-export MAKEFLAGS=
+export MAKEFLAGS=--jobs=$NPROC
 
 if test "$GITHUB_ACTIONS" = "true"
 then
 	CI_TYPE=github-actions
 	CC="${CC_PACKAGE:-${CC:-gcc}}"
 
-	export GIT_PROVE_OPTS="--timer --jobs 10"
+	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
 	export GIT_TEST_OPTS="--verbose-log -x"
-	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
-- 
2.36.1.1045.gf356b5617dd

