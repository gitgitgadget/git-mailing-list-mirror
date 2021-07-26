Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529BCC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD3860F6C
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhGZVdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 17:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhGZVdo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 17:33:44 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4834C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 15:14:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a13so13799483iol.5
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 15:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U1ZuO67HqJ/ufix44UUC+tZvi8A9LH2d4LULdKE0e5s=;
        b=n7Ap75gBTd1cfHEMdMkDKN0wPocqWV6CBfiPK2CKrbLrSumDaiH1bFOthLzLX846wm
         /tyke4NEU9m5xthwTsXISEK+F8YS8AxpfE7g9e/tcQl92KdNW1vy62AvecazNjvxBIHL
         gS73J8MtF+9G98FnFDQdW93M8pUtOz1Z+aaIzxmb/nnaACTzJdgW7Pee0e6Td4ZMTOg8
         IkMEdPdrczsy+Q1K56x14mlSQIHlmfyx9oyKdCa/MgstRhhS6BbcQ/VcevXtjTCsJwbp
         5XhMjF6/fSIp2EmqFplW6vHWh6L22rVv93QAH7Sd/H43w5oHAeTj5KjB3WNA+5Opip/0
         QKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U1ZuO67HqJ/ufix44UUC+tZvi8A9LH2d4LULdKE0e5s=;
        b=NqMTqlfLXTbITyQBxYs+3vizv3TtZvrcmLhNi9e7D3207kg7vt41SX38iwMcmtlQTH
         +xoI/v7OlkldQLDHzPjt/URa13PH8/yqtd5zR6tSCAKykL3HA0YtrnE74J6vbgMWoFQb
         X00x/FJFd/KW+NdJZZRT/heBcrPXlE7O2Ql1zSLoElB2RMfma/cbdKXXZsjhQLbHDdh5
         W4ED5HO2PIjIv28AjqaKthXR/o7FJnLIRSHj97dBIgt2kTwwMMrMmzbRTjrN41CNgquX
         FK1udjvpxpIg61/v6//VLAD6QWY8Cq3QCmr61Ic+PrBUbwvlXGJllt1kIyLuG1R6FyT1
         qUgQ==
X-Gm-Message-State: AOAM530+k8ENksBmX+CLPomZpnJMzyLVZJxL9OTXfD3gxfQ7LHXG5i9U
        6Mg8sDQjScMsplWFI2bgzcMEZA==
X-Google-Smtp-Source: ABdhPJy5eneRmW7dy56n2UxGarv4zpZkoVLUdmwpcZrwpevdpCB1y5wqUZsdQiyVxRkd1MLBZTv/jw==
X-Received: by 2002:a6b:fe19:: with SMTP id x25mr16756550ioh.39.1627337651105;
        Mon, 26 Jul 2021 15:14:11 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id x11sm564700ilu.3.2021.07.26.15.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:14:10 -0700 (PDT)
Date:   Mon, 26 Jul 2021 18:14:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <YP8zsR+W8JeCWc1Q@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
 <YPf1m01mcdJ3HNBt@coredump.intra.peff.net>
 <YPhz+iOMu4Q7zjY4@nand.local>
 <YPp98QgXW5PQHzyy@coredump.intra.peff.net>
 <YP8F9ttlMXwNZBam@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YP8F9ttlMXwNZBam@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 02:59:02PM -0400, Taylor Blau wrote:
> On Fri, Jul 23, 2021 at 04:29:37AM -0400, Jeff King wrote:
> > On Wed, Jul 21, 2021 at 03:22:34PM -0400, Taylor Blau wrote:
> >
> > > > > This avoids a problem that would arise in subsequent patches due to the
> > > > > combination of 'git repack' reopening the object store in-process and
> > > > > the multi-pack index code not checking whether a pack already exists in
> > > > > the object store when calling add_pack_to_midx().
> > > > >
> > > > > This would ultimately lead to a cycle being created along the
> > > > > 'packed_git' struct's '->next' pointer. That is obviously bad, but it
> > > > > has hard-to-debug downstream effects like saying a bitmap can't be
> > > > > loaded for a pack because one already exists (for the same pack).
> > > >
> > > > I'm not sure I completely understand the bug that this causes.
> > >
> > > Off-hand, I can't quite remember either. But it is important; I do have
> > > a distinct memory of dropping this patch and then watching a 'git repack
> > > --write-midx' (that option will be introduced in a later series) fail
> > > horribly.
> > >
> > > If I remember correctly, the bug has to do with loading a MIDX twice in
> > > the same process. When we call add_packed_git() from within
> > > prepare_midx_pack(), we load the pack without caring whether or not it's
> > > already loaded. So loading a MIDX twice in the same process will fail.
> > >
> > > So really I think that this is papering over that bug: we're just
> > > removing one of the times that we happened to load a MIDX from during
> > > the writing phase.
> >
> > Hmm, after staring at this for a bit, I've unconfused and re-confused
> > myself several times.
> >
> > Here are some interesting bits:
> >
> >   - calling load_multi_pack_index() directly creates a new midx object.
> >     None of its m->packs[] array will be filled in. Nor is it reachable
> >     as r->objects->multi_pack_index.
> >
> >   - in using that midx, we end up calling prepare_midx_pack() for
> >     various packs, which creates a new packed_git struct and adds it to
> >     r->objects->packed_git (via install_packed_git()).
> >
> > So that's a bit weird already, because we have packed_git structs in
> > r->objects that came from a midx that isn't r->objects->multi_pack_index.
> > And then if we later call prepare_multi_pack_index(), for example as
> > part of a pack reprepare, then we'd end up with duplicates.
>
> Ah, this jogged my memory: this is a relic from when we generated MIDX
> bitmaps in-process with the rest of the `repack` code. And when we did
> that, we did have to call `reprepare_packed_git()` after writing the new
> packs but before moving them into place.

Actually, I take that back. You were right from the start: the way the
code is written we *can* end up calling both:

  - load_multi_pack_index, from write_midx_internal(), which sets up a
    MIDX, but does not update r->objects->multi_pack_index to point at
    it.

  - ...and prepare_multi_pack_index_one (via prepare_bitmap_git ->
    open_bitmap -> open_midx_bitmap -> get_multi_pack_index ->
    prepare_packed_git) which *also* creates a new MIDX, *and*
    updates the_repository->objects->multi_pack_index to point at it.

(The latter codepath is from the check in write_midx_internal() to see
if we already have a MIDX bitmap when the MIDX we are trying to write
already exists on disk.)

So in this scenario, we have two copies of the same MIDX open, and the
repository's single pack is opened in one of the MIDXs, but not both.
One copy of the pack is pointed at via r->objects->packed_git. Then when
we fall back to open_pack_bitmap(), we call get_all_packs(), which calls
prepare_midx_pack(), which installs the second MIDX's copy of the same
pack into the r->objects->packed_git, and we have a cycle.

I think there are a few ways to fix this bug. The most obvious is to
make install_packed_git() check for the existence of the pack in the
hashmap of installed packs before (re-)installing it. But that could be
quadratic if the hashmap has too many collisions (and the lookup tends
towards being linear in the number of keys rather than constant).

But I think that a more straightforward way would be to open the MIDX we
use when generating the MIDX with prepare_multi_pack_index_one() instead
of load_multi_pack_index() so that the resulting MIDX is pointed at by
r->objects->multi_pack_index. That would prevent the latter call from
deep within the callstack of prepare_bitmap_git() from opening another
copy and then (mistakenly) re-installing the same pack twice.

Thoughts?

Thanks,
Taylor
