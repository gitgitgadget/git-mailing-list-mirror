Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D9EC433DB
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BF022583
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 11:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgL1LRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgL1LRf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 06:17:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6321BC06179C
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i9so11030557wrc.4
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 03:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uAuu72FlkmWGfiSbzW2PBA+6L6K8jcsYnFjikJdp3xE=;
        b=LlqcsN3sN7tJ8NvB6uN1308e342FEtDb+iZK4aKcCsVQdOYsfcUq3Mw/9+9/DAmau/
         +TsHh9L6dwne9sRG5zkQsqbYu1v6pSSD5c64dsSdgdw9mmjlu0OZyFKejuK+Olq5tcAl
         PQdvNVTgXS+Xkjr5Yi6bNzvwvU1xMq6TD0Snz5igNIwfXsvb3gEP4fPOt1YdUtVWZr5E
         bfpxpNTB3FkPOLISUEQ9htrm+IAt5pxt9T5u0ZDCbKzxUJQy5tOdVyGrYJtmNETx+YI9
         YCreQ4+8r8T/jJPYPrATrtPSJnX7lhfXMSeRTH/FeCy0AF5rmT7L3kFcVonUxpZijjTv
         TJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uAuu72FlkmWGfiSbzW2PBA+6L6K8jcsYnFjikJdp3xE=;
        b=EkmpBY8lg1WyY5A7obQ3uROCYUJIKzJD4W2tH31rTzcWQpBDMBl8Sr2PEpiWDTM+yd
         Oc7ipDjiojYASg/ssuxYtVmSjpZTNgTgVWWFUQ7sDVjR6Tl5QGXw6h5W8wAbUXOxxRN5
         ISkdPIZlj6MxjaJsEI0JWW6/tW5YQJEzPnbhh+LFQkeMwuh6UjQdHeh1NWRBxzmRIFCo
         4GuuWm5HGrOkitzDIKWp6fsx+0DEGNh7ZjSqSKOdzQJD3m6c1G1eZn61oKY9lQa6E9dt
         EOaWFgFXp25LoYEB14Vx3WoXlzuLB9c6uH5EQpmH+nTfwn9ZDrVzHU3Ra+z/Zw9Cnv4m
         kDww==
X-Gm-Message-State: AOAM531OaK0hBZ38f1tA4MTnbVyyjhVndStZJtmmiiWIBUIgh1WCrbto
        6xGHc1m2tjnTrHyOov2JKibm/HNLCTg=
X-Google-Smtp-Source: ABdhPJyix5DXEgRQoiOnaSCNb4QDvqDwP2ZYaeguEJhYParihqNFvj7hY6uyZqwnQr2AlQFrOfFt3w==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr51771977wrb.105.1609154177998;
        Mon, 28 Dec 2020 03:16:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18sm56499455wrp.74.2020.12.28.03.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 03:16:17 -0800 (PST)
Message-Id: <859c39eff52e32ad322969d024184971acec82e7.1609154168.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Dec 2020 11:16:04 +0000
Subject: [PATCH v5 07/11] commit-graph: implement corrected commit date
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

With most of preparations done, let's implement corrected commit date.

The corrected commit date for a commit is defined as:

* A commit with no parents (a root commit) has corrected commit date
  equal to its committer date.
* A commit with at least one parent has corrected commit date equal to
  the maximum of its commit date and one more than the largest corrected
  commit date among its parents.

As a special case, a root commit with timestamp of zero (01.01.1970
00:00:00Z) has corrected commit date of one, to be able to distinguish
from GENERATION_NUMBER_ZERO (that is, an uncomputed corrected commit
date).

To minimize the space required to store corrected commit date, Git
stores corrected commit date offsets into the commit-graph file. The
corrected commit date offset for a commit is defined as the difference
between its corrected commit date and actual commit date.

Storing corrected commit date requires sizeof(timestamp_t) bytes, which
in most cases is 64 bits (uintmax_t). However, corrected commit date
offsets can be safely stored using only 32-bits. This halves the size
of GDAT chunk, which is a reduction of around 6% in the size of
commit-graph file.

However, using offsets be problematic if one of commits is malformed but
valid and has committerdate of 0 Unix time, as the offset would be the
same as corrected commit date and thus require 64-bits to be stored
properly.

While Git does not write out offsets at this stage, Git stores the
corrected commit dates in member generation of struct commit_graph_data.
It will begin writing commit date offsets with the introduction of
generation data chunk.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 commit-graph.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 1b2a015f92f..bfc3aae5f93 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1339,9 +1339,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 					ctx->commits.nr);
 	for (i = 0; i < ctx->commits.nr; i++) {
 		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
+		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
 
 		display_progress(ctx->progress, i + 1);
-		if (level != GENERATION_NUMBER_ZERO)
+		if (level != GENERATION_NUMBER_ZERO &&
+		    corrected_commit_date != GENERATION_NUMBER_ZERO)
 			continue;
 
 		commit_list_insert(ctx->commits.list[i], &list);
@@ -1350,16 +1352,23 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 			struct commit_list *parent;
 			int all_parents_computed = 1;
 			uint32_t max_level = 0;
+			timestamp_t max_corrected_commit_date = 0;
 
 			for (parent = current->parents; parent; parent = parent->next) {
 				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
+				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
 
-				if (level == GENERATION_NUMBER_ZERO) {
+				if (level == GENERATION_NUMBER_ZERO ||
+				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
 					all_parents_computed = 0;
 					commit_list_insert(parent->item, &list);
 					break;
-				} else if (level > max_level) {
-					max_level = level;
+				} else {
+					if (level > max_level)
+						max_level = level;
+
+					if (corrected_commit_date > max_corrected_commit_date)
+						max_corrected_commit_date = corrected_commit_date;
 				}
 			}
 
@@ -1369,6 +1378,10 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
 					max_level = GENERATION_NUMBER_V1_MAX - 1;
 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
+
+				if (current->date && current->date > max_corrected_commit_date)
+					max_corrected_commit_date = current->date - 1;
+				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
 			}
 		}
 	}
-- 
gitgitgadget

