Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116027726
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179565; cv=none; b=LCLmyarfutzoJ9/cMierfEsxVyDzi/F5Wm95vCGh6U+Ct4Zs9baAGfC+SdLSjPQRlFAoasoXs0WWuiwleVYZ1WvF9ItXa39n2f15tsfz6xAEHuP5fl0rZuHquz5r+ZzK8lJDtQKRx+qVHfHZnRSVtCJfMaNwaq8kXkmg+tXTsJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179565; c=relaxed/simple;
	bh=7BWKMJB9Tdk6wjALQcpBrmEITusr64niXoMWAm289MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWSR21y+nA1x/v+NcaiQmwo2PCsDN8KRes6Ac5FgJOD3pX5uJ330tpak9r1i5PPICIXz8G/U/PvgqmrbT4RZHCsunqRSKtVATWUnBqC6O2FxuiFzk5hUc/TJAoZ3v3U5zGYPZS/eJnJBvwPEw/IyJpVc6ivp0Ha48sM0nQxSvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TBAc7pKi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TBAc7pKi"
Received: (qmail 114107 invoked by uid 109); 26 Aug 2025 03:39:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7BWKMJB9Tdk6wjALQcpBrmEITusr64niXoMWAm289MU=; b=TBAc7pKidd8ep6mwVYswBpOfSC0+Qex68/T3H1ahUI7CT/Mt4LX9p5tS0+gA6DfyAafg8FFnqAMUgLoCBW3qpBuKg9fo/IOAeTdTy10TmDHGCyg37pAINd+dmeSi/4n5Rj7fM+rtuX6TDIhrN4dsO8pOG4WvG/hg+okgl5SB2uZZ9J3SwRmEtnaEBVogd0+XcQtIAASx5JS25htI6bpZKpjMWHNRA0fOVw+ko8V5roF/qpwHd5Fn1VKt/hYU498QGuyP8jOPNKGUSXIXhcnksj8LO5oOxlY0n01eVTr8pC2dmaO+oowJLwVcWn8oBjJWR9iugxzEKDyJ5FEQRtwh/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Aug 2025 03:39:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166048 invoked by uid 111); 26 Aug 2025 03:39:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Aug 2025 23:39:20 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Aug 2025 23:39:20 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
Message-ID: <20250826033920.GA388997@coredump.intra.peff.net>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
 <20250825081345.GA352784@coredump.intra.peff.net>
 <xmqqcy8jqlue.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcy8jqlue.fsf@gitster.g>

On Mon, Aug 25, 2025 at 11:48:09AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So out of curiosity I tried replacing a slab that should be pretty
> > densely filled, using a khash based on oidhash/ptr along with some
> > quality-of-life wrappers.  Patch is below.
> >
> > It performs...very badly. Not sure if I've screwed something up, but
> > it's about 7x slower to run "git rev-list --author-date-order HEAD" in
> > the kernel. So maybe slabs really are worth it overall.
> 
> Hmph.  It is the best case scenario for the slab code, as you'd need
> author date for each and every commit object in this use case, and
> the comparison function called by prio-queue would be called for the
> same object many times.
> 
> But the hash function being oidhash(), I am a bit surprised.  It
> shouldn't be so much more expensive to peek at the first 4 bytes and
> then do the usual hashtable thing than looking at the in-object
> commit->index.  Is it a sign that the range of oidhash() is a bit
> too small for a real workload?
> 
> Nah, 4 byte unsigned integer should be sufficient for the number of
> objects in the kernel.

I was surprised, too. I expected it be maybe 20% slower or something.
Which really makes me think I've managed to screw up the patch, but if
so, I don't see it. I tried profiling the result, expecting to see a
bunch of extra time spent in obj_timestamp_put() or obj_timestamp_get().
But I don't. They account together for only a few percent of the
run-time, according to perf.

So I dunno. I am confused by the results, but I am not sure if I am
holding it wrong.

-Peff
