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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E169AC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D2F64E9A
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhBBDCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhBBDCY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:02:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04082C06178B
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:01:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c12so18815840wrc.7
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qGSrYcI03ieKb5lZ3ZkAaQmm8swizM37VkDzobzj8UU=;
        b=Kg39wr4KZhUCl4LUjF9j9Y03vbdtS9DXdlm4dPxH5Qon0RD21z0Loq0Yq5eYjlpbmo
         GQXcY9N1Gx0IzelHFrRrFTrhMu1dvIBmTlTFBZbhMaah888xRccgEILx17+cTP9Ml9QI
         UWCSkl99qannlYnRyJYYhbEYSVDpvWvkv/M2DE9aKWYFY56KMJTBuhIgmHhurd5VDimq
         +dhidkR4gNkz4zki5Kr/XXkRSZAdCOIe/8XlIs0eoQ6nvnOGbzrHzvVrXB+4RhvcUYq5
         Rjj32vAI82QyvEpEaxOwof92f1V1AYYfhNkNSrhmPY2lzHdrr7F9KiEZlUo0E0h2x8SL
         qQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qGSrYcI03ieKb5lZ3ZkAaQmm8swizM37VkDzobzj8UU=;
        b=HhzEhQZZS60qaTZ9jGNwnCVNCgTi8nMxmav7EdUXDwBQuf//iOYSrO8gmPlLWXjgKO
         oTwew3P8x8Ow+dDzQQgx5sFu2sO2igK8AjhkQY11D4L/6A9p7ZYPv5yeHbgTzD5fiHd6
         pTeI+1ugQx+Gbv7o1lbwaDTZkqYlCQTDzWMEahhmWArf4Y/US4bPVnO4XdImj9szS8ID
         7yRHfTQdizMw7wtcpI9OPe4wozb/rL/7u9crEyhqo6iThzs0WmW18LqfX33Sl5cnNulX
         2as763qGtUqAGDlOnQtvKkD5Q4pSvEWewd/BIVeWZnUqeK010ibmMIiydW9aFPMDPslT
         n3VA==
X-Gm-Message-State: AOAM532Q9R2wtQe1R9v6yatOYDJmkRpIth0lchUNwp1F5S4OThqJ4v12
        3K2sMfiGV8ZQS9Jg0/otKtjUSBGBvFk=
X-Google-Smtp-Source: ABdhPJy/bPtiK67cf1AyYbQrjdN3/S5JbV+KHDE3CIGZzZbOxO6eEU2hGv+0pFEDw91Wp2Xw6cMnYw==
X-Received: by 2002:a5d:4bc2:: with SMTP id l2mr21514435wrt.204.1612234885132;
        Mon, 01 Feb 2021 19:01:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14sm27816436wri.48.2021.02.01.19.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 19:01:24 -0800 (PST)
Message-Id: <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
In-Reply-To: <pull.850.git.1612199707.gitgitgadget@gmail.com>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Feb 2021 03:01:17 +0000
Subject: [PATCH v2 0/6] Generation Number v2: Fix a tricky split graph bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, gitster@pobox.com,
        abhishekkumar8222@gmail.com, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <ttaylorr@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a bugfix for the recently-landed-in-next generation v2 topic
(ak/corrected-commit-date).

This was occasionally hitting us when computing new commit-graphs on
existing repositories with the new bits. It was very hard to reproduce, and
it turns out to be due to not parsing commits before accessing generation
number data. Doing so in the right place demonstrates the bug of recomputing
the corrected commit date even for commits in lower layers with computed
values.

The fix is split into these steps:

 1. Parse commits more often before accessing their data. (This allows the
    bug to be demonstrated in the test suite.)
 2. Check the full commit-graph chain for generation data chunks.
 3. Don't compute corrected commit dates if the lower layers do not support
    them.
 4. Parse the commit-graph file more often.

Thanks, -Stolee


Updates in v2
=============

 * Fixed some typos or other clarifications in commit messages.

 * The loop assigning read_generation_data is skipped if they already all
   agree with value 1.

 * I split compute_generation_numbers into two methods. This essentially
   splits the previous patch 4 into patches 4 & 5 here. The new patch 4 just
   splits the logic as-is, then the new patch 5 does the re-initialization
   of generation values when in the upgrade scenario.

Derrick Stolee (6):
  commit-graph: use repo_parse_commit
  commit-graph: always parse before commit_graph_data_at()
  commit-graph: validate layers for generation data
  commit-graph: compute generations separately
  commit-graph: be extra careful about mixed generations
  commit-graph: prepare commit graph

 commit-graph.c          | 138 +++++++++++++++++++++++++++++-----------
 commit.h                |   5 +-
 t/t5318-commit-graph.sh |  21 ++++++
 3 files changed, 125 insertions(+), 39 deletions(-)


base-commit: 5a3b130cad0d5c770f766e3af6d32b41766374c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-850%2Fderrickstolee%2Fgen-v2-upgrade-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-850/derrickstolee/gen-v2-upgrade-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/850

