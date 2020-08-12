Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E2DC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 11:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901A72065C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 11:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTFIlfQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHLLti (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 07:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgHLLth (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 07:49:37 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9545C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 04:49:36 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so1911454eje.7
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 04:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cCNSmGLF6+HoAsen3NhsPz5WvOrQ9xxJcjhXj580g1I=;
        b=lTFIlfQQmGd1UiOO3lyEuW9pSzOKZS1t+9BGs7GabbWiYvL8FO+lgKZ4uvrD333Uj4
         CiXX6p2P1btjLc/bLclTxs6hOmO68U7L4HPvlCconkvMULwwnmgk5Olr1gER1gJIakE/
         lP1lb47q8BgThLEtB5+zuOF6ZRTnFe3mI5BQMH9O1PHe2ccYG9tSpf0dki9f30qRvRsK
         2D00vSlRVPNDRSVn2UPXgOBObSBVmOwBCWsaJqguEbakxeC8ha4zdrjO21L9S3Bj/mQ+
         oOzpdjHjNT+umtaL00tOJkoEdOtBsLBUbK650lCqRb3uSPV4YV3ASO2xLJj/PPEqgpnB
         urOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCNSmGLF6+HoAsen3NhsPz5WvOrQ9xxJcjhXj580g1I=;
        b=JUEFOCrHTzi1bbBRvT2Vztd9GJnJz3mC+tJ84YnbIrfvGAb3jOgxkg2Fo42Yed9i3c
         cQwb6pWK/UsrI1IOA+qbLZ5+F4fLm8t0+XDTYbEXY94plqzdapvgeCTFmyUn0XggjJFf
         Oc0l0OeuhJmYUdyKSmICx9olUNPenoTdHe9yRGmyaxCYA8JSUqRZYn7o5nA4/WattsnT
         h5mxSR9vkGhYJBCZXc6ykubEMiddpun47/uzDk2AyPIx4r7+FUXb6mgXnj8wPbmVihlo
         F847WeWITNuWj43IGMsVQqw5SDD6DrT69QPnrFMBlgBZHgAm+eAVmE71Eo7T+N464FYO
         ssfA==
X-Gm-Message-State: AOAM531jIAg2fBXaQk1aoA1HcIDPF0Tp25avJQEms7qKbQLrnYldfTwo
        +vi2edZ0R6IJRuMvuKc/Kfg=
X-Google-Smtp-Source: ABdhPJxYgdrlijghs380bK8q5tCnADr9+Z7rpHqN2Yn1dxpLHzdoFa9858p0/OqKSLC+dVAcdmd5ag==
X-Received: by 2002:a17:906:4a4e:: with SMTP id a14mr31477457ejv.450.1597232975693;
        Wed, 12 Aug 2020 04:49:35 -0700 (PDT)
Received: from szeder.dev (62-165-238-100.pool.digikabel.hu. [62.165.238.100])
        by smtp.gmail.com with ESMTPSA id j24sm1372366ejv.32.2020.08.12.04.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 04:49:35 -0700 (PDT)
Date:   Wed, 12 Aug 2020 13:49:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200812114929.GA19082@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 04:52:14PM -0400, Taylor Blau wrote:

> diff --git a/commit-graph.c b/commit-graph.c
> index 6886f319a5..4aae5471e3 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -954,7 +954,8 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
>  }
>  
>  static int get_bloom_filter_large_in_graph(struct commit_graph *g,
> -					   const struct commit *c)
> +					   const struct commit *c,
> +					   uint32_t max_changed_paths)
>  {
>  	uint32_t graph_pos = commit_graph_position(c);
>  	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
> @@ -965,6 +966,17 @@ static int get_bloom_filter_large_in_graph(struct commit_graph *g,
>  
>  	if (!(g && g->bloom_large))
>  		return 0;
> +	if (g->bloom_filter_settings->max_changed_paths != max_changed_paths) {
> +		/*
> +		 * Force all commits which are subject to a different
> +		 * 'max_changed_paths' limit to be recomputed from scratch.
> +		 *
> +		 * Note that this could likely be improved, but is ignored since
> +		 * all real-world graphs set the maximum number of changed paths
> +		 * at 512.
> +		 */
> +		return 0;
> +	}
>  	return bitmap_get(g->bloom_large, graph_pos - g->num_commits_in_base);
>  }
>  
> @@ -1470,6 +1482,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  	int i;
>  	struct progress *progress = NULL;
>  	int *sorted_commits;
> +	int max_new_filters;
>  
>  	init_bloom_filters();
>  	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD + 1);
> @@ -1486,10 +1499,15 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
>  		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
>  		&ctx->commits);
>  
> +	max_new_filters = ctx->opts->max_new_filters >= 0 ?
> +		ctx->opts->max_new_filters : ctx->commits.nr;

git_test_write_commit_graph_or_die() invokes
write_commit_graph_reachable() with opts=0x0, so 'ctx->opts' is NULL,
and we get segfault.  This breaks a lot of tests when run with
GIT_TEST_COMMIT_GRAPH=1 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1.

