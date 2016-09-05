Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 073B720705
	for <e@80x24.org>; Mon,  5 Sep 2016 21:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933325AbcIEVwO (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 17:52:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:38476 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932217AbcIEVwN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 17:52:13 -0400
Received: (qmail 7953 invoked by uid 109); 5 Sep 2016 21:52:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 21:52:12 +0000
Received: (qmail 22328 invoked by uid 111); 5 Sep 2016 21:52:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Sep 2016 17:52:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Sep 2016 17:52:10 -0400
Date:   Mon, 5 Sep 2016 17:52:10 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] t5305: move cleanup into test block
Message-ID: <20160905215209.pzuxtfprvfoppalt@sigill.intra.peff.net>
References: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160905215141.b6unqtjqko7775is@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We usually try to avoid doing any significant actions
outside of test blocks. Although "rm -rf" is unlikely to
either fail or to generate output, moving these to the
point of use makes it more clear that they are part of the
overall setup of "clone.git".

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5305-include-tag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index f314ad5..6018404 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -25,7 +25,6 @@ test_expect_success setup '
 	} >obj-list
 '
 
-rm -rf clone.git
 test_expect_success 'pack without --include-tag' '
 	packname_1=$(git pack-objects \
 		--window=0 \
@@ -33,6 +32,7 @@ test_expect_success 'pack without --include-tag' '
 '
 
 test_expect_success 'unpack objects' '
+	rm -rf clone.git &&
 	(
 		GIT_DIR=clone.git &&
 		export GIT_DIR &&
@@ -51,7 +51,6 @@ test_expect_success 'check unpacked result (have commit, no tag)' '
 	test_cmp list.expect list.actual
 '
 
-rm -rf clone.git
 test_expect_success 'pack with --include-tag' '
 	packname_1=$(git pack-objects \
 		--window=0 \
@@ -60,6 +59,7 @@ test_expect_success 'pack with --include-tag' '
 '
 
 test_expect_success 'unpack objects' '
+	rm -rf clone.git &&
 	(
 		GIT_DIR=clone.git &&
 		export GIT_DIR &&
-- 
2.10.0.rc2.154.gb4a4b8b

