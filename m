Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D158EDE99E
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 09:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbjINJnU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbjINJnB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 05:43:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFAF2712
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 02:40:05 -0700 (PDT)
Received: (qmail 27339 invoked by uid 109); 14 Sep 2023 09:40:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Sep 2023 09:40:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21334 invoked by uid 111); 14 Sep 2023 09:40:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Sep 2023 05:40:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Sep 2023 05:40:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 4/4] merge-ort: drop unused "opt" parameter from
 merge_check_renames_reusable()
Message-ID: <20230914094004.GD2254894@coredump.intra.peff.net>
References: <20230914093409.GA2254811@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914093409.GA2254811@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The merge_options parameter has never been used since the function was
introduced in 64aceb6d73 (merge-ort: add code to check for whether
cached renames can be reused, 2021-05-20). In theory some merge options
might impact our decisions here, but that has never been the case so
far.

Let's drop it to appease -Wunused-parameter; it would be easy to add
back later if we need to (there is only one caller).

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-ort.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 20eefd9b5e..3953c9f745 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4880,8 +4880,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	trace2_region_leave("merge", "allocate/init", opt->repo);
 }
 
-static void merge_check_renames_reusable(struct merge_options *opt,
-					 struct merge_result *result,
+static void merge_check_renames_reusable(struct merge_result *result,
 					 struct tree *merge_base,
 					 struct tree *side1,
 					 struct tree *side2)
@@ -5083,7 +5082,7 @@ void merge_incore_nonrecursive(struct merge_options *opt,
 
 	trace2_region_enter("merge", "merge_start", opt->repo);
 	assert(opt->ancestor != NULL);
-	merge_check_renames_reusable(opt, result, merge_base, side1, side2);
+	merge_check_renames_reusable(result, merge_base, side1, side2);
 	merge_start(opt, result);
 	/*
 	 * Record the trees used in this merge, so if there's a next merge in
-- 
2.42.0.628.g8a27295885
