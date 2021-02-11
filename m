Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A717C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0137E64E6C
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 15:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhBKPmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 10:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhBKPj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 10:39:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEC0C061786
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 07:39:16 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id g6so4569282wrs.11
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 07:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=u1d970izniqFs2wBYpEsCluywHf7Fmatziixa6isIok=;
        b=ER/Pqe/Jbsu0sYVtRdAqvjqCwpRylOrPhY116CaddyN/wm/ImXgeit9w1uNA5XqzCK
         3pfm7nS2Py1riPthdt1Z02/tSLHGhN/BlQYYzaFQWd8sIt7WGWZI3zh8jP1SxOXR2pqL
         iJb23ZD7iSNcsHjrTU6uk378rmfNXA7dzBc+mmlbyFR7OCODzcS1Rzmdt0+8MQyXgZgo
         j2iGGssSZWRgAfGtxikE3njeE9AIVvzXsQoAeQdH6J/ASCbzvKhrtbt5YReS6ck4KVj0
         yVbr3jQhTf1xR7RBQhWkDVMm0rSw8yeXqSGNuCIKGzNcPioDQoD/is0g3k8r+rG/ELb+
         31hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u1d970izniqFs2wBYpEsCluywHf7Fmatziixa6isIok=;
        b=mXh/TUUOLtfNSPOCmc3BKNOAwLiXAeZFfM7AQ8fBySzINQ8/xaa8ZS9KWd1OOwDVAX
         q3/VgF6plt2+x572fKZ5W1IldG7wq4/0C4lqXsq5KJlQhM4Z4lwWcxoyRieixZXPhZym
         wGy5wCa7XYjv7G/+HlXiKGbQoY2mejyTYpZxp9kbNmFy5PIyQGJqyp4DGOtR9kGRzzK+
         Mgp+ewLGzroLOzTP6YqPsayPaqCz7hYXeKJJiWTjMVnUAtH5HD473d58EZCxVfROhcFN
         SO3CfypfhgaP3xJxfqI5rpgi6Wi96pByBhMK9p0WPnD2qvIszQETCC1AIQgOtAQcmSXB
         T/2A==
X-Gm-Message-State: AOAM530ng3vx0ENjgwyk0PFKUkRvZJxkmViZs9ZsHQLV/qrc/6Xy7xqL
        flDi/48j+UzL318RuT0IvrwlaNIYtFw=
X-Google-Smtp-Source: ABdhPJyWGwUjx+oEun22UY4ix6alJVElaRd+fEL8WWHxtuY/kvL2dtFBY6ZP+AaL487oZ/ulNqtJBQ==
X-Received: by 2002:adf:fe0d:: with SMTP id n13mr6270698wrr.258.1613057955323;
        Thu, 11 Feb 2021 07:39:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm11533580wmb.14.2021.02.11.07.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 07:39:15 -0800 (PST)
Message-Id: <pull.875.git.1613057954213.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Feb 2021 15:39:13 +0000
Subject: [PATCH] commit-graph: when incompatible with graphs, indicate why
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `gc.writeCommitGraph = true`, it is possible that the commit-graph
is _still_ not written: replace objects, grafts and shallow repositories
are incompatible with the commit-graph feature.

Under such circumstances, we need to indicate to the user why the
commit-graph was not written instead of staying silent about it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Be clear why commit-graph was skipped
    
    After repairing my local checkout
    [https://github.com/gitgitgadget/git/pull/873], I was puzzled that the
    commit-graph file was not written. Turns out that I still had almost a
    dozen replace objects. But I only found out that they were blocking the
    commit-graph when I stepped through git gc in a debugger. This is my
    attempt to make it more straight-forward to recover from similar
    situations in the future.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-875%2Fdscho%2Fwarn-if-commit-graph-is-skipped-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-875/dscho/warn-if-commit-graph-is-skipped-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/875

 commit-graph.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 65410602714e..9ad176fa7c8e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -205,16 +205,24 @@ static int commit_graph_compatible(struct repository *r)
 
 	if (read_replace_refs) {
 		prepare_replace_object(r);
-		if (hashmap_get_size(&r->objects->replace_map->map))
+		if (hashmap_get_size(&r->objects->replace_map->map)) {
+			warning(_("repository contains replace objects; "
+			       "skipping commit-graph"));
 			return 0;
+		}
 	}
 
 	prepare_commit_graft(r);
 	if (r->parsed_objects &&
-	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_parent))
+	    (r->parsed_objects->grafts_nr || r->parsed_objects->substituted_parent)) {
+		warning(_("repository contains (deprecated) grafts; "
+		       "skipping commit-graph"));
 		return 0;
-	if (is_repository_shallow(r))
+	}
+	if (is_repository_shallow(r)) {
+		warning(_("repository is shallow; skipping commit-graph"));
 		return 0;
+	}
 
 	return 1;
 }

base-commit: f9f2520108bab26a750bcbb00518dc27672cf0a2
-- 
gitgitgadget
