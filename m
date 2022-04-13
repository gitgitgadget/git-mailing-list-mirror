Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F51C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238502AbiDMTyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbiDMTy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525DA5F4F3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g18so4115374wrb.10
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95G+ydbQyhJHHHkhIbeovRa95gH5GpdV/tUGZfCYYDg=;
        b=Rh7tP1Si/3h73NrgJzGOiHiOFLgrGyiWnAvy3LfqYxyzD3QbMYLmNurxfyNIRzvOnK
         VofGLuBPcdD4+rQFsFFU8yT5W/k+OSaV7QwDQl1Vmd+1xx9YT9XqLtXx+Ricrd/bYPqS
         NaxpYh/9ZdUL9Tw7QWM+tEW9aJ81HYNkjFCunJ8xRI77Df6zGEOJbcbiMpwYDhUvRRKj
         SwNNWBsBIy997fvzQHk3A5qAKFMWTQ1baUzU3F7E8ad5H5Pd8KLJopa1GY9sCGZVn+em
         qi22JAJXJsUuReoEkoPtoLev0I0UANWugDFfHCVFjsBnH3ItgWbiaYOjZB7Vsqrcdd1G
         xQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=95G+ydbQyhJHHHkhIbeovRa95gH5GpdV/tUGZfCYYDg=;
        b=2ZOpMrEusi9bCRWqzAtxXDzsmT9aqKjJu6DAQVJsqcXJEcP2Bw9QqoEFFVWViZZ8LK
         Qi16UWwHuarxoRLmXG7u4bTMV/VGrPP9W52LSMA4NEPKKGiVe9KtN7mahTZ6TpHa621l
         O3o3AahQpT9Mug+PvfjLHGOkw1O3Sq4YhVSjodHJDLcdREcrZIdMTYqPN74uIFi1XSL1
         NnQX7ieqsN2HGmqMYl3M4kvdItAA0dVGDfNSkLVIowFGwU6+NvX6mq0jPjEjidaj3aqE
         vQkMu8bTVoI8RTfSH1OOKjOPIQwVDjIk10qqgo+w7j5uOTI9ccUUeXaPnMOHSFcG8Onk
         jXZw==
X-Gm-Message-State: AOAM530rcbO/VFZRom+ZwuEh+ccXDuBx6YUvF4EtUPPhCorwp+S9pUL9
        x1k/ZFVlMqhzM5y/nxVtcjE8PgeCuC0wIA==
X-Google-Smtp-Source: ABdhPJyQ34KJ5l6ssIIhOi5CPWMK964K8FG5pxQOTBIHBM0o1A69J/3SOOQuOcyflxy7y3DAU4i9CA==
X-Received: by 2002:a05:6000:15c1:b0:204:7e75:1eb1 with SMTP id y1-20020a05600015c100b002047e751eb1mr347462wry.482.1649879524689;
        Wed, 13 Apr 2022 12:52:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:03 -0700 (PDT)
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
Subject: [PATCH v3 11/29] CI: consistently use "export" in ci/lib.sh
Date:   Wed, 13 Apr 2022 21:51:24 +0200
Message-Id: <patch-v3-11.29-8ab4e81e1ca-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
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
index 5736a4d2e04..5783eed1b20 100755
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
2.36.0.rc2.843.g193535c2aa7

