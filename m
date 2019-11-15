Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,WEIRD_QUOTING shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49E51F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKOJGD (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:06:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:48244 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725829AbfKOJGC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:06:02 -0500
Received: (qmail 31647 invoked by uid 109); 15 Nov 2019 09:06:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Nov 2019 09:06:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16401 invoked by uid 111); 15 Nov 2019 09:09:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Nov 2019 04:09:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 15 Nov 2019 04:06:01 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     NAKAYAMA DAISUKE <nakyamad@icloud.com>
Subject: [PATCH 2/4] t/gitweb-lib.sh: drop confusing quotes
Message-ID: <20191115090601.GB21987@sigill.intra.peff.net>
References: <20191115090545.GA30971@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115090545.GA30971@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some variables assignments in gitweb_run() look like this:

  FOO=""$1""

The extra quotes aren't doing anything. Each set opens and closes an
empty string, and $1 is actually outside of any double-quotes (which is
OK, because variable assignment does not do whitespace splitting on the
expanded value).

Let's drop them, as they're simply confusing.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/gitweb-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 006d2a8152..130c7ed64f 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -58,8 +58,8 @@ gitweb_run () {
 	GATEWAY_INTERFACE='CGI/1.1'
 	HTTP_ACCEPT='*/*'
 	REQUEST_METHOD='GET'
-	QUERY_STRING=""$1""
-	PATH_INFO=""$2""
+	QUERY_STRING=$1
+	PATH_INFO=$2
 	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD \
 		QUERY_STRING PATH_INFO
 
-- 
2.24.0.739.gb5632e4929

