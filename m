Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642882DCBE6
	for <git@vger.kernel.org>; Fri, 23 May 2025 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747966104; cv=none; b=lEzkul6sPV4iX13MclaVipYX8nF0HX4qFGmEqGJjBcQUZRGxTlkTm+WxONfbjmuKdrd4darYBJlnullK456B36VNpAGqng6ECr7kUcHu5T9mhZlKvsGk2VfnKdKVbyUrW9F7yHu9hnyiNV2X9Bk0lFCg3ORioEluvXiLQiNWTi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747966104; c=relaxed/simple;
	bh=zYyKfxMMaaRuQSY9GwdzMzGcz3JbrbyfXERT+V/XxyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQeohRLDiGNsfX1W7lRJ9M7QD2fFh52QEn730dobNvwa4PxdlWDrM6D840Wi79kSGNHI4G6jlFvmezwyaR+ixTdnsaxA+DrIAisQrnmtkindjid3QOJy9oT1dpfJsvKSO20F+2SN60a7ZIP4twQueLYbxTp60qeMF+HO6jpnjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U4udxaVn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U4udxaVn"
Received: (qmail 2594 invoked by uid 109); 23 May 2025 02:08:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zYyKfxMMaaRuQSY9GwdzMzGcz3JbrbyfXERT+V/XxyA=; b=U4udxaVnEydk1a3GS6czuYemRxAKOwqtTkGoeM2cEkA3bmvX8r9IGBkMJCEES0sg3Y5W//1UFLSlF/fft62IsU0itQLMC3+PtdefxowYkfcg3z0IyJu4a8BwuDU7ZEOxeJQMYTY7Q/CSxLIYR9GUjywOOWVNWTotWVKbwJ+WEKwelPNC7BzNrLsEmYk4UiQ2lJ9adtLBPorIYzrLy1439Iu+JiQ2mv2+MWjuMr6yZLMy8UeDFvjuGZzXt8YCtHpHBm17Xcolh89qzeVg/XrPLVWtKzU3vhYCOR6zztIO/GfJgdowbMYhlEFK+RvmuTR12NtqQC1eOavEjP+jJ8Hp3w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 May 2025 02:08:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28040 invoked by uid 111); 23 May 2025 02:08:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 22:08:24 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 22:08:20 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] midx: stop repeatedly looking up nonexistent
 packfiles
Message-ID: <20250523020820.GB559000@coredump.intra.peff.net>
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
 <20250520-pks-pack-avoid-stats-on-missing-v2-2-333c5217fb05@pks.im>
 <20250522053235.GB1134267@coredump.intra.peff.net>
 <xmqqbjrk7ikx.fsf@gitster.g>
 <20250522165924.GA1613@coredump.intra.peff.net>
 <aC/Nz2wQgncXzFvs@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aC/Nz2wQgncXzFvs@nand.local>

On Thu, May 22, 2025 at 09:22:23PM -0400, Taylor Blau wrote:

> > I think there's a subtlety here with incremental midx's, in that a pack
> > id can be "global" within the whole midx chain, or a local index into a
> > specific chain element's list of packs.
> 
> If you'll indulge me in a bit of pedantry for a moment, I would add that
> the pack_int_id is *always* global within the whole MIDX chain. It only
> happens to additionally be the correct local index when
> m->num_packs_in_base is zero.

Yeah, I agree with that...

> The thing here:
> 
>     m->packs[pack_int_id - m->num_packs_in_base];
>              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> is indexing into the current layer's pack array, which only contains the
> packs at that layer, so the index there is no longer really a
> pack_int_id at all.

...and this...

> > In fill_midx_entry(), I think we get such a global id back from
> > nth_midxed_pack_int_id(). And then when we hand that to
> > prepare_midx_pack(), it is converted into a local midx/id pair with:
> >
> >   pack_int_id = midx_for_pack(&m, pack_int_id);
> 
> ...this confusion is really my fault, since the thing midx_for_pack() is
> returning isn't really a pack_int_id in the classic sense at all. I
> think I chose this name to avoid making the patch noisy, and to avoid
> the possibility of accidentally using the global identifier when you
> meant to use the local index.

...but yeah, this is the part that got me. ;) I think elsewhere you
called it local_pack_int_id, in nth_midxed_pack(). Which made things
more clear (though still calls it a pack_int_id ;) ).

> (As an aside, I think I recall you suggesting a while ago that it might
> be interesting to define "global" things with a different type than
> "local" ones to prevent this sort of confusion. That would allow us to
> keep both "pack_int_id" and the return value of "midx_for_pack()" in
> scope at the same time, without the possibility of using one when you
> meant to use the other.)

Yeah. The trouble is that it becomes awkward in C, since the language
will happily intermix two integer typedefs. So you have to wrap them in
a struct and access the struct fields everywhere.

> >   - There's a similar case in midx-write.c:want_included_pack(). That
> >     one seems to have the same local/global confusion, but I do not
> >     obviously see anything preventing it from being fed a non-base midx.
> >     So it might possibly be buggy?
> 
> Yeah, this spot is definitely broken. At minimum it would need something
> like:
> 
> --- 8< ---
> diff --git a/midx-write.c b/midx-write.c
> index 0897cbd829..54a04f7b75 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1634,9 +1634,10 @@ static int want_included_pack(struct repository *r,
>  			      uint32_t pack_int_id)
>  {
>  	struct packed_git *p;
> +	midx_for_pack(&m, pack_int_id);
>  	if (prepare_midx_pack(r, m, pack_int_id))
>  		return 0;
> -	p = m->packs[pack_int_id];
> +	p = m->packs[pack_int_id - m->num_packs_in_base];
>  	if (!pack_kept_objects && p->pack_keep)
>  		return 0;
>  	if (p->is_cruft)
> --- >8 ---

Yep, that's exactly what I was envisioning. I guess it's probably
possible to trigger in practice by writing a new midx based on an
existing incremental state. I'll let you figure that part out. :)

> >     Likewise fill_included_packs_batch() in the same file.
> 
> I think this one is actually OK for the same reason as the
> expire_midx_packs() case. Its sole caller in midx_repack() has:
> 
>     if (m->base_midx)
>         die(_("cannot repack an incremental multi-pack-index"));
> 
> , so we are OK there. We might want to add an ASSERT() in
> fill_included_packs_batch() to make it clearer, though.

Ah, good. Yes, I agree that an assertion would be a nice bit of
documentation/safety. Though for these cases I think they only care
about the pack (not the containing midx), so changing the return type of
prepare_midx_pack() might be an even easier way to get that safety.

-Peff
