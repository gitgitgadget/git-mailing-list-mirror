Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6113E49F5
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 06:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787554543; cv=none; b=DN/t813jVvBp9mqf+glqWNpZXXns7U93i9tNDe/X6Mlb/WVgMdMtwTj7AbBDzKyxLmGYax114vbuUEqjFA/VAZTYfoAK3Nz64hwqnkilueJJTXVYm7dc7xA/e4Y4g+xRCyt/cTJbrkgM8D9tn+Lxt90JAOjqcXiVq1zWZSyHO9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787554543; c=relaxed/simple;
	bh=tBiW6jo0zmoPUmMvjn4H1pGDAP85vgeCQqZkkblGzCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukDsEm2QpL3VFPjPeQ0bhqlUwRf5DcR09yTyjPXaRv8MdwB4SGq259pNU6wo3IZUSY0LBKZdXbICdCnHxDIprVnM5orZyR8Tx8oF0fYS4MDLbdhaVJ2UavVBhY3h/VbMzmX6CI8Xgtoec4PxE+vRvCs0z7k8yb3k+DRPtMoPOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NQoic6QA; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NQoic6QA"
Received: (qmail 105770 invoked by uid 106); 24 Aug 2026 06:55:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tBiW6jo0zmoPUmMvjn4H1pGDAP85vgeCQqZkkblGzCs=; b=NQoic6QA/9sRn9Po5SMawQuRNaOVmiK57aKUQA7MF3+oU0WN2inoF+foHkRdpF2OUtRQmbQRodsKu3IA5ZfxcVPpAYGGLyCXV3klHDqFC1s5XPxwa5Uegp+51S73wxS0wMsERathakGg2PWA5sf9kfG62yf3Fx9NN8r0PsLo28/KGzQq5U2ssitaqEQ+FRdhS7zKVeW3ZexLHvRg4DTo20UAschG4QDzMu5tEAJUMFfeAtM4tCbJI0oUzyUTpRreRaIQZm13vMb+wFXiDohEx6jQx/3/HFObZ7WACAvkY9R5y5OWFFPxQrXZ06NltE7E9/gZyhDAj7w0r0tDFsYSsQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2026 06:55:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 129892 invoked by uid 111); 24 Aug 2026 06:55:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2026 02:55:44 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Aug 2026 02:55:39 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren <newren@gmail.com>,
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
Message-ID: <20260824065539.GA149254@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
 <aoayppoxHAkcFTBN@pks.im>
 <CABPp-BEBbdmE9q+98gWq-wLzDdhJOyazcHF=pP95o5AcmgCv1Q@mail.gmail.com>
 <20260824044822.GA142844@coredump.intra.peff.net>
 <aovTA4F04aX8SPTU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aovTA4F04aX8SPTU@pks.im>

On Mon, Aug 24, 2026 at 07:13:39AM +0200, Patrick Steinhardt wrote:

> On Mon, Aug 24, 2026 at 12:48:22AM -0400, Jeff King wrote:
> > So between the two cases, it sounds like things (or at least the
> > low-level lookups) are working as designed, and there is no bug. Or am I
> > misunderstanding something?
> 
> I agree that QUICK is working as designed, and that callers that pass it
> without being able to accommodate for false negatives are buggy. But the
> patch sent by Elijah still fixes an actual bug where we may not find an
> object that is contained in two MIDXd packs where the preferred pack for
> a respective object vanishes concurrently. Filling the packfile entry
> via the MIDX will fail because the pack vanished, and the lookup via the
> non-preferred pack will fail, too, because we skip over any packs that
> are covered by the MIDX when doing the non-MIDX lookup. Consequently, we
> won't find the object at all.

Ah, OK. I get it now. Thanks for explaining.

It feels like the midx is foiling the usual reprepare strategy
(well, SECOND_READ these days) because we don't actually flush it for
the second read. Assuming the writing side always generates a new midx
(that no longer references the to-be-deleted pack) before deleting the
pack itself, then we'd be able to find the object by refreshing the
midx. Just like we find new objects by refreshing the pack list and
finding the new .idx files.

And I guess that's what the original commit message was saying here:

  This recovers the object without touching the multi-pack-index itself.
  Reloading the stale index would be a more complete fix but would be much
  more involved: other code (pack bitmaps, object name disambiguation)
  borrows and caches the "struct multi_pack_index *" across object reads,
  so freeing it underneath them would be a use-after-free.  Refreshing the
  index with proper invalidation of those borrowers is left for future
  work.

That's not a problem for packs because we _don't_ free the packfile
structs. We keep them around forever. So presumably we'd have to do the
same for stale midxs. But I agree that it might end up more complicated
than we'd like (especially because there's so much "there is only one
midx" assumption baked into various parts of the code). So working
around it in a more immediate way makes some sense.

> That case is broken no matter whether we pass QUICK or not.

Right. It would be OK to skip Elijah's fallback workaround when
SECOND_READ is not set; the QUICK callers are prepared to accept the
false negative. But since it is cheap-ish to do the fallback check, it
is perhaps OK to just do it on the first pass?

I wonder how true that is. Imagine you had a midx covering a million
packs, and you notice an object is missing, but you're in QUICK mode. Do
you really want to individually check each of those million pack idx
files (that were otherwise not even opened or mmap'd because they're
covered by the midx!).

I think it's mostly academic. You'd have to do the million-pack search
if we are not in QUICK mode. And the point of QUICK mode is mostly
avoiding tons of fruitless searches for objects we don't actually have.
The bsearch() conditional means that we _know_ this is a racy negative
and not just some object we never even had. So it would trigger
generally only when the search is useful.

-Peff
