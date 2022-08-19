Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964CEC28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 08:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347822AbiHSIuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347814AbiHSIuf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 04:50:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3634BCCE2C
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 01:50:35 -0700 (PDT)
Received: (qmail 17534 invoked by uid 109); 19 Aug 2022 08:50:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 08:50:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 407 invoked by uid 111); 19 Aug 2022 08:50:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 04:50:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 04:50:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/6] log-tree: drop unused commit param in remerge_diff()
Message-ID: <Yv9O2RK7ahmw5ge7@coredump.intra.peff.net>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function has never used its "commit" parameter since it was added
in db757e8b8d (show, log: provide a --remerge-diff capability,
2022-02-02).

This makes sense; we already have separate parameters for the parents
(which lets us redo the merge) and the oid of the result tree (which we
can then diff against the remerge result).

Let's drop the unused parameter in the name of clarity.

Signed-off-by: Jeff King <peff@peff.net>
---
 log-tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index d0ac0a6327..82d9b5f650 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -956,8 +956,7 @@ static void cleanup_additional_headers(struct diff_options *o)
 
 static int do_remerge_diff(struct rev_info *opt,
 			   struct commit_list *parents,
-			   struct object_id *oid,
-			   struct commit *commit)
+			   struct object_id *oid)
 {
 	struct merge_options o;
 	struct commit_list *bases;
@@ -1052,7 +1051,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 					"for octopus merges.\n");
 				return 1;
 			}
-			return do_remerge_diff(opt, parents, oid, commit);
+			return do_remerge_diff(opt, parents, oid);
 		}
 		if (opt->combine_merges)
 			return do_diff_combined(opt, commit);
-- 
2.37.2.928.g0821088f4a

