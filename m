Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E02D29C8
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788003181; cv=none; b=TP5EYyJODX8k+cIMN33uUlBt9kvIR6+Ay38EvsU8EHu+F3qMvJ0UI/j3za3bVZq5Itdy32PQEe+GjxtqdOpzac7J6LsGPgPDIIYQOgIHBKa7mL3Yfb6KXPd82fzZBM3T60VupkkWdcE04+Q6IRaLGZz3aw0/BOzs3//gkqK3KL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788003181; c=relaxed/simple;
	bh=jobD9tDc1n6IAh8j/X/h3vjWhr2/2T4334g2VNwPxMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhVoQwefPpEiRphXOIZP6cWtxdeHR5OKijajvAVucWhQjNiUmBjRUc/9f2YHnXCGLP+Y4NPhIyyJ2Ec311anbgIGoUJjSi2XXVp0pXI8fVgJfjoV9z880u3tlk+W5haMS/sIsgCgY9Tjk6bX80gFbYAi1ydTyuCDnTRmiHhnXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=T8P9OXJP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="T8P9OXJP"
Received: (qmail 46775 invoked by uid 106); 29 Aug 2026 11:32:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jobD9tDc1n6IAh8j/X/h3vjWhr2/2T4334g2VNwPxMo=; b=T8P9OXJPeJ6txdXASd5vxoTMYZ8AXBR2G1LqL80gSylr+KJIfVZa5PN6ZzVvSkXKcXn6j8v7iTRP75F8891GZx/rNNhJ/WK0HfvIRHts47yBFNiQ1miloT0wrnDNW4cPjqZpx4IhcvyOFO2BT5HVNZEM+eW+yP/xIiauFYKr7md0JZeb3mno+Z7dhbyLes5PcJrlC0FKJ+HZL4iG2hW/Gf3qSleqLF2lt35gzXZFDG0FcotxILvFuK+vzBb4vw4ahELT/FPSd9OBmF7w/JJoY6t2tlpUDF6oRkmBTWvjnV0Grrq/80KBy7d/QU823g+Vn6Bb2qNA6f4KR7R7OOgHYw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 29 Aug 2026 11:32:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 83739 invoked by uid 111); 29 Aug 2026 11:32:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 29 Aug 2026 07:32:58 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 29 Aug 2026 07:32:57 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/4] packfile: recover object lookups racing a
 concurrent repack
Message-ID: <20260829113257.GC40814@coredump.intra.peff.net>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
 <fc98f48ddb4d46cad66a40ecdd96c139e1397784.1787684429.git.gitgitgadget@gmail.com>
 <20260827055743.GB189659@coredump.intra.peff.net>
 <CABPp-BEmReAR-f-aweM=f=5QhRPxG1K-KLTsbyRt2aDQD_QnVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEmReAR-f-aweM=f=5QhRPxG1K-KLTsbyRt2aDQD_QnVA@mail.gmail.com>

On Thu, Aug 27, 2026 at 03:23:30PM -0700, Elijah Newren wrote:

> It's far more likely that I am the one being dense.  My rough line of thinking:
> 
> * We see "packfile ... index unavailable" in our logging
> * There's only one thing that remove packfiles
> * Investigate the mechanism
> * Look for other affected callers (e.g. mktree --batch)
> * Consider corrective measures
> 
> Steps 1-4 above are probably fine, and step 5 may have been where I
> went off the rails.  My thinking there, wrong or right, was:

I think we should consider the log message independently from whether we
eventually return a value (whether QUICK or not). It seems like the log
message is often unnecessarily scary, because we either recover via
SECOND_READ, or we are in QUICK mode and the false negative is OK. So
the message is informative at best, and probably just noise in those
cases.

But it perhaps _is_ helpful when a non-QUICK lookup ends up returning
failure. We'll end up with some other error() message, but it may be
useful context to know that we _thought_ we had the object available and
then the rug was pulled out from under us. But we don't have a good way
of queuing up an error that is shown conditionally.

So I dunno. We could consider moving that message into trace/trace2,
making it more of a "debug" message. And then people digging into a
problem can turn on traces. But I have a feeling that is not very
helpful, since it is mostly a racy situation (so you can't just easily
replay your failure with tracing turned on).

> * It makes sense that we don't want to reprepare most of the time
> * ...but _if_ we know of the existence of some specific packfile in
> this process and that packfile has since disappeared by the time we go
> to open or read it, is that a special case?  Should it be?

So now we can consider the actual return value, aside from the logged
message. For non-QUICK requests, I think this case is uninteresting (we
already do a reprepare and follow-up read). For mktree, I think the core
of the problem is using QUICK when it should not.

I think the current behavior of QUICK is _correct_, in the sense that
false negatives are OK. But can we make it better? Possibly. To me the
argument for this patch's direction is something like:

  The point of QUICK was to avoid lots of reprepare effort when we are
  looking up objects that we might reasonably not have. This has
  historically been about things like fetch speculatively looking for
  stuff the other side mentioned. But there we are mostly concerned
  about objects we _never_ had, and avoiding tons of reprepare work that
  will almost certainly not help us. But in some races, we might learn
  that we _did_ have the object at one point (because we opened its idx,
  or a midx) but the lookup still failed (because the pack couldn't be
  accessed).

  We can cheaply notice this case by differentiating true idx misses
  from failure to access the pack contents. And these items _are_ worth
  a reprepare, because they were almost certainly caused by a repacking
  race (or a true repo corruption or object pruning, but that is rare
  enough not to worry about for optimization purposes).

  So even though QUICK is not _wrong_ to say "we do not have that
  object", it is a good tradeoff to spend a little bit of time calling
  reprepare in order to produce fewer false negative "no such object"
  responses (because tools like fetch then have a chance to optimize
  their own task more as a result).

Maybe that argument was somewhere in your original commit message. I
admit I got lost about half-way through. ;)

But I think the key thing is separating:

  - is the logging confusing or useful? What should we do about it?

  - is mktree racily broken because of QUICK? I think so.

  - even though QUICK is not wrong to skip the second read for this
    case, it might be a good tradeoff for it to detect and try harder
    here (i.e., the argument above).

Which sounds like three patches to me, each of which can be motivated
and argued on its own.

> > So I don't see QUICK itself here violating any contract (even if it
> > _could_ find the object in some cases with just a little more work, as
> > in the case that we were discussing for v1).
> 
> I'll drop this patch and instead send a small mktree change that stops
> passing OBJECT_INFO_QUICK (keeping SKIP_FETCH_OBJECT), so mktree
> recovers via the normal reprepare like every other non-QUICK reader.
> That removes the packfile.c changes entirely, so both the
> reload-under-QUICK hack and the .idx/.pack raciness you noted in
> pack_index_is_missing() go away with them.

I am also happy with this direction. Then we can consider the other
questions separately (or not at all if nobody cares enough).

-Peff
