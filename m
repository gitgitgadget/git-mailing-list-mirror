Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA68C2D0DB
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A6321582
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grQUvmpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfL0Nrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:41 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41807 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfL0Nrk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:40 -0500
Received: by mail-qv1-f65.google.com with SMTP id x1so10053872qvr.8
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EQtUtvk0AIv97glR8qlAjrNj9xKQXSc7sXN9og5/4T0=;
        b=grQUvmpTftD4hbXmkVZNs1CUZcLNR6mndu2hiUDgXUwcUD1atg215QG0h6qgS4KwRH
         esKPrh3CjhjJS+Afu0sxuBbFNaS+9UW7xE7qcWpl9B4MOiw0yoDP0LjLJ5VjvtpwqqRn
         yFjcdoLLxlgT9Wmm/0T6L9+VFGTlv1rYPjj7BJjYFB6NVRxkhaB9jiL3vzRb9y+vFRJD
         1JE2jE7meSQgkteXrsDyIUQ4QBULO1VF7KvE8MRUcEV1VQiPo4hpl69TyNQZBmEtg04o
         ZDnvzg2OrofEII5oleVETxWBoszLRZgLV/DjWLQ2GZxnRRS7ZDpJdDIBBV3XCDJ7V0w8
         Qw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQtUtvk0AIv97glR8qlAjrNj9xKQXSc7sXN9og5/4T0=;
        b=uT0d5u/yjvWfvn11dMcYCKr45+sZY+CLSzfga5nm3Oq/OrX48lPrcxX9yFpOsW8iTW
         y+CZ5Rvc41voPJw3WCA4eCl1gLRzGd4x1xFXPdxqEhA70p6HHqwjQuTd+w04Lyoqohe2
         ITn5Fvml1jzSweeu9K00JGtWUvI6nUEGIPo9CI9RiukiqziOVkpKXNAQGvN6jcFxxn6/
         xhU1HPFD4QoyU4+lLbw8AFUsq7JmpO0Qhd5KcT6jkyudXIdOcX0AXKAc9X1CTyM8/oaR
         IWF/ZhOM4g7QJ4f1vUtFMRx1iF07f5YWNb8HZzUNRwfCrH+njAigKX1uCuQnsAPRZF7R
         CyWQ==
X-Gm-Message-State: APjAAAV448lIvJjmV1vHJtvRQNHrU1SxXTCu6NZnmfw2vJkZMSgcLnGi
        TypIrnpV1tosmIw+e3+/A/O29LgV
X-Google-Smtp-Source: APXvYqxCIFRPj5SWT15Zd9q3HufzQ77h3MdbhQ9DO/uUhJnt6UeQA04b9MeUlPcGhOzNaWZxzp5FrQ==
X-Received: by 2002:ad4:450a:: with SMTP id k10mr37813493qvu.136.1577454459114;
        Fri, 27 Dec 2019 05:47:39 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:38 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 04/16] t2018: teach do_checkout() to accept `!` arg
Date:   Fri, 27 Dec 2019 08:47:13 -0500
Message-Id: <4eab751a3cf00bbffaf4b1084928dad264fa1572.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, we were running `test_must_fail do_checkout`. However,
`test_must_fail` should only be used on git commands. Teach
do_checkout() to accept `!` as a potential first argument which will
prepend `test_must_fail` to the enclosed git command and skips the
remainder of the function.

This increases the granularity of the test as, instead of blindly
checking that do_checkout() failed, we check that only the specific
expected invocation of git fails.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t2018-checkout-branch.sh | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index e6b852939c..43551332ed 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -13,6 +13,12 @@ test_description='checkout'
 #
 # If <checkout options> is not specified, "git checkout" is run with -b.
 do_checkout () {
+	should_fail= &&
+	if test "x$1" = "x!"
+	then
+		should_fail=test_must_fail &&
+		shift
+	fi &&
 	exp_branch=$1 &&
 	exp_ref="refs/heads/$exp_branch" &&
 
@@ -26,10 +32,13 @@ do_checkout () {
 		opts="$3"
 	fi
 
-	git checkout $opts $exp_branch $exp_sha &&
+	$should_fail git checkout $opts $exp_branch $exp_sha &&
 
-	test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
-	test $exp_sha = $(git rev-parse --verify HEAD)
+	if test -z "$should_fail"
+	then
+		test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
+		test $exp_sha = $(git rev-parse --verify HEAD)
+	fi
 }
 
 test_dirty_unmergeable () {
@@ -92,7 +101,7 @@ test_expect_success 'checkout -b to a new branch, set to an explicit ref' '
 
 test_expect_success 'checkout -b to a new branch with unmergeable changes fails' '
 	setup_dirty_unmergeable &&
-	test_must_fail do_checkout branch2 $HEAD1 &&
+	do_checkout ! branch2 $HEAD1 &&
 	test_dirty_unmergeable
 '
 
@@ -126,7 +135,7 @@ test_expect_success 'checkout -f -b to a new branch with mergeable changes disca
 
 test_expect_success 'checkout -b to an existing branch fails' '
 	test_when_finished git reset --hard HEAD &&
-	test_must_fail do_checkout branch2 $HEAD2
+	do_checkout ! branch2 $HEAD2
 '
 
 test_expect_success 'checkout -b to @{-1} fails with the right branch name' '
@@ -165,7 +174,7 @@ test_expect_success 'checkout -B to an existing branch with unmergeable changes
 	git checkout branch1 &&
 
 	setup_dirty_unmergeable &&
-	test_must_fail do_checkout branch2 $HEAD1 -B &&
+	do_checkout ! branch2 $HEAD1 -B &&
 	test_dirty_unmergeable
 '
 
-- 
2.24.1.810.g65a2f617f4

