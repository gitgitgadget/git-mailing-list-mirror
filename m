Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C36C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 09:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7EA20702
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 09:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgA3JwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:52:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:48318 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726882AbgA3JwU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 04:52:20 -0500
Received: (qmail 26028 invoked by uid 109); 30 Jan 2020 09:52:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 09:52:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22601 invoked by uid 111); 30 Jan 2020 10:00:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 05:00:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 04:52:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] normalize_path_copy(): document "dst" size expectations
Message-ID: <20200130095219.GA840531@coredump.intra.peff.net>
References: <20200130095155.GA839988@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200130095155.GA839988@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We take a "dst" buffer to write into, but there's no matching "len"
parameter. The hidden assumption is that normalizing always makes things
smaller, so we're OK as long as "dst" is at least as big as "src". Let's
document that explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
 path.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/path.c b/path.c
index a76eec8b96..88cf593007 100644
--- a/path.c
+++ b/path.c
@@ -1077,6 +1077,8 @@ const char *remove_leading_path(const char *in, const char *prefix)
 
 /*
  * It is okay if dst == src, but they should not overlap otherwise.
+ * The "dst" buffer must be at least as long as "src"; normalizing may shrink
+ * the size of the path, but will never grow it.
  *
  * Performs the following normalizations on src, storing the result in dst:
  * - Ensures that components are separated by '/' (Windows only)
-- 
2.25.0.515.gaba5347bc6

