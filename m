Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37909201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 21:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbdBXVPB (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 16:15:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:33632 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbdBXVPB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 16:15:01 -0500
Received: (qmail 12850 invoked by uid 109); 24 Feb 2017 21:08:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 21:08:19 +0000
Received: (qmail 1280 invoked by uid 111); 24 Feb 2017 21:08:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 16:08:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 16:08:16 -0500
Date:   Fri, 24 Feb 2017 16:08:16 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: [PATCH 3/3] parse_hide_refs_config: tell parse_config_key we don't
 want a subsection
Message-ID: <20170224210816.ftcfa4jy4wltv2b7@sigill.intra.peff.net>
References: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170224210643.max6z2ykm3gbg7lw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This lets us avoid declaring some otherwise useless
variables.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 21bc8c910..b9188908b 100644
--- a/refs.c
+++ b/refs.c
@@ -1034,11 +1034,10 @@ static struct string_list *hide_refs;
 
 int parse_hide_refs_config(const char *var, const char *value, const char *section)
 {
-	const char *subsection, *key;
-	int subsection_len;
+	const char *key;
 	if (!strcmp("transfer.hiderefs", var) ||
-	    (!parse_config_key(var, section, &subsection, &subsection_len, &key)
-	    && !subsection && !strcmp(key, "hiderefs"))) {
+	    (!parse_config_key(var, section, NULL, NULL, &key) &&
+	     !strcmp(key, "hiderefs"))) {
 		char *ref;
 		int len;
 
-- 
2.12.0.616.g5f622f3b1
