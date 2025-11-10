Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B72E613B
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797258; cv=none; b=HGHDKapx3od36OEjVZbOySoMhyJsNJevjtoeCGWwc/QF9ELIhnYjSBn7CDcnvPzpo4qphoy4y1lUx7u/8Zaj1UjS78rYuASlC68mcjIT4GE1ciCR+iDYeunyl75LV0mWrm8Xx6OgjWTH2BZ95IgqmzbWrPKi7qjPpNLpBS/3Gmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797258; c=relaxed/simple;
	bh=c+Ca8MDwmSDWEHADJN85IB8TMmVkDFPVkFTR8yeRSTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XS70VXOVqubKeFcKrxQVmJiE3gTysy/QgGomf6Q0oEUK+cIkgQ+doCWQopNWuNh6nctq8SQ5onW2VvRrH36WjH3k4/XsF7VvdYg+blgdOJTElTJYcGc8rQzOe1typAQ+GEL7Rg/IMBj7fIvT8nqkwqPA1l9kUrNq2LO1kjUu5n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CSAlHdhT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CSAlHdhT"
Received: (qmail 481611 invoked by uid 109); 10 Nov 2025 17:54:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=c+Ca8MDwmSDWEHADJN85IB8TMmVkDFPVkFTR8yeRSTE=; b=CSAlHdhTwRJm3RPtYd9r/NMTsoG8QTgqyaB5mbSjoryvAopZX5W7lS1XHd28/g70xmbcuEOV+eghGWRLJ2h++ndbjP/cDvvqR5Bpotrmhu1eslYPaZBxkpffz2PnIL2K3O9RcyccdbMVLepAjy/dpnqDxn4qQsxI40tVAiazpp8DVBVzGtTuR7RPnibXbEvqRDJrPdpqvKXjUZJfdDCd5NzoG+doQqovCWfduO3WH7FcQgE3JEMUSY1ppFTjVRl8/65B/yB/htjVJI9hl8f7L3IySfZepoGkaVLWVN3B6A0/h6o7gUOp5TIPbtZcsGw4xOEomDpTiSQ0z3rCuD+sOg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 Nov 2025 17:54:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 763497 invoked by uid 111); 10 Nov 2025 17:54:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Nov 2025 12:54:09 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 10 Nov 2025 12:54:08 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff: disable rename detection with --quiet
Message-ID: <20251110175408.GB76603@coredump.intra.peff.net>
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
 <8796cd59-2335-4674-823d-d682ce7b7f8e@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8796cd59-2335-4674-823d-d682ce7b7f8e@web.de>

On Sun, Nov 09, 2025 at 05:43:36PM +0100, René Scharfe wrote:

> Detecting renames and copies improves diff's output.  This effort is
> wasted if we don't show any.  Disable detection in that case.
> 
> This actually fixes the error code when using the options --cached,
> --find-copies-harder, --no-ext-diff and --quiet together:
> run_diff_index() indirectly calls diff-lib.c::show_modified(), which
> queues even non-modified entries using diff_change() because we need
> them for copy detection.  diff_change() sets flags.has_changes, though,
> which causes diff_can_quit_early() to declare we're done after seeing
> only the very first entry -- way too soon.
> 
> Using --cached, --find-copies-harder and --quiet together without
> --no-ext-diff was not affected even before, as it causes the flag
> flags.diff_from_contents to be set, which disables the optimization
> in a different way.

This makes sense to me, and I can't think of a reason why you would want
rename detection on if we're not going to show the results (and likewise
I can't think of a way that a rename result would affect has_changes).

I wonder if we should _also_ take the hunk from v1 that teaches
can_quit_early() to avoid triggering when copy detection is on. It's
probably redundant now, but it feels to me like that's the place where
the correctness check should kick in. And the patch here is just
optimizing out the unnecessary work, but also happens to align things
for correctness downstream.

But I dunno. Maybe a check for a condition that we think can never be
triggered becomes too confusing for later maintenance.


You don't say in the commit message when this bug started. I briefly
wondered if it was caused by the recent diff_from_contents stuff we've
been discussing. But it's the opposite here (the bug happens when we
_don't_ set diff_from_contents). And I think it goes all the way back to
b4194828dc (diff-index --quiet: learn the "stop feeding the backend
early" logic, 2011-05-31).

-Peff
