Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27E622A7F8
	for <git@vger.kernel.org>; Thu, 15 May 2025 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338872; cv=none; b=ZvVvjpTxnYfkTU1G/IEVwN6t4EflLdj/kwwQLVc5CPf5GxZAkPclNesA4rhMk7ofuS18PL3Zn/RW/TIAqACs292K7VRiqGeS3SF42lcBMe70GS3xbvwQlCjO+O//dTWqH+quASgKVxQ02vNbYfmhzB4vjZkHEkOrDDzziGOrx70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338872; c=relaxed/simple;
	bh=Sno0rzqav1PhBOqCOihfNlqbBMHMKPPTy4P/Kz86t4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2ow+yBOcTz0sQIFzXRXnbUbywYeEdQ7Pnf+vMRtZwjSrSMwTHcVTCIQukMQuZZYVv9t3PZifpYlEXi4/1T7c+lUe0PtmhaAmM5h6Xqy1BRtKoRuHukyWDR5IloxxmSRHtcHd5hnwuBakXLUTBh4c5ClrlVvqb878hJ2rMuV8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=L7emX6xO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="L7emX6xO"
Received: (qmail 604 invoked by uid 109); 15 May 2025 19:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Sno0rzqav1PhBOqCOihfNlqbBMHMKPPTy4P/Kz86t4M=; b=L7emX6xOQjI+Fb4BLK01oJ719ffq6gg4C8WNc9EbKpmgxP/uhtoygNaI7Oc+ENLRywqRZ5gtfRas3XtaCSfnA812d1cuVowHjTcXcaGKIKP3WDumAZgiEg5DBwaedeBksoUk4Le9u4AMc/oC4TrMP0nQ6VqYZjdnJuFJzXZ1V8hkEf+hM6t1GvmdfmzgJ1v4GO88Ur0NwIFJdC/0Hy9jvgHzj2ds0gnwAgrh4gTWgzH4fDcAHG7hbNp1G71A6Kj9ZHnGWibGe7lqP48UdcGfO8BdjFrc5+HCcSSSaMYpRj+s/EjsrrXlLFVd/RvvYa/qD2QxP/re41xMGEO1wzp+nA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 19:54:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30463 invoked by uid 111); 15 May 2025 19:54:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 15:54:31 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 15:54:28 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 03/11] commit-graph: avoid malloc'ing a local variable
Message-ID: <20250515195428.GD3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <5a3a8880a68f8c69c2af39d2e32ebb56eb5fa483.1747314709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a3a8880a68f8c69c2af39d2e32ebb56eb5fa483.1747314709.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:41PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> We do need a context to write the commit graph, but that context is only
> needed during the life time of `commit_graph_write()`, therefore it can
> easily be a stack variable.

Yay. I am in favor of using stack variables when possible as a general
rule.

> diff --git a/commit-graph.c b/commit-graph.c
> index 6394752b0b08..9f0115dac9b5 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2509,7 +2509,17 @@ int write_commit_graph(struct object_directory *odb,
>  		       const struct commit_graph_opts *opts)
>  {
>  	struct repository *r = the_repository;
> -	struct write_commit_graph_context *ctx;
> +	struct write_commit_graph_context ctx = {
> +		.r = r,
> +		.odb = odb,
> +		.append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0,
> +		.report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0,
> +		.split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0,
> +		.opts = opts,
> +		.total_bloom_filter_data_size = 0,
> +		.write_generation_data = (get_configured_generation_version(r) == 2),
> +		.num_generation_data_overflows = 0,
> +	};
>  	uint32_t i;
>  	int res = 0;
>  	int replace = 0;
> @@ -2531,17 +2541,6 @@ int write_commit_graph(struct object_directory *odb,
>  		return 0;
>  	}
>  
> -	CALLOC_ARRAY(ctx, 1);
> -	ctx->r = r;
> -	ctx->odb = odb;
> -	ctx->append = flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
> -	ctx->report_progress = flags & COMMIT_GRAPH_WRITE_PROGRESS ? 1 : 0;
> -	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
> -	ctx->opts = opts;
> -	ctx->total_bloom_filter_data_size = 0;
> -	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
> -	ctx->num_generation_data_overflows = 0;

OK, this moves the initialization to the top of the function. So to
review this for correctness, we must make sure that we do not change the
values of any of those variables between the two spots (i.e., in the
diff context that is omitted).

Most of it looks fine. Our call to get_configured_generation_version()
now happens earlier, before the call to prepare_repo_settings(). I think
that is OK, because the former calls repo_config_get_int() directly. It
does seem like a potential maintenance problem if that call is ever
rolled into prepare_repo_settings().

So maybe OK, but the smaller change would be to just replace the calloc
with a memset(), and s/->/./ on the subsequent lines.

-Peff
