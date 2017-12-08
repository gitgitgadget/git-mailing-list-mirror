Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1128B20C32
	for <e@80x24.org>; Fri,  8 Dec 2017 10:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbdLHKBB (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 05:01:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:51916 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753954AbdLHJ6W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 04:58:22 -0500
Received: (qmail 32043 invoked by uid 109); 8 Dec 2017 09:58:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 09:58:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30740 invoked by uid 111); 8 Dec 2017 09:58:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 04:58:43 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 04:58:19 -0500
Date:   Fri, 8 Dec 2017 04:58:19 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] cvsimport: apply shell-quoting regex globally
Message-ID: <20171208095819.GA1899@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 5b4efea666 (cvsimport: shell-quote variable used in
backticks, 2017-09-11) tried to shell-quote a variable, but
forgot to use the "/g" modifier to apply the quoting to the
whole variable. This means we'd miss any embedded
single-quotes after the first one.

Reported-by: <littlelailo@yahoo.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 git-cvsimport.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 36929921ea..2d8df83172 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -642,7 +642,7 @@ sub is_sha1 {
 
 sub get_headref ($) {
 	my $name = shift;
-	$name =~ s/'/'\\''/;
+	$name =~ s/'/'\\''/g;
 	my $r = `git rev-parse --verify '$name' 2>/dev/null`;
 	return undef unless $? == 0;
 	chomp $r;
-- 
2.15.1.659.g8bd2eae3ea
