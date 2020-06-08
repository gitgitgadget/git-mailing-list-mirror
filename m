Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1323BC433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 08:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E295D206A4
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 08:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5bI21DN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgFHI0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbgFHI0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 04:26:40 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41508C08C5C3
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 01:26:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r15so15581023wmh.5
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZAcG/9vo/YVtV048277FIno5Z9b8Rg2DSnS1voKlmBs=;
        b=W5bI21DN6nq2BelIRJ3TeUrAfhtinjAk65MlatIlCBmm2mjgSdq7eQ6YdxW4iuA8WZ
         Zm/uqUHrwj+KvZS/CxN3likR8Z1WTXvBDxTG1Flgv/Iunm7XceigmU3efakJ5iFSbq7J
         Xf0xKXFuyEV8EA3jWci0k6DEWguxOaYO1pYo8I985FqrYKQ5M63IWvzWFttJKVXeohcy
         VOv0KVByEFGKJx5DBonuITuicfz4MbBxNzQtnKE+5nKgPPgYZrIzBsJVdSvaQdLxGMN3
         SOd+wkWhGkVvAxhprYaThgngPbKXbOQuFEZ58ZBYDN94Scu/Iw5uh+AC9QLD5iEm6WRR
         nk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZAcG/9vo/YVtV048277FIno5Z9b8Rg2DSnS1voKlmBs=;
        b=b5AEQLU7w5Tj49OJkqm/VZdlTIpGkiNlouCbcyMjto/M+HxRkMKafrz9ZIezrnL0/u
         maRlOWa1LylWPz0uIxT2efnKZ0MdDl3n4lr55piriEKaNKuonVUVTowmfaRLjV+rxUwe
         FFRrg5B2+KyUmTlBTgoCBVuJS0CKVB8g050U4VPiy6HaVar/o4QbP3IdUrLk9n4Q78K0
         T2w2q/lMBBb8zT3EHj2F1Es+DcdaStB/HWTY1NcOSzGxswcHYegrU9C1v1NBFgFI8qzH
         wzRBfrVCC6JXKxRRegPHx2pBnRkRW9++93jhgP+xdxnblxxAVQ24MM5VSR5altZVJWqx
         YibQ==
X-Gm-Message-State: AOAM530zkwzc+jvcgmtH81f7apvLyN8zTplPxgiVpu1O0TRcR55h08wx
        15FRoE8ItC1cjjbTuRji2hRfKKt7
X-Google-Smtp-Source: ABdhPJxE6SROoAbQCBmYnf/9xkItqrms6IVe37hvMOxgAairKgNAgFo9GnQdWVr8NxA6+8d+kVeknw==
X-Received: by 2002:a1c:8049:: with SMTP id b70mr15845703wmd.145.1591604799041;
        Mon, 08 Jun 2020 01:26:39 -0700 (PDT)
Received: from szeder.dev (78-131-14-185.pool.digikabel.hu. [78.131.14.185])
        by smtp.gmail.com with ESMTPSA id g18sm22039950wme.17.2020.06.08.01.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 01:26:38 -0700 (PDT)
Date:   Mon, 8 Jun 2020 10:26:36 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com, stolee@gmail.com
Subject: Re: [GSOC Patch v2 2/4] commit: move members graph_pos, generation
 to a slab
Message-ID: <20200608082636.GC8232@szeder.dev>
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-1-abhishekkumar8222@gmail.com>
 <20200607193237.699335-3-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200607193237.699335-3-abhishekkumar8222@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 08, 2020 at 01:02:35AM +0530, Abhishek Kumar wrote:
> diff --git a/commit-graph.c b/commit-graph.c
> index 7d887a6a2c..f7cca4def4 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c

> @@ -1302,8 +1302,8 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  					ctx->commits.nr);
>  	for (i = 0; i < ctx->commits.nr; i++) {
>  		display_progress(ctx->progress, i + 1);
> -		if (ctx->commits.list[i]->generation != GENERATION_NUMBER_INFINITY &&
> -		    ctx->commits.list[i]->generation != GENERATION_NUMBER_ZERO)
> +		if (commit_graph_generation(ctx->commits.list[i]) != GENERATION_NUMBER_INFINITY &&
> +		    commit_graph_generation(ctx->commits.list[i]) != GENERATION_NUMBER_ZERO)
>  			continue;
>  
>  		commit_list_insert(ctx->commits.list[i], &list);
> @@ -1314,22 +1314,22 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
>  			uint32_t max_generation = 0;
>  
>  			for (parent = current->parents; parent; parent = parent->next) {
> -				if (parent->item->generation == GENERATION_NUMBER_INFINITY ||
> -				    parent->item->generation == GENERATION_NUMBER_ZERO) {
> +				if (commit_graph_generation(parent->item) == GENERATION_NUMBER_INFINITY ||
> +				    commit_graph_generation(parent->item) == GENERATION_NUMBER_ZERO) {
>  					all_parents_computed = 0;
>  					commit_list_insert(parent->item, &list);
>  					break;
> -				} else if (parent->item->generation > max_generation) {
> -					max_generation = parent->item->generation;
> +				} else if (commit_graph_generation(parent->item) > max_generation) {
> +					max_generation = commit_graph_generation(parent->item);
>  				}
>  			}
>  
>  			if (all_parents_computed) {
> -				current->generation = max_generation + 1;
> +				commit_graph_data_at(current)->generation = max_generation + 1;
>  				pop_commit(&list);
>  
> -				if (current->generation > GENERATION_NUMBER_MAX)
> -					current->generation = GENERATION_NUMBER_MAX;
> +				if (commit_graph_generation(current) > GENERATION_NUMBER_MAX)
> +					commit_graph_data_at(current)->generation = GENERATION_NUMBER_MAX;
>  			}
>  		}
>  	}

Something about these conversions is not right, as they send
compute_generation_numbers() into an endless loop, and
't5318-commit-graph.sh' hangs because of this.

