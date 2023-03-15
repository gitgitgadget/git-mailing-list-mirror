Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B750C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 22:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjCOWue (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 18:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCOWub (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 18:50:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7672C9E071
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 15:50:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p79-20020a25d852000000b00b32573a21a3so16968018ybg.18
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 15:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678920600;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X5eGXDDTWJgfKPb2YT/Vq3WR6InIzVDUbGxAm9+f6OA=;
        b=rlsM3rKsp/r9/MosLwVm/kNuqrCHILAUNKkPHK7rP/QlM91Yh6XmBp+Hzqahg7nS0W
         /j5//qbXla1LmrIjee7CSSW6kh+GS6VWuygSCCxe1bEu0Pr7gqhEa4QMGeuz1xaNvHJq
         gWigBHIxw+4clzU1JhdUY+f+czcCVozxkUUnBHmV+PQE6a1TRYp6zZX+Oh3Z++ahBKyx
         l9S0Bvhg01sNKWjj3tdtC6oZkqZXVkfP76Xte/00nT0tFXaqRFlawesVqpPK6mF3gcMZ
         y7pQ4k5y1DjDC3OQpaBW8wF4Xu1R9R7vpia4so+s6PcImSP/yx+lZ1DcwTtQPwwEKgBh
         MQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678920600;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5eGXDDTWJgfKPb2YT/Vq3WR6InIzVDUbGxAm9+f6OA=;
        b=MEiPvbbTEu/109ZPDMij8/KimcfXeuljezXV6/FBUXwSp3WV9qoCtxu0tG5Uaat/u2
         +ItxIqZaa21Ge9WmMoaMyi+xhwBdaGCnsU8C2g41UfB6BF5cpJqI97QYgfaUIalHRaLB
         K2QU6O+gEuwdGZ5J+iUqAHOOvAresnsiIUOylsCpPSg0+cjrmBCUQcKI0+LJKNeZiITG
         dHfKNwGyevF0yrKKTQxXNLjBf6hHBQa0AdQ/AV3YTWJb5WML9HcqJk+/d6G7J5QkN+Oy
         ST6gt9UtEsdfPf9/2g9P+674TrBplWjNFOYuY4cu/PI9yw5zqCLFHnXmpXe7NSx8J6S3
         ELcg==
X-Gm-Message-State: AO0yUKVzH4XrZURH55/DVbys/8cHlysdEz/MB50hYfR9Vf8XgZ9kWSKY
        gzxj9VMOI9VJJgCxPB65rV52PSanenHquVIe7cLM
X-Google-Smtp-Source: AK7set+F1yXaiXyLsuj85Pse7+sJUbYX38Z+KZ9MaE2sMhV+jKXzyaiZZpGOYovkM1TOy1dB/MG9+mWfvim44Xq+aMLh
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:524e:ff9a:ee19:127f])
 (user=jonathantanmy job=sendgmr) by 2002:a81:431b:0:b0:544:94fe:4244 with
 SMTP id q27-20020a81431b000000b0054494fe4244mr952715ywa.10.1678920600460;
 Wed, 15 Mar 2023 15:50:00 -0700 (PDT)
Date:   Wed, 15 Mar 2023 15:49:58 -0700
In-Reply-To: <3b15e9df770a118331a1b25f51de8ce97c1b7cab.1678902343.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230315224958.169443-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/8] commit-graph: combine generation computations
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> +static void compute_reachable_generation_numbers_1(
> +			struct compute_generation_info *info,
> +			int generation_version)
>  {
>  	int i;
>  	struct commit_list *list = NULL;
>  
> -	if (ctx->report_progress)
> -		ctx->progress = start_delayed_progress(
> -					_("Computing commit graph topological levels"),
> -					ctx->commits.nr);
> -	for (i = 0; i < ctx->commits.nr; i++) {
> -		struct commit *c = ctx->commits.list[i];
> -		uint32_t level;
> +	for (i = 0; i < info->commits->nr; i++) {
> +		struct commit *c = info->commits->list[i];
> +		timestamp_t gen;
> +		repo_parse_commit(info->r, c);
> +		gen = info->get_generation(c, info->data);
>  
> -		repo_parse_commit(ctx->r, c);
> -		level = *topo_level_slab_at(ctx->topo_levels, c);
> +		display_progress(info->progress, info->progress_cnt + 1);
>  
> -		display_progress(ctx->progress, i + 1);
> -		if (level != GENERATION_NUMBER_ZERO)
> +		if (gen != GENERATION_NUMBER_ZERO && gen != GENERATION_NUMBER_INFINITY)
>  			continue;
>  
>  		commit_list_insert(c, &list);

So this replaces a call to display_progress with another...

>  			if (all_parents_computed) {
>  				pop_commit(&list);
> -
> -				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
> -					max_level = GENERATION_NUMBER_V1_MAX - 1;
> -				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
> +				gen = compute_generation_from_max(
> +						current, max_gen,
> +						generation_version);
> +				info->set_generation(current, gen, info->data);
>  			}

...here is where set_generation is called...

> +static void set_topo_level(struct commit *c, timestamp_t t, void *data)
> +{
> +	struct write_commit_graph_context *ctx = data;
> +	*topo_level_slab_at(ctx->topo_levels, c) = (uint32_t)t;
> +	display_progress(ctx->progress, ctx->progress_cnt + 1);
> +}

...is this display_progress() redundant? (set_topo_level() is one of the
possibilities that set_generation could be assigned to.) There already
seems to be one at the top. Further supporting my query is the fact that
in the hunk containing set_generation, there is no progress report on
the LHS of the diff.

> +static void set_generation_v2(struct commit *c, timestamp_t t, void *data)
> +{
> +	struct write_commit_graph_context *ctx = data;
> +	struct commit_graph_data *g = commit_graph_data_at(c);
> +	g->generation = (uint32_t)t;
> +	display_progress(ctx->progress, ctx->progress_cnt + 1);
> +}

Likewise for this function.

Everything else up to and including this patch looks good.
