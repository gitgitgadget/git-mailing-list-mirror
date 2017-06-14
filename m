Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D9A20401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbdFNK63 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:58:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:39971 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbdFNK61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:58:27 -0400
Received: (qmail 20824 invoked by uid 109); 14 Jun 2017 10:58:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 10:58:27 +0000
Received: (qmail 11197 invoked by uid 111); 14 Jun 2017 10:58:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 06:58:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 06:58:25 -0400
Date:   Wed, 14 Jun 2017 06:58:25 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 2/2] t: move "git add submodule" into test blocks
Message-ID: <20170614105825.zbxdgvcezuilpins@sigill.intra.peff.net>
References: <20170614105437.cgdlykmtocdj5vzw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170614105437.cgdlykmtocdj5vzw@sigill.intra.peff.net>
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
2.13.1.766.g6bea926c5
