Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BAECDB477
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 18:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjJKSqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjJKSqd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 14:46:33 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C77B93
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:46:31 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af609c5736so53379b6e.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697049990; x=1697654790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rakoLf6bFp+4U9CijMyY63obnUs7iUvG88tlXJUMTNo=;
        b=SZ7/UMnafrruVccs9lGDDK1X8sVDO050yDD/ojjvYCP4UxSk/MLebnIAyalkxiwKMm
         rTBZyappddN/rv3C8ALLDzUX+sZ+KEDvBuZnG0ZfgYhtX4ccTLpRzfMM08Pfxj5pR04B
         bmlx7h03o0Rt2cfnd2TF7r8Pwy7G9yNG89wtJ+brsZ03HW5/GUSryYnsW23yNzQuP6is
         t9qKZsZdIbGo/k/KVfCkt56fPCjLqJ7yxq7XsRcEmk0UbM+3zYjgc7UakBN+9NDaetOO
         7Coy3B9OvptYZu9q72rTwlVB3Q7x5Lz58ydS7c5ecC0NS4sFlCHmtYzxdhTMlCwkZ5jU
         TxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697049990; x=1697654790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rakoLf6bFp+4U9CijMyY63obnUs7iUvG88tlXJUMTNo=;
        b=ZHHbG92ONQGD/YudpkKueVoUZCULk4kPQhL143Ugw5YtdWETLW6LEmTrLWM+a/VPio
         NNtwPL2VOruFgp6x//qAv7vJQKe/l9w6C3oCCSK1TW8dkYGIobzEmOkiKSk5kOzxsU70
         ohRCDVs57PRNeE4mto72iKKgbGyPPivSFdf58QjfQmCdRYxOIlKpYlT6iV6jO3pq2+gj
         prDpVbeFSjpeCgegIRa8BzadAGy+LDJcsmn/+QI7GhrjE03UP9i32V24KBg+aR71SM6r
         1Hm0t5oxOnwICCs2gi/GZ6X6Xq3VwdvRRzjFP3xdXqkkVS1DAm8UsVdsX2oFplzULnCU
         M3iw==
X-Gm-Message-State: AOJu0YxDIoEgL99bBUSdopXjclLb3l8eyIKiF5ZBtWFtGVJMfSf7URjm
        pN/M59US8RXHo9zot6trwC4/2VXOaAmTwlURO3dYMQ==
X-Google-Smtp-Source: AGHT+IE0BfbNOcRmCiUw24UZOq4QOzs7va4tIT21WPq/nHyDdAmDTtbOGuh9MAS5GQ9pOOP5093WbQ==
X-Received: by 2002:a05:6808:20a1:b0:3ac:b73a:757f with SMTP id s33-20020a05680820a100b003acb73a757fmr24947530oiw.39.1697049990580;
        Wed, 11 Oct 2023 11:46:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w7-20020a0cc247000000b0066cfd398ab5sm1333422qvh.146.2023.10.11.11.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:46:30 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:46:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 12/20] commit-graph: check size of commit data chunk
Message-ID: <ZSbthK5919QdrEPx@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210536.GL3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210536.GL3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:36PM -0400, Jeff King wrote:
> We expect a commit-graph file to have a fixed-size data record for each
> commit in the file (and we know the number of commits to expct from the
> size of the lookup table). If we encounter a file where this is too
> small, we'll look past the end of the chunk (and possibly even off the
> mapped memory).
>
> We can fix this by checking the size up front when we record the
> pointer.
>
> The included test doesn't segfault, since it ends up reading bytes
> from another chunk. But it produces nonsense results, since the values
> it reads are garbage. Our test notices this by comparing the output to a
> non-corrupted run of the same command (and of course we also check that
> the expected error is printed to stderr).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  commit-graph.c          | 12 +++++++++++-
>  t/t5318-commit-graph.sh |  9 +++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 472332f603..9b80bbd75b 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -340,6 +340,16 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
>  	return 0;
>  }
>
> +static int graph_read_commit_data(const unsigned char *chunk_start,
> +				  size_t chunk_size, void *data)
> +{
> +	struct commit_graph *g = data;
> +	if (chunk_size != g->num_commits * GRAPH_DATA_WIDTH)

Should this be guarded with an st_mult? I think that GRAPH_DATA_WIDTH is
defined as (the_hash_algo->rawsz + 16), so I *think* that the expression
in the parenthesis would get done as a size_t, and then g->num_commits
would be widened to a size_t for the purposes of evaluating this
expression.

So I think that this is all OK in the sense that we'd never underflow
the 64-bit space, and having more than 2^64-1/36 (some eighteen
quintillion) commits is... unlikely ;-).

But it may be worth wrapping this computation in an st_mult() anyway to
avoid future readers having to think about this.

> +		return error("commit-graph commit data chunk is wrong size");
> +	g->chunk_commit_data = chunk_start;
> +	return 0;
> +}
> +
>  static int graph_read_bloom_data(const unsigned char *chunk_start,
>  				  size_t chunk_size, void *data)
>  {
> @@ -422,7 +432,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
>
>  	read_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph);
>  	read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
> -	pair_chunk_unsafe(cf, GRAPH_CHUNKID_DATA, &graph->chunk_commit_data);
> +	read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph);

Here again would be a good use-case for a `pair_chunk_expect()`
function, but I don't want to beat a dead horse ;-).

Thanks,
Taylor
