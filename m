Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC18FC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbiBUOrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:47:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378306AbiBUOr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:47:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E82560C7
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d27so27512687wrc.6
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6W6pzwo2pcJV0O/hQWzO0q9jWSzFQTXekGfcJvx/GT4=;
        b=SCpOon71yKRDS0lM6e5XxvF00PS2OkrVkhH97hkIsdxIXMe5cE/VG9qAq/apvSkwOC
         ugriwbdIydexFrLcYSliQDGQBgjboOFO3Mp5lWqfC01EUK+Vi5vNPQ8IdQTojACo274d
         onSuynwVvnygvbLbprJgN90d+Oc7cZ1/KHPGyoH+S1UsCM03rG+TZX4Mxh/hiRtRDVuQ
         vtPSNvCKggkXhgGCuO2r9IZ7XnuzJmunyT846YdZO3I+bd98eSTN1hAp7j8Xj1tAIOgb
         SN8lOj/OSLIUYoUAABcPme7CCmBLlUeBFtZva4VSG+BJ79+aLyfzmYms20cZUBC6dGlf
         XZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6W6pzwo2pcJV0O/hQWzO0q9jWSzFQTXekGfcJvx/GT4=;
        b=dkLRk3RumWcf49eJkBHLn3JT/p6jLmlPzElVQYrqh2YRa/xMuz9P5LlGU2atDbNGVZ
         LsEdYQ0r187BPXpJnmrGVxoo1YJC41QikTZQv8bKgORybrYB+EXlhTZcA1iK2dhKhIhH
         tKJKwrKSAq7nhtWPjexwd762ATyKkdIGRjwsvQ5zFrjjUCfVDFURmR6+m/2FwvUod6ol
         oiuxMGlOVUZf4oLsUblLjLGAiRDGr6//Sg5zOzgDQkBZFS8mmUg+dDNtQnlB5I/Ws4jI
         mnozc/4rLMd5MkrC9oOhiIy3O2VX68M4G+VnEAFCWufjHgn9oqKxNN+7KYXi6khYT2Lh
         kBeA==
X-Gm-Message-State: AOAM5330e3GFW7ty4QzzLESA3gDjqVXve4wtDSu13XBiL6zxVNAgChAs
        0DaoB7ZV9cwT7bKHuJRjErItsiqFK5Tarw==
X-Google-Smtp-Source: ABdhPJyzF6V7J45URC30jxl2Ub6s2/mYzFlItySbeQaH3EMhWimhFv/B8U+gWm2NhhjKuDVlqIoOrQ==
X-Received: by 2002:adf:b318:0:b0:1e7:7143:d92d with SMTP id j24-20020adfb318000000b001e77143d92dmr16047439wrd.137.1645454816703;
        Mon, 21 Feb 2022 06:46:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r14sm25071094wrz.84.2022.02.21.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:46:56 -0800 (PST)
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
Subject: [PATCH 10/25] CI: consistently use "export" in ci/lib.sh
Date:   Mon, 21 Feb 2022 15:46:22 +0100
Message-Id: <patch-10.25-b6a61a786c5-20220221T143936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
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
 ci/lib.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 6b37b10d750..31fe3a476a9 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -27,7 +27,7 @@ check_unignored_build_artifacts ()
 export TERM=${TERM:-dumb}
 
 # Clear MAKEFLAGS that may come from the outside world.
-export MAKEFLAGS=
+MAKEFLAGS=
 
 if test "$GITHUB_ACTIONS" = "true"
 then
@@ -35,10 +35,12 @@ then
 	CC="${CC:-gcc}"
 
 	export GIT_PROVE_OPTS="--timer --jobs 10"
-	export GIT_TEST_OPTS="--verbose-log -x"
+	GIT_TEST_OPTS="--verbose-log -x"
 	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
+
+	export GIT_TEST_OPTS
 else
 	echo "Could not identify CI type" >&2
 	env >&2
@@ -92,4 +94,4 @@ linux-leaks)
 	;;
 esac
 
-MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
+export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
-- 
2.35.1.1132.ga1fe46f8690

