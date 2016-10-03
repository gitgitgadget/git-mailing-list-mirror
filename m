Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0FDF207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbcJCUdz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:33:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:51412 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752161AbcJCUdy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:33:54 -0400
Received: (qmail 17189 invoked by uid 109); 3 Oct 2016 20:33:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:33:53 +0000
Received: (qmail 29635 invoked by uid 111); 3 Oct 2016 20:34:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:34:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:33:51 -0400
Date:   Mon, 3 Oct 2016 16:33:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 01/18] t5613: drop reachable_via function
Message-ID: <20161003203350.3u6ddr6ndr3jwr74@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was never used since its inception in dd05ea1
(test case for transitive info/alternates, 2006-05-07).
Which is just as well, since it mutates the repo state in a
way that would invalidate further tests, without cleaning up
after itself. Let's get rid of it so that nobody is tempted
to use it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5613-info-alternate.sh | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 9cd2626..e13f57d 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -6,16 +6,6 @@
 test_description='test transitive info/alternate entries'
 . ./test-lib.sh
 
-# test that a file is not reachable in the current repository
-# but that it is after creating a info/alternate entry
-reachable_via() {
-	alternate="$1"
-	file="$2"
-	if git cat-file -e "HEAD:$file"; then return 1; fi
-	echo "$alternate" >> .git/objects/info/alternate
-	git cat-file -e "HEAD:$file"
-}
-
 test_valid_repo() {
 	git fsck --full > fsck.log &&
 	test_line_count = 0 fsck.log
-- 
2.10.0.618.g82cc264

