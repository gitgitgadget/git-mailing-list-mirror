Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBD9C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346369AbiDRQdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346211AbiDRQcS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B5830F4A
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c10so19163426wrb.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XYZImw7tELVBRL7EtL0VPKdL83G06okSwJH3kK023W8=;
        b=eCaoxP63EilYZtohxuFHhTDXDw7fVbRGIqxUjRr2sCRr999BgBmMNLwA4c6YaMWoh1
         CCm9I/Bnb7VUKL2mu2TWHPr4KFhqIK/lLzfA7tVq6Vtoev7sQamnmvnmAmrWitSAXOep
         8KNeSp2KNiddawcmY8GzJtcK07M3chG5UEqo4SOC5Ldj++F67LxxTx7Vu7+mSRMvlwSh
         RosIo1MQZlTFbEECL1apzGQBA+BAVWUo41Og/jXjFxAIECwEXy3LfWltH4kc8pZKn330
         3/xxjw+A4r7CLJ1jv8owv2YypLo8slZ5xGGBLXJYiIvjINqMVWDPTWATs3s2S30d7tme
         r3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XYZImw7tELVBRL7EtL0VPKdL83G06okSwJH3kK023W8=;
        b=RMl+P6DyeyIVtEV2W5Lrd4ULbB8JUDvMcqhEwx8lV32SvWxeUv97W0vMiPq3k1FVvV
         rq1t93MPrOGRCF9v8eb0oeIWCzVNpGubpqsp+hi494sWsEm/DXA0WHeN/q7uBnPmVf3A
         PB2WyuQPk9CQ8FlhKt5vcDnWSsajTe9i43j0syr3NbZiaUWI8M4OUuo0lJTAvga7cXo5
         BUzU18+PX1G6uCwjjlCdkfsp7hhIuFd5E1qpo8x+n5cYmBAHUd/36yETgQhUZyh/unmp
         sFEk+s5b+uOk3iFSGz75d10SXv+vxeQRLkkVuZ44+glCCetaUgUXUYZP8It6MnOwnEaJ
         j/WA==
X-Gm-Message-State: AOAM530HqIi+Yp2ylBVq1vqLvZrh0SNGFPVTDVjFWo7RVasxVkbxPSaJ
        jIb8fxNjgYTQqYQU8hcIQkOmV6NpOHiARw==
X-Google-Smtp-Source: ABdhPJyWZUQh72UmUbConHmEmLPE3SZmGBjEs3YUvHeG49yJCZm1hNyibdF/f9jGiQ0u048GKQriMw==
X-Received: by 2002:a5d:4dce:0:b0:207:a830:9fcf with SMTP id f14-20020a5d4dce000000b00207a8309fcfmr8891757wru.167.1650299376408;
        Mon, 18 Apr 2022 09:29:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:35 -0700 (PDT)
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
Subject: [PATCH v4 25/31] CI: add more variables to MAKEFLAGS, except under vs-build
Date:   Mon, 18 Apr 2022 18:29:02 +0200
Message-Id: <patch-v4-25.31-78f4609a9c1-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
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
index 50bc766254b..8fb0bfd43e1 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -61,6 +61,13 @@ COMMON_MAKEFLAGS=--jobs=$NPROC
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
 	CC="${CC:-gcc}"
@@ -77,10 +84,8 @@ github-actions)
 	;;
 esac
 
-setenv --build DEVELOPER 1
 setenv --test DEFAULT_TEST_TARGET prove
 setenv --test GIT_TEST_CLONE_2GB true
-setenv --build SKIP_DASHED_BUILT_INS YesPlease
 
 case "$runs_on_pool" in
 ubuntu-latest)
@@ -117,6 +122,9 @@ windows-test)
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
2.36.0.rc2.898.gdf6bbac50ff

