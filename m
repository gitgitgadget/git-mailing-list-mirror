Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2BDC43334
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 08:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiGFIAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiGFIAX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 04:00:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B6237FB
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 01:00:18 -0700 (PDT)
Received: (qmail 2287 invoked by uid 109); 6 Jul 2022 08:00:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Jul 2022 08:00:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18060 invoked by uid 111); 6 Jul 2022 08:00:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Jul 2022 04:00:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Jul 2022 04:00:12 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/3] clone: drop extra newline from warning message
Message-ID: <YsVBDK0CNLfWMgEG@coredump.intra.peff.net>
References: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need to put a "\n" in calls to warning(), since it adds one
itself (and the user sees an extra blank line). Drop it, and while we're
here, drop the full-stop from the message, which goes against our
guidelines.

This bug dates all the way back to 8434c2f1af (Build in clone,
2008-04-27), but presumably nobody noticed because it's hard to trigger:
you have to clone a repository whose HEAD is unborn, but which is not
otherwise empty.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 89a91b0017..f596cedcf1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -672,7 +672,7 @@ static int checkout(int submodule_progress, int filter_submodules)
 	head = resolve_refdup("HEAD", RESOLVE_REF_READING, &oid, NULL);
 	if (!head) {
 		warning(_("remote HEAD refers to nonexistent ref, "
-			  "unable to checkout.\n"));
+			  "unable to checkout"));
 		return 0;
 	}
 	if (!strcmp(head, "HEAD")) {
-- 
2.37.0.408.g2817302ee7

