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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE82C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC1164E45
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhBKTsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhBKTsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:48:16 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBFFC0617A9
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:19 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u15so3894850plf.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tZev5n64exraIkBO6lpZsj5owZ1J75NCF+GxB3Z7Pgg=;
        b=rNkKGhh08l/sCHD3PsYw6x60TN5HPma/de523TOXzQZWhuwgKMJiZjE17D8dkiAtDU
         qqB31UiIHmhznAZyrUpu9UBAVfcUXg8Et1WwFkJyokOMjMtxVIFPrss9m48Mi3Xs5egA
         2o2pYM5U+cqK/42drmtbj8Bhow3BIOcPKXBOzZfhsDXOQLMRjS2mjwuR74O9HfRHCqaS
         kg58nrXaM2P/l5eoiaCa9lLOwMaOElp42EmNqZMib98DGUvccsVtyCyjLnjabmixhkWy
         sS7vzLPFfsxCt3TeVb1CuAuHi8OGtfEHrPDTgaU0SyEQVYMzhWWDS0uZXFy2CPqFjeOD
         bvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tZev5n64exraIkBO6lpZsj5owZ1J75NCF+GxB3Z7Pgg=;
        b=W6DfkhtY6BgC4bTTnQPiNgl1JMoVGuWaxIQhpu1epF3x0RrndfNUgcmQkk6GLJwWo7
         q+XDydQURmf1eUzBFZCFxXVei1NVSl0kk7w270zQBlAXcSXxsOd3D9cjvmNyMjkL9OmR
         XLeWJJI2jbtf3MkgtrVIse4bg0SBYFnpzNP1ENoCTId50ZeByfqDm4Mh9mYnk1GJikFR
         9df6A83ewQkFvKcAoKN/CEUDUIANx6bOK2LaUh35n4FxH9KveQrUC11u6o0yBkhH3SSr
         V2eB9faOZSqqVkEYvKgG9eE3eRQmOEYZ3/eQj0QvA3t6r70S+E2wP2WOlg5jr9KGysO5
         9fJg==
X-Gm-Message-State: AOAM531fxmRW8ZtnTopHZPeAl8nUPnrWXT0LfHSr9rLhpyuydhV+sed4
        4YNlWT22BX/effnRcBbzyWLSXZ9VsvCtIA==
X-Google-Smtp-Source: ABdhPJy2pkfRe1gT/lpTDAHsI0O4KqPOku7RpdtHxI301DKpN4yxmB0X81DReG7ucPHEo7+ECNZQkA==
X-Received: by 2002:a17:90b:4c0b:: with SMTP id na11mr5138672pjb.45.1613072838672;
        Thu, 11 Feb 2021 11:47:18 -0800 (PST)
Received: from localhost.localdomain ([47.8.36.172])
        by smtp.gmail.com with ESMTPSA id a141sm6524778pfa.189.2021.02.11.11.47.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:47:18 -0800 (PST)
From:   Shubham Verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 03/10] t7001: remove unnecessary blank lines
Date:   Fri, 12 Feb 2021 01:16:57 +0530
Message-Id: <20210211194704.28913-4-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211194704.28913-1-shubhunic@gmail.com>
References: <20210211194704.28913-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests use a deprecated style in which there are unnecessary
blank lines after the opening quote of the test body and before the
closing quote. So we should remove these unnecessary blank lines.

Signed-off-by: Shubham Verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 0f74c6339c..e98b44f7a1 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -182,7 +182,6 @@ test_expect_success "Sergey Vlasov's test case" '
 '
 
 test_expect_success 'absolute pathname' '(
-
 	rm -fr mine &&
 	mkdir mine &&
 	cd mine &&
@@ -196,12 +195,9 @@ test_expect_success 'absolute pathname' '(
 	! test -d sub &&
 	test -d in &&
 	git ls-files --error-unmatch in/file
-
-
 )'
 
 test_expect_success 'absolute pathname outside should fail' '(
-
 	rm -fr mine &&
 	mkdir mine &&
 	cd mine &&
@@ -216,7 +212,6 @@ test_expect_success 'absolute pathname outside should fail' '(
 	test -d sub &&
 	! test -d ../in &&
 	git ls-files --error-unmatch sub/file
-
 )'
 
 test_expect_success 'git mv to move multiple sources into a directory' '
@@ -232,7 +227,6 @@ test_expect_success 'git mv to move multiple sources into a directory' '
 '
 
 test_expect_success 'git mv should not change sha1 of moved cache entry' '
-
 	rm -fr .git &&
 	git init &&
 	echo 1 >dirty &&
@@ -243,7 +237,6 @@ test_expect_success 'git mv should not change sha1 of moved cache entry' '
 	echo 2 >dirty2 &&
 	git mv dirty2 dirty &&
 	[ "$entry" = "$(git ls-files --stage dirty | cut -f 1)" ]
-
 '
 
 rm -f dirty dirty2
@@ -266,7 +259,6 @@ test_expect_success 'git mv error on conflicted file' '
 '
 
 test_expect_success 'git mv should overwrite symlink to a file' '
-
 	rm -fr .git &&
 	git init &&
 	echo 1 >moved &&
@@ -279,13 +271,11 @@ test_expect_success 'git mv should overwrite symlink to a file' '
 	test "$(cat symlink)" = 1 &&
 	git update-index --refresh &&
 	git diff-files --quiet
-
 '
 
 rm -f moved symlink
 
 test_expect_success 'git mv should overwrite file with a symlink' '
-
 	rm -fr .git &&
 	git init &&
 	echo 1 >moved &&
@@ -296,11 +286,9 @@ test_expect_success 'git mv should overwrite file with a symlink' '
 	! test -e symlink &&
 	git update-index --refresh &&
 	git diff-files --quiet
-
 '
 
 test_expect_success SYMLINKS 'check moved symlink' '
-
 	test -h moved
 '
 
-- 
2.25.1

