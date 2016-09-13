Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE5B207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754811AbcIMDYJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:24:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:42321 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754778AbcIMDYI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:24:08 -0400
Received: (qmail 20386 invoked by uid 109); 13 Sep 2016 03:24:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:24:09 +0000
Received: (qmail 18610 invoked by uid 111); 13 Sep 2016 03:24:18 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:24:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:24:00 -0700
Date:   Mon, 12 Sep 2016 20:24:00 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 12/16] t1302: use "git -C"
Message-ID: <20160913032400.jw7kegfpvbydbfxq@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is shorter, and saves a subshell.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1302-repo-version.sh | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 9bcd349..f859809 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -25,10 +25,7 @@ test_expect_success 'setup' '
 test_expect_success 'gitdir selection on normal repos' '
 	echo 0 >expect &&
 	git config core.repositoryformatversion >actual &&
-	(
-		cd test &&
-		git config core.repositoryformatversion >../actual2
-	) &&
+	git -C test config core.repositoryformatversion >actual2 &&
 	test_cmp expect actual &&
 	test_cmp expect actual2
 '
@@ -36,35 +33,20 @@ test_expect_success 'gitdir selection on normal repos' '
 test_expect_success 'gitdir selection on unsupported repo' '
 	# Make sure it would stop at test2, not trash
 	echo 99 >expect &&
-	(
-		cd test2 &&
-		git config core.repositoryformatversion >../actual
-	) &&
+	git -C test2 config core.repositoryformatversion >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'gitdir not required mode' '
 	git apply --stat test.patch &&
-	(
-		cd test &&
-		git apply --stat ../test.patch
-	) &&
-	(
-		cd test2 &&
-		git apply --stat ../test.patch
-	)
+	git -C test apply --stat ../test.patch &&
+	git -C test2 apply --stat ../test.patch
 '
 
 test_expect_success 'gitdir required mode' '
 	git apply --check --index test.patch &&
-	(
-		cd test &&
-		git apply --check --index ../test.patch
-	) &&
-	(
-		cd test2 &&
-		test_must_fail git apply --check --index ../test.patch
-	)
+	git -C test apply --check --index ../test.patch &&
+	test_must_fail git -C test2 apply --check --index ../test.patch
 '
 
 check_allow () {
-- 
2.10.0.230.g6f8d04b

