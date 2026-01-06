Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668F24BD03
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767695889; cv=none; b=CNR4KzGsojIhAGaUTLpxDbIowlMesGe5uLhztPk1b+slHdRFB8tMbviWzDK0AV9jDE5S1djqUtILx0TIJWMVRdYBaw1+Me+Bx+NGwNNACW4fImT3sDMakmGdgwaxNovZTGR0+POI5GtJvFng2Lf4JU/QWOSOH4RQrLxt2s6AWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767695889; c=relaxed/simple;
	bh=JiuCzUwAUAd1U94Qi1oBymwdnLZyDqnF1sd8Kkm1Gno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGdqOWFjbJvTzFIWEviJiE46rcrAvXzur3d+oQUlYXjGpIDtTrzSUOGljBA5GBrZJhuQGKErVr9N3PjAEwFyPfz8fWUmvf+DuZzqEFLLCV3KWjPe/UvX5tWwS4p9qMP+UVBNHxd9QbyVjTiAsu3wUrL3NWp8Cf2Xsjx+PTJx+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QSvQb7Pu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QSvQb7Pu"
Received: (qmail 601026 invoked by uid 109); 6 Jan 2026 10:38:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JiuCzUwAUAd1U94Qi1oBymwdnLZyDqnF1sd8Kkm1Gno=; b=QSvQb7Pu9FBxckACa9XKLZ9nFvfiLdgrNTZM+bzd7+IP22HluMY5ht2c5BvfzqxgJ3hCvqR6iLfbqeMxkP+CJL6oGfjCHZZKblfFUOT7lkEqVd3ie6bERrlFcsZkgjZ6TSD6Q8oLjGCBeDYGkUXc9c+kJVcYOd+GBaO4gz+U9KW+NXXKKwo6a6kmzkgYszbO9atlYFhbrF0IoIfNKD4stVy26z/p/uLNDZXkau219RyJ2E4s9QDIOkhJ0deXhKiUscTsQXJ29WjVDWILiJGkRoYQkKrebnB8tuAFXOhPEUhUkQCBKXr8bDSyIC2s+Sb73GKtxABQXIEXZ0WmKYCO0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Jan 2026 10:38:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 789289 invoked by uid 111); 6 Jan 2026 10:38:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Jan 2026 05:38:09 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 6 Jan 2026 05:38:03 -0500
From: Jeff King <peff@peff.net>
To: Martin Fick <mfick@nvidia.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Message-ID: <20260106103803.GA69061@coredump.intra.peff.net>
References: <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
 <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
 <20260102074901.GD2581074@coredump.intra.peff.net>
 <CH3PR12MB90260C4887067C88629BBE52C286A@CH3PR12MB9026.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CH3PR12MB90260C4887067C88629BBE52C286A@CH3PR12MB9026.namprd12.prod.outlook.com>

On Mon, Jan 05, 2026 at 11:45:41PM +0000, Martin Fick wrote:

> By repacking to get one used, and one cruft pack only, and no loose 
> objects, I have confirmed that pack-refs it is still slow. This rules out the 
> idea that the loose object, or pack file counts were making things slow.

OK, that is interesting. I'd still expect opening the objects to be the
dominating factor, but now the load would be on jumping around the
mmap'd packfile rather than open/read/close calls.

> OK, after discovering the strace -r and -T options, I have determined that
> the 29K writes were all very fast in themselves. However, most of the
> writes seem to follow each other with no other system calls in between.
> This explains why it looks like the writes are slow, even though they aren't.
> 
> If I tally up the time between the previous system call, and each write(),
> it adds up to the bulk of the time (4mins out of 4m15s) that it takes to
> pack refs. This tells me that no visible I/O or system calls are the problem,
> but rather that the program itself is taking a long time between writes.
> I very much doubt that this is heavy CPU time, but rather I am going to 
> guess that this is hidden system time spent accessing mmaped memory.

That would be consistent with reading object data from the packfile.
We'll jump around within the packfile to get that data.

> Could it be really slow reading the packed-refs file? I can see the 
> packed-refs file is mmaped() before the writes start, and then 
> munmapped after the writes are completed. If I had to guess, that likely
> means that the packed-refs file is being read in small increments by the 
> kernel via mmap, and that is what is making things very slow over NFS.

The packed-refs file is mmap'd, but we'll be reading it sequentially. I
guess whether or not there is good read-ahead there may depend on the
NFS implementation.

> My alternative theory, is that each ref is being looked up via a binary 
> search, but I don't think git does this?

Git does binary search within the packed-refs file, but it shouldn't be
doing so here. The write-out phase of packing refs is a straight merge
between two lists: the existing packed-refs entries and the new entries
we are adding.

I'd second Patrick's suggestion to use perf or similar to try to see
where the time is going.

You might also try building Git with NO_MMAP. That might make the I/O
costs more apparent via strace, because they'll be coming via pread().

-Peff
