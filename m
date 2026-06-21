Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D421234994
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077288; cv=none; b=idA0Zw/PrnUdVCoh+wlzxDkb993AOAcSNEE6riN2lo/WiCCPx+EohGkpfq2v2Am1gQCew7rrhxITMyYK5dt7uoice3ifR/zNnm0PTYSRTyYVeX6r3G2xatEnesK9He3QXy7/MAymWPM1YHgHzul0YaLk7P6CvY02vzMrt2D0e7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077288; c=relaxed/simple;
	bh=LoQJ5G/mHx6DAGkKsoxvNBgcgeZLhj3U7zFsDQuwIyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf2X/F+nQkRRUpP6spRsvjvQErLPSNrH/Qtuxw8mBs1MCfEO2dLdHcGFnu2akdsFeXyiQwPAiF9k8wkthlQnOb8DgDc8xE5lO0Hiyve85+hNyYXSIzEgtEO2d/0Q8JZftAqnzap7NBnA//+W8N8UJfXQl4S9XYqOlESwZpI+d+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ur2seOro; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ur2seOro"
Received: (qmail 208596 invoked by uid 106); 21 Jun 2026 21:28:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LoQJ5G/mHx6DAGkKsoxvNBgcgeZLhj3U7zFsDQuwIyk=; b=Ur2seOrobYwSkuWjmKaZHG2QO/2Za+o4uQc7hyKsqQqhcpxMTHZEqWPqW6gNgyrhj5gl524TQPqcbqHGXVtBt85o9TrdKOyIS6swKO95fEVegfvevpVexLsO1AFozkX9K/sO9j0AmD/zIaDnjkEq0+WMlHlxppBFgaw8YqsE0B0usmfYNiHofPgiQgaubcl4E7Xtclx4CRgc5ma7mHGPCrMu9qIuk7buwgTll3eqsyKB5xEjzkInYQtoDOxE76ARUWticnPW2Vsky8yDFLpIer6UODz+RNfO0jfkqZlgKrKuHtleYTftDn7461KvzloZe/AWCAcB2PXqLXdioqnqUw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Jun 2026 21:28:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 526536 invoked by uid 111); 21 Jun 2026 21:28:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Jun 2026 17:28:08 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 21 Jun 2026 17:28:05 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
Message-ID: <20260621212805.GB2297179@coredump.intra.peff.net>
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
 <20260609001134.GD358144@coredump.intra.peff.net>
 <CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
 <20260611085526.GL2191159@coredump.intra.peff.net>
 <CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
 <xmqqa4sog1e9.fsf@gitster.g>
 <20260621172432.GA2206349@coredump.intra.peff.net>
 <20260621174518.GB2206349@coredump.intra.peff.net>
 <xmqqfr2f7iay.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfr2f7iay.fsf@gitster.g>

On Sun, Jun 21, 2026 at 01:24:53PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't know if any of this is really worth digging too far. This feels
> > like a case we could do a bit better at, but I wonder how much it
> > matters in practice. As soon as you do any index-refresh (including "git
> > status"), the racy entries are cleared and everything is faster. It
> > just seems kind of lame that we write out the initial working tree with
> > so many racy entries.
> 
> Yeah, We didn't want to stall for a full second back when we were
> not using subsecond in anywhere, with nanosecond resolution
> timestamps in place, we could delay writing the index file by 50
> milliseconds, nobody notices the delay, and raciness would go away,
> perhaps?

Yes, though that implies comparing the index and file mtimes with
nanosecond precision.  We have that precision stored (at least
when the system supports it) but I'm not sure if that comparison would
run afoul of the reasons USE_NSEC was not the default in the first
place.

I guess not? The problem there is that the nanosecond portion would
sometimes get wiped if the entry was dropped from the kernel's in-memory
cache. And then stat-matching would not work. But if we are talking
about strictly asking "is this mtime later than that mtime", then I
think the worst case is that we fall back to the current behavior.

But at the point that we are comparing nanoseconds, I don't think we
even need to bother with the delay. It takes maybe 5 seconds to write
out all of the linux.git files and then the final index. So ~20% of
those files will have the same timestamp as the index. With nanosecond
resolution, we'd expect that to drop by an order of a billion. Even if
we get unlucky and have a single file with the same timestamp, that is
not so bad.

The code to do the nanosecond compare is already there! But it's gated
on USE_NSEC. So this (plus a bonus debugging trace ;) ):

diff --git a/read-cache.c b/read-cache.c
index 21829102ae..f84159a060 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -356,14 +356,10 @@ static int is_racy_stat(const struct index_state *istate,
 			const struct stat_data *sd)
 {
 	return (istate->timestamp.sec &&
-#ifdef USE_NSEC
 		 /* nanosecond timestamped files can also be racy! */
 		(istate->timestamp.sec < sd->sd_mtime.sec ||
 		 (istate->timestamp.sec == sd->sd_mtime.sec &&
 		  istate->timestamp.nsec <= sd->sd_mtime.nsec))
-#else
-		istate->timestamp.sec <= sd->sd_mtime.sec
-#endif
 		);
 }
 
@@ -434,6 +430,7 @@ int ie_match_stat(struct index_state *istate,
 	 * carefully than others.
 	 */
 	if (!changed && is_racy_timestamp(istate, ce)) {
+		warning("%s is racy", ce->name);
 		if (assume_racy_is_modified)
 			changed |= DATA_CHANGED;
 		else

makes the problem go away. I'm not sure if I'm missing some case where
we could be bitten by the problem that led to making USE_NSEC
conditional, though.

-Peff
