Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED1DC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2179A2073B
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgC3ODW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:03:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:55614 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727255AbgC3ODW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 10:03:22 -0400
Received: (qmail 15158 invoked by uid 109); 30 Mar 2020 14:03:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 14:03:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18713 invoked by uid 111); 30 Mar 2020 14:13:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 10:13:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 10:03:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/7] oid_array: use size_t for iteration
Message-ID: <20200330140320.GB2456038@coredump.intra.peff.net>
References: <20200330140247.GA476088@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200330140247.GA476088@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit started using size_t for our allocations. There are
some iterations that use int or unsigned, though. These aren't dangerous
with respect to memory, but they could produce incorrect results.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1-array.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1-array.c b/sha1-array.c
index 3eeadfede9..bada0c4353 100644
--- a/sha1-array.c
+++ b/sha1-array.c
@@ -46,7 +46,7 @@ int oid_array_for_each(struct oid_array *array,
 		       for_each_oid_fn fn,
 		       void *data)
 {
-	int i;
+	size_t i;
 
 	/* No oid_array_sort() here! See sha1-array.h */
 
@@ -62,7 +62,7 @@ int oid_array_for_each_unique(struct oid_array *array,
 			      for_each_oid_fn fn,
 			      void *data)
 {
-	int i;
+	size_t i;
 
 	if (!array->sorted)
 		oid_array_sort(array);
@@ -82,7 +82,7 @@ void oid_array_filter(struct oid_array *array,
 		      for_each_oid_fn want,
 		      void *cb_data)
 {
-	unsigned nr = array->nr, src, dst;
+	size_t nr = array->nr, src, dst;
 	struct object_id *oids = array->oid;
 
 	for (src = dst = 0; src < nr; src++) {
-- 
2.26.0.597.g7e08ed78ff

