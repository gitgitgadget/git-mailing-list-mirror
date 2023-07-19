Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FADC0015E
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 18:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGSSYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGSSYr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 14:24:47 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0DB1BF6
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 11:24:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-cc7863e7b82so5137584276.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689791085; x=1692383085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bAXfDjdSrEgcClXlVHg9e4u29LhaezTuXvRGiZ4ZLA=;
        b=mgsa+E88xN5grSR+3ciK05WdKSzmynpuPaGffJSrCQy1FIDE/npSjU4Imis+MP6j71
         HxThJtpTY9gUKhQIWRVwosnpvKDAVE9PB43doq6ZoGSmE8VNKkScVMjjV8wTR4G+wybA
         b6sRxB+N+QinFtOCn6KIVDOnlwcD+c8WRsRXHyCfCr6QrCye9eD8BZI8Qj0D2GFxCGEr
         VJ3wXhoGhtWRvGpGLyCd2TC6LM876f497ECfMhu+0xIxbTEE1Ei+nhpfx68PJ7SvLPwm
         hLVf1hMtu7+7xlcwjwXfGRmT2b4ZwBR/N5e7nBBrEpCnHj2H0jffV4CrVbOn8ipN93Ma
         yWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689791085; x=1692383085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bAXfDjdSrEgcClXlVHg9e4u29LhaezTuXvRGiZ4ZLA=;
        b=VBYqHP82QdbdUIRzvkO31VaLq3DuzhuzhiYMD55PFSuKz4tTUvzDgIyUwnf0UQWcoT
         reioqsG9xQdsWEjOAKxbRFXr6vwtObSOSMAIGbMSAkbVhpfyFFfLaJh0YdKsLJQA4Y9J
         r4NDXdGvkWOM1VH8p2TMCzI/rGaPPLAWm1Cf/JwB0QBMu2gy8r3ajd9HuzDB478sfPZE
         O2B36o1bJBLgUBXsojdVA4IVP4FBLKwaAmvIHzXxuahWVoSOq7xA3fAadM2hG8TSLCVb
         erRGhe/kh7eI7w4D20xBmTKyg8ML5imDJa2cgyNwBoh55nW7bzgm3O+qejJXLZpDeNqe
         oz5Q==
X-Gm-Message-State: ABy/qLYFSiIA/K/GTD/EL2i2Rtg//v7VxX0Gbqf/I5lP1fa+a2CufSki
        ruC35CuFiCBwb7Bp5d9x5Ro6qPONjes8TOdJOnqjVg==
X-Google-Smtp-Source: APBJJlGAabQamWLmjUKYIrbHk4C7C65OAQqk2mm0PcW0+l9t/f+c4qcQ+YYXOU44NdGDREO+HDveCg==
X-Received: by 2002:a81:4755:0:b0:583:3b24:d1c0 with SMTP id u82-20020a814755000000b005833b24d1c0mr3498347ywa.34.1689791085479;
        Wed, 19 Jul 2023 11:24:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r74-20020a0de84d000000b00545a081849esm1153958ywe.46.2023.07.19.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:24:45 -0700 (PDT)
Date:   Wed, 19 Jul 2023 14:24:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] commit-graph: new filter ver. that fixes murmur3
Message-ID: <ZLgqbB2JG8+HPoHN@nand.local>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1689283789.git.jonathantanmy@google.com>
 <47ba89c565d3383a8a14272fe52ac274be82d0be.1689283789.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47ba89c565d3383a8a14272fe52ac274be82d0be.1689283789.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2023 at 02:42:11PM -0700, Jonathan Tan wrote:
> The murmur3 implementation in bloom.c has a bug when converting series
> of 4 bytes into network-order integers when char is signed (which is
> controllable by a compiler option, and the default signedness of char is
> platform-specific). When a string contains characters with the high bit
> set, this bug causes results that, although internally consistent within
> Git, does not accord with other implementations of murmur3 and even with
> Git binaries that were compiled with different signedness of char. This
> bug affects both how Git writes changed path filters to disk and how Git
> interprets changed path filters on disk.

I think that you make a worthwhile point that the existing
implementation is internally consistent, but doesn't actually implement
a conventional murmur3. I wonder if it's worth being explicit where you
mention its internal consistency to say that the existing implementation
would never cause us to produce wrong results, but wouldn't be readable
by other off-the-shelf implementations of murmur3.

(To be clear, I think that you already make this point, I'm just
suggesting that it may be worth spelling it out even more explicitly
than what is written above).

