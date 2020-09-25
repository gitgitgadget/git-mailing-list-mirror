Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36E5C4727F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8718A20936
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxlfTMcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgIYRDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYRDV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2F7C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d13so3108095pgl.6
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgaplaltBQYeqEYWxNUek72WSVLLhXd818GgBmGmTB4=;
        b=XxlfTMcUEb05+PLmAtHdhUoe0bFpnzv9Ctr4uu5TfDf3KYWKiUiSabYwhSjz8M2tAp
         fbtOv65v1+o3dQU6wt/YjvhFRwgzEp3jzIrbZHi3JutaWHYEIO+o13Yy14mLajdSlVL0
         +exHCYdug5n9X4pO82QcVC6SNMHuT8WmVbBlqNf+nJ5ZlFKkEI2pa0o5iVxj0a+fToA3
         a0BEDpZsVUPWlAJvJSOyfFsya8rrl1zfYrPU5A1lvtg84zw3lNHJc55L56TNfLEdT/N3
         bSxzJ17JwIGesNMlF9T3Qd02VX6z9otonb92D26itpsNz/ucLF3tTFeGQSwPKGRrUKb/
         9FKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgaplaltBQYeqEYWxNUek72WSVLLhXd818GgBmGmTB4=;
        b=r2RG1tz63DzbjdJ3gSDlpWM25Dq6MoXYiwFWo15koHQDFPj3QZETdLjUKZdGz7Fhm6
         800oxNKe6aH7in23XP4uwHd/UDR8fcZNPg0BGAMUDSugBu6ouiYefZZ4VNtia1qGBz2A
         Qnl+AupU0i9SZD4D8Uz7h0dn5os0vYx2FM28XJ0Sqs4LzV1y5T9v5n/ZCV4LLGenlHQj
         c+T2lwRKxV/UdYVv27BkUxfVCJTKlOta3Mhl5rRo4t3NtsoXI+7JHCxOYPNVn2pHnSqm
         AeWA5yhkIed0TRjqeX/6sPHrjtCJQWdqS9L9usWKdhdL+gJQrIpvGDF9eceIYTUiXB6T
         4DRQ==
X-Gm-Message-State: AOAM531Au+8f/c/clfJxhyAuwOOoitKwIA30fXjontvdqoHyKm/DGzmh
        pEHRJNregYh3nQby538Jscz9yq5KgGdd0A==
X-Google-Smtp-Source: ABdhPJwooriF+OxXLM5KUnJKebedBEL3yXGHX8zqwlowld7VzaLulKG8mnMkI3Hk430teshyax3sJQ==
X-Received: by 2002:a63:fd08:: with SMTP id d8mr843223pgh.223.1601053400335;
        Fri, 25 Sep 2020 10:03:20 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:19 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Cc:     Shubham Verma <shubhunic@gmail.com>
Subject: [PATCH 03/11] t7001: remove unnecessary blank lines
Date:   Fri, 25 Sep 2020 22:32:48 +0530
Message-Id: <20200925170256.11490-4-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
References: <20200925170256.11490-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shubham Verma <shubhunic@gmail.com>

Some tests use a deprecated style in which there are unnecessary
blank lines after the opening quote of the test body and before the
closing quote. So we should removed these unnecessary blank lines.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 7503233814..f63802442b 100755
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

