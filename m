Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8A2C83F29
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 07:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjHaHUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjHaHUb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 03:20:31 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA931A3
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 00:20:28 -0700 (PDT)
Received: (qmail 21404 invoked by uid 109); 31 Aug 2023 07:20:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 07:20:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3557 invoked by uid 111); 31 Aug 2023 07:20:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 03:20:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 03:20:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 8/8] parse-options: mark unused parameters in noop callback
Message-ID: <20230831072027.GF3197751@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831070935.GA3197495@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unsurprisingly, the noop options callback doesn't bother to look at any
of its parameters. Let's mark them so that -Wunused-parameter does not
complain.

Another option would be to drop the callback and have parse-options
itself recognize OPT_NOOP_NOARG. But that seems like extra work for no
real benefit.

Signed-off-by: Jeff King <peff@peff.net>
---
 parse-options-cb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index a24521dee0..bdc7fae497 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -227,7 +227,9 @@ int parse_opt_strvec(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
+int parse_opt_noop_cb(const struct option *opt UNUSED,
+		      const char *arg UNUSED,
+		      int unset UNUSED)
 {
 	return 0;
 }
-- 
2.42.0.561.gaa987ecc69
