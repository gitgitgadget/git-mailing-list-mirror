Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A83C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346250AbiDRQcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346211AbiDRQcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8624F2FFC0
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i20so19106922wrb.13
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6DWGRhRNcRGgjkuVwLBMInrZ7j7QY0GppmayO6AXVo=;
        b=Anctj1mjrI0ADGEWwQbjXKG3TKL8riP6d8AaY0AaP7WczNeWJa+d+vQKNvQtQ47V1b
         WMv6Nm1jP2iHpj42SrkqGWl19PGKi7xsk9O79laGpGJYIkkQx/0dBiw6xVT7wFkQbbf2
         MvGUGeCIbbxcGAw09bf92haAOwaVkOCT1xMzb5JBiZD3V/KO4FXpacOfhhaDwl/4gfC1
         kqepecEGM09NyuOwTG5ODlKLpDJnmNIj7qkWFvasWZsPaoMD52O9Qlpk7waxO9uc4O7P
         JljKaaBLF96AmwPjmfwVu//E6GGd0C5puo6rIckEgHXLoKQMeKYvV3zgMTHb42LIvW12
         YgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6DWGRhRNcRGgjkuVwLBMInrZ7j7QY0GppmayO6AXVo=;
        b=NwA9NJXpVuuLEQtv84WRIFad3fFAvTMqeOCCV+vwr1Kmp9aWd7me9SVV8xsIbwxFfT
         URGw8a1YvrhAuZA8Dhg7azMelwDtwbBGBf5cUFxJ3JxIWuIeIKbXaLBWMIcYrVV0Iun1
         ZZs2bA6diZbJav7B9KbRVaMtbDxB2Q2egQH8WLAomuQhg+VIXZPK3aH11yO5fsU3KXbX
         bRbeqwY5I0pUGZcoIwL5idXml+a8WOAod+ZlLYaHGOGoIvX0qVnE8Dwj3a4v2IRtl8/g
         b8kBcZsd5WNEX25vwpsc55K1xUdi40jcL957ub74q5HF008qRj8xFWaN1uYL+E7c7x29
         /Xjg==
X-Gm-Message-State: AOAM5321ifHvcbj4YIOO9IwYCUYPRupfpWANGQP319xFQjK4pEM7Q7t4
        9f5Kvgpjw4I+cFWZouPWg9+OSUEw8fWZnw==
X-Google-Smtp-Source: ABdhPJwXY+TZCu9a3CAWnUwe4826e+CZpdDdfKg81dEJ4RdK18B2TsWDJObANNVBNm7RrmLJMzdLFw==
X-Received: by 2002:a5d:64c8:0:b0:204:ccc:4ba5 with SMTP id f8-20020a5d64c8000000b002040ccc4ba5mr9082729wri.409.1650299357798;
        Mon, 18 Apr 2022 09:29:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:17 -0700 (PDT)
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
Subject: [PATCH v4 06/31] CI/lib.sh: stop adding leading whitespace to $MAKEFLAGS
Date:   Mon, 18 Apr 2022 18:28:43 +0200
Message-Id: <patch-v4-06.31-151f28e3818-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
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
index c4b829c1eed..21c009757f4 100755
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
 	CC="${CC:-gcc}"
 
-	export GIT_PROVE_OPTS="--timer --jobs 10"
+	export GIT_PROVE_OPTS="--timer --jobs $NPROC"
 	export GIT_TEST_OPTS="--verbose-log -x"
-	MAKEFLAGS="$MAKEFLAGS --jobs=10"
 	test Windows != "$RUNNER_OS" ||
 	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
 else
-- 
2.36.0.rc2.898.gdf6bbac50ff

