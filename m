Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85DAA1F732
	for <e@80x24.org>; Wed, 31 Jul 2019 05:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfGaFhh (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 01:37:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:56550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725866AbfGaFhh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 01:37:37 -0400
Received: (qmail 11733 invoked by uid 109); 31 Jul 2019 05:37:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 05:37:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13971 invoked by uid 111); 31 Jul 2019 05:39:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 01:39:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 01:37:36 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Gregory Szorc <gregory.szorc@gmail.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Subject: [PATCH 1/3] t7700: clean up .keep file in bitmap-writing test
Message-ID: <20190731053735.GA16941@sigill.intra.peff.net>
References: <20190731053703.GA16709@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731053703.GA16709@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After our test snippet finishes, the .keep file is left in place, making
it hard to do further tests of the auto-bitmap-writing code (since it
suppresses the feature completely). Let's clean it up.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7700-repack.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 0e9af832c9..8d9a358df8 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -243,6 +243,7 @@ test_expect_success 'no bitmaps created if .keep files present' '
 	pack=$(ls bare.git/objects/pack/*.pack) &&
 	test_path_is_file "$pack" &&
 	keep=${pack%.pack}.keep &&
+	test_when_finished "rm -f \"\$keep\"" &&
 	>"$keep" &&
 	git -C bare.git repack -ad &&
 	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
-- 
2.23.0.rc0.426.gbdee707ba7

