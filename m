Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D055EC4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFAF2076E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgI3M1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:27:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:45282 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgI3M1y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:27:54 -0400
Received: (qmail 23891 invoked by uid 109); 30 Sep 2020 12:27:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:27:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27894 invoked by uid 111); 30 Sep 2020 12:27:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:27:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:27:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/10] convert: drop unused crlf_action from
 check_global_conv_flags_eol()
Message-ID: <20200930122753.GA1901279@coredump.intra.peff.net>
References: <20200930122732.GA1901036@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930122732.GA1901036@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The crlf_action parameter hasn't been used since a0ad53c181 (convert:
Correct NNO tests and missing `LF will be replaced by CRLF`,
2016-08-13), where that part of the function was hoisted out to a
separate will_convert_lf_to_crlf() helper. Let's drop the useless
parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 convert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 8e6c292421..ee360c2f07 100644
--- a/convert.c
+++ b/convert.c
@@ -195,7 +195,7 @@ static enum eol output_eol(enum crlf_action crlf_action)
 	return core_eol;
 }
 
-static void check_global_conv_flags_eol(const char *path, enum crlf_action crlf_action,
+static void check_global_conv_flags_eol(const char *path,
 			    struct text_stat *old_stats, struct text_stat *new_stats,
 			    int conv_flags)
 {
@@ -547,7 +547,7 @@ static int crlf_to_git(const struct index_state *istate,
 			new_stats.crlf += new_stats.lonelf;
 			new_stats.lonelf = 0;
 		}
-		check_global_conv_flags_eol(path, crlf_action, &stats, &new_stats, conv_flags);
+		check_global_conv_flags_eol(path, &stats, &new_stats, conv_flags);
 	}
 	if (!convert_crlf_into_lf)
 		return 0;
-- 
2.28.0.1173.gad90222cf0

