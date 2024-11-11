Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3C1B95B
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362691; cv=none; b=ij2CbCao//yGEGUXKYa1f0YkJ94vLVJUqgFeVMr0pL5u3jkld/T79tOlwQU9tyjmg9Z5HAknhMAoRJZvwvlJ7utymE6uNH6Cz5kSdXDzNhG33FhmGqKW3jLkux3aXlUYHPSMJZS4KwKewhOfTXS7CN78ijWErfEyu7EZbLqjpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362691; c=relaxed/simple;
	bh=XZegv9O1j0fLPL4IEaBdTX6dIXS0d6h75+3VV5HzEq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYTKYrEGcVa/ovr8BoSER5jKwNkeIYTRcE07wrcY0Dbyd1Nwft6YM2O1r+i1xLw1Oo4P+v7BDWGDMGSYfpPASPVuapJoR6lzLyT+RegoIKPpuTuA7wAN6ZROJfraC9Yehmc2ZbMLg69qVVLtLE/5BDsxBdigFuyJfHR3eq23V0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ym4Zt3L5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ym4Zt3L5"
Received: (qmail 21960 invoked by uid 109); 11 Nov 2024 22:04:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XZegv9O1j0fLPL4IEaBdTX6dIXS0d6h75+3VV5HzEq4=; b=Ym4Zt3L5imX+b0qwpFNnfipMXZ7QhhJIxRM0QHu8IG2dFjLZCcd/FvsV0WNSkyIdoaTjIUGjuHIc8tsmiJABkPmjIDHeRzACV6e+CCm0JuRTPYgPrjXVB+jlU4ZCqFGwAChKdLNBZzVZSDyz7Gbp0el8MhQC4GqAoCYhNjHdDlrPxq20thBHfnVlNEsNi1UilJupem9WH3AHvrBwbE9E3cGsqCQ5V4ppA8c310O4xlkfqG8MtUkOaNKpo6BLd3WceaAW6Pal6lBvpqBfy+H/alnyCnn3Q+WfCq2pi1i64hyJZipzeeZR1TIXYh5WcBJ3Al174FsX/nU2RoVtbbSRMw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Nov 2024 22:04:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20559 invoked by uid 111); 11 Nov 2024 22:04:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2024 17:04:50 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Nov 2024 17:04:47 -0500
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de, ps@pks.im,
	johncai86@gmail.com, newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com
Subject: Re: [PATCH 0/6] PATH WALK I: The path-walk API
Message-ID: <20241111220447.GD5019@coredump.intra.peff.net>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
 <ZyUqr/wb5K4Og9j9@nand.local>
 <2d2940ef-0b26-4060-90b6-9b6969f23754@gmail.com>
 <20241104172533.GA2985568@coredump.intra.peff.net>
 <xmqq1pzqwnck.fsf@gitster.g>
 <f02ee8ac-01e4-42e3-b99a-d9616b9ff1bb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f02ee8ac-01e4-42e3-b99a-d9616b9ff1bb@gmail.com>

On Fri, Nov 08, 2024 at 10:17:24AM -0500, Derrick Stolee wrote:

> > > I'm not sure why a larger hash would be worse in a shallow clone. As you
> > > note, with only one version of each path the name-similarity heuristic
> > > is not likely to buy you much. But I'd have thought that would be true
> > > for the existing name hash as well as a longer one. Maybe this is the
> > > "over-emphasizing" case.
> 
> I'm confused by your wording of "larger hash" because the hash size
> is the exact same: 32 bits. It's just that the --full-name-hash option
> has fewer collisions by abandoning the hope of locality.
> 
> In a depth 1 shallow clone, there are no repeated paths, so any hash
> collisions are true collisions instead of good candidates for deltas.
> The full name hash is essentially random, so the delta compression
> algorithm basically says:
> 
>   1. Sort by type.
>   2. Within each type, sort the objects randomly.
> 
> With that sort, the delta compression scan is less effective than the
> standard name hash.

Ah, OK. I'm sorry, I had not really investigated the full-name-hash and
misunderstood what it was doing. I thought we were using a larger hash
in order to give more locality hints. I.e., to let us distinguish
"foo/long-path.c" from "bar/long-path.c", but still retain some locality
between them.

But it is throwing away all locality outside of the exact name. So yes,
it would never find a rename from "foo/" to "bar/", as those mean the
name-hash is effectively random.

So I guess getting back to what Taylor and I had talked about off-list:
we were wondering if there was a way to provide a better "slider" for
locality as part of the normal delta candidate sorting process. I think
you could store the full pathname and then doing a sort based on the
reverse of the string (so "foo.c" and "bar.c" would compare "c", then
".", etc). And that would let you tell the difference between
"foo/long-path.c" and "bar/long-path.c" (preferring the identical
filenames over the merely similar ones), but still sort them together
versus "some-unrelated-path.c".

And what I wondered (and what I had initially thought full-name-hash was
doing) was whether we could store some fixed-size hash that produces a
similar distribution (modulo collisions) to what that reverse-name sort
would do.

-Peff