> Therefore, introduce a new version (2) of changed path filters that
> corrects this problem. The existing version (1) is still supported and
> is still the default, but users should migrate away from it as soon
> as possible.

Makes sense.

> Because this bug only manifests with characters that have the high bit
> set, it may be possible that some (or all) commits in a given repo would
> have the same changed path filter both before and after this fix is
> applied. However, in order to determine whether this is the case, the
> changed paths would first have to be computed, at which point it is not
> much more expensive to just compute a new changed path filter.

Hmm. I think in the general case that is true, but I wonder if there's a
shortcut we could take for trees that are known to not have *any*
characters with their high-order bits set. That is, if we scan both of
the first parent's trees and determine that no such paths exist, the
contents of the Bloom filter would be the same in either version, right?

I think that that would be faster than recomputing all filters from
scratch. In either case, we have to load the whole tree. But if we can
quickly scan (and cache our results by setting some bit--indicating the
absence of paths with characters having their highest bit set--on the tree
objects' `flags` field), then we should be able to copy forward the
existing representation of the filter.

I think the early checks would be more expensive, since in the worst
case you have to walk the entire tree, only to realize that you actually
wanted to compute a first-parent tree diff, meaning you have to
essentially repeat the whole walk over again. But for repositories that
have few or no commits whose Bloom filters need computing, I think it
would be significantly faster, since many of the sub-trees wouldn't need
to be visited again.

> There is a change in write_commit_graph(). graph_read_bloom_data()
> makes it possible for chunk_bloom_data to be non-NULL but
> bloom_filter_settings to be NULL, which causes a segfault later on. I
> produced such a segfault while developing this patch, but couldn't find
> a way to reproduce it neither after this complete patch (or before),
> but in any case it seemed like a good thing to include that might help
> future patch authors.

Hmm. Interesting, I'd love to know more about what you were doing that
produced the segfault. I think it would be worth it to prove to
ourselves that this segfault can't occur in the wild. Or if it can, it
would be worth it to understand the bug and prevent it from happening.

> +static uint32_t murmur3_seeded_v1(uint32_t seed, const char *data, size_t len)
>  {
>  	const uint32_t c1 = 0xcc9e2d51;
>  	const uint32_t c2 = 0x1b873593;
> @@ -130,8 +187,10 @@ void fill_bloom_key(const char *data,
>  	int i;
>  	const uint32_t seed0 = 0x293ae76f;
>  	const uint32_t seed1 = 0x7e646e2c;
> -	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
> -	const uint32_t hash1 = murmur3_seeded(seed1, data, len);
> +	const uint32_t hash0 = (settings->hash_version == 2
> +		? murmur3_seeded_v2 : murmur3_seeded_v1)(seed0, data, len);
> +	const uint32_t hash1 = (settings->hash_version == 2
> +		? murmur3_seeded_v2 : murmur3_seeded_v1)(seed1, data, len);

I do admire the ternary operator over the function being called, as I
think that Stolee pointed out earlier in this series. But I worry that
these two checks could fall out of sync with each other, causing us to
pick incosistent values for hash0, and hash1, respectively.

FWIW, I would probably write this as:

    const uint32_t hash0, hash1;
    if (settings->hash_version == 2) {
        hash0 = murmur3_seeded_v2(seed0, data, len);
        hash1 = murmur3_seeded_v2(seed1, data, len);
    } else {
        hash0 = murmur3_seeded_v1(seed0, data, len);
        hash1 = murmur3_seeded_v1(seed1, data, len);
    }

I suppose that there isn't anything keeping the calls within each arm of
the if-statement above in sync with each other (i.e., I could call
murmur3_seeded_v1() immediately before dispatching a call to
murmur3_seeded_v2()). So in that sense I think that this is no more or
less safe than what's already written.

But IMHO I think this one reads more cleanly, so I might prefer it over
what you have in this patch. But I don't feel so strongly about it
either way.

> diff --git a/commit-graph.c b/commit-graph.c
> index 9b72319450..c50107eed5 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -302,16 +302,25 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
>  	return 0;
>  }
>
> +struct graph_read_bloom_data_data {
> +	struct commit_graph *g;
> +	int *commit_graph_changed_paths_version;
> +};
> +

Nit: maybe `graph_read_bloom_data_context`, to avoid repeating "data"? I
don't have strong feelings here, FWIW.

The rest of the implementation and tests look good to me.

Thanks,
Taylor
