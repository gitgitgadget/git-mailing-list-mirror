Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA42C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiCYThm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiCYThT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:37:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0890820824D
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v130-20020a1cac88000000b00389d0a5c511so9517550wme.5
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8Gdmw/wrOeDER8oUUqdhTg6MJulAML/q9Ev21o2Xhc=;
        b=P+P0VadLlMXedO8JtUsBBpC+nTE3F3XZVnx6gnK0OTeI9ByMzmWDzpiG/vzcOLEiHs
         xMuHyjbyVhalhGDE6u1JgVoV/BkGCVkmagg5NmZznh5MohtB/9910y7qjD0Bg9w1dm7I
         NK291ohKtioglruYTQa+08fgK45/A0JlfoizjvyfSNkrDlFJPMp+R1FjOIbj1pVIjJuU
         n4KTmu5hD3gFzIfyFkidtwZrLiY3nGQgcSxDW6qVvuvzlT8v+4I8n90cCpaa4m41thIZ
         AOa1CVpUqM7Zul5WSp+yXmW1IFl/0H55IO4r4yFxuHJE/q50irGJFHWL+61SQ8H0rfxs
         7smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8Gdmw/wrOeDER8oUUqdhTg6MJulAML/q9Ev21o2Xhc=;
        b=Ol+XH9WPVnNOw8U+OEuImo65XvmmEuhS8fjLR0DKQqbyUgjL//0v95YpH3vlOUY65c
         RYDhBBM8Ie/2IbBHTeQn9tBEN2X8lXxn3iXcVAfSSzSQ8n20T9u/kTkjhbs15JBmDMOK
         mSjsPUe020xLsHEG1H7Ct7lKrLj5TPrK1U/kOcc3djvlwRcg240M9vXaVWO40igQEbPg
         S4vDBB0oRt9WtlMOC9fRFQAAlYV+dndJWj7F8ow8RKblJpD7A+Y3bK0G7u9MjAQX4o0k
         JzZHFypy6AOv9S6q5W+TYbllImICIP4IQ5+55Abc2f1HRsXhG8sj1tWI6hWaaJ9x23nq
         rhag==
X-Gm-Message-State: AOAM5310XVq8j8M1ZJiyrz72BPBWjtENv1/P4LRM3/EMmhHlx22RY8Aj
        YNF/ldR3C5O/c7GDKCEdxu/+zCDCkaETkw==
X-Google-Smtp-Source: ABdhPJx88raGbDlvJAYDmOus8ITYzky7X6LtXarz9sjaxN7rSRPPDeR1Vv3Wprv7o9p5V3i2cAwC4A==
X-Received: by 2002:a05:600c:1d0f:b0:38c:8ff8:e703 with SMTP id l15-20020a05600c1d0f00b0038c8ff8e703mr11426865wms.202.1648233508315;
        Fri, 25 Mar 2022 11:38:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:27 -0700 (PDT)
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
Subject: [PATCH v2 10/25] CI: consistently use "export" in ci/lib.sh
Date:   Fri, 25 Mar 2022 19:38:01 +0100
Message-Id: <patch-v2-10.25-9dc148341ba-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
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
2.35.1.1517.g20a06c426a7

