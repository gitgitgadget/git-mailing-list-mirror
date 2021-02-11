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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7277C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 04:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A56B664E7A
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 04:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhBKEpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 23:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhBKEpD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 23:45:03 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D2C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 20:44:23 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t29so2929359pfg.11
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 20:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=iq8APo+LvwosxXdEcZ+p4d6BwjCndjggkw07bSYcuqY=;
        b=OUqy3qiFKI/kku8EGvXyI1LH7UQKenRtGI8KtklpvfGLYb3nFxGRPR8YrxU0UXRRM6
         0Ep+ViYyIV5cOrvxZEbAwNP9Xk5o/vkiSS5sKRt/BvsbdSbmvhgN5kk8eaG0guzRndG+
         pyVCxvUAR3LvNj1aXJ5Pta1+XdVqgg8T0b8l+grISl4dtBYOwVrlirnlrhXLnrfQ+2rJ
         Tv9UhHWpAdTOc7tw4E5rFl1HbT+xJodYLjAGZn/0+vmDaAsUjaCjBfigZwZCPw/3UDYU
         p+Aa1Dfx4gY9/sBkbN5DjEH9HkHuY5Y0UFDgArcv2ATL1eHO/kDx2bQLRPXEq8ryZ2Sy
         dU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=iq8APo+LvwosxXdEcZ+p4d6BwjCndjggkw07bSYcuqY=;
        b=MToIMEyeRsa2kps4M6HUHC96wemlQ3F70Op1LWEHpmLv1tNw8G/fPpq9s14Y8KQ52N
         K6L+dB3SNAhSv0xAPcs87BvyVG1nvCXc8nv2KdTEThWnoCVmPIUfo25vF58LL+Gf4IhD
         tdwTa5RPpkt3mP0wsD80vqNrxrf0q9utLkrMvl5/EvfRb+yM26Op7B4/eJjkCrHRwHcC
         6PP6AUjCE5EcJEl6Rr5igcq9VHFUTMWKEEUGO/63EZdzGiEymZ+Ddt00roWN6Cp6FTJ8
         mOf7RqAe0LtfZ4ZZRnIBhT7YYVEPgQ9VsKWmrInj1udrw0+QS9PIeSx9886Ke6PBafis
         hP/g==
X-Gm-Message-State: AOAM533VH1hEEMV/9lSVKnsS9/AvJapHD/u59/1wKxmrosIBH7iZH4ag
        I/tt7GlpIrz6Ci18V6YCpnM=
X-Google-Smtp-Source: ABdhPJx6ib5TTmPBKvarUbZs3qv2N1lgXTL/kNpSTPXUIONO1BctExd/2m4Z+dvkJFAmwLgejO2pJQ==
X-Received: by 2002:a62:5ec5:0:b029:1ae:6847:fa02 with SMTP id s188-20020a625ec50000b02901ae6847fa02mr6639658pfb.61.1613018662622;
        Wed, 10 Feb 2021 20:44:22 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:2e82:f07e:f5d5:3426:49b7:77ef])
        by smtp.gmail.com with ESMTPSA id k9sm3536694pjj.8.2021.02.10.20.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 20:44:22 -0800 (PST)
Date:   Thu, 11 Feb 2021 10:14:39 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     abhishekkumar8222@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        peff@peff.net, stolee@gmail.com, ttaylorr@github.com
Subject: Re: [PATCH v2 0/6] Generation Number v2: Fix a tricky split graph bug
Message-ID: <YCS2N8WC5jQW1jCZ@Abhishek-Arch>
Reply-To: pull.850.v2.git.1612234883.gitgitgadget@gmail.com
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 03:01:17AM +0000, Derrick Stolee via GitGitGadget wrote:
> Here is a bugfix for the recently-landed-in-next generation v2 topic
> (ak/corrected-commit-date).
> 
> This was occasionally hitting us when computing new commit-graphs on
> existing repositories with the new bits. It was very hard to reproduce, and
> it turns out to be due to not parsing commits before accessing generation
> number data. Doing so in the right place demonstrates the bug of recomputing
> the corrected commit date even for commits in lower layers with computed
> values.
> 
> The fix is split into these steps:
> 
>  1. Parse commits more often before accessing their data. (This allows the
>     bug to be demonstrated in the test suite.)
>  2. Check the full commit-graph chain for generation data chunks.
>  3. Don't compute corrected commit dates if the lower layers do not support
>     them.
>  4. Parse the commit-graph file more often.
> 
> Thanks, -Stolee
> 

