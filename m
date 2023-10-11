Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3523CDB47C
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjJKTFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjJKTFR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:05:17 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ADC93
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:05:15 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65b0557ec77so987796d6.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697051115; x=1697655915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzYwjAmHoP126oxfHb3uG1ZZ6YehxhYfZoIPOAm53XA=;
        b=PpsZ4y6y9Q3rP4AFimJ6u+uEx6yKv89MEevbAjlZnrlR2vvAnMzJL0WBHvUmwDTT+e
         nn6G6cif9/X3v66z0N0gGK52oN/abR3qdwYz2tNsJTTEYg0aSKuqCO2D416SrdAYsGy3
         WEDEE3xakA1kzgp6snlnokVFp+ep04Kqooacrp6fyKCZlEUzulTUrlnuO8kwPWURVvKE
         H7/SQl20M3eAH8r7q6tmBdTmCACxA41Q8t6xocPwLgrGr81mU7EH9Nq8BUF+1D5hiiXz
         yEiqeEvCd8lEcgEHOCnn05KEGjuSogXsY0PWPO+vSqCGdIWQvLvN0WktFaWA7L61CSna
         wGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697051115; x=1697655915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzYwjAmHoP126oxfHb3uG1ZZ6YehxhYfZoIPOAm53XA=;
        b=v1kkh/276YabWTWesF2GT98IUfO0r9IVIe+8TwB93CqDMUrlQNgF6VE2c/QtaFoWXK
         PJapBOUOUbEQq5toGe8htnnIOm9tYZDaNhMz8lQJXz9CzIfqezKTapymTdbLj5dUrhDA
         yM9eL2H9R6OHDS4J4YRdxeSibi+c5UXBk3aH+WqysiAZ8viaGLgr86oDEWGQJ/iqbmaH
         gvCZBbKVFGXOhDKnk/VuQkfI8EURgCkOACUh5mItUEEtxbRmHiCTrMARpTqP9Z9The6I
         7uuQTMlGie6iKSMc94kr0nP7YCfNLxNkFsDvxETqXggsQW8fFbaIQqFSxb27NrRTwH1+
         vWbQ==
X-Gm-Message-State: AOJu0YxIrIQbCOvQLJjhKVAsLB+4jEBxjVPE88FF+JW6dWi+/Fwp6Qlz
        hxBZdTyQ7E3rjM160S7O99KFkg==
X-Google-Smtp-Source: AGHT+IH64yqgjDg0kUnHu47XZjGXdo4Zc2eJDTqSyQmLD3v8rGmksf+GJstZfj2l9m2sAFtQszi2Rg==
X-Received: by 2002:a0c:a9d7:0:b0:66d:229:b440 with SMTP id c23-20020a0ca9d7000000b0066d0229b440mr3732432qvb.7.1697051114974;
        Wed, 11 Oct 2023 12:05:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m11-20020a0cac4b000000b0065d0a4262e0sm5956246qvb.70.2023.10.11.12.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 12:05:14 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:05:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 14/20] commit-graph: bounds-check base graphs chunk
Message-ID: <ZSbx6ZqgEJQ9ikPJ@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210541.GN3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210541.GN3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:41PM -0400, Jeff King wrote:
> When we are loading a commit-graph chain, we check that each slice of the
> chain points to the appropriate set of base graphs via its BASE chunk.
> But since we don't record the size of the chunk, we may access
> out-of-bounds memory if the file is corrupted.
>
> Since we know the number of entries we expect to find (based on the
> position within the commit-graph-chain file), we can just check the size
> up front.
>
> In theory this would also let us drop the st_mult() call a few lines
> later when we actually access the memory, since we know that the
> computed offset will fit in a size_t. But because the operands
> "g->hash_len" and "n" have types "unsigned char" and "int", we'd have to
> cast to size_t first. Leaving the st_mult() does that cast, and makes it
> more obvious that we don't have an overflow problem.
>
> Note that the test does not actually segfault before this patch, since
> it just reads garbage from the chunk after BASE (and indeed, it even
> rejects the file because that garbage does not have the expected hash
> value). You could construct a file with BASE at the end that did
> segfault, but corrupting the existing one is easy, and we can check
> stderr for the expected message.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  commit-graph.c                |  8 +++++++-
>  commit-graph.h                |  1 +
>  t/t5324-split-commit-graph.sh | 14 ++++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index e4860841fc..4377b547c8 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -435,7 +435,8 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
>  	read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph);
>  	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges,
>  		   &graph->chunk_extra_edges_size);
> -	pair_chunk_unsafe(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
> +	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs,
> +		   &graph->chunk_base_graphs_size);
>
>  	if (s->commit_graph_generation_version >= 2) {
>  		pair_chunk_unsafe(cf, GRAPH_CHUNKID_GENERATION_DATA,
> @@ -546,6 +547,11 @@ static int add_graph_to_chain(struct commit_graph *g,
>  		return 0;
>  	}
>
> +	if (g->chunk_base_graphs_size / g->hash_len < n) {
> +		warning(_("commit-graph base graphs chunk is too small"));
> +		return 0;
> +	}
> +

Nice. Here's a spot where we would not benefit from a function like
`pair_chunk_expect()`, since we don't know about the chain when we are
parsing an individual layer of it. So storing the length off to the side
and checking it within `add_graph_to_chain()` makes sense.

Thanks,
Taylor
