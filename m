Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E85B202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 19:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbdKGTgC (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 14:36:02 -0500
Received: from siwi.pair.com ([209.68.5.199]:44339 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbdKGTf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 14:35:59 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5211E8453B;
        Tue,  7 Nov 2017 14:35:59 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BAA1284537;
        Tue,  7 Nov 2017 14:35:58 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 2/6] oidmap: add oidmap iterator methods
Date:   Tue,  7 Nov 2017 19:35:42 +0000
Message-Id: <20171107193546.10017-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171107193546.10017-1-git@jeffhostetler.com>
References: <20171107193546.10017-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add the usual map iterator functions to oidmap.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 oidmap.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/oidmap.h b/oidmap.h
index 18f54cd..d3cd2bb 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -65,4 +65,26 @@ extern void *oidmap_put(struct oidmap *map, void *entry);
  */
 extern void *oidmap_remove(struct oidmap *map, const struct object_id *key);
 
+
+struct oidmap_iter {
+	struct hashmap_iter h_iter;
+};
+
+static inline void oidmap_iter_init(struct oidmap *map, struct oidmap_iter *iter)
+{
+	hashmap_iter_init(&map->map, &iter->h_iter);
+}
+
+static inline void *oidmap_iter_next(struct oidmap_iter *iter)
+{
+	return hashmap_iter_next(&iter->h_iter);
+}
+
+static inline void *oidmap_iter_first(struct oidmap *map,
+				      struct oidmap_iter *iter)
+{
+	oidmap_iter_init(map, iter);
+	return oidmap_iter_next(iter);
+}
+
 #endif
-- 
2.9.3

