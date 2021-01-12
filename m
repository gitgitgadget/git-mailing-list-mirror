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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B01C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEE423123
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438115AbhALVhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436878AbhALUTk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:40 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19137C0617B0
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y17so3812376wrr.10
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ke29G83NNsmb6HLJxtPdUXwXpHHhGnuKUg6jtsexGtE=;
        b=InDWQbd9iodNQUnBlM2AgZGB14qvhSX3e8DPyxbPg2/UcNVwVyF42DTWRzLOeGHPxt
         L0El7ReU+u90vaVs9GLLLzBmZ7BvK6FTxxfjH8qv7KB3WLCRzx7xuvXRaPAjpIpcpOmv
         tlJ1NiTUplc1CAwb5q5TeAzRXcn7i5jaSOYmJL/Y2nnuLOUlARBWAy2XjB0uFpzkV939
         nFqBiIg+jOsrXy7axN7l8RiRTgAzBrhr7HjMNDsNOj64OI3Ycl8VGzYZUY3pA3WDvQ9p
         pzFHEIV205/GPKMB+QEZVbsKSzwim0YeEqF25XLtLaqxtGH4ymm32oAV2x0NoU6jUZXm
         OspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ke29G83NNsmb6HLJxtPdUXwXpHHhGnuKUg6jtsexGtE=;
        b=JrxaYh5BHEW8sJnwaTLdx2SQUOJANrDk4QurCIv/qdT2Hw6/Wdg5vj+lWZidzDpy4z
         WWgRbsuBkI+4TBkAKlitZYz/c5UE+N7kYZ6MpfhOWKdgkzHfMFaaOcohZga7LGWRu7Jv
         qeKh0qFwxdVEBPJHGP48XnXOjqV8JpHl2VMo+cqh/IqhxACMTGOipyYLSuISS0Alafgh
         be4iRkFxAuSmavz5f8Cf6jSAvQzDvVh5uxPiJiXSYBJv51oPFCuyLZCKNmPVFmh0lkeQ
         Kh5hzkXiqjh64CWKlr8Jb9l+v49FT075RRoVSLEKh5WHwm8JQhljJ3WYxhLZ0iccpJjo
         OBZQ==
X-Gm-Message-State: AOAM5329Gt5oY0HZE+lTSMJKzL7uVV7y7vaurcTmKsisGpZFJ6ioQ5AQ
        GdiMK47jeskqH+MtEndR8loJ4ipN+A399g==
X-Google-Smtp-Source: ABdhPJyymzidtWMbFIR5nwG8Oq22iKXdHO1ZmEjpqIIRXNLt7pLOlxYlDq2e9SfGT/4eS0zQnE3giw==
X-Received: by 2002:adf:c403:: with SMTP id v3mr531076wrf.55.1610482717479;
        Tue, 12 Jan 2021 12:18:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 14/22] test-lib functions: add --author support to test_commit
Date:   Tue, 12 Jan 2021 21:17:58 +0100
Message-Id: <20210112201806.13284-15-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for --author to "test_commit". This will simplify some
current and future tests, one of those is being changed here.

Let's also line-wrap the "git commit" command invocation to make diffs
that add subsequent options easier to add, as they'll only need to add
a new option line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7509-commit-authorship.sh |  7 ++-----
 t/test-lib-functions.sh      | 11 ++++++++++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
index 500ab2fe72..ee6c47416e 100755
--- a/t/t7509-commit-authorship.sh
+++ b/t/t7509-commit-authorship.sh
@@ -18,11 +18,8 @@ message_body () {
 }
 
 test_expect_success '-C option copies authorship and message' '
-	echo "Initial" >foo &&
-	git add foo &&
-	test_tick &&
-	git commit -m "Initial Commit" --author Frigate\ \<flying@over.world\> &&
-	git tag Initial &&
+	test_commit --author Frigate\ \<flying@over.world\> \
+		"Initial Commit" foo Initial Initial &&
 	echo "Test 1" >>foo &&
 	test_tick &&
 	git commit -a -C Initial &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 194b601bc0..529f6264fe 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -185,6 +185,8 @@ debug () {
 #	Do not call test_tick before making a commit
 #   --signoff
 #	Invoke "git commit" with --signoff
+#   --author=<author>
+#	Invoke "git commit" with --author=<author>
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
@@ -193,6 +195,7 @@ debug () {
 
 test_commit () {
 	notick= &&
+	author= &&
 	signoff= &&
 	indir= &&
 	while test $# != 0
@@ -201,6 +204,10 @@ test_commit () {
 		--notick)
 			notick=yes
 			;;
+		--author)
+			author="$2"
+			shift
+			;;
 		--signoff)
 			signoff="$1"
 			;;
@@ -222,7 +229,9 @@ test_commit () {
 	then
 		test_tick
 	fi &&
-	git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
+	git ${indir:+ -C "$indir"} commit \
+	    ${author:+ --author "$author"} \
+	    $signoff -m "$1" &&
 	git ${indir:+ -C "$indir"} tag "${4:-$1}"
 }
 
-- 
2.29.2.222.g5d2a92d10f8

