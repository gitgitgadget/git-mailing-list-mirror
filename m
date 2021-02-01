Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4697BC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2141E64E8F
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 17:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBARkt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhBARkg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 12:40:36 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A954EC0613ED
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 09:39:56 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d85so17065352qkg.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 09:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y8HkwY7SnVqalr1dGR/VUN9/22CO9/fJpJDVEKLku24=;
        b=pmWKSa3SP2o2Fvcl7okNrElMrBanwjPsgrLMCW3zlGv9RFceTAjfX2BycuU6rSDxS6
         1/nw9cDKbI31E2LRe9R7aHngjzsCrPRTCUmA5XxtT8qnoyNNitb64psxeZUTBjqkJzof
         dw95qc9hghzEb0e/UmaCBbGjfKPXHQWTYZwqTMWt/lXwc2FPa4ucnZXoDCeiWunMneyu
         hgmNkh1uFQZsTj0fnl7a6pC5Dx6bZmUWLBeMc/ZKFiWSuKRXGe8LwZ+BMXfFTKeh14/S
         I7LyjtQB3j/UXbzaqO7gtRDfNN7Uv7pjuJtauz9Q/hTBwVokHimooxaZrBYdAWwouqyG
         Ce4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y8HkwY7SnVqalr1dGR/VUN9/22CO9/fJpJDVEKLku24=;
        b=doUKv7RcEJ+NLhW5Srm+zYwws2Fda08+zEyxEjuv1H3FMb5HIelD4fPpJjn4d0rgdb
         9Vuz4yMVzYevKLUH/8ML4UWR0yE55X1+pAZhHShoLN+3QnZocXvfJexp4JS0rROFkxMY
         APvTlAZhXLcbRtPzyBX1NaWb8BOLNQlSLbdf14dsqj4UDv1cMiCAe7Ky56s90HHq8p4V
         KedJb4hkRFmmwtJH/rDwlm5u27cVX8O2l4yQOm3g0fS5JKgelefIdPxKraEgIKBgqJ5D
         LjG3dZgb94gHI1pwcw2arjgVeBgFFs6Alc7QtoOuki87fKa9dPTJBRUDuux745CXiI79
         Fhfg==
X-Gm-Message-State: AOAM531OdetKK9/I6t1mSn7Lq2ICK5uywrV0qQ2YFQbYbjiKntCdD0sF
        0jT1G+2Kki8IYrACjyuNHbsyTA==
X-Google-Smtp-Source: ABdhPJxbzuTpX6lo14fYqcDLSF/mp0BdmH50RXQQ1a9CGcFCHPc62SrP50Sn6j0GeXF+78wWSSHVAA==
X-Received: by 2002:a05:620a:4c:: with SMTP id t12mr17362602qkt.74.1612201195942;
        Mon, 01 Feb 2021 09:39:55 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:8bd2:a84b:ef4c:2356])
        by smtp.gmail.com with ESMTPSA id c12sm14706343qkg.118.2021.02.01.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:39:54 -0800 (PST)
Date:   Mon, 1 Feb 2021 12:39:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gister@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/5] commit-graph: validate layers for generation data
Message-ID: <YBg858G1eFy1if6o@nand.local>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <d554fa306601c9e5e0e804d10b7a73b6eece6b04.1612199707.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d554fa306601c9e5e0e804d10b7a73b6eece6b04.1612199707.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 01, 2021 at 05:15:05PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index edbb3a0f2cc..13992137dd0 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -614,19 +614,26 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
>  	return graph_chain;
>  }
>
> -static void validate_mixed_generation_chain(struct commit_graph *g)
> +/*
> + * returns 1 if and only if all graphs in the chain have
> + * corrected commit dates stored in the generation_data chunk.
> + */
> +static int validate_mixed_generation_chain(struct commit_graph *g)

Thanks for the comment. It does make me wonder if the function name
needs updating, though. I'm having some trouble coming up with a better
alternative, though, so maybe it's fine...

>  {
> -	int read_generation_data;
> +	int read_generation_data = 1;

OK, we might not ever enter the while loops below, so this needs
initializing.

> +	struct commit_graph *p = g;
>
> -	if (!g)
> -		return;
> -
> -	read_generation_data = !!g->chunk_generation_data;
> +	while (read_generation_data && p) {
> +		read_generation_data = p->read_generation_data;
> +		p = p->base_graph;
> +	}

This could probably be guarded with an 'if !read_generation_data', since
if the previous while loop always read '1' from
'p->read_generation_data', then nothing needs updating, no?

(If you do make this change, please don't add '!read_generation_data' to
the while expression, since it isn't a property of the loop.)

>  	while (g) {
>  		g->read_generation_data = read_generation_data;
>  		g = g->base_graph;
>  	}
> +
> +	return read_generation_data;
>  }
>
>  struct commit_graph *read_commit_graph_one(struct repository *r,
> --
> gitgitgadget
>

Thanks,
Taylor
