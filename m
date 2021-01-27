Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2195EC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A48206B9
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 03:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbhA0D7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhA0DE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 22:04:26 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9251CC061786
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 19:02:46 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id v3so490463qtw.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 19:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W7c39vfYAQcqa9VB2NCZmwFNu2tywLzGrqHmlw79K0s=;
        b=ihd7mv6XSOEJe02RAynATbCN802YzNpJUUDOSAmimNAqE7YZSORpqecvQ46dDW5gc2
         WYngS5AnANnmKpSo1Y38vrNnZWy6zxfsp/wkG8qZMJZiSXRD15Pas0wAj3Vfbn/sTHqd
         OMKthbmeleIgUEtIQ0LN7kAMOp1omtlB7RcpWr/j5gPqv5veSB6cat8pyFVa6CXvYcuX
         cEWK2DgoCd+tENSDRthMGaI0yY7IiXbCwCFxzzj6MZLgsASNU3QguO8sWdiBqbYJFOY3
         bz2hYxCBW2k7gi5Hp6GrlfSswVPYJ3Tft5JCDzs9IHdIw1vgo87v/4Vfa2UfoB1OgS48
         EXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W7c39vfYAQcqa9VB2NCZmwFNu2tywLzGrqHmlw79K0s=;
        b=QJ1LQOby+nOjIl8mzpSxeOAZErXXF8+HyhmX92FTXwgPuSSNYvXzXIVN1BtsCOZGSH
         hHn7WW6J6WsMLTRkl+79LgarH46dvoNNZyr6tB5BQMfOaAzFa8z0cuHmMy5tLDAXjKPv
         o0At35I41pojDnBj6AQd6ZuY+w4fa0jZ66vjBfsJf3plM017K7yC+Zz2Na18TolQk1x3
         03Sv462r9NLNRiJt1fCXx+9q6b3cOgGQMUud/AKr+gdir6zW/hoJAXIBF4XVdlZWgjfk
         tqUSRZsy68zXXFZqfQWG0yR2CGCDFV7u0XyMB+w8/nuh0WJ7W+XZP020/hVroNeSYNLZ
         YJhw==
X-Gm-Message-State: AOAM532GHmxpW6ygCeuMiyGXPGSaHu1J8mOoFf9Tw8HRYx/vawMQMuNX
        1ogW6B+8hvRj2XvxssQEF6Pkcw==
X-Google-Smtp-Source: ABdhPJyUxuT0tsigSfCutQMJhgBAhzcQd0NS8r9ffL+sB0wjXViQQcLagvShPjGu0t4bz6ZuB3MrsQ==
X-Received: by 2002:ac8:4d59:: with SMTP id x25mr4147892qtv.369.1611716565745;
        Tue, 26 Jan 2021 19:02:45 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5cad:8534:72d4:8c70])
        by smtp.gmail.com with ESMTPSA id t6sm500362qti.2.2021.01.26.19.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 19:02:45 -0800 (PST)
Date:   Tue, 26 Jan 2021 22:02:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, szeder.dev@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 12/17] chunk-format: create read chunk API
Message-ID: <YBDX0wD4wwzuCyYh@nand.local>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <e3475633e1d2e397c5095f34c23a19fccb2c8428.1611676886.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3475633e1d2e397c5095f34c23a19fccb2c8428.1611676886.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 04:01:21PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/chunk-format.c b/chunk-format.c
> index 2ce37ecc6bb..674d31d5e58 100644
> --- a/chunk-format.c
> +++ b/chunk-format.c
> @@ -12,6 +12,8 @@ struct chunk_info {
>  	uint32_t id;
>  	uint64_t size;
>  	chunk_write_fn write_fn;
> +
> +	const void *start;

It may be clearer to fold both of these into an anonymous union along
with an enum to indicate which mode we're in. But, I could also buy that
that is more error prone, so perhaps just a comment along the lines of
"exactly one of these is NULL" would suffice, too.

>  };
>
>  struct chunkfile {
> @@ -89,3 +91,65 @@ int write_chunkfile(struct chunkfile *cf, void *data)
>
>  	return 0;
>  }
> +
> +int read_table_of_contents(struct chunkfile *cf,
> +			   const unsigned char *mfile,
> +			   size_t mfile_size,

Assuming that mfile and mfile_size are a pointer to a memory mapped
region and its size? If so, a nit is that I'd expect "data" and "size"
instead of "mfile".

I think that it's probably going too far to have the chunkfile API
handle mapping its own memory, so in that way I don't think it's wrong
for the callers to be handling that.

OTOH, it does seem a little weird to temporarily hand off ownership like
this. I don't think I have a better suggestion, though.

The implementation of this function looks good to me.

> +int pair_chunk(struct chunkfile *cf,
> +	       uint32_t chunk_id,
> +	       chunk_read_fn fn,
> +	       void *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < cf->chunks_nr; i++) {
> +		if (cf->chunks[i].id == chunk_id)
> +			return fn(cf->chunks[i].start, cf->chunks[i].size, data);
> +	}
> +
> +	return CHUNK_NOT_FOUND;
> +}
> diff --git a/chunk-format.h b/chunk-format.h
> index bfaed672813..250e08b8e6a 100644
> --- a/chunk-format.h
> +++ b/chunk-format.h
> @@ -17,4 +17,25 @@ void add_chunk(struct chunkfile *cf,
>  	       size_t size);
>  int write_chunkfile(struct chunkfile *cf, void *data);
>
> +int read_table_of_contents(struct chunkfile *cf,
> +			   const unsigned char *mfile,
> +			   size_t mfile_size,
> +			   uint64_t toc_offset,
> +			   int toc_length);
> +
> +/*
> + * When reading a table of contents, we find the chunk with matching 'id'
> + * then call its read_fn to populate the necessary 'data' based on the
> + * chunk start and size.
> + */
> +typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
> +			     size_t chunk_size, void *data);
> +
> +
> +#define CHUNK_NOT_FOUND (-2)
> +int pair_chunk(struct chunkfile *cf,
> +	       uint32_t chunk_id,
> +	       chunk_read_fn fn,
> +	       void *data);

From reading the implementation, I take it that this function calls fn
with the location and size of the requested chunk, along with the user
supplied data.

I'm not sure that "pair" gives me that same sense. Maybe "read" or
"lookup" would be better?

Dunno.

Thanks,
Taylor
