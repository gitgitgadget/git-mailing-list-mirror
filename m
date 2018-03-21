Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0740F1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 05:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeCUFuA (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 01:50:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:37006 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750810AbeCUFt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 01:49:59 -0400
Received: (qmail 29208 invoked by uid 109); 21 Mar 2018 05:50:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Mar 2018 05:49:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6988 invoked by uid 111); 21 Mar 2018 05:50:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Mar 2018 01:50:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2018 01:49:57 -0400
Date:   Wed, 21 Mar 2018 01:49:57 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 5/7] diff-highlight: test graphs with --color
Message-ID: <20180321054957.GE14016@sigill.intra.peff.net>
References: <20180321054718.GA13936@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180321054718.GA13936@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our tests send git's output directly to files or pipes, so
there will never be any color. Let's do at least one --color
test to make sure that we can handle this case (which we
currently can, but will be an easy thing to mess up when we
touch the graph code in a future patch).

We'll just cover the --graph case, since this is much more
complex than the earlier cases (i.e., if it manages to
highlight, then the non-graph case definitely would).

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 33bcdbc90f..bf0c270d60 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -264,6 +264,15 @@ test_expect_success 'diff-highlight works with the --graph option' '
 	test_cmp graph.exp graph.act
 '
 
+# Just reuse the previous graph test, but with --color.  Our trimming
+# doesn't know about color, so just sanity check that something got
+# highlighted.
+test_expect_success 'diff-highlight works with color graph' '
+	git log --branches -p --date-order --graph --color |
+		"$DIFF_HIGHLIGHT" | trim_graph | left_trim >graph &&
+	grep "\[7m" graph
+'
+
 # Most combined diffs won't meet diff-highlight's line-number filter. So we
 # create one here where one side drops a line and the other modifies it. That
 # should result in a diff like:
-- 
2.17.0.rc0.402.ged0b3fd1ee

