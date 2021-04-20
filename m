Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C719C43462
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D36A613C0
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhDTMWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhDTMWq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033B4C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso10091940wmq.2
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VvAwW3pZ0KXSCg400wEK8KILNxqoHxjpNb9AzvVL3/w=;
        b=QI/6VpN78czpPJ0eKj5LLCVP4U1cKtpVZgyzZA3Cz+1z0zYRcTi/GgAh1Jsb3r9U63
         r2sYTuuq4omyqzh22X1ndViKTZSSVrmsjpIN3R6I1ME4YyhTe34MUHWLMVi1YLepTHJl
         cBkm+qMwXB61DP4AnoO7iPEK38R29LSllaBot6M5FkQadQJ7w3DgbgnVsE2/evTVzEoM
         Gc1R31SH1VVLrjnhA4Rg62+WiUEIdfiW1v9l0QmtT2b3oSHeGhcZa+srHefj3aOFT+0q
         Ns/lzP4MmFclsmxsqjU8PypM/sqfECZHDuaFT4rYF3PKSOipuSHg2hNH3obT0lE2wMjF
         LDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VvAwW3pZ0KXSCg400wEK8KILNxqoHxjpNb9AzvVL3/w=;
        b=ahMjTTg9BYe6bohfkGqirsO9AJY7fBLj0GYh/eJsNFEhwXXLzmyY7n5TBR60mjS4vY
         XkzO/IMmhVMfqilBIGwKP+tEtpDgO27sCOszfNvYI4qDkOQH5BFtVNEIRVTCU4j6h81w
         40PfzMTgTosbWrDwkTe9Tcp+kgET8xN6m96EBh0R4kgWWpY6CLR4B3AdaHyts2DHgFHU
         q6fJ0bedmjGcD/Y07ryisLz5vtygq65/CMPvle8Xx8M3WSWV5bAXAwZZ6kHQ9/hVUEV1
         cVpWA2UhLj2g4KYTuGAAkyo2QX2oy+m7aiSCkFFZ203De1nhfjGBGFbnVWyNESWrjI+S
         qhEg==
X-Gm-Message-State: AOAM5335Xg9OlSWQUy3oCYnguo5/08NnVUWo68SN1BLIFik6AifBvgK8
        IXm6Wg//vBxW0kleVaU1tpLyZ/CoCYsqag==
X-Google-Smtp-Source: ABdhPJwyRgZEMWwHYvb7RBiuVCqY2pIwT7WpyumfoptG0Or0Gv2fUY2JvoutRt5d30KcfdXLodA6Iw==
X-Received: by 2002:a7b:cbc1:: with SMTP id n1mr4267323wmi.50.1618921333467;
        Tue, 20 Apr 2021 05:22:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/12] describe tests: convert setup to use test_commit
Date:   Tue, 20 Apr 2021 14:21:58 +0200
Message-Id: <patch-07.12-683b3ba3dd-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the setup of the describe tests to use test_commit when
possible. This makes use of the new --annotated-tag option to
test_commit.

Some of the setup here could simply be removed since the data being
created wasn't important to any of the subsequent tests, so I've done
so. E.g. assigning to the "one" variable was always useless, and just
checking that we can describe HEAD after the first commit wasn't
useful.

In the case of the "two" variable we could instead use the tag we just
created. See 5312ab11fbf (Add describe test., 2007-01-13) for the
initial version of this code. There's other cases here like redundant
"test_tick" invocations, or the simplification of not echoing "X" to a
file we're about to tag as "x", now we just use "x" in both cases.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6120-describe.sh | 58 ++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 45 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e89b6747be..88fddc9142 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -31,64 +31,32 @@ check_describe () {
 }
 
 test_expect_success setup '
+	test_commit initial file one &&
+	test_commit second file two &&
+	test_commit third file three &&
+	test_commit --annotate A file A &&
+	test_commit c file c &&
 
-	test_tick &&
-	echo one >file && git add file && git commit -m initial &&
-	one=$(git rev-parse HEAD) &&
-
-	git describe --always HEAD &&
-
-	test_tick &&
-	echo two >file && git add file && git commit -m second &&
-	two=$(git rev-parse HEAD) &&
-
-	test_tick &&
-	echo three >file && git add file && git commit -m third &&
-
-	test_tick &&
-	echo A >file && git add file && git commit -m A &&
-	test_tick &&
-	git tag -a -m A A &&
-
-	test_tick &&
-	echo c >file && git add file && git commit -m c &&
-	test_tick &&
-	git tag c &&
-
-	git reset --hard $two &&
-	test_tick &&
-	echo B >side && git add side && git commit -m B &&
-	test_tick &&
-	git tag -a -m B B &&
+	git reset --hard second &&
+	test_commit --annotate B side B &&
 
 	test_tick &&
 	git merge -m Merged c &&
 	merged=$(git rev-parse HEAD) &&
 
-	git reset --hard $two &&
-	test_tick &&
-	echo D >another && git add another && git commit -m D &&
-	test_tick &&
-	git tag -a -m D D &&
-	test_tick &&
-	git tag -a -m R R &&
-
-	test_tick &&
-	echo DD >another && git commit -a -m another &&
+	git reset --hard second &&
+	test_commit --no-tag D another D &&
 
 	test_tick &&
-	git tag e &&
+	git tag -a -m R R &&
 
-	test_tick &&
-	echo DDD >another && git commit -a -m "yet another" &&
+	test_commit e another DD &&
+	test_commit --no-tag "yet another" another DDD &&
 
 	test_tick &&
 	git merge -m Merged $merged &&
 
-	test_tick &&
-	echo X >file && echo X >side && git add file side &&
-	git commit -m x
-
+	test_commit --no-tag x file
 '
 
 check_describe A-* HEAD
-- 
2.31.1.723.gf6bad1b9ba1

