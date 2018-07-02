Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9791F516
	for <e@80x24.org>; Mon,  2 Jul 2018 21:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbeGBVL0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 17:11:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:56858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753131AbeGBVLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 17:11:25 -0400
Received: (qmail 7881 invoked by uid 109); 2 Jul 2018 21:11:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Jul 2018 21:11:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27361 invoked by uid 111); 2 Jul 2018 21:11:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Jul 2018 17:11:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2018 17:11:23 -0400
Date:   Mon, 2 Jul 2018 17:11:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Aleksandr Makarov <aleksandr.o.makarov@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 1/3] t6300: add a test for --ignore-case
Message-ID: <20180702211122.GA23324@sigill.intra.peff.net>
References: <20180702211100.GA20885@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180702211100.GA20885@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --ignore-case option was added by 3bb16a8bf2 (tag,
branch, for-each-ref: add --ignore-case for sorting and
filtering, 2016-12-04), but it was never tested. And indeed,
it does not work due to multiple bugs (which will be fixed
in subsequent patches).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6300-for-each-ref.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 48379aa0ee..b2bc81103f 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -795,4 +795,15 @@ test_expect_success ':remotename and :remoteref' '
 	)
 '
 
+test_expect_failure 'for-each-ref --ignore-case ignores case' '
+	>expect &&
+	git for-each-ref --format="%(refname)" refs/heads/MASTER >actual &&
+	test_cmp expect actual &&
+
+	echo refs/heads/master >expect &&
+	git for-each-ref --format="%(refname)" --ignore-case \
+		refs/heads/MASTER >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.18.0.359.ge51c883f96

