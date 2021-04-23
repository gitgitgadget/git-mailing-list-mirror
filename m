Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB81AC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6B8613C4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 07:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbhDWHWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241093AbhDWHWE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C35EC06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n2so72425738ejy.7
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 00:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVcyhVyfa+/+3jSQtfdgy6Yrq9vDAtx0TJY6PrTOgdU=;
        b=RbziMKSbmV3SlOq17O1I7vEU5+JM0hQru87hBOtd3L7DmFWvLqh/olk/BdbdL3wA8U
         HGaYHcjQ4e6K1Qm9Jy8BANJigTxQDHtur/LMkM4RrACWxGs4xmEabvtcQdz/WDBcYlGx
         vubmcC5nDFAvGlw1IrTz0+XqVnDPbMnbI+UyeorScKQmDXZWApBjjrIMBcWkZzsszqC2
         fFnQuKbFQZMnmyzKXX6TM611dCh+XlsjFOaey96JWzXmOLVldOtGQvcAVzYG3wsQOSao
         5b3z06db5tx3GIefGccM24hWvhu6k9PFcEJdVnY3xSrHRfBiFcgdlxmHVTz2IWPcA8lS
         zEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVcyhVyfa+/+3jSQtfdgy6Yrq9vDAtx0TJY6PrTOgdU=;
        b=WSZ/8/PSim32EKdqmTJAgJyvOoc7pNvYrIx2lRWJ5qynFUPBBremYjWL2IK2y8McH0
         7Z+H6gPYMBKBesQfP9dTfKRgndh+zzw/ZIcoklqTzc2ROXTFSAjrv06z24FCG6pbqmHw
         rwOMATMbzUqfvQ56fXCZ3Ijl6lgXPwx3DytTMtvg08rsA/gMO0hKifQ6nrw3QVwySh+W
         fxGBbuEmZp1AftssQLv0tpK7tu37eZeFQ5BQHqRFhfg7ZqBn4czlyBD2yOb+iv0/sl3H
         qP/kU0Tvtsr2fKLFJnPD+vXykz3mOyUyJ6A/SApNfBPFC9lkzV2DPgqUyG1hxUcR+swO
         n3Dw==
X-Gm-Message-State: AOAM531YEtzDeCKdlH670WSr4yn6EzuUn+FxP/YM2QNwndJ9s5FvFRkt
        2h2R/jGvETwTdHGmIF77+elQU9G6WsgfbA==
X-Google-Smtp-Source: ABdhPJzN3EiZFLdQHcQbvKyIelUaDgrLnTQ2GdqutlQ1ZZLVXB17GiddGYIkrgg8p18oeEROcHXj/w==
X-Received: by 2002:a17:906:1114:: with SMTP id h20mr2735639eja.453.1619162486571;
        Fri, 23 Apr 2021 00:21:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e5sm3328892ejq.85.2021.04.23.00.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:21:26 -0700 (PDT)
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
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 05/11] test-lib functions: add an --annotated option to "test_commit"
Date:   Fri, 23 Apr 2021 09:21:09 +0200
Message-Id: <patch-05.11-4ceba3d404b-20210423T072006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.737.g98b508eba36
In-Reply-To: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com> <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an --annotated option to test_commit to create annotated tags. The
tag will share the same message as the commit, and we'll call
test_tick before creating it (unless --notick) is provided.

There's quite a few tests that could be simplified with this
construct. I've picked one to convert in this change as a
demonstration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1403-show-ref.sh     |  6 ++----
 t/test-lib-functions.sh | 27 ++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 6ce62f878c3..17d3cc14050 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -7,11 +7,9 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-	test_commit A &&
-	git tag -f -a -m "annotated A" A &&
+	test_commit --annotate A &&
 	git checkout -b side &&
-	test_commit B &&
-	git tag -f -a -m "annotated B" B &&
+	test_commit --annotate B &&
 	git checkout main &&
 	test_commit C &&
 	git branch B A^0
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c6d07f4ce32..827c8502b10 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -179,6 +179,10 @@ debug () {
 #	Invoke "git commit" with --author <author>
 #   --no-tag
 #	Do not tag the resulting commit
+#   --annotate
+#	Create an annotated tag with "--annotate -m <message>". Calls
+#	test_tick between making the commit and tag, unless --notick
+#	is given.
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
@@ -191,7 +195,7 @@ test_commit () {
 	author= &&
 	signoff= &&
 	indir= &&
-	no_tag= &&
+	tag=light &&
 	while test $# != 0
 	do
 		case "$1" in
@@ -219,7 +223,10 @@ test_commit () {
 			shift
 			;;
 		--no-tag)
-			no_tag=yes
+			tag=none
+			;;
+		--annotate)
+			tag=annotate
 			;;
 		*)
 			break
@@ -243,10 +250,20 @@ test_commit () {
 	git ${indir:+ -C "$indir"} commit \
 	    ${author:+ --author "$author"} \
 	    $signoff -m "$1" &&
-	if test -z "$no_tag"
-	then
+	case "$tag" in
+	none)
+		;;
+	light)
 		git ${indir:+ -C "$indir"} tag "${4:-$1}"
-	fi
+		;;
+	annotate)
+		if test -z "$notick"
+		then
+			test_tick
+		fi &&
+		git ${indir:+ -C "$indir"} tag -a -m "$1" "${4:-$1}"
+		;;
+	esac
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
2.31.1.737.g98b508eba36

