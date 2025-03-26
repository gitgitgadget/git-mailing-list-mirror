Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463124EF7C
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012601; cv=none; b=s6esRrhSzueNuO+tc8bxFSTPH9EKM7c2gxj6pyNheHvlBcahnhSFHJ9DrwnIjx5o20CMdbi+aMLaK8iGlpofgO8apedWz2oi3jZlaaT6hd7QPCCcgJxkia2prxy4byX8MxG64RYOkdzmzFrUMZh97ZLKMtWynhHfmMFemt6Ep9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012601; c=relaxed/simple;
	bh=WCtoupb89WayalVnxBXZLNyVZ+Obk9ng1kHz9tqkmBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umJoH02t3pjHB975/7xL+MEh4uUCrVClLQPLpe+4dQq0xfcmXzcY5ZJ+99WmzWCVuPhe81kWaIzGwAA0qCmfwdbddKo1bvlSTuToychYflW49kVtf65SlWJIJuUUaAY1+MYwBapyihzWAi09Uic87P4U5NRZ1JQcZKZA3F6ax1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LoylBPFx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LoylBPFx"
Received: (qmail 13919 invoked by uid 109); 26 Mar 2025 18:09:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WCtoupb89WayalVnxBXZLNyVZ+Obk9ng1kHz9tqkmBE=; b=LoylBPFxmg81zvccreNhXEOJIqlAnP1dm+Lhi8rLr2wWloI1xb9XsGR47Sw0qa+lF4rRsZhuPRuBPCzE+6M0E6LB7oyd5GfMi/g5DK56OG9/R7WyOtma2LyYLtZ1ugZabu9DhrG5QlOIoFHmu4JzDTUewKvsWCISXkKacycPiw2ucVZLvI9q+Z4mqZI+G72C4AY66BAG5JFeRpYhG/hnAEwMo8Rq3/Hm4AZHNULxJjLhH6HJY0PjnnYctrhQtO5+2oemHouAvA+8QB9zdtPVxLL77CG7ImFRDe8oFXgtMQQj+ZhPSGoekUK4j4icUJ+bf4CjlQcmCthYEgwsn6ngtQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Mar 2025 18:09:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18215 invoked by uid 111); 26 Mar 2025 18:09:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Mar 2025 14:09:58 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Mar 2025 14:09:58 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2025, #07; Wed, 26)
Message-ID: <20250326180958.GE2508080@coredump.intra.peff.net>
References: <xmqqiknwhsdz.fsf@gitster.g>
 <Z+Q3FUCcsPETzVBs@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z+Q3FUCcsPETzVBs@nand.local>

On Wed, Mar 26, 2025 at 01:19:17PM -0400, Taylor Blau wrote:

> On Wed, Mar 26, 2025 at 05:46:00AM -0700, Junio C Hamano wrote:
> > * tb/incremental-midx-part-2 (2025-03-21) 14 commits
> >  - midx: implement writing incremental MIDX bitmaps
> >  - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
> >  - pack-bitmap.c: keep track of each layer's type bitmaps
> >  - ewah: implement `struct ewah_or_iterator`
> >  - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
> >  - pack-bitmap.c: compute disk-usage with incremental MIDXs
> >  - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
> >  - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
> >  - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
> >  - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
> >  - pack-bitmap.c: open and store incremental bitmap layers
> >  - pack-revindex: prepare for incremental MIDX bitmaps
> >  - Documentation: describe incremental MIDX bitmaps
> >  - Documentation: remove a "future work" item from the MIDX docs
> >
> >  Incrementally updating multi-pack index files.
> >
> >  Comments?
> >  source: <cover.1742493373.git.me@ttaylorr.com>
> 
> I think that this one is ready to go. Elijah was satisfied[1] with the
> changes between v4->v5. Peff looked at v4 and seemed generally
> satisfied[2], and I think the changes he suggested were faithfully
> implemented in v5.

Yep, sorry for the slow response; I was offline most of last week. All
of my questions were addressed in v5.

-Peff
