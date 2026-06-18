Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046C33DEC2
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781825745; cv=none; b=dIqbNg4KSDo1cTvDgt0Wz9w9NDwy+1AeU0JwnF95KRUqhrmsZT6RKLZS6JB3+vRShEca30SzgHDsHf0VDn4+XH9ywLkMPB6u3dPw5wQGHK+5HZ2o941a5xL87nHPSwgzTpNNszJ3aYLlL3IWtQUnkV6F/efOqS77V+vQqNVpyPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781825745; c=relaxed/simple;
	bh=TbYW9q7+OJso8x9FsmJMBjVIx0Dp+ocIIo4FOons82Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evCcMCMd5NK/VJ3COu171W87KuYlLhWTLam6G/kwL53jRoHz4na/F0un9NReSH4vBqgExSLU3hTgraDJJ7LCCAHbXXyvc0gE8j3hspFunzmpqkPGtQ44DyQ8pFBEHK2UehvmacM7a8EfrIcL8E9G8pJVFcKjjKZ9EXEAipuCHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IQcrZw/M; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IQcrZw/M"
Received: (qmail 170212 invoked by uid 106); 18 Jun 2026 23:35:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TbYW9q7+OJso8x9FsmJMBjVIx0Dp+ocIIo4FOons82Y=; b=IQcrZw/M1BQKnKJH92lI3Yrt3Z0JQfwJiq7u4O889j2Cf6WeDzKlmHFi00qO2eSVAwelq5+5rlZPCGFY7d5UFwiu4f8wkPf5MNHPyFeXFkAUKQ3Eebau02xaTwZVrK8PtJgHtVvZvQ/KeSJ4YIwPmspaZQjKN8nJ2bbU3JNjzPL+PhcXEOOIUWYf0lk9llsSXzN3X552Nl0Yw1uYHYq6rTKM7PAUtl9oJ5FKrkqzYOeM91OKgWP1QoWvhfAEaIt5JZ3CGiQjGKz6IBCmGZX+g2UMZzpT8DaZvDYMFCPMy05lGXXGNkRAccpexfl3bD0e1IMVIm2yp/bgQWRg7KTTHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Jun 2026 23:35:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 480070 invoked by uid 111); 18 Jun 2026 23:35:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Jun 2026 19:35:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Jun 2026 19:35:36 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: git-2.55.0-rc1 t4216 broken TAP failures on non-x86 arch
Message-ID: <20260618233536.GA1431359@coredump.intra.peff.net>
References: <20260617220330.n6byiFQr@teonanacatl.net>
 <ajOP1IOjA3EYvRfm@pks.im>
 <xmqq4iizpkig.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4iizpkig.fsf@gitster.g>

On Thu, Jun 18, 2026 at 03:10:47PM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> Building git-2.55.0-rc1 today, all non-x86 architectures
> >> failed with:
> >>  ...
> >> This looks like it comes from the following chunk of code in
> >> the test:
> >> 
> >>     # expect will not match actual if char is unsigned by default. Write the test
> >>     # in this way, so that a user running this test script can still see if the two
> >>     # files match. (It will appear as an ordinary success if they match, and a skip
> >>     # if not.)
> >>     if test_cmp highbit1/expect highbit1/actual
> >>     then
> >> 	    test_set_prereq SIGNED_CHAR_BY_DEFAULT
> >>     fi
> >>     test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 changed-path' '
> >> 	    # Only the prereq matters for this test.
> >> 	    true
> >>     '
> 
> The "problematic" part is from mid 2024, so it is not anything new
> in 2.55-rc1, is it?  Nobody built and ran tests for the past two
> years on non-x86 boxes?

Presumably they did not notice the extra cruft to stdout, either because
it was being eaten by the TAP harness or for a raw "make test" it was
mixed in with a million other lines of output. But since 389c83025d (t:
let prove fail when parsing invalid TAP output, 2026-06-04) it will
cause a test failure.

-Peff
