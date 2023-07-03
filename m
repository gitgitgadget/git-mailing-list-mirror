Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD4AEB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGCGoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjGCGoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B3CCD
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:03 -0700 (PDT)
Received: (qmail 14019 invoked by uid 109); 3 Jul 2023 06:44:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2613 invoked by uid 111); 3 Jul 2023 06:44:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/14] do_for_each_ref_helper(): mark unused repository
 parameter
Message-ID: <20230703064402.GB3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function gets a repository parameter because it's a callback for
do_for_each_repo_ref_iterator(). But it's just a wrapper that passes
along each call to a regular each_ref_fn callback, and the latter
doesn't accept a repository argument.

Probably in the long run all of the each_ref_fn callbacks should get a
repository parameter, too. But changing that now would require updates
all over the code base. Until that happens, let's annotate this wrapper
callback to quiet the compiler's -Wunused-parameter warning.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index c029f64982..edeae90ebb 100644
--- a/refs.c
+++ b/refs.c
@@ -1588,7 +1588,7 @@ struct do_for_each_ref_help {
 	void *cb_data;
 };
 
-static int do_for_each_ref_helper(struct repository *r,
+static int do_for_each_ref_helper(struct repository *r UNUSED,
 				  const char *refname,
 				  const struct object_id *oid,
 				  int flags,
-- 
2.41.0.586.g3c0cc15bc7

