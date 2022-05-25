Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7ADC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbiEYKFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241540AbiEYKE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1C6D961
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z17so5306459wmf.1
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsfcG5Is4/F/Q6NsqyPjH2sSp8Hxv3gJNN7z4CWwErQ=;
        b=j1WU1R3XYdefsn6eg4kM+SReWFir2HGnTJ0+2tJi6+XLahWrQrwifN/7KRVs6VRlfc
         SUCVd5oljZ6FUJicCbuJXSVof/TgD/CFj1rpcWNJqP6X7XpBmoRoS9qC7Lf2mSH+aRZO
         dSEEXcFNzUvw3Y4VtD3Bb5tlzub5pBoQ3Cc0Kybx02w8pOUEAmufioKhMNK8Zl2u1N2x
         fNkGUmEXkHPRLhmUlnnJnJ4IQw3XVzfEysupfQYvxCpGTnQ77oqEEhrjVoOgxLSWpMGz
         FNTCmMJ5WTtjhObOfDhw5eYAaqyjTUVx8GdkKqGRtGZDGHb5SDxFFPK642IB1k1Bxx/0
         70FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsfcG5Is4/F/Q6NsqyPjH2sSp8Hxv3gJNN7z4CWwErQ=;
        b=7ojF9vsPNjEovuC352Nof486gocQfn4xmPqMYVVvTiY1aeplXR4wJVBgQqYVv8SzCu
         tOG5s8qgLtQRzIbP9gB6k2ZVZRtwFORhVK3jQtA0oNjbcqFdZhn+DNfgAGRbVla+2ywd
         ThB+LtH8DS0El/jAMvM6MD2gL1SB7YXBPcmjFdfkfSilVocn6VPtUluA/sBNximwPJ2g
         9O5UBqaVdad9SgnAyCp6KPxF616kXj7cMcmNi1SYRmsPOA4ObIQdhs45yx5LCsWualQK
         Rklkpr1QevWaSo6spUt2T9jTixKyaxuRmKgM0VTlKzmSlGdH933tUlAlTfZDkVcdPK9W
         25tA==
X-Gm-Message-State: AOAM533j9gRp2lUBYc/C20MqFLszekYHA08Z9thMFj/nmRsfeAQvbbIv
        8OlZqTrH/rQPMO0G2z3Kf5lwui5fz8eXkA==
X-Google-Smtp-Source: ABdhPJykavSUkSWiKt0LfgAIljJvCI51e1uugf6RYou2F9QpZJWfEMm0tHT5COKtxlQ9z8zzgVZEuA==
X-Received: by 2002:a1c:7912:0:b0:397:41e9:872d with SMTP id l18-20020a1c7912000000b0039741e9872dmr7390861wme.184.1653473093313;
        Wed, 25 May 2022 03:04:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:52 -0700 (PDT)
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
Subject: [PATCH v6 11/29] CI: consistently use "export" in ci/lib.sh
Date:   Wed, 25 May 2022 12:03:50 +0200
Message-Id: <patch-v6-11.29-9655bae9e21-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
index e789cd2a1cd..1b5b805c5ca 100755
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
 	CC="${CC_PACKAGE:-${CC:-gcc}}"
 
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
2.36.1.1045.gf356b5617dd

