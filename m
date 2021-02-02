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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA0CC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6AD64E9C
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhBBDDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhBBDCh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:02:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4ADC061797
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:01:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id u14so1047635wml.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YdGHpYEjlWjy/M9oqm/ijQbzattP/S90vUHrg7e3h0M=;
        b=B/CAeGEEUWIxX5apsRiXJY4006qT51ZyXgWJuierWVGmAeFR6xF73IhfgIKZdqBcT/
         zaGa0jcOviA1UiJUz3OCdnSKkRubpo27Mw813Am7Hbbr2zB1DUKqLwxbrsBdIDWWnnTm
         HYIfnw5+cqyR5wsyO3MV9a5GlUe+xC8TXJtv6ih3XHln+Y1Z1KcwHwSGtTe0yvI2sijp
         8wYmfwl9oKRRc9us1UMHC5DtyvcvUjB1DnusuhVoTGK2v4lTpFaFY6YaxGG4F0snYa5x
         b51eO8z4tw2Ior6Fne4gNwp/dmx/r03sB1xaghUFAr8XmgSa+v8DWxIqKuNOfMg9BE2D
         AYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YdGHpYEjlWjy/M9oqm/ijQbzattP/S90vUHrg7e3h0M=;
        b=toSh31cf1H2cVsxaPgyTfcPn8x1zYh9ow+KQX02vDIrO1l2MatnitwdY4yQ9GPKscB
         vWVghlmLGXWSvPSBh4WmrablibpSEfC9hEs4Jw1rrBEIgtqR7iMec3oSKv5rmRXLPpZC
         YUvBVo+NtGT3ZZJoTszFeeRgXOW6XKzk1x2VDB3xze30WDW1X9vUjQvjFif9oLBvhRGE
         +V5SqZCnOwTN9ZNkAs+C2s/sgX9NzZwFHYsLPrVQYAvbD1OxQO557z1PETKUQQcEW7GZ
         5z9foTgFZDMVptFye6SZ+JL6vtxAmIqo8NS47lcQgEqxIj88MkmN4wOIthe9iMn/yWn4
         bQvg==
X-Gm-Message-State: AOAM530OlXuGIN2onEwH6RZOffMxDwba+sKKmzH2kMNTar2uFuqNP5um
        O9mtC1nee1UgZId8yiMkcaskoWOU4LI=
X-Google-Smtp-Source: ABdhPJxURW8gb77bPlSKAU5eG5zB3LE6y4Ow2sww4KUqiPJphMtZfo+lgXWvlZMx1ctVqp7mQMeszg==
X-Received: by 2002:a1c:a90f:: with SMTP id s15mr1535271wme.154.1612234889625;
        Mon, 01 Feb 2021 19:01:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18sm28609884wrx.17.2021.02.01.19.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:01:29 -0800 (PST)
Message-Id: <9bccee8fb6381102d543d6b28e90959307ed08eb.1612234883.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
        <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 03:01:22 +0000
Subject: [PATCH v2 5/6] commit-graph: be extra careful about mixed generations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, gitster@pobox.com,
        abhishekkumar8222@gmail.com, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When upgrading to a commit-graph with corrected commit dates from
one without, there are a few things that need to be considered.

When computing generation numbers for the new commit-graph file that
expects to add the generation_data chunk with corrected commit
dates, we need to ensure that the 'generation' member of the
commit_graph_data struct is set to zero for these commits.

Unfortunately, the fallback to use topological level for generation
number when corrected commit dates are not available are causing us
harm here: parsing commits notices that read_generation_data is
false and populates 'generation' with the topological level.

The solution is to iterate through the commits, parse the commits
to populate initial values, then reset the generation values to
zero to trigger recalculation. This loop only occurs when the
existing commit-graph data has no corrected commit dates.

While this improves our situation somewhat, we have not completely
solved the issue for correctly computing generation numbers for mixed
layers. That follows in the next change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 2790f70d113..ee8d5a0cdb4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1036,7 +1036,8 @@ struct write_commit_graph_context {
 		 split:1,
 		 changed_paths:1,
 		 order_by_pack:1,
-		 write_generation_data:1;
+		 write_generation_data:1,
+		 trust_generation_numbers:1;
 
 	struct topo_level_slab *topo_levels;
 	const struct commit_graph_opts *opts;
@@ -1508,6 +1509,15 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 		ctx->progress = start_delayed_progress(
 					_("Computing commit graph generation numbers"),
 					ctx->commits.nr);
+
+	if (!ctx->trust_generation_numbers) {
+		for (i = 0; i < ctx->commits.nr; i++) {
+			struct commit *c = ctx->commits.list[i];
+			repo_parse_commit(ctx->r, c);
+			commit_graph_data_at(c)->generation = GENERATION_NUMBER_ZERO;
+		}
+	}
+
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
 		timestamp_t corrected_commit_date;
@@ -2439,7 +2449,7 @@ int write_commit_graph(struct object_directory *odb,
 	} else
 		ctx->num_commit_graphs_after = 1;
 
-	validate_mixed_generation_chain(ctx->r->objects->commit_graph);
+	ctx->trust_generation_numbers = validate_mixed_generation_chain(ctx->r->objects->commit_graph);
 
 	compute_topological_levels(ctx);
 	if (ctx->write_generation_data)
-- 
gitgitgadget

