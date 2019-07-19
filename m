Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9342E1F461
	for <e@80x24.org>; Fri, 19 Jul 2019 21:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfGSV4L (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 17:56:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:40668 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727344AbfGSV4L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 17:56:11 -0400
Received: (qmail 8692 invoked by uid 109); 19 Jul 2019 21:56:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jul 2019 21:56:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29184 invoked by uid 111); 19 Jul 2019 21:57:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jul 2019 17:57:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jul 2019 17:56:09 -0400
Date:   Fri, 19 Jul 2019 17:56:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v3 2/6] t5310: increase the number of bitmapped commits
Message-ID: <20190719215609.GB32188@sigill.intra.peff.net>
References: <20190719215417.GA31841@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190719215417.GA31841@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bitmap index we compute in t5310 has only 20 commits in it. This
gives poor coverage of bitmap_writer_select_commits(), which simply
writes a bitmap for everything when there are fewer than 100 commits.

Let's bump the number of commits in the test to cover the more complex
code paths (this does drop coverage of the individual lines of the
trivial path, but the complex path does everything it does and more).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5310-pack-bitmaps.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 3aab7024ca..6640329ebf 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -21,7 +21,7 @@ has_any () {
 }
 
 test_expect_success 'setup repo with moderate-sized history' '
-	test_commit_bulk --id=file 10 &&
+	test_commit_bulk --id=file 100 &&
 	git checkout -b other HEAD~5 &&
 	test_commit_bulk --id=side 10 &&
 	git checkout master &&
-- 
2.22.0.993.gcc1030c86b