Thanks for the fast bug-fix. It must have been hard to track down why as
we weren't able to reproduce this behaviour before. As Taylor said
before, this patch is a clear improvement in readability and correctness.

Thanks
- Abhishek

> 
> Updates in v2
> =============
> 
>  * Fixed some typos or other clarifications in commit messages.
> 
>  * The loop assigning read_generation_data is skipped if they already all
>    agree with value 1.
> 
>  * I split compute_generation_numbers into two methods. This essentially
>    splits the previous patch 4 into patches 4 & 5 here. The new patch 4 just
>    splits the logic as-is, then the new patch 5 does the re-initialization
>    of generation values when in the upgrade scenario.
> 
> Derrick Stolee (6):
>   commit-graph: use repo_parse_commit
>   commit-graph: always parse before commit_graph_data_at()
>   commit-graph: validate layers for generation data
>   commit-graph: compute generations separately
>   commit-graph: be extra careful about mixed generations
>   commit-graph: prepare commit graph
> 
>  commit-graph.c          | 138 +++++++++++++++++++++++++++++-----------
>  commit.h                |   5 +-
>  t/t5318-commit-graph.sh |  21 ++++++
>  3 files changed, 125 insertions(+), 39 deletions(-)
> 
> 
> base-commit: 5a3b130cad0d5c770f766e3af6d32b41766374c0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-850%2Fderrickstolee%2Fgen-v2-upgrade-fix-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-850/derrickstolee/gen-v2-upgrade-fix-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/850
> 
> Range-diff vs v1:
> 
>  1:  9c605c99f66 = 1:  9c605c99f66 commit-graph: use repo_parse_commit
>  2:  82afa811dff ! 2:  454b183b9ba commit-graph: always parse before commit_graph_data_at()
>      @@ Commit message
>           problems when writing a commit-graph with corrected commit dates based
>           on a commit-graph without them.
>       
>      -    It has been difficult to identify the issue here becaus it was so hard
>      +    It has been difficult to identify the issue here because it was so hard
>           to reproduce. It relies on this uninitialized data having a non-zero
>           value, but also on specifically in a way that overwrites the existing
>           data.
>  3:  d554fa30660 ! 3:  3d223fa2156 commit-graph: validate layers for generation data
>      @@ commit-graph.c: static struct commit_graph *load_commit_graph_chain(struct repos
>        
>       -	if (!g)
>       -		return;
>      --
>      --	read_generation_data = !!g->chunk_generation_data;
>       +	while (read_generation_data && p) {
>       +		read_generation_data = p->read_generation_data;
>       +		p = p->base_graph;
>       +	}
>        
>      +-	read_generation_data = !!g->chunk_generation_data;
>      ++	if (read_generation_data)
>      ++		return 1;
>      + 
>        	while (g) {
>      - 		g->read_generation_data = read_generation_data;
>      +-		g->read_generation_data = read_generation_data;
>      ++		g->read_generation_data = 0;
>        		g = g->base_graph;
>        	}
>       +
>      -+	return read_generation_data;
>      ++	return 0;
>        }
>        
>        struct commit_graph *read_commit_graph_one(struct repository *r,
>  -:  ----------- > 4:  05248ff222f commit-graph: compute generations separately
>  4:  b267a9653a7 ! 5:  9bccee8fb63 commit-graph: be extra careful about mixed generations
>      @@ Commit message
>           existing commit-graph data has no corrected commit dates.
>       
>           While this improves our situation somewhat, we have not completely
>      -    solved the issue for correctly computing generation numbers for mixes
>      +    solved the issue for correctly computing generation numbers for mixed
>           layers. That follows in the next change.
>       
>           Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
>        					_("Computing commit graph generation numbers"),
>        					ctx->commits.nr);
>       +
>      -+	if (ctx->write_generation_data && !ctx->trust_generation_numbers) {
>      ++	if (!ctx->trust_generation_numbers) {
>       +		for (i = 0; i < ctx->commits.nr; i++) {
>       +			struct commit *c = ctx->commits.list[i];
>       +			repo_parse_commit(ctx->r, c);
>      @@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph
>       +
>        	for (i = 0; i < ctx->commits.nr; i++) {
>        		struct commit *c = ctx->commits.list[i];
>      - 		uint32_t level;
>      -@@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>      - 				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
>      - 
>      - 				if (level == GENERATION_NUMBER_ZERO ||
>      --				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
>      -+				    (ctx->write_generation_data &&
>      -+				     corrected_commit_date == GENERATION_NUMBER_ZERO)) {
>      - 					all_parents_computed = 0;
>      - 					commit_list_insert(parent->item, &list);
>      - 					break;
>      -@@ commit-graph.c: static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>      - 					max_level = GENERATION_NUMBER_V1_MAX - 1;
>      - 				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
>      - 
>      --				if (current->date && current->date > max_corrected_commit_date)
>      --					max_corrected_commit_date = current->date - 1;
>      --				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
>      --
>      --				if (commit_graph_data_at(current)->generation - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
>      --					ctx->num_generation_data_overflows++;
>      -+				if (ctx->write_generation_data) {
>      -+					timestamp_t cur_g;
>      -+					if (current->date && current->date > max_corrected_commit_date)
>      -+						max_corrected_commit_date = current->date - 1;
>      -+					cur_g = commit_graph_data_at(current)->generation
>      -+					      = max_corrected_commit_date + 1;
>      -+					if (cur_g - current->date > GENERATION_NUMBER_V2_OFFSET_MAX)
>      -+						ctx->num_generation_data_overflows++;
>      -+				}
>      - 			}
>      - 		}
>      - 	}
>      + 		timestamp_t corrected_commit_date;
>       @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
>        	} else
>        		ctx->num_commit_graphs_after = 1;
>      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
>       -	validate_mixed_generation_chain(ctx->r->objects->commit_graph);
>       +	ctx->trust_generation_numbers = validate_mixed_generation_chain(ctx->r->objects->commit_graph);
>        
>      - 	compute_generation_numbers(ctx);
>      - 
>      + 	compute_topological_levels(ctx);
>      + 	if (ctx->write_generation_data)
>  5:  dddeec30ebf ! 6:  38086c85b52 commit-graph: prepare commit graph
>      @@ Commit message
>           commit-graph: prepare commit graph
>       
>           Before checking if the repository has a commit-graph loaded, be sure
>      -    to run prepare_commit_graph(). This is necessary because without this
>      -    instance we would not initialize the topo_levels slab for each of the
>      -    struct commit_graphs in the chain before we start to parse the
>      -    commits. This leads to possibly recomputing the topological levels for
>      -    commits in lower layers even when we are adding a small number of
>      -    commits on top.
>      +    to run prepare_commit_graph(). This is necessary because otherwise
>      +    the topo_levels slab is not initialized. As we compute topo_levels for
>      +    the new commits, we iterate further into the lower layers since the
>      +    first visit to each commit looks as though the topo_level is not
>      +    populated.
>       
>           By properly initializing the topo_slab, we fix the previously broken
>           case of a split commit graph where a base layer has the
> 
> -- 
> gitgitgadget
