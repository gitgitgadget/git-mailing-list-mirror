Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1189FC433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F7964E26
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhBKCyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhBKCyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 21:54:06 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA30C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:53:26 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id g84so4574518oib.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KYO796AooVFqnbOJqg89wujTj6YdqJ1p/SRDWsE3kCk=;
        b=Uq82J2jD9sjOP+SUWfk8rARqznztT0u8GiLtphYpMmgHLDts+Z0y3gFHnuCQiaFcln
         dD5i6kSEAMCTWyJjj2F1KWDWQjmR0o/Eg+vOxklTNQnpQeN22bKjexjE8L7fDKkdjW/S
         rqEZLyvRGuMldebI1ToojMorNMdG7sMb2+mFa4w+8KOPeCjXD/qkl/MNJ6E+d9Bg54Ql
         CNFQDZV6T0/D4BG6lv61+0yvH7YX5QEiQGj/VINV+frrpUTqUgNygi+WB0qX54dKKPRl
         uPQUPpx18LwCueghJno3k2hLCMaEVFVEh2llNPAGT/IdzUZdJddoCaTgKNWH/jTo5Wnw
         umVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KYO796AooVFqnbOJqg89wujTj6YdqJ1p/SRDWsE3kCk=;
        b=Bf5BK/kl71CDkz2NMux+65qETLi66ku4aswxfQ4XiMnREMmMok/FbPtc3dhmrH7d+m
         wZPwVYog3lOW4PBF+bnhn3dQjtOxIraqC8UiW8ADNy9UGKqdEXYSPM5wRrr0IWHq6Sh8
         Q9TR42CgfA7SJ9FB+il1DXqFNDVS1e48QN+LVPLEqA9iKotE5vXjZ8Hh1Pf+j2f8cbdg
         2avztlueNOsbbrtGwKOV+AvqmBGG08nWBr9GvMVgcYCL67uX0VdZFlP/GLB0O/CmFLfz
         f5UswLNeGcqDV7jp+PLS5UvtyqFJCzMb+KMOF/nooylWb+9MV1HH93AMv/twXSuVJSm8
         mYAA==
X-Gm-Message-State: AOAM531KlFhIyzLF2X3ZY9DcpI4M2+qZ2jAJLT9Fv25oGJu2G1l75YtQ
        O5vtd7FKe1umc1fq6EMblrc=
X-Google-Smtp-Source: ABdhPJxesGs4hHIpT49Aqg1XvTwzXG0MU/gJEg7qBCHaw1ENzGAW7cCzfI5zueT3HuXCQy1FVRAvNQ==
X-Received: by 2002:aca:fc50:: with SMTP id a77mr1503544oii.166.1613012005754;
        Wed, 10 Feb 2021 18:53:25 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:5030:63f6:1d3e:64d9])
        by smtp.gmail.com with ESMTPSA id k4sm818624ots.24.2021.02.10.18.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 18:53:25 -0800 (PST)
Subject: Re: [PATCH 7/9] pack-revindex: read multi-pack reverse indexes
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
References: <cover.1612998106.git.me@ttaylorr.com>
 <4c5e64c5fcb2948a0598d6e0c70097a9561716a9.1612998106.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3680ce51-81ba-d6a3-a0b6-6f3a7cc14503@gmail.com>
Date:   Wed, 10 Feb 2021 21:53:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4c5e64c5fcb2948a0598d6e0c70097a9561716a9.1612998106.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/21 6:03 PM, Taylor Blau wrote:
> Implement reading for multi-pack reverse indexes, as described in the
> previous patch.
> 
> Note that these functions don't yet have any callers, and won't until
> multi-pack reachability bitmaps are introduced in a later patch series.
> In the meantime, this patch implements some of the infrastructure
> necessary to support multi-pack bitmaps.
> 
> There are three new functions exposed by the revindex API:
> 
>   - load_midx_revindex(): loads the reverse index corresponding to the
>     given multi-pack index.
> 
>   - midx_to_pack_pos() and pack_pos_to_midx(): these convert between the
>     multi-pack index and pseudo-pack order.
> 
> load_midx_revindex() and pack_pos_to_midx() are both relatively
> straightforward.
> 
> load_midx_revindex() needs a few functions to be exposed from the midx
> API. One to get the checksum of a midx, and another to get the .rev's
> filename. Similar to recent changes in the packed_git struct, three new
> fields are added to the multi_pack_index struct: one to keep track of
> the size, one to keep track of the mmap'd pointer, and another to point
> past the header and at the reverse index's data.
> 
> pack_pos_to_midx() simply reads the corresponding entry out of the
> table.
> 
> midx_to_pack_pos() is the trickiest, since it needs to find an object's
> position in the psuedo-pack order, but that order can only be recovered
> in the .rev file itself. This mapping can be implemented with a binary
> search, but note that the thing we're binary searching over isn't an
> array, but rather a _permutation_.
> 
> So, when comparing two items, it's helpful to keep in mind the
> difference. Instead of a traditional binary search, where you are
> comparing two things directly, here we're comparing a (pack, offset)
> tuple with an index into the multi-pack index. That index describes
> another (pack, offset) tuple, and it is _those_ two tuples that are
> compared.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx.c          |  11 +++++
>  midx.h          |   6 +++
>  pack-revindex.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
>  pack-revindex.h |  46 ++++++++++++++++++++
>  packfile.c      |   3 ++
>  5 files changed, 178 insertions(+)
> 
> diff --git a/midx.c b/midx.c
> index bf258c4fde..12bfce8bb1 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -48,11 +48,22 @@ static uint8_t oid_version(void)
>  	}
>  }
>  
> +static const unsigned char *get_midx_checksum(struct multi_pack_index *m)
> +{
> +	return m->data + m->data_len - the_hash_algo->rawsz;

'struct multi_pack_index' has a 'hash_len' member that you could
use here. It would allow a different hash length in the stored
file than the one required by the repository. Except...

> +}
> +
>  static char *get_midx_filename(const char *object_dir)
>  {
>  	return xstrfmt("%s/pack/multi-pack-index", object_dir);
>  }
>  
> +char *get_midx_rev_filename(struct multi_pack_index *m)
> +{
> +	return xstrfmt("%s/pack/multi-pack-index-%s.rev",
> +		       m->object_dir, hash_to_hex(get_midx_checksum(m)));

...this assumes the hash is of the same length as the_hash_algo,
so you are doing the right thing. Currently, I think we check
that 'm->hash_len == the_hash_algo->rawsz' on load. We'll need
to check this again later when in the transition phase of the
new hash work.

(No changes are needed to your patch.)

Thanks,
-Stolee
