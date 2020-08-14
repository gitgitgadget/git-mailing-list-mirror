Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FEAC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C8320771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="DzLHJxbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHNUUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgHNUUY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:20:24 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96ACC061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:20:24 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so9533742qkb.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ag4K6mhBphk3RIUH3r/jYyDE22KOFFS2xpGDRBcv85Q=;
        b=DzLHJxbAzNPS7JPOkwUXQdXuqjXnGUEpZxpA1ZX12vsDgTgqc3/3nbSQKgXcBXgpK8
         fQ6FTjOVhGqYC5JNPVulO8eyeDbSnZEMHmpuMZ+sMlGeurnR/WIWK4u++83jjBeEOydj
         Lyacn+WDARicaNarN21646cpoKzsHDuAn+y2ZOn5CgOYJTA/DgvCQcxb1nWiOEFVnxxq
         8w3NKWl/M+6XXOgNL55dffpcEhnDPaLFH8aOGfqHvgX8EwHkezsYx4UDZIqqC1MGiFoH
         8UY4Fn2XgIvJe34XmeXFI9p1S0baNwPW81i3kikv0Exh55f2Oyic9zMIN4vJI/Jd6cgo
         Ht4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ag4K6mhBphk3RIUH3r/jYyDE22KOFFS2xpGDRBcv85Q=;
        b=NxJZ9H994O5XGGKDX7/GjpnU5+btHPHEYC1rL7ZCUtLy6+9yNYxKtXrmdwU5FftPub
         IpucHgRzyx0lJlFyM985SEMHQCuWop39d+4xG7R2XDrVUFq3mLpkyfqRJXQmOs3vOaVY
         kubr3ZWwzfgmQyDh67103SF7KuNJX2WBP5+6k/dna2Cxoi4Tevacx/cpBjiXlPqR0oMU
         jGTXNbohw1DpRn0NMOMB/bYkGFtG+nOBR7k0LMpKBWYznVCKcS5LcCgYf+M0mmRfGFQz
         ntrn0ClsjH3vnd+ilAhieKogpbVoOWJ7+GdeVGWau8i7uKAefnioL1Ru/REKg4lNhkWL
         coAQ==
X-Gm-Message-State: AOAM530L06WgBUJf8Kp4i3ePY1qpImKLjOLwdsCOUgS0BwQkSlDNU6lW
        CD4/heligCl+xvwY96Iug2digw==
X-Google-Smtp-Source: ABdhPJz+DCVj0YFFjg3IbJb0nS8grxJBFA9gUbVsWatosz8BSUbjzzyh2R9LnnCkcxIbnx9UFTLMFQ==
X-Received: by 2002:a05:620a:1525:: with SMTP id n5mr3536734qkk.126.1597436423377;
        Fri, 14 Aug 2020 13:20:23 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3009:7f9d:1da1:7877])
        by smtp.gmail.com with ESMTPSA id i30sm11829271qte.30.2020.08.14.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:20:22 -0700 (PDT)
Date:   Fri, 14 Aug 2020 16:20:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 14/14] builtin/commit-graph.c: introduce
 '--max-new-filters=<n>'
Message-ID: <20200814202021.GE30103@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <09f6871f66bff838c067a3e0d23cd4622171f3bd.1597178915.git.me@ttaylorr.com>
 <20200812114929.GA19082@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812114929.GA19082@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 01:49:29PM +0200, SZEDER Gábor wrote:
> On Tue, Aug 11, 2020 at 04:52:14PM -0400, Taylor Blau wrote:
>
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 6886f319a5..4aae5471e3 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -954,7 +954,8 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
> >  }
> >
> >  static int get_bloom_filter_large_in_graph(struct commit_graph *g,
> > -					   const struct commit *c)
> > +					   const struct commit *c,
> > +					   uint32_t max_changed_paths)
> >  {
> >  	uint32_t graph_pos = commit_graph_position(c);
> >  	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
> > @@ -965,6 +966,17 @@ static int get_bloom_filter_large_in_graph(struct commit_graph *g,
> >
> >  	if (!(g && g->bloom_large))
> >  		return 0;
> > +	if (g->bloom_filter_settings->max_changed_paths != max_changed_paths) {
> > +		/*
> > +		 * Force all commits which are subject to a different
> > +		 * 'max_changed_paths' limit to be recomputed from scratch.
> > +		 *
> > +		 * Note that this could likely be improved, but is ignored since
> > +		 * all real-world graphs set the maximum number of changed paths
> > +		 * at 512.
> > +		 */
> > +		return 0;
> > +	}
> >  	return bitmap_get(g->bloom_large, graph_pos - g->num_commits_in_base);
> >  }
> >
> > @@ -1470,6 +1482,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
> >  	int i;
> >  	struct progress *progress = NULL;
> >  	int *sorted_commits;
> > +	int max_new_filters;
> >
> >  	init_bloom_filters();
> >  	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD + 1);
> > @@ -1486,10 +1499,15 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
> >  		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
> >  		&ctx->commits);
> >
> > +	max_new_filters = ctx->opts->max_new_filters >= 0 ?
> > +		ctx->opts->max_new_filters : ctx->commits.nr;
>
> git_test_write_commit_graph_or_die() invokes
> write_commit_graph_reachable() with opts=0x0, so 'ctx->opts' is NULL,
> and we get segfault.  This breaks a lot of tests when run with
> GIT_TEST_COMMIT_GRAPH=1 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1.

Great catch, thanks. Fixing this is as simple as adding 'ctx->opts &&'
right before we dereference 'ctx->opts', since setting this variable
equal to 'ctx->commits.nr' is the right thing to do in that case.

Unrelated to this comment, I am hoping to send out a final version of
this series sometime next week so that we can keep moving forward with
Bloom filter improvements.

Have you had a chance to review the rest of the patches? I'll happily
wait until you have had a chance to do so before sending v5 so that we
can avoid a v6.

Thanks,
Taylor
