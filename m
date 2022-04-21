Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C8EC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391334AbiDUS04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391313AbiDUS0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA1D4AE38
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u3so7857617wrg.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p94WjbMGHOc2dL0HHWYI6XlNlZZtXEyEIXxT07L8HJs=;
        b=VAR37CQ5yqCiTl9KpS6ym+a1LaVQHDeovV9/FuOpnOXiICES9ack/Cqvznao+ROUeK
         1lEhUoNyT1kirxGEsFlRaqGJlxVypP2rnCu8vTvQn/uZrxj1Tx+51wZg0wmcc5wsdlfx
         saYEQM2PAtgRjQqOkPpx+ua3dbjVFAkhn9m6N8WX9T8Ibm68vaineqtS1dX/R6zDrGBR
         9em6rOylQVdGSGNXZawo7tFiAEfxp1ZcB6Sf9RZfzyE1zanTAnxjvHeX0GVi3b2JAuhn
         DMAqAp0v3/fwXWFnhEcRi2JPBl4jnIeDhf71+rbyyasRfZYXTo0RuGIIXOjmnZmDFh2p
         o1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p94WjbMGHOc2dL0HHWYI6XlNlZZtXEyEIXxT07L8HJs=;
        b=ER6FBRfhO+wCJ6KpDuK7S06VZAJjqIFfwzazIyPo44lAtgUnkkSmFHPzMYRGKoF1ax
         IShhNz4RmqgCvIIRtXttupC/potuu5MpoF2RbYAH9E35qRt4RSXbVAi2h7ZxkhRPbcuY
         4nVbKTVM+uxuKMjo+sStfk3Fc/k8sV1LIm1F7BJEyrYvCHHWufFH2SwSyxK66vr7lo1l
         9YH9M3SV3QLawbAIZnFpHrX5y3nKjMUw528qegiczPf33Hvovhq1x2y7inXtF1A4ad7r
         TnhLXM4RsLdz2dLl2zTiWwCYZRHfETrxeGB8ix0euRG0fGx2lH6tF24ORl+cYYjoIr1k
         Vvbw==
X-Gm-Message-State: AOAM532HthK4Chbw206wX6S3cy0dePCsrPFETpYbt/QlU2O7+1X0zHez
        y257I5oajWqk56uPFTwdrRpuCmiHt4u4IA==
X-Google-Smtp-Source: ABdhPJxmjx0eJMxFHV4fC/XcNTnIjz4cs+FxPzWRgfYwaEusXusFKcJErVqRoVv+S90ppqI7mBnMlQ==
X-Received: by 2002:a5d:6da9:0:b0:20a:8d08:9977 with SMTP id u9-20020a5d6da9000000b0020a8d089977mr747545wrs.24.1650565425342;
        Thu, 21 Apr 2022 11:23:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:44 -0700 (PDT)
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
Subject: [PATCH v5 11/29] CI: consistently use "export" in ci/lib.sh
Date:   Thu, 21 Apr 2022 20:23:06 +0200
Message-Id: <patch-v5-11.29-272bd590a95-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "ci/lib.sh" script co consistently use "export", for
e.g. MAKEFLAGS we were exporting it, and then assigning to it, let's
do it the other way around.

Right now this doesn't matter, since we in
e.g. "ci/install-dependencies.sh" source this file, and don't use
something like "env(1)" to retrieve these variables. But in a
subsequent commit we'll "export" these variables through a wrapper (to
additionally write them to a GitHub CI-specific $GITHUB_ENV
file). This change makes that subsequent change easier to read, as it
won't need to do any control flow refactoring.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 3ceb36c7058..2e425cb787c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -30,7 +30,7 @@ export TERM=${TERM:-dumb}
 NPROC=10
 
 # Clear MAKEFLAGS that may come from the outside world.
-export MAKEFLAGS=--jobs=$NPROC
+MAKEFLAGS=--jobs=$NPROC
 
 if test "$GITHUB_ACTIONS" = "true"
 then
@@ -38,9 +38,10 @@ then
 	CC="${CC:-gcc}"
 
 	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
-	export GIT_TEST_OPTS="--verbose-log -x"
+	GIT_TEST_OPTS="--verbose-log -x"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+	export GIT_TEST_OPTS
 else
 	echo "Could not identify CI type" >&2
 	env >&2
@@ -94,4 +95,4 @@ linux-leaks)
 	;;
 esac
 
-MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
-- 
2.36.0.879.g3659959fcca

