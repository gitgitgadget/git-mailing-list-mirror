Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A5E51F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKOJGG (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:06:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:48250 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727002AbfKOJGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:06:06 -0500
Received: (qmail 31655 invoked by uid 109); 15 Nov 2019 09:06:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Nov 2019 09:06:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16418 invoked by uid 111); 15 Nov 2019 09:09:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Nov 2019 04:09:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Nov 2019 04:06:04 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     NAKAYAMA DAISUKE <nakyamad@icloud.com>
Subject: [PATCH 3/4] t/gitweb-lib.sh: set $REQUEST_URI
Message-ID: <20191115090604.GC21987@sigill.intra.peff.net>
References: <20191115090545.GA30971@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115090545.GA30971@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a real webserver's CGI call, gitweb.cgi would typically see
$REQUEST_URI set. This variable does impact how we display our URL in
the resulting page, so let's try to make our test as realistic as
possible (we can just use the $PATH_INFO our caller passed in, if any).

This doesn't change the outcome of any tests, but it will help us add
some new tests in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/gitweb-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 130c7ed64f..1f32ca66ea 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -60,8 +60,9 @@ gitweb_run () {
 	REQUEST_METHOD='GET'
 	QUERY_STRING=$1
 	PATH_INFO=$2
+	REQUEST_URI=/gitweb.cgi$PATH_INFO
 	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
-		QUERY_STRING PATH_INFO
+		QUERY_STRING PATH_INFO REQUEST_URI
 
 	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
 	export GITWEB_CONFIG
-- 
2.24.0.739.gb5632e4929

