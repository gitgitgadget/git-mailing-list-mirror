Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84807CD98E0
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 00:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjJKAIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 20:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJKAIK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 20:08:10 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC6C8F
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 17:08:08 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-45269fe9d6bso2708306137.2
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 17:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696982887; x=1697587687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LSNA25rws6yHzwso7nu3gOkXpfj/ONEPXTqq1HcYQc=;
        b=LtCgKX2CGjkTMalMFQCaOLve5sLTzGztYIXVi1Z0Qh/vHC68Mpq31cv/DAcKD+RKhn
         HxQXjyik/fFdRtUbu7vLtmvqBs7FgfKOJBSniBhvtdZfpag28Dz4VLQsZK/mqzQYKpaN
         AxKNXEFjb+zc0Z/J0u3CIn+NfWGIJItgC8DEgRfLpqqD8s5lHI2AD4ujcxv4df5qOOO4
         NTl8NjoaKEiXKKw3LXQHH3AIg7Uw8MquYH69UTHyx7kr2pyMUxGSkq472qsp5SKUiOQW
         rT1TfGszd4RTxQbeTgpIY0s2dvyWPRoyPrelETsGKK01D4JBFK7t8l83GzdjNBoNtV3B
         7cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982887; x=1697587687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LSNA25rws6yHzwso7nu3gOkXpfj/ONEPXTqq1HcYQc=;
        b=BT/F6eQiS6Ai7FmXXz6Zei2jGdkvoOLzUiF3r59LhDOVj2MNjan1Luskd8lF9mr5+6
         bA3aS6nrNnbjdjo8Zxe8hpXTDAVKT96dKQ/M+OnCZvqfsDOYNY8YoqjT1rJT/riP8g4O
         DuFU4wsT9uKZ+KTeAXBYOcmLFjpmr0Ksk7lXDx48P0xaIM0W64fGgvcho1bqKohzdcGk
         zyl+cHJ4JBQAfS7+vlQJOPuaATIGg4NwaaZMx2ocF4cFttrQmDfGFpMSGhYFAXn7IwR+
         lGKrfIhzVuRSlXvOybN+F1RHiydHKcg6N4zpAT1BSLjpIFXZrKTXbf0iAYysqZ+cdQu4
         zhQA==
X-Gm-Message-State: AOJu0YzoKyBynhxUP0sn7uHkRfW500eqkHZN80+nDh7HhhFGrQqY2ATa
        Iyoq2Th8wI8r6t82jQBCnrQwfDH7ghnl3VjsjTdUeA==
X-Google-Smtp-Source: AGHT+IF5MpLtssMLihYrGXGrMOQrdoKUhxsCNSeezts8w6g6UDAgUhLU4rN3GoTcUONEn9R59cuIkg==
X-Received: by 2002:a05:6102:7a3:b0:452:6178:642c with SMTP id x3-20020a05610207a300b004526178642cmr18901119vsg.1.1696982887392;
        Tue, 10 Oct 2023 17:08:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x12-20020a0cb20c000000b0065b2f4dd300sm5304994qvd.90.2023.10.10.17.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:08:06 -0700 (PDT)
Date:   Tue, 10 Oct 2023 20:08:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/20] commit-graph: check size of oid fanout chunk
Message-ID: <ZSXnZXglgbfK3VYd@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009205951.GD3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205951.GD3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 04:59:51PM -0400, Jeff King wrote:
> We load the oid fanout chunk with pair_chunk(), which means we never see
> the size of the chunk. We just assume the on-disk file uses the
> appropriate size, and if it's too small we'll access random memory.
>
> It's easy to check this up-front; the fanout always consists of 256
> uint32's, since it is a fanout of the first byte of the hash pointing
> into the oid index. These parameters can't be changed without
> introducing a new chunk type.

Cool, this is the first patch that should start reducing our usage of
the new pair_chunk_unsafe() and hardening these reads. Let's take a
look...

> This matches the similar check in the midx OIDF chunk (but note that
> rather than checking for the error immediately, the graph code just
> leaves parts of the struct NULL and checks for required fields later).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  commit-graph.c          | 13 +++++++++++--
>  t/t5318-commit-graph.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index a689a55b79..9b3b01da61 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -305,6 +305,16 @@ static int verify_commit_graph_lite(struct commit_graph *g)
>  	return 0;
>  }
>
> +static int graph_read_oid_fanout(const unsigned char *chunk_start,
> +				 size_t chunk_size, void *data)
> +{
> +	struct commit_graph *g = data;
> +	if (chunk_size != 256 * sizeof(uint32_t))
> +		return error("commit-graph oid fanout chunk is wrong size");

Should we mark this string for translation?

> +	g->chunk_oid_fanout = (const uint32_t *)chunk_start;
> +	return 0;
> +}
> +

Nice. This makes sense and seems like an obvious improvement over the
existing code.

I wonder how common this pattern is. We have read_chunk() which is for
handling more complex scenarios than this. But the safe version of
pair_chunk() really just wants to check that the size of the chunk is as
expected and assign the location in the mmap to some pointer.

Do you think it would be worth changing pair_chunk() to take an expected
size_t and handle this generically? I.e. have a version of
chunk-format::pair_chunk_fn() that looks something like:

    static int pair_chunk_fn(const unsigned char *chunk_start,
                             size_t chunk_size, void *data)
    {
        const unsigned char **p = data;
        if (chunk_size != data->size)
            return -1;
        *p = chunk_start;
        return 0;
    }

and then our call here would be:

  if (pair_chunk(cf, GRAPH_CHUNKID_OIDFANOUT,
                 (const unsigned char **)&graph->chunk_oid_fanout,
                 256 * sizeof(uint32_t)) < 0)
      return error("commit-graph oid fanout chunk is wrong size");

I dunno. It's hard to have a more concrete recomendation without having
read the rest of the series. So it's possible that this is just complete
nonsense ;-). But my hunch is that there are a number of callers that
would benefit from having this built in.

Thanks,
Taylor
