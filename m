Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB9CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244541AbiDRQdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346241AbiDRQcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96C130F44
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so1760899wmq.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+z8tZCyPQyCJW5DoDhi4plxqsBjZdFHChOWVUCE+OM=;
        b=l/URI3URDJf3QQInIj5GAP9VD40hDYRUANqbxC+5W0aRiI7qv/ILBIOcm0xyPRpVGT
         lDqDbFs7QTG0aRV3WfHdFeSeMvkE4eVaR+UegynArTnBTWi60EcVg4C1g3qxMNB5o2rD
         na+ISpYtpOXi4gy7Dyn4nFHw9JrpeLlhgsQEjspZttzmxSUtRhvRDT9LaGxxgkGftzgq
         lGofCU0h2cvq7JB6W5SqMXya0BJ1o4f/rCr3WGVlF/vozhf2b+Jvd3AEq8k/4Punc7T/
         O+uLyzUPiqVdt8WXZwA5dRblFBj9dfjUgBxe4ZVMeghhqsgVaJwKesyXDuAJxhUKou0K
         ICug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+z8tZCyPQyCJW5DoDhi4plxqsBjZdFHChOWVUCE+OM=;
        b=NJ8t2Ml3fpL3h0nXSQC/d4IfHTdw7jzR8kO7nU1BiADbnU+Bp9rL5AxJ1jTh5LWFeX
         xYMWJaebZcGTaDPjcewx2QmjU7gHsEpt/Qdzh/gjDkmwVRgXfhFgysP79abmJi3AK7vL
         MT46BZ31gXFgRKrzCm6amAbfUR+wZB8CQvr9mMICCueXSMzqDheZ5tsd9DiTFVyq1fvA
         QkdPc7fPoep3fFYKCz2YKdIrEQQu6K/e0K4hPGYqrzAX53oxIKQ6M+sqyP8N3u0+UixD
         qZ07fEMNAfi5W+c0QsM8AKKnW5HMLf4MBAnwpGvGnypKRIU3qeazF/aoQ9keSoelbjbA
         I58A==
X-Gm-Message-State: AOAM53190I5XuVjv4JbXui1mP1UaiA09RMahEq/RX3iLZTOZF5WWXrGQ
        CudZ+iM71HghHBFx56EB33JveZCoFAE+Vw==
X-Google-Smtp-Source: ABdhPJz77g1RG4oD6R7DboDjXoN5vm5Rlhs/7R2fVB7eRfyw7SkR1EDCIhDFjd0Awd6Ru3Mvkeoc8w==
X-Received: by 2002:a05:600c:190e:b0:392:889d:506 with SMTP id j14-20020a05600c190e00b00392889d0506mr11854166wmq.126.1650299362870;
        Mon, 18 Apr 2022 09:29:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:22 -0700 (PDT)
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
Subject: [PATCH v4 11/31] CI: consistently use "export" in ci/lib.sh
Date:   Mon, 18 Apr 2022 18:28:48 +0200
Message-Id: <patch-v4-11.31-1d3d357dcef-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
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
2.36.0.rc2.898.gdf6bbac50ff

