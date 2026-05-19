Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569012253EE
	for <git@vger.kernel.org>; Tue, 19 May 2026 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152072; cv=none; b=cQFle4musLLleuWDdBv5KOGqVUm30rBg7ZaDSoUG2lkeFnmrCvBD6fPf9/u1VDvFRljel/HaXWrMGrPo4tU0pgCnPEG7GAGsBB03vExboMlYT2VPM9+JgkU1eKwKhVaZQng2XJsc9D8jW/WTF3lJyUXvLPLWeN6yROMWMlREzFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152072; c=relaxed/simple;
	bh=OF1kPRWhI22kpp/aCtW51dHhrAL41fpKKdjh95GTlAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS3csPiR69N80ODWeyCq8yFlBADTtjQsRocLvospnV3t11j+0ku7Wbd7vB3SG1bm9pWq74/Kj2w2W3naCN/dmc7QGfvAlaxdiiNEPc3uFj8qwW6LGcWcCd/qTymytXA1ec7aOZ2DH914dSfuu0iZZDx67SC2s7dzoMtarE1XROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dKcBoi/6; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dKcBoi/6"
Received: (qmail 15697 invoked by uid 106); 19 May 2026 00:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OF1kPRWhI22kpp/aCtW51dHhrAL41fpKKdjh95GTlAg=; b=dKcBoi/6SJaa3sHt5iFCBnbFvExk9vR0Gu3Q+JrAESOpA5+M9x2yWVSKZB0FC/8j6QMIyVFlGrw8V8fkjm3E5mjLge1VrE524l0kFZoFkUIeCxVBNkDDSihPhbFaGgOae+qYqcBgkhiLpYwLRK/tVqJFQTIeVZXFI24FZhgRJRTPIm7GD0QRXuVxXgSBCn58jrlVtkvpfKhDHm5f+LbXC1VvO+Q9w5voPjcgR32oF6wgIeX1REYmDswkxds6kXEHs53b18w9JNiBhpuqBFn6HnR5TiKngxJFQY+UR5ENVZNwAf5vyVzRlJ2r6nfv9xyeFJkAVTdp3wVRxChheAolIg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 00:54:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38375 invoked by uid 111); 19 May 2026 00:54:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2026 20:54:32 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 May 2026 20:54:29 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] revision: use priority queue in limit_list()
Message-ID: <20260519005429.GD1612961@coredump.intra.peff.net>
References: <pull.2114.git.1778777491939.gitgitgadget@gmail.com>
 <20260515041641.GA81292@coredump.intra.peff.net>
 <CAL71e4Mfq3SCO7vnTbFCxpzH9txWPTencV-vq-aQ=wJ7dPMV2g@mail.gmail.com>
 <aad34ac2-4cd5-4c85-b8ff-14c0caaa1c7b@gmail.com>
 <CAL71e4MxhcZqxPVEe38Shuqt7h5dxLDGi66hN2cFXnmg-POKWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL71e4MxhcZqxPVEe38Shuqt7h5dxLDGi66hN2cFXnmg-POKWA@mail.gmail.com>

On Sun, May 17, 2026 at 05:26:06PM +0200, Kristofer Karlsson wrote:

> Another note - I think I managed to apply the same change to
> get_revision_1 too - speeding up a monorepo "git rev-list HEAD" by
> 3.3x so it seems like a reasonable thing to do.
> This simplifies process_parents and also makes
> commit_list_insert_by_date dead code.
> 
> The only caveat is that get_revision_1 starts to get messier and the
> rev_info struct needs both a prio_queue and a linked list of commits -
> and then flushing everything
> from the list into the prio_queue when executing get_revision_1.

IMHO it is worth replacing rev_info's list with a prio_queue and letting
that be the source of authority. You do have to be careful to cover
cases where the list _isn't_ date-sorted, but prio_queue supports that
with a NULL comparator.

You do still have to convert between list and queue at a few spots, but
I think in the long run many of those could be converted to use a queue.

You can see my patches to do so at:

  https://github.com/peff/git jk/revs-commits-prio-queue

I've been running with them locally for a few years. Mostly I hadn't
gotten around to polishing them, and I think I had wanted to do some
more perf testing. It sounds like you have a good candidate repo for
showing off the improvement. ;)

If you'd like to go in that direction, please feel free to pick out
whatever is useful from what you find on that branch.

> I don't want to pollute this patch with that change - should I start a
> separate thread for it or just revisit this later?
> (Perhaps I have too many optimization patches in flux already)

Yes, it definitely makes sense to do that as a separate change. If you
look at the patches I linked above, note that they'll get a bit simpler
by rebasing on top of your limit_list() changes, since it does some of
the same things.

-Peff
