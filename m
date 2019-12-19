Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB74C2D0C1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F43C2467F
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXIp2yP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfLSWVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:21:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40848 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfLSWVj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:21:39 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so4072572pfh.7
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/cHz9jXRyGP9I2nk3E8zlqOrVEHelcTSO/s6fkRs/BM=;
        b=HXIp2yP3YA5vTmuRnCtTJjVcwEb1Wuih8Qt7GC+sqaVjDiBRCMFbRhzS4FDCjxX46G
         cNJx0aNF/QK9IDjOkbnNLFz+3oJMPPgKSIc0DofWs+9wjw9E4a8qtp2Q7xCsnzEibiUR
         FZ9RTX0RpyB4Ea2/INHhVMiw49RN0PgzyvkvbOLUu+VBlYWILEibwkySqEcKZIh/ZbCu
         +oYCbbzhTUJUU+50B/DN4Q/vusK/mJlOWQoYA9tXu9WQJtz6jHpyJdEJrSuvwZzSwX0b
         DlABGyiVRkz3Ek2BFB8/VPPKnUKY5LIK3rtoNvHqh8w6GipvZicKhcS3+glEzLNc3LS/
         oMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/cHz9jXRyGP9I2nk3E8zlqOrVEHelcTSO/s6fkRs/BM=;
        b=kCo8oODFzc64ZANUKtvkAtGcch4vWmhVJrJD7KkEIdOg/Ns1atXG1lJ93z2ZNpqZo2
         Lyj7p3nECXs6qshHsvL7h9dOLp3wBSz4OgqK3Bs/LLtjBAMmR2waWoFoPdDtSPhKrBoF
         BzikQO7VVX7BGTTdyF/q6Qr2H2WEhD74rsaNd657v0FjPjCUQ+WYRGH6xoAUSAFW0lWN
         a3bt0ck/okQ0MOW7QkZP1iFTz+El6PwMEk0JWR9tE/ux9PmQB/Cu3UsaAknuevDYAQiB
         xNDj+Ixl56PTx2SlvJpCRUfBuVcoQLgGuvN8IfhDW3uPnhoQJoQnkmSBi+H7qxUVQQvu
         m31g==
X-Gm-Message-State: APjAAAXCikebkqh6UlqjiQ4+RahRBMoceslcBZO5YioSMh8z6kNmpsO1
        WAuXOS0R1aehkxsQsvoLsU+aXIY/
X-Google-Smtp-Source: APXvYqx4ZgzLxfNKGCuMSsSGYtkcfh6lRzssJ2WIA5ZnCC7dbp1y2jVe0BRgkK8qpIrMmS1LeP3hAQ==
X-Received: by 2002:a65:42ca:: with SMTP id l10mr11413514pgp.121.1576794098119;
        Thu, 19 Dec 2019 14:21:38 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id o19sm11428528pjr.2.2019.12.19.14.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:21:37 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/16] t0000: replace test_must_fail with run_sub_test_lib_test_err()
Date:   Thu, 19 Dec 2019 14:22:38 -0800
Message-Id: <778ae9052bb75c4f574519027917a78d6d61596b.1576794144.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <cover.1576794144.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com> <cover.1576794144.git.liu.denton@gmail.com>
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

