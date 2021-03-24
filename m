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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6D0C433EB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E75619EE
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhCXBtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhCXBtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:49:25 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E2EC061765
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j18so22779148wra.2
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kwY7Ff1LK+qRoAEygm3Q7zxo1H3BriXLKXHAtD8oaIc=;
        b=rF4jFsyMfIgse0KiXFhGvakVcKxhHWVgn2koIQdf48tcWstvQhJ2sA3+/zEnxbLNsk
         k5B8HIoSj6slA3j4tQXaG0glWe3itQiV0ShorLv3iMhpUaqUUuWfBN6CWquZNJsrDchQ
         QXWGqyfQ6wjLl4/PyC+880uSgJjS63b2ykpA3s7smYsGbMCzhYILfCb0TimVZ1w1FOeO
         0BsGctg9ZmAQ0Z8NWvcD5eruni11PVlJIGUN4vkf3N5LPtVb07ZInefmNT7FMZbu82Oe
         ThI4RVAzjvf6JsFJQAX0gm1qnceQz9yIqRd0VqQNCHe/79bp0EiWf3+owyrhWq1LMZYC
         +kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kwY7Ff1LK+qRoAEygm3Q7zxo1H3BriXLKXHAtD8oaIc=;
        b=g83sjyPij0hQevw4OD055Ld5l502NO3tcSCzxfBz/ddY+4AlBI3cUfCl1tgb4hFjqL
         z/R07MTMiuDWsWAszDIXAoWKFNmXluuoksRwSF1lJlPmQctx8nvtrve6LT4lE1EwnRrt
         JsnTTSnrfK7Gt8x9KvKMgb31ndQ8m4tvQHQzpRHB46DhS5XK7w+L6g5Dza/2nCVTaXWA
         ya+PhVEO2aw4uATTl+j4DxHNSNtNIzbmebUeo4Ih7N2PFcrixTxkJykSGPdTGKcdG+/A
         E7WheDXeadx0UlHpX96UugOjgUnS9c8bdIe3bOirjinQXU/goz8qTsmPv8rtPZqLHUYt
         siUw==
X-Gm-Message-State: AOAM531tYIgxSdfvWQdbZ7nBnd2o0sFhvc9EMgVizmaMH1nV3qBHTb1q
        ISjDpn7kCzFr3CAX5m2n9i6KqWPt1vQqQA==
X-Google-Smtp-Source: ABdhPJwLybF1Pm7+qJqLEM1nf34ICOwSt4VAhv6g23VOCol4ZBr8f/9G4gndwiJ9N0gGY8rwZAcdfg==
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr735081wro.206.1616550562446;
        Tue, 23 Mar 2021 18:49:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y205sm598177wmc.18.2021.03.23.18.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:49:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/10] blame tests: simplify userdiff driver test
Date:   Wed, 24 Mar 2021 02:48:52 +0100
Message-Id: <patch-10.11-ce98c61bf40-20210324T014604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com> <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the test added in 9466e3809d (blame: enable funcname blaming
with userdiff driver, 2020-11-01) to use the --author support recently
added in 999cfc4f45 (test-lib functions: add --author support to
test_commit, 2021-01-12).

We also did not need the full fortran-external-function content. Let's
cut it down to just the important parts.

I'm modifying it to demonstrate that the fortran-specific userdiff
function is in effect by adding "DO NOT MATCH ..." and "AS THE ..."
lines surrounding the "RIGHT" one.

This is to check that we're using the userdiff "fortran" driver, as
opposed to the default driver which would match on those lines as part
of the general heuristic of matching a line that doesn't begin with
whitespace.

The test had also been leaving behind a .gitattributes file for later
tests to possibly trip over, let's clean it up with
"test_when_finished".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/annotate-tests.sh | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 04a2c58594c..d3b299e75cb 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -479,32 +479,26 @@ test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
 	check_count -f hello.c -L$n -L^:ma.. F 4 G 1 H 1
 '
 
-test_expect_success 'setup -L :funcname with userdiff driver' '
-	echo "fortran-* diff=fortran" >.gitattributes &&
-	fortran_file=fortran-external-function &&
-	cat >$fortran_file <<-\EOF &&
+test_expect_success 'blame -L :funcname with userdiff driver' '
+	cat >file.template <<-\EOF &&
+	DO NOT MATCH THIS LINE
 	function RIGHT(a, b) result(c)
+	AS THE DEFAULT DRIVER WOULD
 
 	integer, intent(in) :: ChangeMe
-	integer, intent(in) :: b
-	integer, intent(out) :: c
-
-	c = a+b
-
-	end function RIGHT
 	EOF
-	git add "$fortran_file" &&
-	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
-	git commit -m "add fortran file" &&
-	sed -e "s/ChangeMe/IWasChanged/" <"$fortran_file" >"$fortran_file".tmp &&
-	mv "$fortran_file".tmp "$fortran_file" &&
-	git add "$fortran_file" &&
-	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
-	git commit -m "change fortran file"
-'
 
-test_expect_success 'blame -L :funcname with userdiff driver' '
-	check_count -f fortran-external-function -L:RIGHT A 7 B 1
+	fortran_file=file.f03 &&
+	test_when_finished "rm .gitattributes" &&
+	echo "$fortran_file diff=fortran" >.gitattributes &&
+
+	test_commit --author "A <A@test.git>" \
+		"add" "$fortran_file" \
+		"$(cat file.template)" &&
+	test_commit --author "B <B@test.git>" \
+		"change" "$fortran_file" \
+		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
+	check_count -f "$fortran_file" -L:RIGHT A 3 B 1
 '
 
 test_expect_success 'setup incremental' '
-- 
2.31.0.366.ga80606b22c1

