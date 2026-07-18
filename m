Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30235369D4E
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784365530; cv=none; b=fVY0uWIcoV7Pf/Fy4kY8fkrQJ7GBgbz/1dcI/KDNrkg6EDvtttO92BSCwWImGXZ0BvMOZQAGe5ATlAG0oA1ac9eby1THqZexeGCyXuElhm6m9Xt8x/5Z1BSNs6dLkfn2pV61StBkAwaj3kLK8zld9kr8+eBwiMExdcCWUXAaxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784365530; c=relaxed/simple;
	bh=GJtz4yeSmaE5iiBj60d+C0x2h0ZqmBTvQy7lpKtc9nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byYmQQOZ6JMEw6DInlBoSxbp+RT0xasLUrAQvfHpoKj4wqaXUzYKIYOqrL0C20yWyfb4gR8u4Fw6VzowEIOcm1s6sKJh0F2zXN44Bs3QwzotgYyRo1cN1idOz8gobbv65fTq1tzJ9zG7xLYqYBlDBIuOpV0GVZmQx2aH1/ctGu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Qc7MNs8w; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Qc7MNs8w"
Received: (qmail 60807 invoked by uid 106); 18 Jul 2026 09:05:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GJtz4yeSmaE5iiBj60d+C0x2h0ZqmBTvQy7lpKtc9nw=; b=Qc7MNs8whQDTvqcsy0IAgEiDYDDDCol4zUaS8L1oo841e7r2Y89E8/rlSMlFyVgNJU/w6mjFlfCgV5Tx2rrVXafpvKXwLdhFNXhdolFNvRuJ0RQmmqbQGDCiSqqVCfNyCPqxZwwRFVOT/GkfEQEycd5IkRVtsFLOH00TXRG7q/Q+mcVr3TehoCWnZLBkFJOGT5SyA3GzGwgHSAgajPhvGvwnRgx7XJ6j4s3odZE4o3d5J6clXQ94ikfxn5aPl9I4smVTuUXeg6JHRJ8qISdAFPbGrSpIGHBOH0EGkbdB/CPhRMYxdWTxYza7VeaFTa9L4QYhBSUaUsvdK/bffM2zCg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 18 Jul 2026 09:05:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 107396 invoked by uid 111); 18 Jul 2026 09:05:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 18 Jul 2026 05:05:32 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 18 Jul 2026 05:05:27 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] send-pack: introduce a `no-ref-delta` capability
Message-ID: <20260718090527.GA30873@coredump.intra.peff.net>
References: <alQ7U8TOWjhasaWk@com-79390>
 <20260714074506.GD4058320@coredump.intra.peff.net>
 <alaxDPps6mg32C0g@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alaxDPps6mg32C0g@com-79390>

On Tue, Jul 14, 2026 at 02:58:36PM -0700, Taylor Blau wrote:

> > So I have the feeling that there's some ulterior motive, or that this is
> > part of a larger system, but I don't quite understand what it is. And so
> > it's hard to say whether this is a sensible approach.
> 
> The implementation motivating this is write-through in the sense that it
> first parses and spools the incoming pack, then replays those exact
> bytes together with the same ref commands to an upstream receive-pack.

OK, that kind-of makes sense. But is that intermediate layer not
indexing at all? As in, it does not know which OIDs are present in the
incoming pack?

It sounds like you _do_ index it based on this:

> In retrospect, I don't think the cover letter distinguishes this well.
> The pack that we receive over the wire is stored byte-for-byte as an
> immutable artifact, and the per-object physical index is derived
> asynchronously. That indexer is designed to operate in a single pass
> forward over the pack.

So I can see how REF_DELTA makes a single streaming pass harder. But can
you actually do a single pass even with OFS_DELTA? You'll need to look
at earlier bytes in order to resolve each new object. And possibly
recursively. So you must maintain random access to the new pack data,
and you must maintain some kind of in-memory structure, at least for
each delta family (especially if you want to avoid re-generating deltas
over and over as you satisfy a long chain).

> (Supporting REF_DELTA there during the indexing process is possible in
> theory, but requires keeping an OID lookup around, delaying resolution,
> taking another pass, or rewriting the retained pack. This design avoids
> all of those.)

Right, for each new OID you discover, you need to ask "is this an OID I
was looking to resolve". But the size of that table scales with the
number of objects in the pack. And if you are generating a pack index
with one OID per object in the pack, doesn't that also scale?

I.e., I am having trouble understanding what makes REF_DELTA more
expensive than OFS_DELTA, either in terms of random-access to the pack
or in terms of indexing memory. It's more _complicated_ for sure,
though.

I guess maybe you are also trying to send the resulting .idx to each of
the child receive-packs, and you want to be able to stream it to them as
you go rather than waiting for final REF_DELTA resolution at the end?
You can't send a literal .idx as you generate it (because it's sorted),
but presumably you're mostly trying to offload the hash computation, and
it's OK if the receivers still have to sort the set of (oid,offset)
pairs themselves.

That doesn't seem all _that_ compelling to me. I think the more
interesting thing is that in the worst case, a single REF_DELTA can kill
your pipeline entirely (assuming you are trying to do as much CPU-heavy
resolving work as possible while the pack is transferring). Imagine a
pack like this:

  0: REF_DELTA(abcd)
  1: OFS_DELTA(offsetof(0))
  2: OFS_DELTA(offsetof(1))
  3: OFS_DELTA(offsetof(2))
  ...
  N: base object with hash "abcd"

You can't resolve a single delta until you hit object N, after which you
must then resolve each of 0..N-1 sequentially because they all depend on
each other.

The problem there is not REF_DELTA itself, but the fact that REF_DELTA
allows you to place a base after the delta which depends on it.

If _that_ is your main concern, would it be worth a tighter capability
advertisement that insists that bases come before their deltas (if they
are in the pack at all)? We already generate packs that way by default,
and it would really just give the server a license to reject these
non-standard packs.

But now I'm about 3 levels deep in guessing at your real issues, so I'll
stop for now and see how close I got. ;)

-Peff
