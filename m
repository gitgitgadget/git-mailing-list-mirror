Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1E267AF6
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766130607; cv=none; b=fTRx/YN0WRXfMEJokUS1kLX9evjuF3nduSlZLG4n6cDsiUfEaKi7QeHNfLfe4iDBQZ1vxDlQdPRYdOK0CZ5wZu0GXFVk+4eu+xdMyLyYq0Tva7Q6chulwr/sd3ppMiKu/Zm6IagZubL24pjXQjkNx1GsQshKdi0QJk2B2Qh3fF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766130607; c=relaxed/simple;
	bh=ZTBphQgz4d+NMpLNCl1Cra36i0YIaUdDEzBiD6JBCzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaDeaXWbwlFjaYntSnW+2rMcnM8eqs4c694+7V9fIfjhQH1oBZmaPQ9QapX6v1UrnkpzXffFL4zAtoWo4ZXzMJ9vdj6fXqojPIGGoDuNW6zH8GVGjwKE38126gwpOYumDgVjRto0BqqlW28oIttNsuW6FOIjbi5RL41kE4R6p0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=e1jkZYmx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="e1jkZYmx"
Received: (qmail 396442 invoked by uid 109); 19 Dec 2025 07:50:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZTBphQgz4d+NMpLNCl1Cra36i0YIaUdDEzBiD6JBCzU=; b=e1jkZYmx5xRUp79PNq2xWZbq5NIyA8VzA8N4we/sJlev6Dq9FJDjM+DrB3lKyDYS2chvgOwo9yMmWwdacLZoY35Okg3ab27MJfuNBF7dw1DYMoVnX5/pcaO3qGYp509acIcnh+4X8RXrX17BpZpXcslGlyRsaT4O6Wngayd4n4ZvdYVZvXuVTZi7xYnYJ8Iwkb3stuzdGHuYrs4j3HyMeb+fIxkAwkbl/osPDL60p2m2x0Bw7EL5l9M7Fye+fTNLTUBa+WJ9clyHqQtsHcqDxyAliXVO9a60xzdzi4F/I42ElMR8z1QQG2J4Pu7QR6HJ3sF62yUHF61LlZ6X80bi2g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Dec 2025 07:50:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 530305 invoked by uid 111); 19 Dec 2025 07:50:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Dec 2025 02:50:06 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Dec 2025 02:50:02 -0500
From: Jeff King <peff@peff.net>
To: Daniel Stenberg <daniel@haxx.se>
Cc: git@vger.kernel.org, Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH 0/3] test-suite fixes for upcoming curl 8.18.0
Message-ID: <20251219075002.GB3784564@coredump.intra.peff.net>
References: <20251218121120.GA3252258@coredump.intra.peff.net>
 <613s97no-7021-pp15-79s4-302o39p7n5r8@unkk.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <613s97no-7021-pp15-79s4-302o39p7n5r8@unkk.fr>

On Thu, Dec 18, 2025 at 01:37:11PM +0100, Daniel Stenberg wrote:

> >  [1/3]: t5551: handle trailing slashes in expected cookies output
> 
> This is all benign. As you correctly observed, we no longer keep the
> "original" cookie path around and only work with the sanitized version - so
> that's the one stored now. It was already the one used for actual
> comparisons so apart from the change in storage, it *should* not cause any
> problems.

OK, good. I did wonder if there might be some subtle behavior change
under the hood, but figured you probably knew what you were doing
(especially since the normalization was the point of that commit, and
not some unexpected side effect).

> >  [2/3]: t5563: add missing end-of-line in HTTP header
> 
> I believe I made some code checks a little stricter: header lines MUST end
> with at CR or LF (or both) to be treated as a valid one. Your fix for this
> should be good also for older libcurl versions.

Makes sense. I think it's accurate to call what our test was doing
garbage that we happened to be lucky was accepted, and the new curl
behavior will not hurt any real world cases.

> >  [3/3]: t5563: relax whitespace assumptions for unfolded headers
> 
> This one is material for me to rethink.
> 
> I had to completely change our header unfolding logic because we learned
> that we did not apply it early enough, so some header parsing was wrongly
> done on pre-unfolded data. In this process, I also changed the logic that
> appends the following line on the previous line. To avoid having to keep a
> state, I decided to just append the second line onto the first one without
> trying to reduce the whitespace characters to a single one.
> 
> I did not fully consider the impact this might have on users such as you.
> Allow me to rework that a little bit further and get the former white-space
> behavior back. Thanks!

I do think you're following the standards in including the extra space,
so that part isn't wrong per se. But it may be kinder to do a bit of
whitespace collapsing. I dunno.

The more fundamental change is that a CURLOPT_HEADERFUNCTION callback is
now fed unfolded headers, rather than getting the lines piecemeal (and
having to do the unfolding itself).

So I'm not sure that we should be worried about a case where old code
preferred the unfolded but whitespace-collapsed headers, and will be
broken if curl does not keep doing that. There was no such code, because
curl was not unfolding at all!

The only code which would confused is a callback that did its own
unfolding and somehow implemented it differently than curl does (which
is what happened here). But every caller should be prepared to take
unfolded data, since after all the server could have avoided folding in
the first place.

So I dunno. While we did see "breakage" here, I am inclined to think it
was mostly about how intimate and brittle the tests were, and that any
real world use would not run into this.

I'd like to think it probably doesn't matter much in the real world
considering the deprecated status of folding in the first place, but
that might be too optimistic. ;)

-Peff
