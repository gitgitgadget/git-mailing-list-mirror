Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47A220282
	for <e@80x24.org>; Tue, 13 Jun 2017 09:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbdFMJYd (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 05:24:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:38927 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752543AbdFMJY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 05:24:27 -0400
Received: (qmail 21314 invoked by uid 109); 13 Jun 2017 09:24:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 09:24:21 +0000
Received: (qmail 21929 invoked by uid 111); 13 Jun 2017 09:24:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jun 2017 05:24:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jun 2017 05:24:20 -0400
Date:   Tue, 13 Jun 2017 05:24:20 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 2/2] t: move "git add submodule" into test blocks
Message-ID: <20170613092419.hzrtbn2jvykoxsry@sigill.intra.peff.net>
References: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some submodule tests do some setup outside of a test_expect
block. This is bad because we won't actually check the
outcome of those commands. But it's doubly so because "git
add submodule" now produces a warning to stderr, which is
not suppressed by the test scripts in non-verbose mode.

This patch does the minimal to fix the annoying warnings.
All three of these scripts could use more cleanup of related
setup.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4041-diff-submodule-option.sh             | 8 +++++---
 t/t4060-diff-submodule-option-diff-format.sh | 8 +++++---
 t/t7401-submodule-summary.sh                 | 8 +++++---
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 2d9731b52..058ee0829 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -430,9 +430,11 @@ test_expect_success 'deleted submodule' '
 	test_cmp expected actual
 '
 
-test_create_repo sm2 &&
-head7=$(add_file sm2 foo8 foo9) &&
-git add sm2
+test_expect_success 'create second submodule' '
+	test_create_repo sm2 &&
+	head7=$(add_file sm2 foo8 foo9) &&
+	git add sm2
+'
 
 test_expect_success 'multiple submodules' '
 	git diff-index -p --submodule=log HEAD >actual &&
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 33ec26d75..4b168d0ed 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -643,9 +643,11 @@ test_expect_success 'deleted submodule' '
 	test_cmp expected actual
 '
 
-test_create_repo sm2 &&
-head7=$(add_file sm2 foo8 foo9) &&
-git add sm2
+test_expect_success 'create second submodule' '
+	test_create_repo sm2 &&
+	head7=$(add_file sm2 foo8 foo9) &&
+	git add sm2
+'
 
 test_expect_success 'multiple submodules' '
 	git diff-index -p --submodule=diff HEAD >actual &&
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 366746f0d..4e4c45550 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -241,9 +241,11 @@ EOF
 	test_cmp expected actual
 "
 
-test_create_repo sm2 &&
-head7=$(add_file sm2 foo8 foo9) &&
-git add sm2
+test_expect_success 'create second submodule' '
+	test_create_repo sm2 &&
+	head7=$(add_file sm2 foo8 foo9) &&
+	git add sm2
+'
 
 test_expect_success 'multiple submodules' "
 	git submodule summary >actual &&
-- 
2.13.1.675.g57c06d071
