Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF06CDB480
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbjJKTMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjJKTME (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:12:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85F690
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:12:02 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4181462ebf0so1299021cf.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697051522; x=1697656322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NB3hgDAjR3VPum3NigKeMQ5zVvhlOr4jcCGBYkpsoQo=;
        b=vlkarY4Wbqd65axzv3YNU+Schf9jgnkLVCZH35wQrZlvIDtR83qzmguY1+BMWaRas1
         k3CbSYzrd7uT9ga9z/SPGr/yeX7dfSxUkq1HpaWFzIvYXjNYswJT9oOOle4uBRePsQzJ
         XyPcz2KXZriWFZ/WUwf797NNPG25FFDnCwDK8l64z53KUtjWPopSWuXqCrlUHw7PGZQW
         c5qbJ2G3INYJayzcr3WA7MzFhdVyfUOwS4nVQODKi+WxCgA5nIMCXHCr9TDTcOoImgRS
         rAmN2BWP4xSJ4boSLaG6HMmm62fntB9cRYbF5tu3W/Qe6xy1EJUrbdO9mUUWRa2zzLPN
         zPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697051522; x=1697656322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB3hgDAjR3VPum3NigKeMQ5zVvhlOr4jcCGBYkpsoQo=;
        b=eon5Cj6RR4CLCCXynXPkSuCohrXHV47LNdYFTCWHB8CeCOV5RUr3u4fhkTcxVg0TZ+
         nUcKjQZByHGQbnW17UzSaVKEZsv0GFkxmhDDYf1PN0wdyDdcbUQjxYwdfkSirSsmERjL
         7txsmiNREns2ZNRE3C5fBOpxZqrKZdPnDEWChO8ePMSqg7w93FiLAmriIRjYJkuO1611
         CP7oDXDR3chGkJf+Qp3aWqReGgmTfvYFT2V1n4X3I3ipMnpmGsDudDEpUa3a9MaQpqZk
         xoyaclKgSYlFBHE1/ZxlN0LdFW5t8iwU8sY51PUyhQgC2EwB6kSsZnf02lNp2o4MKxRx
         CQrA==
X-Gm-Message-State: AOJu0Yw6uI9QTu2SVbE2o4dsicMExKUYpVQbknEtkc04ZHgwgUTG9Sk7
        wJZNlMXBexKkSeRm2yNzpRdq4Q==
X-Google-Smtp-Source: AGHT+IH2CdvlQ4fbxFgFhL3cPwbK5beRyYr44DA6m8MGy5lqH8gDeO6FDO1/WRyxuWc8J9nV0pr6hA==
X-Received: by 2002:a05:622a:1749:b0:419:4d8a:336 with SMTP id l9-20020a05622a174900b004194d8a0336mr25973089qtk.60.1697051521748;
        Wed, 11 Oct 2023 12:12:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r1-20020ac85e81000000b00419ab6ffedasm5535511qtx.29.2023.10.11.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 12:12:01 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:11:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 17/20] commit-graph: check bounds when accessing BDAT
 chunk
Message-ID: <ZSbzf0o7r5GWAZFF@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210550.GQ3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210550.GQ3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:50PM -0400, Jeff King wrote:
> ---
>  bloom.c              | 24 ++++++++++++++++++++++++
>  commit-graph.c       | 10 ++++++++++
>  commit-graph.h       |  1 +
>  t/t4216-log-bloom.sh | 28 ++++++++++++++++++++++++++++
>  4 files changed, 63 insertions(+)
>
> diff --git a/bloom.c b/bloom.c
> index aef6b5fea2..61abad7f8c 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -29,6 +29,26 @@ static inline unsigned char get_bitmask(uint32_t pos)
>  	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
>  }
>
> +static int check_bloom_offset(struct commit_graph *g, uint32_t pos,
> +			      uint32_t offset)
> +{
> +	/*
> +	 * Note that we allow offsets equal to the data size, which would set
> +	 * our pointers at one past the end of the chunk memory. This is
> +	 * necessary because the on-disk index points to the end of the
> +	 * entries (so we can compute size by comparing adjacent ones). And
> +	 * naturally the final entry's end is one-past-the-end of the chunk.
> +	 */
> +	if (offset <= g->chunk_bloom_data_size - BLOOMDATA_CHUNK_HEADER_SIZE)
> +		return 0;
> +
> +	warning("ignoring out-of-range offset (%"PRIuMAX") for changed-path"
> +		" filter at pos %"PRIuMAX" of %s (chunk size: %"PRIuMAX")",
> +		(uintmax_t)offset, (uintmax_t)pos,
> +		g->filename, (uintmax_t)g->chunk_bloom_data_size);

Should this be marked for translation?

> +	return -1;
> +}
> +
>  static int load_bloom_filter_from_graph(struct commit_graph *g,
>  					struct bloom_filter *filter,
>  					uint32_t graph_pos)
> @@ -51,6 +71,10 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
>  	else
>  		start_index = 0;
>
> +	if (check_bloom_offset(g, lex_pos, end_index) < 0 ||
> +	    check_bloom_offset(g, lex_pos - 1, start_index) < 0)

Can lex_pos ever be zero? I can't think of any reason that it couldn't,
and indeed the (elided) diff context shows that immediately preceding
this if-statement is another that checks "if (lex_pos > 0)".

So I think we'd want to avoid checking lex_pos - 1 if we know that
lex_pos is zero. Not that any of this really matters, since the only
thing we use the computed value for is showing the graph position in the
warning() message. So seeing a bogus value there isn't the end of the
world.

But avoiding this check when lex_pos == 0 is straightforward, so is
probably worth doing.

(As an aside, we should be able to simplify that if statement to just
"(if lex_pos)", since lex_pos will never be negative).

> +		return 0;
> +
>  	filter->len = end_index - start_index;
>  	filter->data = (unsigned char *)(g->chunk_bloom_data +
>  					sizeof(unsigned char) * start_index +
> diff --git a/commit-graph.c b/commit-graph.c
> index f446e76c28..f7a42be6d0 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -365,7 +365,17 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
>  {
>  	struct commit_graph *g = data;
>  	uint32_t hash_version;
> +
> +	if (chunk_size < BLOOMDATA_CHUNK_HEADER_SIZE) {
> +		warning("ignoring too-small changed-path chunk"
> +			" (%"PRIuMAX" < %"PRIuMAX") in commit-graph file",
> +			(uintmax_t)chunk_size,
> +			(uintmax_t)BLOOMDATA_CHUNK_HEADER_SIZE);

Ditto on the translation suggestion from above.

Thanks,
Taylor
