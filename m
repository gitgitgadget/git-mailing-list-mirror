Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06BA1FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbdEZTIJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:08:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:58607 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932453AbdEZTHo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:07:44 -0400
Received: (qmail 21657 invoked by uid 109); 26 May 2017 19:07:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 19:07:44 +0000
Received: (qmail 32148 invoked by uid 111); 26 May 2017 19:08:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 15:08:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 May 2017 15:07:42 -0400
Date:   Fri, 26 May 2017 15:07:42 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 3/6] check_filename(): use skip_prefix
Message-ID: <20170526190742.d53haiwyr3uegbub@sigill.intra.peff.net>
References: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This avoids some magic numbers (and we'll be adding more
similar calls in a minute).

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 000ffa810..f2a8070bd 100644
--- a/setup.c
+++ b/setup.c
@@ -137,10 +137,9 @@ int check_filename(const char *prefix, const char *arg)
 	char *to_free = NULL;
 	struct stat st;
 
-	if (starts_with(arg, ":/")) {
-		if (arg[2] == '\0') /* ":/" is root dir, always exists */
+	if (skip_prefix(arg, ":/", &arg)) {
+		if (!*arg) /* ":/" is root dir, always exists */
 			return 1;
-		arg += 2;
 		prefix = NULL;
 	}
 
-- 
2.13.0.496.ge44ba89db

