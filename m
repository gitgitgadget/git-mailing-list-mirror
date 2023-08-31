Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E595C83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 06:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjHaGT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 02:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbjHaGT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 02:19:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D172C2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 23:19:24 -0700 (PDT)
Received: (qmail 21147 invoked by uid 109); 31 Aug 2023 06:19:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 06:19:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2964 invoked by uid 111); 31 Aug 2023 06:19:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 02:19:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 02:19:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/10] tree-walk: rename "error" variable
Message-ID: <20230831061922.GC3185325@coredump.intra.peff.net>
References: <20230831061735.GA2702156@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831061735.GA2702156@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "error" variable in traverse_trees() shadows the global error()
function (meaning we can't call error() from here). Let's call the local
variable "ret" instead, which matches the idiom in other functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-walk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index ad49d55290..4efd0fc391 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -441,7 +441,7 @@ int traverse_trees(struct index_state *istate,
 		   int n, struct tree_desc *t,
 		   struct traverse_info *info)
 {
-	int error = 0;
+	int ret = 0;
 	struct name_entry *entry;
 	int i;
 	struct tree_desc_x *tx;
@@ -539,7 +539,7 @@ int traverse_trees(struct index_state *istate,
 		if (interesting) {
 			trees_used = info->fn(n, mask, dirmask, entry, info);
 			if (trees_used < 0) {
-				error = trees_used;
+				ret = trees_used;
 				if (!info->show_all_errors)
 					break;
 			}
@@ -558,7 +558,7 @@ int traverse_trees(struct index_state *istate,
 	strbuf_release(&base);
 
 	traverse_trees_cur_depth--;
-	return error;
+	return ret;
 }
 
 struct dir_state {
-- 
2.42.0.561.gaa987ecc69

