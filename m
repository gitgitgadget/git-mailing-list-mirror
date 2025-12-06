Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F23B8D46
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764986314; cv=none; b=LmUYhmuJOL42jRLa7whx6LF3MR8q25ZFewVt6i7Fp26Fg/sCocVcrYQAhAjprz40MLSHu2LQ7oWz9ZOLCC6wf7s0fou+HHSlFWaZrOw+FHC+vI6kzYmBPh5bElj/R3AqF6JG+UWHUdl66Cuz/qKftwvijcjCou6is1uWkHZCZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764986314; c=relaxed/simple;
	bh=OoxAYapBVoIlrV+BkZHm9SJ/EuurVMlry2hHUwJBB3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lO8cTTH4QLJA5cK5oqbLOt/+XIZ52oLBwTza7/0YAofTffey+BQ2Atj1lO7dSnxk1XSRm+mtNt8KZ5HSAXDSu1CkFTeBHqe5y8+H0IeJzEIa7LCNgiXjibgfg0OzNSmVlaQ6guX8MEjbcUPl3/CZKSDq3THWsJsj/1Yb3NCq834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=a9J4PLyC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="a9J4PLyC"
Received: (qmail 274297 invoked by uid 109); 6 Dec 2025 01:58:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OoxAYapBVoIlrV+BkZHm9SJ/EuurVMlry2hHUwJBB3o=; b=a9J4PLyC9q/yGWzwMc+5JyRzvfqM1l64VvTLZqaPnKE6tVUwq2SHp2H2PruhiAerrP4wrtgyd9h8e6H+baKdpMX45JWMd8vFQ6C7vbZ65N74aanNGjiGqWzKSNNAXNsOp/DvVbutqVKn/gY2T9F1mLIVVNSpM0Lo7PP5HjCNbjRpQmVycTtr46KbhVmVZevWRV7lqADuwLiFnl2wcAveIIJouvfAqZQs7IswKUQ0zekulQgLj9XQGlu1p00xpEy2APofXXhhU1zoPU83p6Lssvl8RgieYSB8GG210/2zzTJaT0wrFODv5HjGAv1pshXsB0oZRxZYi4TMABaCM501mg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Dec 2025 01:58:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 345466 invoked by uid 111); 6 Dec 2025 01:58:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Dec 2025 20:58:33 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Dec 2025 20:58:30 -0500
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
Message-ID: <20251206015830.GA1714099@coredump.intra.peff.net>
References: <20251204172132.319360-1-aplattner@nvidia.com>
 <20251205174854.GA18566@coredump.intra.peff.net>
 <20251205180106.GC18566@coredump.intra.peff.net>
 <235d80bd-2516-47f9-958f-0e5a16892758@nvidia.com>
 <20251205212839.GA35153@coredump.intra.peff.net>
 <4bd18399-26b3-44cd-93a7-8d2d32bef709@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4bd18399-26b3-44cd-93a7-8d2d32bef709@nvidia.com>

On Fri, Dec 05, 2025 at 01:56:23PM -0800, Aaron Plattner wrote:

> > I do wonder how you end up with OBJ_NONE, though. That implies somebody
> > created the "struct object" but without knowing which type it was
> > supposed to be, and then did not follow up by actually parsing it.
> 
> If I'm understanding correctly, this loop creates a dummy struct object for
> every object in the promisor packs:
> 
> 	if (revs->exclude_promisor_objects) {
> 		for_each_packed_object(revs->repo, mark_uninteresting, revs,
> 				       FOR_EACH_OBJECT_PROMISOR_ONLY);
> 	}
> 
> Backtrace for one such object:
> 
> #0   create_object
> #1   lookup_unknown_object
> #2   mark_uninteresting
> #3   for_each_object_in_pack
> #4   for_each_packed_object
> #5   prepare_revision_walk
> #6   cmd_rev_list
> #7   run_builtin
> #8   handle_builtin
> #9   cmd_main
> #10  main
> 
> Then the is_promisor_object() loop finds these dummy objects when it loops
> over all the objects again.

Ah, of course. That makes sense (and I don't think there's any other way
to do it, as we need the object struct to store the flags).

And that also explains this bit:

> > That's probably immaterial to what parse_object() should be doing, but
> > it is certainly a curiosity. And I'm also not sure why I got good
> > results from my rev-list invocation, but you did not. Weird.
> 
> Yeah, that's still a mystery.

It's because in the command I used:

  git rev-list --objects --exclude-promisor-objects $(perl -e 'print "1" x 40')

we call into is_promisor_object() _before_ we hit that part of
prepare_revision_walk() that marks everything uninteresting. In my
invocation above, we'd notice the missing object in get_reference() as
we try to load the initial tips for the walk, and then check it against
is_promisor_object() immediately.

And when I tried something more like your command:

  git rev-list --objects --all --exclude-promisor-objects

it did mark them all uninteresting, but because I had no objects that
were missing (and not simply marked uninteresting), it never needed to
call into is_promisor_object().

So good, mystery resolved.

> >    2. You didn't have a commit-graph built.
> 
> This repository came from "scalar clone" and then I created a worktree and
> disabled sparse checkout. I didn't do anything special to enable or disable
> commit-graph.
> 
> What I do notice is that usually, a `git pull` from the server this
> repository is hosted on is fast, but occasionally it hits this pathological
> case. I was using git-rev-list as a proxy for what git-pull was getting
> stuck on. Is it possible that having a working commit-graph is what avoids
> the problem in the first place? I'll admit to not having a great
> understanding of how the commit graph is used during a normal pull.

I'd expect scalar to create commit-graphs. We can leave it be, but if
you're curious you can double-check that .git/objects/info has either a
commit-graph file or a commit-graphs/ directory. If not, then running
"git commit-graph write -reachable" should generate one, and you can see
if that changes the timings at all.

-Peff
