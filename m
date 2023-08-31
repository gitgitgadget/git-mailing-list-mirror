Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7552FC83F2F
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 21:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347524AbjHaVXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347549AbjHaVXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 17:23:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2900E1703
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 14:22:28 -0700 (PDT)
Received: (qmail 26039 invoked by uid 109); 31 Aug 2023 21:22:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 21:22:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11618 invoked by uid 111); 31 Aug 2023 21:22:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 17:22:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 17:22:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 10/10] parse-options: mark unused parameters in noop
 callback
Message-ID: <20230831212220.GJ949469@coredump.intra.peff.net>
References: <20230831211637.GA949188@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831211637.GA949188@coredump.intra.peff.net>
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
