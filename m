Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95609C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F1F22C9F
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgLDTP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgLDTP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:15:28 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A9EC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 11:14:48 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id m5so3734995pjv.5
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jF3xzOiioclG1HxQUspravuSQKYKpsz+1HmQsLN9ois=;
        b=jEJMagMcNejZVi6T5U/nsEbebGgVNXC8g/rs2qBcrXlEXOVV6UgM/uhJ4gd7sRGOMz
         NJP+e99kOHFCjCM32n+HxsYhuxuQPp5ksMx4G2xD5HE06g7zubKnT+Nb7Atc5LDiq09L
         bisjhp2vMHTa8NXiDoYPpeGLZhcv1oywgxdbJQ9y4+rsZYyuEgAGZPDQfO+ITgNKLdJC
         H+C5zRuuf8FPWML2hO/X0IwSh5xQvnl3ymHHpORcAkeSkw/op4Kzp2N8Uw3w5tI19ah0
         3/NVKY5M+4bBkcIsV7c336ZNjxn7Cqe9g1uVbGZTFZNNbIzrv77gEUmU7QoSNctopSbt
         gfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jF3xzOiioclG1HxQUspravuSQKYKpsz+1HmQsLN9ois=;
        b=dDxC4kwFR6EE+ys2ZwOYc3nkOndeZLaYzC0SK8gOYaDlcoOqKhwcHYOqVBVNYQmLYn
         lJdJXtUkeUQegjawDQNPq8nk9LU9oz0R/Rf0ObiZHI1FICr3tLpEJ2OpSxFpgXYbINO7
         AFhuHYwRVLgY8J5Sm8/5uvhjVzu6dogd57pBE4K9mWkigPUWOHx5eZolEx6LommZTfV0
         XLee5DBTDQmqUeOtn+99NXECGTQOQfdgl6SlOEGW5BbujcvS45oeBt5nDQmXl5XDIgKI
         ABjp5XRyP+oAvbCq0PmqkWQlVpfXlzuQfuBjBHNaT2VmSHJ61jE7lL1lzLt2zYNQhro1
         wG7g==
X-Gm-Message-State: AOAM5326uvVN+SCSzzKzlbJPbQmEjO1KCURTUFBxLi9uZBVMKIx6l9ph
        s5939tQ2VL95Ekvkv20GFnwcwtq+i0mFucxZ
X-Google-Smtp-Source: ABdhPJy/kzWWNdCLNUKvkeJDk/qdEy3s9qGNh+cGyg4aAPqMXRtMQA8SVMk9Gmj4Krh5biA48LW80g==
X-Received: by 2002:a17:90a:c901:: with SMTP id v1mr5235738pjt.7.1607109287727;
        Fri, 04 Dec 2020 11:14:47 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id b22sm440530pfo.163.2020.12.04.11.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 11:14:47 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:14:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 8/9] commit-graph: replace packed_oid_list with oid_array
Message-ID: <X8qKpL+mIFbjngwl@nand.local>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qGqHvHbJQL9B22@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X8qGqHvHbJQL9B22@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 01:57:44PM -0500, Jeff King wrote:
> Our custom packed_oid_list data structure is really just an oid_array in
> disguise. Let's switch to using the generic structure, which shortens
> and simplifies the code slightly.
>
> There's one slightly awkward part: in the old code we copied a hash
> straight from the mmap'd on-disk data into the final object_id. And now
> we'll copy to a temporary oid, which we'll then pass to
> oid_array_append(). But this is an operation we have to do all over the
> commit-graph code already, since it mostly uses object_id structs
> internally. I also measured "git commit-graph --append", which triggers
> this code path, and it showed no difference.

I noticed that you also dropped the pre-allocation logic, which I think
is the right thing to do (that is, removing it, not keeping it around).

It may be worth a mention here, though.

> @@ -2199,26 +2177,16 @@ int write_commit_graph(struct object_directory *odb,
>  	}
>
>  	ctx->approx_nr_objects = approximate_object_count();
> -	ctx->oids.alloc = ctx->approx_nr_objects / 32;
>
> -	if (ctx->split && opts && ctx->oids.alloc > opts->max_commits)
> -		ctx->oids.alloc = opts->max_commits;

One compelling reason to drop this logic is that we only have the
oid-array internals touching the .alloc variable, and we're not munging
with it ourselves (running the risk of getting it out-of-sync with the
actual number of bytes allocated).

> -
> -	if (ctx->append) {
> +	if (ctx->append)
>  		prepare_commit_graph_one(ctx->r, ctx->odb);

Good, this still needs to happen here.

> -		if (ctx->r->objects->commit_graph)
> -			ctx->oids.alloc += ctx->r->objects->commit_graph->num_commits;
> -	}
> -
> -	if (ctx->oids.alloc < 1024)
> -		ctx->oids.alloc = 1024;
> -	ALLOC_ARRAY(ctx->oids.list, ctx->oids.alloc);
>
>  	if (ctx->append && ctx->r->objects->commit_graph) {
>  		struct commit_graph *g = ctx->r->objects->commit_graph;
>  		for (i = 0; i < g->num_commits; i++) {
> -			const unsigned char *hash = g->chunk_oid_lookup + g->hash_len * i;
> -			hashcpy(ctx->oids.list[ctx->oids.nr++].hash, hash);
> +			struct object_id oid;
> +			hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * i);
> +			oid_array_append(&ctx->oids, &oid);

And this must be the spot that you're talking about that requires the
extra copy. I think that we could certainly live with what you have
here.

Thanks,
Taylor
