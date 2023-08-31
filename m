Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1BEC83F29
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbjHaGTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjHaGTU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:19:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21BE0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:19:17 -0700 (PDT)
Received: (qmail 21144 invoked by uid 109); 31 Aug 2023 06:19:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 06:19:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2961 invoked by uid 111); 31 Aug 2023 06:19:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 02:19:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 02:19:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/10] tree-walk: drop MAX_TRAVERSE_TREES macro
Message-ID: <20230831061916.GB3185325@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831061735.GA2702156@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the previous commit dropped the hard-coded limit in
traverse_trees(), we don't need this macro there anymore (the code can
handle any number of trees in parallel).

We do define MAX_UNPACK_TREES using MAX_TRAVERSE_TREES, due to
5290d45134 (tree-walk.c: break circular dependency with unpack-trees,
2020-02-01). So we can just directly define that as "8" now; we know
traverse_trees() can handle whatever we throw at it.

Signed-off-by: Jeff King <peff@peff.net>
---
I think from previous discussions that this "8" may also be excessive.
But digging into that should definitely be left for another series.

 tree-walk.h    | 2 --
 unpack-trees.h | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index 74cdceb3fe..a6bfa3da3a 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -6,8 +6,6 @@
 struct index_state;
 struct repository;
 
-#define MAX_TRAVERSE_TREES 8
-
 /**
  * The tree walking API is used to traverse and inspect trees.
  */
diff --git a/unpack-trees.h b/unpack-trees.h
index 9b827c307f..5867e26e17 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -7,7 +7,7 @@
 #include "string-list.h"
 #include "tree-walk.h"
 
-#define MAX_UNPACK_TREES MAX_TRAVERSE_TREES
+#define MAX_UNPACK_TREES 8
 
 struct cache_entry;
 struct unpack_trees_options;
-- 
2.42.0.561.gaa987ecc69

