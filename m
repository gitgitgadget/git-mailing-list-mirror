Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E69CC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiDMTzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiDMTzO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:55:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6BD49CAC
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so4103334wrg.12
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I4xjNP7hxNNURYwDe2DFOL3ZTfaQYI1lJlLATyWzdT4=;
        b=hX93PSWLKv0DPZbswVVXoYpHRRHY+/ED+U3xMouoco6dgCHR10X0w3n2oQVzl9gmNY
         dU2x560cqCLTxU7kumvlIKaFP1Ue5rdnnjwryMA4BhUPtN09tAcTfjmYz9cq5WdQNX4F
         3dnPxUrHF3a6wj2aI6Aog0XafmnYTSVYQsmnXMcVUfIF/m+StoSTNBmQEMDFqv1MgJbo
         65d+yWVnC+/5utEvqzOsaP51y8QsyfExe1I/tT0eJvk1zfZrkK1tYOwYfRJCwExnobow
         UfddJvVDyApPWkrGGsP+OHPXfT8mYsC/qZ28wqHEWGBxVG7JHVdsW9qr8EzDcGnKDwTY
         gclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I4xjNP7hxNNURYwDe2DFOL3ZTfaQYI1lJlLATyWzdT4=;
        b=g0crWpnAqSSrlZcp7Fi1s0cdc+uNzuAVvpO0Zzn0dR0Uf8HKTnMBSEUMfpRqPq2gs8
         njzqAevkTtugNYNwiXRN74+HUQOMRgX6YBZWhNu6dEjl/mDD+KSS6vQ03JlNSxMPwlT0
         FR7H26pJH2pgPpfwGA1eclLFpqmv8AzjpExTpWfXnft5Ht4SMyUWRol6d4HEbN34JApr
         3icaOciQpAzg1kLKsON4zm0HUVz20hoPQfZnpx5pnFvmr+E/GR/DJAOC5D8GQNEjwziT
         3VFkzt3qxOhmuEM7K3hkBCLYjCiPXuf9C3lNwP/1N+l3oDOtvzpDJmKoRl8PWLvhMx2o
         ntNA==
X-Gm-Message-State: AOAM5322sOoJcJ0LFDbyV9+lMQgZSOrXqPiDEjfP4ISg4WdJ63hTcgWV
        de1QfTCrWXZxKTqLthIZHaS5IYQnhka+ag==
X-Google-Smtp-Source: ABdhPJycpih7E21dYUYRcwxhPDbjBqbN4YamH9B1DU+Xp2PbLzLp/V4Gtl4nNS9tGmlZZ3ZO/LSeZg==
X-Received: by 2002:adf:9581:0:b0:1ed:c341:4ed1 with SMTP id p1-20020adf9581000000b001edc3414ed1mr311086wrp.299.1649879537621;
        Wed, 13 Apr 2022 12:52:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:17 -0700 (PDT)
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
Subject: [PATCH v3 24/29] CI: add more variables to MAKEFLAGS, except under vs-build
Date:   Wed, 13 Apr 2022 21:51:37 +0200
Message-Id: <patch-v3-24.29-d1d5c1e2f65-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

