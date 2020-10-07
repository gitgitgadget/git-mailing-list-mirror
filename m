Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30812C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0D221775
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgJGST5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:19:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:52650 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgJGST5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 14:19:57 -0400
Received: (qmail 21288 invoked by uid 109); 7 Oct 2020 18:19:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Oct 2020 18:19:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14933 invoked by uid 111); 7 Oct 2020 18:19:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Oct 2020 14:19:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Oct 2020 14:19:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: [PATCH 3/3] index-pack: stop mentioning find_unresolved_deltas()
Message-ID: <20201007181956.GC1976631@coredump.intra.peff.net>
References: <20201007181708.GA222564@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007181708.GA222564@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A comment mentions that we may free cached delta bases via
find_unresolved_deltas(), but that function went away in f08cbf60fe
(index-pack: make quantum of work smaller, 2020-09-08). Its call to
prune_base_data() was moved into threaded_second_pass(), so just refer
to that.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f8f1b48e56..e36f05f7a3 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -898,7 +898,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
  * parents, possibly up to the top base.
  *
  * All deflated objects here are subject to be freed if we exceed
- * delta_base_cache_limit, just like in find_unresolved_deltas(), we
+ * delta_base_cache_limit, just like in threaded_second_pass(), we
  * just need to make sure the last node is not freed.
  */
 static void *get_base_data(struct base_data *c)
-- 
2.29.0.rc0.520.gccaf68d5cd
