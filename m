Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B09F207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbcJCUeG (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:34:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:51418 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbcJCUeE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:34:04 -0400
Received: (qmail 17204 invoked by uid 109); 3 Oct 2016 20:34:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:34:04 +0000
Received: (qmail 29657 invoked by uid 111); 3 Oct 2016 20:34:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:34:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:34:01 -0400
Date:   Mon, 3 Oct 2016 16:34:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 03/18] t5613: use test_must_fail
Message-ID: <20161003203401.d4awnljukgqbku2n@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Besides being our normal style, this correctly checks for an
error exit() versus signal death.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5613-info-alternate.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 4548fb0..65074dd 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -46,10 +46,9 @@ git clone -l -s F G &&
 git clone --bare -l -s G H'
 
 test_expect_success 'invalidity of deepest repository' \
-'cd H && {
-	git fsck
-	test $? -ne 0
-}'
+'cd H &&
+test_must_fail git fsck
+'
 
 cd "$base_dir"
 
@@ -75,7 +74,8 @@ cd "$base_dir"
 test_expect_success 'that info/alternates is necessary' \
 'cd C &&
 rm -f .git/objects/info/alternates &&
-! (git fsck)'
+test_must_fail git fsck
+'
 
 cd "$base_dir"
 
@@ -89,7 +89,7 @@ cd "$base_dir"
 test_expect_success \
     'that relative alternate is only possible for current dir' '
     cd D &&
-    ! (git fsck)
+    test_must_fail git fsck
 '
 
 cd "$base_dir"
-- 
2.10.0.618.g82cc264

