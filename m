Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC121CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 22:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjIRWdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRWdV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 18:33:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709891
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 15:33:15 -0700 (PDT)
Received: (qmail 13103 invoked by uid 109); 18 Sep 2023 22:33:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Sep 2023 22:33:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4743 invoked by uid 111); 18 Sep 2023 22:33:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Sep 2023 18:33:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Sep 2023 18:33:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: [PATCH 7/8] fsmonitor: mark unused hashmap callback parameters
Message-ID: <20230918223314.GG2659298@coredump.intra.peff.net>
References: <20230918222908.GA2659096@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918222908.GA2659096@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like many hashmap comparison functions, our cookies_cmp() does not look
at its extra void data parameter. This should have been annotated in
02c3c59e62 (hashmap: mark unused callback parameters, 2022-08-19), but
this new case was added around the same time (plus fsmonitor is not
built at all on Linux, so it is easy to miss there).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsmonitor--daemon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 7c4130c981..ce511c3ed6 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -129,8 +129,9 @@ struct fsmonitor_cookie_item {
 	enum fsmonitor_cookie_item_result result;
 };
 
-static int cookies_cmp(const void *data, const struct hashmap_entry *he1,
-		     const struct hashmap_entry *he2, const void *keydata)
+static int cookies_cmp(const void *data UNUSED,
+		       const struct hashmap_entry *he1,
+		       const struct hashmap_entry *he2, const void *keydata)
 {
 	const struct fsmonitor_cookie_item *a =
 		container_of(he1, const struct fsmonitor_cookie_item, entry);
-- 
2.42.0.671.g43fbf3903a

