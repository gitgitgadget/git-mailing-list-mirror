Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94598C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBA720866
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEEZc6Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfLTSOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:14:37 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55959 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLTSOg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:14:36 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so4439910pjz.5
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cHz9jXRyGP9I2nk3E8zlqOrVEHelcTSO/s6fkRs/BM=;
        b=LEEZc6Amvb3s1lthQgg8WV6PmqeKOniVg5CM4m9MqQMd9Sgkfe3do3nx9so1oTlQ61
         z6E019Zs/4DcuVFu8yRHh2kqEPnzlckCxvQq1HvSP0hq7ocq64Xu7lXpNTSmzDVEojSx
         2dqnzVK96FPdaOli/xMC32GJkZ4VWKizxiC4LOgklMLWt932cQLGryNXga8AaHC8HcEO
         W0XUL5u4NGoGtsirQVFOJ7lvLBvPOLEbDBpnyLqOaYfXbNjYzoNxjR4tKkutIg03fV7u
         jZaZIEpmVqqc3Y0wgeKyelOnq/c4ZaRL+49Rhs4ZWLQkRNLZ+ECFxPnHf3m6dzDdMtyo
         +WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cHz9jXRyGP9I2nk3E8zlqOrVEHelcTSO/s6fkRs/BM=;
        b=CqwpAARkL/IZVJdrLLtHsdh3jdkXIzDblDBxGNvSsQVP7sHr7gNDGJ4WZYX032V0hf
         PZ/ZB6coWHmsE5cW/F4Hr398Tw23ErsHMACYwKksrsu35WH9poMwlrFBEFmKvIHZ2sr1
         nzy5Vy5eXLCd/ECwqQknHD/85KpYkGdDebK89AXD53mfEbzrV4doLwbilU6HDZrQQZ4j
         3C+9HId3xgHeh5E6F5eJj8z5zJGQcXa/nHJNebhYNZX/SKFqMAjHdy5siN7zj1l38U4d
         2tVLczGvSQurcPIVYfZlZpDxD6YpExbO0lMfz5chEstPiXT3X1hc4HDHhoXSZIsTwpvk
         4e+Q==
X-Gm-Message-State: APjAAAXRVQPBSwNBN/4ISXhyXKq+6yvH8lmZMEum9VaHvzJkW6iyic77
        AFdC8SDyzqtq3zZrVk0uXzSC0urQ
X-Google-Smtp-Source: APXvYqzdqvd5xWTDdxAaCe7fjVugxxqBMGkL4fUlr6Cayn2IaWfhpgBOlfYsKE4hkf5b3TysosBuSQ==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr16944966plp.144.1576865675416;
        Fri, 20 Dec 2019 10:14:35 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id c78sm14063082pfb.122.2019.12.20.10.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:14:34 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/15] t0000: replace test_must_fail with run_sub_test_lib_test_err()
Date:   Fri, 20 Dec 2019 10:15:49 -0800
Message-Id: <51a2226726c941c1229e6aafa355376fdb6c61c5.1576865664.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576865663.git.liu.denton@gmail.com>
References: <cover.1576794144.git.liu.denton@gmail.com> <cover.1576865663.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. We use
test_must_fail to test run_sub_test_lib_test() but that function does
not invoke any git commands internally. Even better, we have a function
that's exactly meant to be used when we expect to have a failing test
suite: run_sub_test_lib_test_err()!

Replace `test_must_fail run_sub_test_lib_test` with
`run_sub_test_lib_test_err`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0000-basic.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 8a81a249d0..3e440c078d 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -155,7 +155,7 @@ test_expect_success 'pretend we have a fully passing test suite' "
 "
 
 test_expect_success 'pretend we have a partially passing test suite' "
-	test_must_fail run_sub_test_lib_test \
+	run_sub_test_lib_test_err \
 		partial-pass '2/3 tests passing' <<-\\EOF &&
 	test_expect_success 'passing test #1' 'true'
 	test_expect_success 'failing test #2' 'false'
@@ -219,7 +219,7 @@ test_expect_success 'pretend we have fixed one of two known breakages (run in su
 "
 
 test_expect_success 'pretend we have a pass, fail, and known breakage' "
-	test_must_fail run_sub_test_lib_test \
+	run_sub_test_lib_test_err \
 		mixed-results1 'mixed results #1' <<-\\EOF &&
 	test_expect_success 'passing test' 'true'
 	test_expect_success 'failing test' 'false'
@@ -238,7 +238,7 @@ test_expect_success 'pretend we have a pass, fail, and known breakage' "
 "
 
 test_expect_success 'pretend we have a mix of all possible results' "
-	test_must_fail run_sub_test_lib_test \
+	run_sub_test_lib_test_err \
 		mixed-results2 'mixed results #2' <<-\\EOF &&
 	test_expect_success 'passing test' 'true'
 	test_expect_success 'passing test' 'true'
@@ -274,7 +274,7 @@ test_expect_success 'pretend we have a mix of all possible results' "
 "
 
 test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
-	test_must_fail run_sub_test_lib_test \
+	run_sub_test_lib_test_err \
 		t1234-verbose "test verbose" --verbose <<-\EOF &&
 	test_expect_success "passing test" true
 	test_expect_success "test with output" "echo foo"
@@ -301,7 +301,7 @@ test_expect_success C_LOCALE_OUTPUT 'test --verbose' '
 '
 
 test_expect_success 'test --verbose-only' '
-	test_must_fail run_sub_test_lib_test \
+	run_sub_test_lib_test_err \
 		t2345-verbose-only-2 "test verbose-only=2" \
 		--verbose-only=2 <<-\EOF &&
 	test_expect_success "passing test" true
@@ -834,7 +834,7 @@ then
 fi
 
 test_expect_success 'tests clean up even on failures' "
-	test_must_fail run_sub_test_lib_test \
+	run_sub_test_lib_test_err \
 		failing-cleanup 'Failing tests with cleanup commands' <<-\\EOF &&
 	test_expect_success 'tests clean up even after a failure' '
 		touch clean-after-failure &&
@@ -863,7 +863,7 @@ test_expect_success 'tests clean up even on failures' "
 "
 
 test_expect_success 'test_atexit is run' "
-	test_must_fail run_sub_test_lib_test \
+	run_sub_test_lib_test_err \
 		atexit-cleanup 'Run atexit commands' -i <<-\\EOF &&
 	test_expect_success 'tests clean up even after a failure' '
 		> ../../clean-atexit &&
-- 
2.24.1.703.g2f499f1283

