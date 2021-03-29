Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F9C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18986198F
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhC2V17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhC2V16 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:27:58 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EF0C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:27:58 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z3so14256182ioc.8
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1+9aAs+Wgk2a74Bo5ytUo8RexFpmk562gjUEZbNffRA=;
        b=uWQV//1biML+agIydEGWq0KBTNjIkjd6g5gAZX41Ry8ExL64CauYmnfwx//gXiFEN/
         XpvxV7FHUELMH/JUmCqgVQW7UiIo/V8VTsnCjfQjWlvw372QYbsNB7bB3n58HTYjx6CY
         BuPq22B7q1/PdU3JqcZcsM+WKdf4qe0u/LCQk2vgXBneVrif8vM90hlHzp3tVZcChWuN
         9k8ULfM2+XK3dcwML3cn7BPHnu9pqWrRhyI4DDWC5zO5r1t9wo2cc259rW+1IFPYMZCd
         nlLRYdMt+zmbKkZHUItE0nU2QaUiQluig2lVXOKpkBER5ORROuKhooORjKlkrTSjhT/8
         tzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1+9aAs+Wgk2a74Bo5ytUo8RexFpmk562gjUEZbNffRA=;
        b=i0aaLcJcKpRB89P+OB5QJWK00rr3iLpBP8u6K6vI0gaAInVnXtpVMn8DSe4lOmBYmY
         P4lWNWHNiZE7+blEj52HmEuE2cGNmZEmkAoSats+EE0shOZRW0yQxtzyVxF1YbSPsZhd
         qkguLRsWg8uNN5ZMHf933ouiWaxZXgu3nRSzmhPSJ6L3JCKTAHz9jw/jORfVVhVNmLFa
         vv2QbwQNSTHiIHm4rd+d7LtWGRHkw16CctiN7Sk2ZFeengoxrv18+yBoYYPdPU8MqqJA
         UQ0GCXffAn735etcpSyVLgmkU6OmCk7GOsjVTMu9g7VJuiKNvj/RgRqUuV1aFUZR+stS
         7dxg==
X-Gm-Message-State: AOAM5307xIKfXjWRI4uv00CCGEWWt+QSc2eFphQSWYvxsDzUdnUJKb4h
        z9aoU6KocIoKFHIpCfBYcl0jpQ==
X-Google-Smtp-Source: ABdhPJwsVWbkxiTloshBIDRbNSQSE0aEAneh5lbPTbfErhAqB9jQwuhzoWaZKWKdAfrKidfzSpG6PA==
X-Received: by 2002:a6b:5905:: with SMTP id n5mr21722371iob.90.1617053278244;
        Mon, 29 Mar 2021 14:27:58 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id y13sm10066536ioc.36.2021.03.29.14.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 14:27:57 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:27:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 13/16] pack-revindex: read multi-pack reverse indexes
Message-ID: <YGJGXJ7Md0tWtnME@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <a6ebd4be91e0ff0b31d1629c2e3a75c016d56397.1615482270.git.me@ttaylorr.com>
 <YGHLe0nmh7R8hsVo@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGHLe0nmh7R8hsVo@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 08:43:39AM -0400, Jeff King wrote:
> On Thu, Mar 11, 2021 at 12:05:29PM -0500, Taylor Blau wrote:
>
> > Implement reading for multi-pack reverse indexes, as described in the
> > previous patch.
>
> Looks good overall. I found a few tiny nits below.
>
> > +int load_midx_revindex(struct multi_pack_index *m)
> > +{
> > +	char *revindex_name;
> > +	int ret;
> > +	if (m->revindex_data)
> > +		return 0;
> > +
> > +	revindex_name = get_midx_rev_filename(m);
> > +
> > +	ret = load_revindex_from_disk(revindex_name,
> > +				      m->num_objects,
> > +				      &m->revindex_map,
> > +				      &m->revindex_len);
> > +	if (ret)
> > +		goto cleanup;
>
> On error, I wondered if m->revindex_map, etc, would be modified. But it
> looks like no, load_revindex_from_disk() is careful not to touch them
> unless it sees a valid revindex. Good.

Yep, that was intentional. Thanks.

> > +int close_midx_revindex(struct multi_pack_index *m)
> > +{
> > +	if (!m)
> > +		return 0;
> > +
> > +	if (munmap((void*)m->revindex_map, m->revindex_len))
> > +		return -1;
> > +
> > +	m->revindex_map = NULL;
> > +	m->revindex_data = NULL;
> > +	m->revindex_len = 0;
> > +
> > +	return 0;
> > +}
>
> It's hard to imagine why munmap() would fail. But if it does, we should
> probably clear the struct fields anyway. I note that the matching code
> for a "struct packed_git" does not bother even checking the return value
> of munmap. Perhaps we should just do the same here.

I tend to agree that we should match the behavior of
"packfile.c:close_pack_revindex()" and just not check the return value
of munmap. Either the call to munmap() worked, and we shouldn't be
reading revindex_map anymore, or it didn't, and something else is
probably wrong enough with the original mmap call that we probably also
shouldn't be reading it.

> The packed_git version also returned early if revindex_map is NULL. Here
> the burden is placed on the caller (it's hard to tell if that matters
> since there aren't any callers yet, but it probably makes sense to push
> the check down into this function).

Yeah, I think that that function actually is doing the worst of both
worlds (which is to check p->revindex_map, but not p itself).

I modified the MIDX version to check both m and m->revindex_map (but I
agree it's hard to tell with the caller coming in a later series).

>
> > +uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos)
> > +{
> > +	if (!m->revindex_data)
> > +		BUG("pack_pos_to_midx: reverse index not yet loaded");
> > +	if (m->num_objects <= pos)
> > +		BUG("pack_pos_to_midx: out-of-bounds object at %"PRIu32, pos);
> > +	return get_be32((const char *)m->revindex_data + (pos * sizeof(uint32_t)));
> > +}
>
> OK, this one is just a direct read of the .rev data, like
> pack_pos_to_index() is. I think the final line can be simplified to:
>
>   return get_be32(m->revindex_data + pos);
>
> just like pack_pos_to_index(). (I suspect this is a leftover from the
> earlier version of your .rev series where the pointer was still a "void
> *").

Yes, definitely.

> Probably sizeof(*m->revindex_data) would be slightly nicer in the
> bsearch call (again, I suspect a holdover from when that was a void
> pointer).

Yes, exactly.

Thanks,
Taylor
