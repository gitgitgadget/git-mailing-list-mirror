Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FC0C0015E
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjGCGoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjGCGoK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4154E8
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:09 -0700 (PDT)
Received: (qmail 14039 invoked by uid 109); 3 Jul 2023 06:44:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2619 invoked by uid 111); 3 Jul 2023 06:44:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/14] http-push: mark unused parameter in xml callback
Message-ID: <20230703064408.GD3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The xml_start_tag() function is passed the expat library's
XML_SetElementHandler() function, so it has to conform to the
expected interface. But we don't actually care about the attributes
list. Mark it so that -Wunused-parameter does not complain.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 9ab2383d2b..a704f490fd 100644
--- a/http-push.c
+++ b/http-push.c
@@ -783,7 +783,7 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 static void one_remote_ref(const char *refname);
 
 static void
-xml_start_tag(void *userData, const char *name, const char **atts)
+xml_start_tag(void *userData, const char *name, const char **atts UNUSED)
 {
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
 	const char *c = strchr(name, ':');
-- 
2.41.0.586.g3c0cc15bc7

