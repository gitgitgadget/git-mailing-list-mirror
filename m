Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE2BCDB477
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 18:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjJKSiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjJKSiM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 14:38:12 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3453A93
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:38:10 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ae214a077cso68972b6e.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697049489; x=1697654289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=16Sf3xu1fFqauwqMp67R6zJNAHksbmnEPg0g5Et2GeI=;
        b=Lst/oZPVWvxTD7sMVpZyHs/Va1ogG4i8HmckWZ30t8TFBPb/7vLdGYTG4xy5eNK+5q
         OjO8nGig2/q1DhbmLBsAVViDp9/BAI21IvzKx9Ofd/TujVBc1OTbyVC29HwqBHUbUTS0
         PPp/8TbCKcEN0PndZXYofgI1KV5wUwQWfh2o5jHnEz+aA3y/6okDBdUjvTMwG7VKwghe
         NqU9YgCtFQxPzTKt0LhyuZ8M4nYzxipGQuGv7tyPdIO1MaHKdH/oB0jF17he3ftMrpIM
         GMcaQmZxKaIqbOTsH77FCKXCE5H/YRBsYW0clvA2F0nhthdA50sHXazzX2rfS98RO9Bk
         j/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697049489; x=1697654289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16Sf3xu1fFqauwqMp67R6zJNAHksbmnEPg0g5Et2GeI=;
        b=xJG2OxWg+FMjLgF6h0hNRn3X//kI1qPx3u6VrshXuoJuSqAKadX+/ldbitJm8oEcP7
         1lssN2GR8wUn1w9peXJBgdBROjaVC7O1c3mmocIu35ZPWAkhoESyJaeAMi0/n6DpaUaV
         JItSB4g7eR5uYwZqq4QnDoETw8EeAYnu0p/BoxrwhRSqe3g4tBxv86rrgeiZwijS0us8
         Kl9EIWP5+YvYlTnfNSjHBywLN0wyHl390dgtMGvCG67W2xeOPypF3l/GJiFmEFkiEjA2
         6ub9Ssm3L5qtqEwD67yMtjxEXWXbvQJy+gh29WzPLn27SzOR4vEGVe3A7+BXCZykU3in
         ju2A==
X-Gm-Message-State: AOJu0Yx0MD7exZY5gxVpPCxPILXuloFTgewnkKIA3cgG6ysFCiBVPSpo
        X7F6lXMOjrtKGvSov9fFoOW/0Q==
X-Google-Smtp-Source: AGHT+IFUSAz58Vg4OvONrmjKE3q7Y3eks/AntXz/W9XmM85GLuzGeI601qh0WxFz3Jj6D9pw6xu1BA==
X-Received: by 2002:aca:2808:0:b0:3a8:472b:febf with SMTP id 8-20020aca2808000000b003a8472bfebfmr22150942oix.21.1697049489447;
        Wed, 11 Oct 2023 11:38:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z9-20020ad44149000000b0066cf6f202cdsm1579132qvp.122.2023.10.11.11.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:38:08 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:38:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/20] midx: bounds-check large offset chunk
Message-ID: <ZSbrj3hmm8H7ce2l@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210530.GJ3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210530.GJ3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:30PM -0400, Jeff King wrote:
> When we see a large offset bit in the regular midx offset table, we
> use the entry as an index into a separate large offset table (just like
> a pack idx does). But we don't bounds-check the access to that large
> offset table (nor even record its size when we parse the chunk!).
>
> The equivalent code for a regular pack idx is in check_pack_index_ptr().
> But things are a bit simpler here because of the chunked format: we can
> just check our array index directly.
>
> As a bonus, we can get rid of the st_mult() here. If our array
> bounds-check is successful, then we know that the result will fit in a
> size_t (and the bounds check uses a division to avoid overflow
> entirely).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  midx.c                      |  8 +++++---
>  midx.h                      |  1 +
>  t/t5319-multi-pack-index.sh | 20 ++++++++++++++++++++
>  3 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index 7b1b45f381..3e768d0df0 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -180,7 +180,8 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
>  	if (read_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, midx_read_object_offsets, m))
>  		die(_("multi-pack-index required object offsets chunk missing or corrupted"));
>
> -	pair_chunk_unsafe(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets);
> +	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets,
> +		   &m->chunk_large_offsets_len);
>
>  	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
>  		pair_chunk_unsafe(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex);
> @@ -303,8 +304,9 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
>  			die(_("multi-pack-index stores a 64-bit offset, but off_t is too small"));
>
>  		offset32 ^= MIDX_LARGE_OFFSET_NEEDED;
> -		return get_be64(m->chunk_large_offsets +
> -				st_mult(sizeof(uint64_t), offset32));
> +		if (offset32 >= m->chunk_large_offsets_len / sizeof(uint64_t))
> +			die(_("multi-pack-index large offset out of bounds"));
> +		return get_be64(m->chunk_large_offsets + sizeof(uint64_t) * offset32);

Makes sense, and this seems very reasonable. I had a couple of thoughts
on this hunk, one nitpick, and one non-nitpick ;-).

The nitpick is the easy one, which is that I typically think of scaling
some index to produce an offset into some chunk, instead of dividing and
going the other way.

So I probably would have written something like:

    if (st_mult(offset32, sizeof(uint64_t)) >= m->chunk_large_offsets_len)
        die(_("multi-pack-index large offset out of bounds"));

But that is definitely a subjective/minor point, and I would not at all
be sad if you felt differently about it. That said, I do wish for a
little more information in the die() message, perhaps:

    if (st_mult(offset32, sizeof(uint64_t)) >= m->chunk_large_offsets_len)
        die(_("multi-pack-index large offset for %s out of bounds "
              "(%"PRIuMAX" is beyond %"PRIuMAX")"),
            (uintmax_t)(offset32 * sizeof(uint64_t)), /* checked earlier */
            (uintmax_t)m->chunk_large_offsets_len);

I can imagine that for debugging corrupt MIDXs in the future, having
some extra information like the above would give us a better starting
point than popping into a debugger to get the same information.

Thanks,
Taylor
