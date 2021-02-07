Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D88C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 20:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0B064E35
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 20:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBGUV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 15:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGUVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 15:21:25 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C6C061756
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 12:20:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s11so15808473edd.5
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 12:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wb8rDdeinMSHdr3hHoFmcwnvVW9lrA9qVVpN4tanSq4=;
        b=MQHvsAtjmILUEE25lMohyN+EPAFAuhgqC35SnGagDOtGGwmnPTQAIg4TjI1pul3o+i
         AZWUAIKqzIt1IwFVuM0J4nZwT+RrMbDW+qnxiMmPOwpIRx1WmNaORuJpHwAA7Bc0rwii
         phAfGnYW84r43aQ5B5pQjpNH0bLCiZmusoPJqlbW1WJVsHYAWf7fviyhsSiVpQg4oUCl
         9TesrniMxzbwEdd5bllmtUxuc76T3n8iS8uByb7SDAMCiT+/p6k4N4NBjt6Z3vs0+C0d
         HVlTV93XTe6Qzkb6eRsS+uYwT6JLYFjXTMhCbxd40/6BA7QdxHMdFSoyzTvl4wTQSG1h
         iaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wb8rDdeinMSHdr3hHoFmcwnvVW9lrA9qVVpN4tanSq4=;
        b=EXdjnIiTWRecPm/RJNllZWVbAqpAGVKaL5PVtzINh5Ohh3pK8LiWxokxutAZtAt68Y
         n4DkQ2YhjTsUwyAO4UPRNN75BladRTqtjGnwgSfBeBuVy4IOBk5DlglQSp+MKxYR+hXr
         A6Gvm4FBBiGaFnnD3lFdJ/BdbexTq5gFox4Mou1lWlGxBGJc0xkCV2gLP9eBwbSDgnWa
         y0b3er1P0Mh9ovdsjAE1MKysfTsVEQIwjofYxpIxhhULRpKLTVClzODHtMNSFloQJezN
         GS3D6bneMzdYWDXhoekSfVWac1xlzj1DLMPww+B30BDB/4OHBFgimESITNkjoZ27IOjD
         xagA==
X-Gm-Message-State: AOAM530IPtYT/SHw9ojPnyrEu2Sl3XCW+BvnxBwfuhpkTi5hhOjtcFC+
        Fn4WLjarr0MGTbuvAS0gJ+M=
X-Google-Smtp-Source: ABdhPJwRhuTouWh14XUBCvS/NrnHYp12LE8jy60tHZjwwkwpoUazf4fk5mXJUT01m7DzX9pwm2C5cg==
X-Received: by 2002:a05:6402:50ce:: with SMTP id h14mr13955950edb.283.1612729243934;
        Sun, 07 Feb 2021 12:20:43 -0800 (PST)
Received: from szeder.dev (62-165-236-114.pool.digikabel.hu. [62.165.236.114])
        by smtp.gmail.com with ESMTPSA id 94sm6293285edq.91.2021.02.07.12.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 12:20:43 -0800 (PST)
Date:   Sun, 7 Feb 2021 21:20:42 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 12/17] chunk-format: create read chunk API
Message-ID: <20210207202042.GC1015009@szeder.dev>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
 <366eb2afee839feccdfd2244b231d2ad718c76d4.1612535453.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <366eb2afee839feccdfd2244b231d2ad718c76d4.1612535453.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 05, 2021 at 02:30:47PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Add the capability to read the table of contents, then pair the chunks
> with necessary logic using read_chunk_fn pointers. Callers will be added
> in future changes, but the typical outline will be:
> 
>  1. initialize a 'struct chunkfile' with init_chunkfile(NULL).
>  2. call read_table_of_contents().

A reader should call read_table_of_contents(), noted.

>  3. for each chunk to parse,
>     a. call pair_chunk() to assign a pointer with the chunk position, or
>     b. call read_chunk() to run a callback on the chunk start and size.
>  4. call free_chunkfile() to clear the 'struct chunkfile' data.

How could a user of this API learn about all chunks present in the
chunkfile, including unrecognized chunks?

> We are re-using the anonymous 'struct chunkfile' data, as it is internal
> to the chunk-format API. This gives it essentially two modes: write and
> read. If the same struct instance was used for both reads and writes,
> then there would be failures.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

> diff --git a/chunk-format.h b/chunk-format.h
> index 9a1d770accec..0edcc57db4e7 100644
> --- a/chunk-format.h
> +++ b/chunk-format.h
> @@ -6,6 +6,19 @@
>  struct hashfile;
>  struct chunkfile;
>  
> +/*
> + * Initialize a 'struct chunkfile' for writing _or_ reading a file
> + * with the chunk format.
> + *
> + * If writing a file, supply a non-NULL 'struct hashfile *' that will
> + * be used to write.
> + *
> + * If reading a file, then supply the memory-mapped data to the
> + * pair_chunk() or read_chunk() methods, as appropriate.

And call read_table_of_contents() in between.

> + *
> + * DO NOT MIX THESE MODES. Use different 'struct chunkfile' instances
> + * for reading and writing.
> + */
>  struct chunkfile *init_chunkfile(struct hashfile *f);
>  void free_chunkfile(struct chunkfile *cf);
>  int get_num_chunks(struct chunkfile *cf);
> @@ -16,4 +29,37 @@ void add_chunk(struct chunkfile *cf,
>  	       chunk_write_fn fn);
>  int write_chunkfile(struct chunkfile *cf, void *data);
>  
> +int read_table_of_contents(struct chunkfile *cf,
> +			   const unsigned char *mfile,
> +			   size_t mfile_size,
> +			   uint64_t toc_offset,
> +			   int toc_length);
> +
> +#define CHUNK_NOT_FOUND (-2)
> +
> +/*
> + * Find 'chunk_id' in the given chunkfile and assign the
> + * given pointer to the position in the mmap'd file where
> + * that chunk begins.
> + *
> + * Returns CHUNK_NOT_FOUND if the chunk does not exist.
> + */
> +int pair_chunk(struct chunkfile *cf,
> +	       uint32_t chunk_id,
> +	       const unsigned char **p);
> +
> +typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
> +			     size_t chunk_size, void *data);
> +/*
> + * Find 'chunk_id' in the given chunkfile and call the
> + * given chunk_read_fn method with the information for
> + * that chunk.
> + *
> + * Returns CHUNK_NOT_FOUND if the chunk does not exist.
> + */
> +int read_chunk(struct chunkfile *cf,
> +	       uint32_t chunk_id,
> +	       chunk_read_fn fn,
> +	       void *data);
> +
>  #endif
> -- 
> gitgitgadget
> 
