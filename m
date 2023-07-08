Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874F1EB64D9
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 00:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjGHAbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 20:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjGHAbp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 20:31:45 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F192689
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 17:31:44 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-56fff21c2ebso29936797b3.3
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 17:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688776303; x=1691368303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P3Xk8tfrAmerZ9xdSqTtbEDSKEQBgzn10XeITkP40Sk=;
        b=JqFz14lYlZKbO1FRVfMBqHZHzv31zfSLkMLKfTe7xR1ngC+zFBEgL1fVeI+ro5FQFA
         zJb3d6i6UFbF0uiHGQqOX5QOkpf/UDAtRGaP0COjtUWjnk0g3VIpFfPHBc1Q1z9CJrBx
         R48YsaEQQOseYagc6fqW3fJRZw2fN8ynEz2FZWYtGEWV6JAt08qano/mv7VehmaeFAWj
         MuCE4fdcVJlRtCpsqEUPFboB2MHYbqQ2mUDjw6CMgHr0mUTO5xa6YUdRBzLjzwZHvY7a
         UJfMfYmPXggRwxVcWVvYRi/H73Mzod94Yw9O0/tzgrPBTKDgpxgEfJk+K8L0azx7T0s/
         CvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688776303; x=1691368303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3Xk8tfrAmerZ9xdSqTtbEDSKEQBgzn10XeITkP40Sk=;
        b=LnAP0xxc4YbS7ZZDtv1tmRaDzWrp9xgPft90Kz9yXv5MD4pV6tAt399jldQVZEEeMy
         mFrSVtSmQLJJfEXXVHuhx0wK8WPk27sUnlnbVWP+jwB8KDYDOWzmtZMN1nU9hABEMDmP
         7JWk9Ha48dgU5a6RPAQlpZFZZIuKOqAz/Xm//vkF8JZd/ucvNnjMMFa14XPwr9wFCPfk
         cRT3hdYl/isJx6ju8NLEx/9Ekjmr2SxL2QIUQlm+Oj4oF50YSfwECN6geh2t3/96/JD1
         JvaFgKoZa4vKDqycJpKkY8vOIfGeSN7euIfknpyHL3lFSSJ2NAO7fpok/Fw+yrdbLZ2o
         kKBw==
X-Gm-Message-State: ABy/qLbHnpNHqKPZv1m9tCwkYRGJV9xOdV/BFd+qWbDLrAS/EzbIyFwn
        R4LIPcWXZPn0I1a8g5LM5OcpsOX4HsqxptcRcSTwpw==
X-Google-Smtp-Source: APBJJlHk7BY/pLlQYw2cl1u8jQYyu0R9ltEexbgbW2x5yY7XROYuP7UCdTpwt/Y0WxgCQ7Ef8DbGLQ==
X-Received: by 2002:a81:6754:0:b0:577:65ea:78fb with SMTP id b81-20020a816754000000b0057765ea78fbmr7399683ywc.19.1688776303408;
        Fri, 07 Jul 2023 17:31:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g187-20020a8152c4000000b0057a54615bf4sm1132805ywb.55.2023.07.07.17.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:31:43 -0700 (PDT)
Date:   Fri, 7 Jul 2023 20:31:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 5/6] commit-graph.c: pass progress to
 `verify_one_commit_graph()`
Message-ID: <60fc2899d867c9532b5e5f79c3fcd4614726b393.1688776280.git.me@ttaylorr.com>
References: <cover.1688776280.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1688776280.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the final step to prepare for consolidating the output of `git
commit-graph verify`. Instead of having each call to
`verify_one_commit_graph()` initialize its own progress struct, have the
caller pass one in instead.

This patch does not alter the output of `git commit-graph verify`, but
the next commit will consolidate the output.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3c29ea7c706..65dd4edf0e1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2544,12 +2544,11 @@ static int commit_graph_checksum_valid(struct commit_graph *g)
 
 static int verify_one_commit_graph(struct repository *r,
 				   struct commit_graph *g,
-				   int flags)
+				   struct progress *progress)
 {
 	uint32_t i, cur_fanout_pos = 0;
 	struct object_id prev_oid, cur_oid;
 	int generation_zero = 0;
-	struct progress *progress = NULL;
 
 	verify_commit_graph_error = verify_commit_graph_lite(g);
 	if (verify_commit_graph_error)
@@ -2600,10 +2599,6 @@ static int verify_one_commit_graph(struct repository *r,
 	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
 		return verify_commit_graph_error;
 
-	if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
-		progress = start_progress(_("Verifying commits in commit graph"),
-					g->num_commits);
-
 	for (i = 0; i < g->num_commits; i++) {
 		struct commit *graph_commit, *odb_commit;
 		struct commit_list *graph_parents, *odb_parents;
@@ -2693,7 +2688,6 @@ static int verify_one_commit_graph(struct repository *r,
 				     graph_commit->date,
 				     odb_commit->date);
 	}
-	stop_progress(&progress);
 
 	return verify_commit_graph_error;
 }
@@ -2708,9 +2702,16 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 	}
 
 	for (; g; g = g->base_graph) {
-		local_error |= verify_one_commit_graph(r, g, flags);
+		struct progress *progress = NULL;
+		if (flags & COMMIT_GRAPH_WRITE_PROGRESS)
+			progress = start_progress(_("Verifying commits in commit graph"),
+						g->num_commits);
+
+		local_error |= verify_one_commit_graph(r, g, progress);
 		if (flags & COMMIT_GRAPH_VERIFY_SHALLOW)
 			break;
+
+		stop_progress(&progress);
 	}
 
 	return local_error;
-- 
2.41.0.242.g6eec849fa5a

