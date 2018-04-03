Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255F31F404
	for <e@80x24.org>; Tue,  3 Apr 2018 14:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeDCOBo (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 10:01:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:51854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750784AbeDCOBn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 10:01:43 -0400
Received: (qmail 32456 invoked by uid 109); 3 Apr 2018 14:01:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Apr 2018 14:01:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25625 invoked by uid 111); 3 Apr 2018 14:02:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Apr 2018 10:02:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2018 10:01:41 -0400
Date:   Tue, 3 Apr 2018 10:01:41 -0400
From:   Jeff King <peff@peff.net>
To:     Jens =?utf-8?Q?Kr=C3=BCger?= <Jens.Krueger@frm2.tum.de>
Cc:     Git List <git@vger.kernel.org>
Subject: [PATCH 1/2] t5561: drop curl stderr redirects
Message-ID: <20180403140140.GA30376@sigill.intra.peff.net>
References: <20180403140055.GA29556@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180403140055.GA29556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a normal test run, stderr is already redirected to
/dev/null by the test suite. When used with "-v",
suppressing stderr is actively harmful, as it may hide the
reason for curl failing.

Reported-by: Jens Krüger <Jens.Krueger@frm2.tum.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5561-http-backend.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 90e0d6f0fe..6167563986 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -6,7 +6,7 @@ test_description='test git-http-backend'
 start_httpd
 
 GET() {
-	curl --include "$HTTPD_URL/$SMART/repo.git/$1" >out 2>/dev/null &&
+	curl --include "$HTTPD_URL/$SMART/repo.git/$1" >out &&
 	tr '\015' Q <out |
 	sed '
 		s/Q$//
@@ -19,7 +19,7 @@ GET() {
 POST() {
 	curl --include --data "$2" \
 	--header "Content-Type: application/x-$1-request" \
-	"$HTTPD_URL/smart/repo.git/$1" >out 2>/dev/null &&
+	"$HTTPD_URL/smart/repo.git/$1" >out &&
 	tr '\015' Q <out |
 	sed '
 		s/Q$//
-- 
2.17.0.686.g08b0810b04

