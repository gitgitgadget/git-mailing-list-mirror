Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26161C433E3
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06FA9206D8
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 15:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="KNUkSupf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgG1P2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgG1P2s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 11:28:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E9EC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:28:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j187so18971941qke.11
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=czOLTzJrvEyjipViR5Eh7/A8K/FAxuJ6+vAOggNhjn8=;
        b=KNUkSupf4g1Y7eAMbY4uxDIUNnr7mz6bKL76pmyAeXn9xRfBG/6HEWlCsj3tKQlGEQ
         5WjZWazEnYw/eaIQIsOEfU9JyxKTrgkLFpz3AmTw2WCDBIcjh9n2WC0GjTSPa1fXQea1
         0igwZODA3xHM9a+hIZDjiiQ/TIaK5KL4TCBe2UBzCkpr/AAy+F2PlSiFMhhTzdUdhGBf
         mKhtFBbGaQsdfsS6mqWKpbeVUfH7VUr2RFuB1PiSDNRDyZc8u/yAsQscF1EKFQZd7HpS
         JL8evKsKkJ4r2R/YspLbxJCu6kOqqUst0RCeVUHTR9hlGk3MHz+EZuTv1sv6RVcplauP
         e09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=czOLTzJrvEyjipViR5Eh7/A8K/FAxuJ6+vAOggNhjn8=;
        b=P1a6R+luKJEUeMDtGt3zv85gKjU8WbzOq3kS51JbsfVHyDp6WJLuxMjbtMl1KPN3Rj
         8OrL1G8rcy5PVAgtOJ/aB3TYsKtw/W/9vmYIh3UkbuBdCYyTJ5/A3xoaMIL6rkyfFiSr
         b4sqcRmdnANyhnsFBF2d6VtpL2Oh/V2pjcdO89Uk87vpklgF1+7/grDf1zw/92ahpFTN
         ZMqPMAbe/q2oIUWRNNSzvC239PXIXonKpKNHV4w6m5wBJJabr5ypOPX6hgT56n36999a
         VKlQxtom4iRe0+AkTBkn3uOUq67ObWODZqJgUrsTMqUfymg2+6Zy6sVWUGcK5REyKrxA
         2ghQ==
X-Gm-Message-State: AOAM533pWWNdFe0pddjfz8SptY1o4ycfTuna99nJ9IDcScjtJM19cxEn
        4O7aauJuzhZg3cL3op2/ICrpwnCWqjNG7Q==
X-Google-Smtp-Source: ABdhPJzgM6quEVWuWiJhQG2I7OYCO8BS2rQlLH8AGD2/s14miyUtWSlF84AUkHzXPj2K+O0UiVLf0Q==
X-Received: by 2002:a05:620a:63a:: with SMTP id 26mr29176958qkv.490.1595950126670;
        Tue, 28 Jul 2020 08:28:46 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id g21sm11345205qts.18.2020.07.28.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:28:45 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:28:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH 1/6] commit-graph: fix regression when computing bloom
 filter
Message-ID: <20200728152844.GB87373@syl.lan>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <91e6e97a66aff88e0b860e34659dddc3396c7f28.1595927632.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91e6e97a66aff88e0b860e34659dddc3396c7f28.1595927632.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 09:13:46AM +0000, Abhishek Kumar via GitGitGadget wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> With 3d112755 (commit-graph: examine commits by generation number), Git
> knew to sort by generation number before examining the diff when not
> using pack order. c49c82aa (commit: move members graph_pos, generation
> to a slab, 2020-06-17) moved generation number into a slab and
> introduced a helper which returns GENERATION_NUMBER_INFINITY when
> writing the graph. Sorting is no longer useful and essentially reverts
> the earlier commit.

This last sentence is slightly confusing. Do you think it would be more
clear if you said elaborated a bit? Perhaps something like:

  [...]

  commit_gen_cmp is used when writing a commit-graph to sort commits in
  generation order before computing Bloom filters. Since c49c82aa made
  it so that 'commit_graph_generation()' returns
  'GENERATION_NUMBER_INFINITY' during writing, we cannot call it within
  this function. Instead, access the generation number directly through
  the slab (i.e., by calling 'commit_graph_data_at(c)->generation') in
  order to access it while writing.

I think the above would be a good extra paragraph in the commit message
provided that you remove the sentence beginning with "Sorting is no
longer useful..."

> Let's fix this by accessing generation number directly through the slab.
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 1af68c297d..5d3c9bd23c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -144,8 +144,9 @@ static int commit_gen_cmp(const void *va, const void *vb)
>  	const struct commit *a = *(const struct commit **)va;
>  	const struct commit *b = *(const struct commit **)vb;
>
> -	uint32_t generation_a = commit_graph_generation(a);
> -	uint32_t generation_b = commit_graph_generation(b);
> +	uint32_t generation_a = commit_graph_data_at(a)->generation;
> +	uint32_t generation_b = commit_graph_data_at(b)->generation;
> +

Nit; this whitespace diff is extraneous, but it's not hurting anything
either. Since it looks like you're rerolling anyway, it would be good to
just get rid of it.

Otherwise this fix makes sense to me.

>  	/* lower generation commits first */
>  	if (generation_a < generation_b)
>  		return -1;
> --
> gitgitgadget

Thanks,
Taylor
