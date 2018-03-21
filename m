Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338441F404
	for <e@80x24.org>; Wed, 21 Mar 2018 05:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeCUFs4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 01:48:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:36986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750810AbeCUFsz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 01:48:55 -0400
Received: (qmail 29134 invoked by uid 109); 21 Mar 2018 05:48:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 05:48:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6952 invoked by uid 111); 21 Mar 2018 05:49:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 01:49:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 01:48:53 -0400
Date:   Wed, 21 Mar 2018 01:48:53 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/7] diff-highlight: prefer "echo" to "cat" in tests
Message-ID: <20180321054853.GC14016@sigill.intra.peff.net>
References: <20180321054718.GA13936@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321054718.GA13936@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We generate a bunch of one-line files whose contents match
their names, and then generate our commits by cat-ing those
files. Let's just echo the contents directly, which saves
some processes.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index deab90ed91..3f02d31467 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -68,26 +68,22 @@ test_strip_patch_header () {
 #	     D
 #
 dh_test_setup_history () {
-	echo "file1" >file1 &&
-	echo "file2" >file2 &&
-	echo "file3" >file3 &&
-
-	cat file1 >file &&
+	echo file1 >file &&
 	git add file &&
 	test_tick &&
 	git commit -m "D" &&
 
 	git checkout -b branch &&
-	cat file2 >file &&
+	echo file2 >file &&
 	test_tick &&
 	git commit -a -m "E" &&
 
-	cat file3 >file &&
+	echo file3 >file &&
 	test_tick &&
 	git commit -a -m "F" &&
 
 	git checkout master &&
-	cat file2 >file &&
+	echo file2 >file &&
 	test_tick &&
 	git commit -a -m "A"
 }
-- 
2.17.0.rc0.402.ged0b3fd1ee

