Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BD4C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA2B2071E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgI3Ma2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:30:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:45328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbgI3Ma2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:30:28 -0400
Received: (qmail 23980 invoked by uid 109); 30 Sep 2020 12:30:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:30:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28030 invoked by uid 111); 30 Sep 2020 12:30:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:30:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:30:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/10] test-advise: check argument count with argc instead of
 argv
Message-ID: <20200930123027.GH1901279@coredump.intra.peff.net>
References: <20200930122732.GA1901036@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930122732.GA1901036@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We complain if "test-tool advise" is not given an argument, but we
quietly ignore any additional arguments it receives. Let's instead check
that we got the expected number. As a bonus, this silences
-Wunused-parameter, which notes that we don't ever look at argc.

While we're here, we can also fix the indentation in the conditional.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-advise.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index 38cdc2884e..a7043df1d3 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -5,8 +5,8 @@
 
 int cmd__advise_if_enabled(int argc, const char **argv)
 {
-	if (!argv[1])
-	die("usage: %s <advice>", argv[0]);
+	if (argc != 2)
+		die("usage: %s <advice>", argv[0]);
 
 	setup_git_directory();
 	git_config(git_default_config, NULL);
-- 
2.28.0.1173.gad90222cf0

