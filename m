Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42511C433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3B6614A5
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbhEJPQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbhEJPNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:13:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07A6C0515EC
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l13so16844744wru.11
        for <git@vger.kernel.org>; Mon, 10 May 2021 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZylpkvlGYM12eJSaMVjho6bS4/DQjf22fj/IyHQMTA=;
        b=ozAbdToNsaREHmn53Ua/+scWDeACITaOwSRxNOdBkU5hVc1hR95S06r7V/EoFVUwhF
         mI4HtKrkPP9Yx8uKxPgUII+Ej3LL86g4EeQKFHVQixTnvowFtHTd1SHgA8ij/31z3kfU
         GL0B59UgK8RXt2rdg7hE9FR0toEcXXiT8nVXHjGFtWnpb1WB46dv4ZZKQhu2GkqyQ2N7
         QTHJRxappPJkmAmZ62fB5bdT45nrygSrlTd5Qs5mqGNdXgywQiWauIsNcXAKW4VcQLks
         xRyYPIwAt2azAL09xw8w1K1+lJ5ecPbj8PZQGkj3NwaUBAZetPn0mwN6iM27eXhNd+8u
         BXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZylpkvlGYM12eJSaMVjho6bS4/DQjf22fj/IyHQMTA=;
        b=d9cWpOVRLx2CIymQpDvIks+SgOMI4nGll4FGyuITO0IUUI97ucCWjqVwdLbhxrDZ1w
         MirzSLI2YL+B4V7GD2VSxIqGvR0Sl7dbwb6OOPb9rbUqdUiaY+WB+1+FATClyz0bHlH8
         g8E13/fxjZFDhCbeITH+R68mSCaCDOeX3LWY3lVRTinPRqRvsiswpNjtErZR4aJS1HTT
         ypdU4+SkqO2PKFgd2KOvd02SqAWxwTXnj6b+T9WcDVtArRQALpE+OsGEJ3SwcowuojnC
         BNy/oZED4crQh/dF7HDGD0E3EwhAwn6gftAPpJFoVq0868Qacgo/SGRkdg+Bkw134bpX
         xVmw==
X-Gm-Message-State: AOAM530a900HW0DySS6DX/LIc+FZkbi91lBzBjo+cty5QeICHveF2u10
        CT/tgDfAFqFxyyqISyfbhc6C6aPEMjh4lw==
X-Google-Smtp-Source: ABdhPJxuLhMTh4VytAW6G1SbOTYSRwDd7OrpV90hRPBE5jtg28TzBwtSxNLRyhzmNNkR9+EMU0z3Iw==
X-Received: by 2002:a5d:5741:: with SMTP id q1mr31349902wrw.212.1620657138292;
        Mon, 10 May 2021 07:32:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q10sm22421839wre.92.2021.05.10.07.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:32:17 -0700 (PDT)
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
Subject: [PATCH v6 05/11] test-lib functions: add an --annotated option to "test_commit"
Date:   Mon, 10 May 2021 16:19:04 +0200
Message-Id: <patch-05.11-2e0d69209e9-20210510T141055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g924d365b763
In-Reply-To: <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210423T072006Z-avarab@gmail.com> <cover-00.11-00000000000-20210510T141055Z-avarab@gmail.com>
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
2.31.1.838.g924d365b763

