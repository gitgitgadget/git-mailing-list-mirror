Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB41EEB64D9
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 00:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjGHAbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 20:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjGHAbp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 20:31:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4F81FF6
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 17:31:41 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso2580596276.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 17:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1688776300; x=1691368300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dVKKgF9DX6x4Og/MnOS+cwZ/ApmS72HDh15g3jGWP9s=;
        b=kxwWuIK0g+jFpDxRBIID3bLIWu6eUSJrrmXwoaOSMzeWiBXq3+29h91nDtcqe4QHVo
         UpPL/pAJxS5S+b4Ns1TE91sY1Z4Dq7pZScoQPYc5zSV9VOILt+RzNu1DCKWldUBo6iOE
         M2OENX/f8HUxzsiMAvwXzdscg5pywhXm+e1NJm0DR8hVD/X+Nt7L0Lo+eOy+TkoTMjs8
         v5LkMxtB03oc4GeTcVTWa4mpo4sz12wUgK7D7piVMMJ1dflozX0Jcggpb+6ZuG1sJCtS
         P9jvrPZ7gxqX0aviw9mDARBhSAZQtVP0Hh1gx+kQDiMU1pYLwdssabNrvcsI0m8llNrV
         HB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688776300; x=1691368300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVKKgF9DX6x4Og/MnOS+cwZ/ApmS72HDh15g3jGWP9s=;
        b=Nvb+7xIfmvyiEGELsfgxaq7RyFH62RzMe95sajDmC/HgTkv4OMEFYDE4lyXY5ol+3R
         uwCjp1UHTyxJPDMHYgz12lo7GJDldbiTPbER/PUF2npFAHm3sghKxKkmGdBFGfyDzFtU
         NGyYjoO9oPA1F87UgzWJ1wANBHhhpWgn1GKgmlBIsodTloAkhGmDUWWzIOKb0K7x/6if
         ZGYVI7928CRLA0/xPyM665DsmUMNNn5nI85qilzTelZ7xLhOIvwgxZ9vfqjRBfGk30ZB
         A5jRMgOkn3OOXCkYgo97w5EqpooUtNVR4JW4T9Isuw9XB5M7PwhsmKKE1nkzpKVn6mse
         v+WA==
X-Gm-Message-State: ABy/qLYEmu32pb0uBupmB+DHH51AWLOSZKqAJWiyO+rutBYcC7Ll+Jxj
        Oedws/A8OuHAe9tCtW74q+dNpeZ0afi1pZ2BaETf8A==
X-Google-Smtp-Source: APBJJlGD8R4l1M/cikCJNaai5EhE2d9p9OiJMWx2XUmhM3bhXSd8qo5SACexQJNcRzTdrFbaFUc1pA==
X-Received: by 2002:a0d:ea48:0:b0:577:60d4:a879 with SMTP id t69-20020a0dea48000000b0057760d4a879mr6108649ywe.33.1688776300693;
        Fri, 07 Jul 2023 17:31:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a8-20020a816608000000b0057399b3bd26sm1409573ywc.33.2023.07.07.17.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:31:40 -0700 (PDT)
Date:   Fri, 7 Jul 2023 20:31:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 4/6] commit-graph.c: iteratively verify commit-graph chains
Message-ID: <4006bbf08548a8482d0aa4d4f3880de75ebf3c51.1688776280.git.me@ttaylorr.com>
References: <cover.1688776280.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1688776280.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have a function which can verify a single layer of a
commit-graph chain, implement `verify_commit_graph()` in terms of
iterating over commit-graphs along their `->base_graph` pointers.

This further prepares us to consolidate the progress output of `git
commit-graph verify`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3d7cc11927d..3c29ea7c706 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2707,10 +2707,11 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		return 1;
 	}
 
-	local_error = verify_one_commit_graph(r, g, flags);
-
-	if (!(flags & COMMIT_GRAPH_VERIFY_SHALLOW) && g->base_graph)
-		local_error |= verify_commit_graph(r, g->base_graph, flags);
+	for (; g; g = g->base_graph) {
+		local_error |= verify_one_commit_graph(r, g, flags);
+		if (flags & COMMIT_GRAPH_VERIFY_SHALLOW)
+			break;
+	}
 
 	return local_error;
 }
-- 
2.41.0.242.g6eec849fa5a

