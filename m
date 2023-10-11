Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28769CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjJKTP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjJKTPz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:15:55 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF69D
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:15:54 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77063481352so114080185a.1
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697051753; x=1697656553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+io4I/gg33YHwm9v+jJO4wlxgqNYV3dFilp9tSPhwA=;
        b=vF2GAAYklg4TuaeDmj9B208/0b/IxLKSjWK4178Y46eYCnvwXk7rypx+9mVc0sC2Ej
         +T0PkDDLNCesttgPyjUyFSmBv3X+MeXj1pJp4bjVCeUbdMb5Akil6zmHfjZqJMP+q7uZ
         B4W4hqT6BOGqNjAbF73ppItkmT57JpBFajSLTo0TRmdFqv/SDPNC3IjGu2PA1BbprEkP
         v3G1qgOl0dFuH3NwyoHf33xBieFHEIyoCSqTayvkcJniWgrs01ufpmnlVYGtmlHb1Wcu
         fBCOEgo+lfmEJW1U44dft60gL6LHbfjMD2suw2iyaU6zPK1fK1LfunTCQAIcG9DybLTN
         vlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697051753; x=1697656553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+io4I/gg33YHwm9v+jJO4wlxgqNYV3dFilp9tSPhwA=;
        b=gfi62A/C5PVtu3EAT9SRFe+tVc1IPJYwY7FDaN9WLMEAzvxcO6RnqW4SCI9SrxnvgV
         tFyz2OKs/BBy2q+wNqAOyr0XCj/DBGkLv0cENa2IfaTvfdRGIPVqtGXlFxJSYxiU9U3R
         GC7VticFB7PDYpE1kzwkIKNSl5kJf/vSwZFptBJongQvSlu69K/IWsEndcL3qFxHSqjq
         ZCN1vw1pYf0sVfCBR25ThQvd5lKnuYRwLNMwoCmyO+JkcrLiEs/KTXjxSm2ZaTuqxySL
         ap+kK1qOKcG4iifA/mCRkFtJK5ubBDSsxqbE1xz3SkBB/hoaSZFF+AIuefnpOJn0AQLT
         M5nA==
X-Gm-Message-State: AOJu0Yx+pMDk/fvcYaw5PyB9yxmWMjrr6+xcCkcqV38i2R0nShDzfKKk
        9rUkf/dKH/C852YZ7Q+5njKDHmQq/41w8NpgqHkEVw==
X-Google-Smtp-Source: AGHT+IE0BVAO1xqBR9V2jemUrkT23hzYVjct6SGJF7JPHjVjFJlIx86dcX0t8XwuWY2i/xhLsbhPew==
X-Received: by 2002:a05:620a:2907:b0:774:17fe:5820 with SMTP id m7-20020a05620a290700b0077417fe5820mr25794369qkp.21.1697051753079;
        Wed, 11 Oct 2023 12:15:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e12-20020ac8670c000000b0041817637873sm5592603qtp.9.2023.10.11.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 12:15:52 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:15:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 18/20] commit-graph: check bounds when accessing BIDX
 chunk
Message-ID: <ZSb0ZzvW9sYr3/kX@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210553.GR3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210553.GR3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:53PM -0400, Jeff King wrote:
> We load the bloom_filter_indexes chunk using pair_chunk(), so we have no
> idea how big it is. This can lead to out-of-bounds reads if it is
> smaller than expected, since we index it based on the number of commits
> found elsewhere in the graph file.
>
> We can check the chunk size up front, like we do for CDAT and other
> chunks with one fixed-size record per commit.
>
> The test case demonstrates the problem. It actually won't segfault,
> because we end up reading random data from the follow-on chunk (BDAT in
> this case), and the bounds checks added in the previous patch complain.
> But this is by no means assured, and you can craft a commit-graph file
> with BIDX at the end (or a smaller BDAT) that does segfault.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  commit-graph.c       | 16 ++++++++++++++--
>  t/t4216-log-bloom.sh |  9 +++++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index f7a42be6d0..1f334987b5 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -360,6 +360,18 @@ static int graph_read_generation_data(const unsigned char *chunk_start,
>  	return 0;
>  }
>
> +static int graph_read_bloom_index(const unsigned char *chunk_start,
> +				  size_t chunk_size, void *data)
> +{
> +	struct commit_graph *g = data;
> +	if (chunk_size != g->num_commits * 4) {

Here we probably should wrap `g->num_commits * 4` in an st_mult() call.
Having 4B commits is probably pretty unlikely in practice, but we have
definitely seen issues in the wild at GitHub where we have more than
2^32-1/20 commits in a single network.git.

> +		warning("commit-graph changed-path index chunk is too small");

Should this be marked for translation?

> +		return -1;
> +	}
> +	g->chunk_bloom_indexes = chunk_start;
> +	return 0;
> +}
> +
>  static int graph_read_bloom_data(const unsigned char *chunk_start,
>  				  size_t chunk_size, void *data)
>  {
> @@ -470,8 +482,8 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
>  	}
>
>  	if (s->commit_graph_read_changed_paths) {
> -		pair_chunk_unsafe(cf, GRAPH_CHUNKID_BLOOMINDEXES,
> -			   &graph->chunk_bloom_indexes);
> +		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
> +			   graph_read_bloom_index, graph);

Since we know g->num_commits by this point, this would be another spot
that would benefit from a `pair_chunk_expect()` function. But, again,
not trying to beat a dead horse here or anything ;-).

Thanks,
Taylor