Range-diff vs v1:

 1:  9c605c99f66 = 1:  9c605c99f66 commit-graph: use repo_parse_commit
 2:  82afa811dff ! 2:  454b183b9ba commit-graph: always parse before commit_graph_data_at()
     @@ Commit message
          problems when writing a commit-graph with corrected commit dates based
          on a commit-graph without them.
      
     -    It has been difficult to identify the issue here becaus it was so hard
     +    It has been difficult to identify the issue here because it was so hard
          to reproduce. It relies on this uninitialized data having a non-zero
          value, but also on specifically in a way that overwrites the existing
          data.
 3:  d554fa30660 ! 3:  3d223fa2156 commit-graph: validate layers for generation data
     @@ commit-graph.c: static struct commit_graph *load_commit_graph_chain(struct repos
       
      -	if (!g)
      -		return;
     --
     --	read_generation_data = !!g->chunk_generation_data;
      +	while (read_generation_data && p) {
      +		read_generation_data = p->read_generation_data;
      +		p = p->base_graph;
      +	}
       
     +-	read_generation_data = !!g->chunk_generation_data;
     ++	if (read_generation_data)
     ++		return 1;
     + 
       	while (g) {
     - 		g->read_generation_data = read_generation_data;
     +-		g->read_generation_data = read_generation_data;
     ++		g->read_generation_data = 0;
       		g = g->base_graph;
       	}
      +
     -+	return read_generation_data;
     ++	return 0;
       }
       
       struct commit_graph *read_commit_graph_one(struct repository *r,
 -:  ----------- > 4:  05248ff222f commit-graph: compute generations separately
 4:  b267a9653a7 ! 5:  9bccee8fb63 commit-graph: be extra careful about mixed generations
     @@ Commit message
          existing commit-graph data has no corrected commit dates.
      
          While this improves our situation somewhat, we have not completely
     -    solved the issue for correctly computing generation numbers for mixes
     +    solved the issue for correctly computing generation numbers for mixed
          layers. That follows in the next change.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
       					_("Computing commit graph generation numbers"),
       					ctx->commits.nr);
      +
     -+	if (ctx->write_generation_data && !ctx->trust_generation_numbers) {
     ++	if (!ctx->trust_generation_numbers) {
      +		for (i = 0; i < ctx->commits.nr; i++) {
      +			struct commit *c = ctx->commits.list[i];
      +			repo_parse_commit(ctx->r, c);
     @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
      +
       	for (i = 0; i < ctx->commits.nr; i++) {
       		struct commit *c = ctx->commits.list[i];
     - 		uint32_t level;
     -@@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
     - 
     - 				if (level == GENERATION_NUMBER_ZERO ||
     --				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
     -+				    (ctx->write_generation_data &&
     -+				     corrected_commit_date == GENERATION_NUMBER_ZERO)) {
     - 					all_parents_computed = 0;
     - 					commit_list_insert(parent->item, &list);
     - 					break;
     -@@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
     - 					max_level = GENERATION_NUMBER_V1_MAX - 1;
     - 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
     - 
     --				if (current->date && current->date > max_corrected_commit_date)
     --					max_corrected_commit_date = current->date - 1;
     --				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
     --
     --				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
     --					ctx->num_generation_data_overflows++;
     -+				if (ctx->write_generation_data) {
     -+					timestamp_t cur_g;
     -+					if (current->date && current->date > max_corrected_commit_date)
     -+						max_corrected_commit_date = current->date - 1;
     -+					cur_g = commit_graph_data_at(current)->generation
     -+					      = max_corrected_commit_date + 1;
     -+					if (cur_g - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
     -+						ctx->num_generation_data_overflows++;
     -+				}
     - 			}
     - 		}
     - 	}
     + 		timestamp_t corrected_commit_date;
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       	} else
       		ctx->num_commit_graphs_after = 1;
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
      -	validate_mixed_generation_chain(ctx->r->objects->commit_graph);
      +	ctx->trust_generation_numbers = validate_mixed_generation_chain(ctx->r->objects->commit_graph);
       
     - 	compute_generation_numbers(ctx);
     - 
     + 	compute_topological_levels(ctx);
     + 	if (ctx->write_generation_data)
 5:  dddeec30ebf ! 6:  38086c85b52 commit-graph: prepare commit graph
     @@ Commit message
          commit-graph: prepare commit graph
      
          Before checking if the repository has a commit-graph loaded, be sure
     -    to run prepare_commit_graph(). This is necessary because without this
     -    instance we would not initialize the topo_levels slab for each of the
     -    struct commit_graphs in the chain before we start to parse the
     -    commits. This leads to possibly recomputing the topological levels for
     -    commits in lower layers even when we are adding a small number of
     -    commits on top.
     +    to run prepare_commit_graph(). This is necessary because otherwise
     +    the topo_levels slab is not initialized. As we compute topo_levels for
     +    the new commits, we iterate further into the lower layers since the
     +    first visit to each commit looks as though the topo_level is not
     +    populated.
      
          By properly initializing the topo_slab, we fix the previously broken
          case of a split commit graph where a base layer has the

-- 
gitgitgadget
