Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D749EC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiCYTkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiCYTi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:38:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387131FF22B
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so4964540wme.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNOHKzhk3m89wM2h05ioUPpwObuwmtD4Oob27Y2zPOA=;
        b=I9d5zG7Y+tfB0IAg/hAUKxukIhDx2MaEYGqGmFryFIF6EAdE2Qk8xS/tdoSehyp+My
         xWAqj4bTSm3kcezZ/yE+516XJVP+RijVp96qrHkNLZfjzK5Da5sHi500ecEOk1vkYzYL
         +A8LbFyn51z50HFj+Ut4t9OF6xncmO0pYa/7hOtiKOWP1ZuCAg7kKxo3B738gGnJ7rVZ
         metZ8rdel+A1Fjup2Khr1j+TMpMrSvtZEzL+GtwH2XsqwowjNTthuXc8yYOReE8ywlN7
         rS0dY6K9UNo9qYGBJHT7/84KDoSNJEBZ2ODuCwOvRE7vFHYWyTxt+qsg78yxwaPEcDIq
         +/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNOHKzhk3m89wM2h05ioUPpwObuwmtD4Oob27Y2zPOA=;
        b=uOWCTAO3HMJoLCtibDNcmM09ne4ur+fqCnMePmt7PPD2OL0NsvsiCiQnCu21DfHLBT
         s5xjQkgsjhkGhQjN/s4n0k98v2llAzr6CTnmWqufnXEW3/UziD7i6w4b+xGX0yNG4pBX
         hopoCQKZGOUSAaeiw0dGq01wtUJkyAcG/62VOKhI7RaNPF2isR/l9TDwVthEET0s1mBW
         XiqaKU8qazssz5W/WlWEzATG/G/kbgQEYbZ9BRtjqJC4lE9u8Q3SiFX9hGSyrqbfVzQr
         o7rJqd62Zp9COPUgmo1jhQy3ZPG1tqfgwvuu6AaZaroE6CzyaWJVIMq3sdnYE7p9G1br
         35ag==
X-Gm-Message-State: AOAM533kNTFv0OgvCuuHXTIVniWzAWwP3WV3svrtVeYCLwq+YPEr+fEF
        bivX/AviT7Tn7aRU1ZI7otFzP/IcUj9B7Q==
X-Google-Smtp-Source: ABdhPJxrNBux5RZmOG6oM0+SGF3lQImzxJ2yCqn039uVSMVpy6eUkWoFBvM7Qz/q6wu5Xgj0wVtj7g==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr21250493wmh.21.1648233519574;
        Fri, 25 Mar 2022 11:38:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm6622411wrz.29.2022.03.25.11.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:38:38 -0700 (PDT)
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
Subject: [PATCH v2 22/25] CI: add more variables to MAKEFLAGS, except under vs-build
Date:   Fri, 25 Mar 2022 19:38:13 +0100
Message-Id: <patch-v2-22.25-5f56b922e08-20220325T182534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
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
index 367d1ee05d5..475e9f63a74 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -55,6 +55,13 @@ setenv () {
 # Clear MAKEFLAGS that may come from the outside world.
 MAKEFLAGS=
 
+# Common make and cmake build options
+DEVELOPER=1
+SKIP_DASHED_BUILT_INS=YesPlease
+
+# Use common options for "make" (cmake in "vs-build" below)
+MAKEFLAGS="DEVELOPER=$DEVELOPER SKIP_DASHED_BUILT_INS=$SKIP_DASHED_BUILT_INS"
+
 case "$CI_TYPE" in
 github-actions)
 	CC="${CC:-gcc}"
@@ -73,10 +80,8 @@ github-actions)
 	;;
 esac
 
-setenv --build DEVELOPER 1
 setenv --test DEFAULT_TEST_TARGET prove
 setenv --test GIT_TEST_CLONE_2GB true
-setenv --build SKIP_DASHED_BUILT_INS YesPlease
 
 case "$runs_on_pool" in
 ubuntu-latest)
@@ -110,6 +115,9 @@ windows-build)
 	setenv --build ARTIFACTS_DIRECTORY artifacts
 	;;
 vs-build)
+	setenv --build DEVELOPER $DEVELOPER
+	setenv --build SKIP_DASHED_BUILT_INS $SKIP_DASHED_BUILT_INS
+
 	setenv --build NO_PERL NoThanks
 	setenv --build NO_GETTEXT NoThanks
 	setenv --build ARTIFACTS_DIRECTORY artifacts
-- 
2.35.1.1517.g20a06c426a7

