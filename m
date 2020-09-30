Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147E1C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CACAD2071E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgI3M3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:29:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:45306 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3M3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:29:10 -0400
Received: (qmail 23937 invoked by uid 109); 30 Sep 2020 12:29:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:29:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27964 invoked by uid 111); 30 Sep 2020 12:29:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:29:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:29:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/10] push: drop unused repo argument to do_push()
Message-ID: <20200930122909.GE1901279@coredump.intra.peff.net>
References: <20200930122732.GA1901036@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930122732.GA1901036@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We stopped using the "repo" argument in 8e4c8af058 (push: disallow --all
and refspecs when remote.<name>.mirror is set, 2019-09-02), which moved
the pushremote handling to its caller.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/push.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 0eeb2c8dd5..6da3a8e5d3 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -379,7 +379,7 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 	return 1;
 }
 
-static int do_push(const char *repo, int flags,
+static int do_push(int flags,
 		   const struct string_list *push_options,
 		   struct remote *remote)
 {
@@ -629,7 +629,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		if (strchr(item->string, '\n'))
 			die(_("push options must not have new line characters"));
 
-	rc = do_push(repo, flags, push_options, remote);
+	rc = do_push(flags, push_options, remote);
 	string_list_clear(&push_options_cmdline, 0);
 	string_list_clear(&push_options_config, 0);
 	if (rc == -1)
-- 
2.28.0.1173.gad90222cf0

