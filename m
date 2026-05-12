Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F92C3768
	for <git@vger.kernel.org>; Tue, 12 May 2026 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610929; cv=none; b=qzUBe844PnANvAVgPiWzvtqBnH/GldoyXeJQq/x7LXpQIOc2yq6ecFqy1ueUFZBjxUs4pODEjALC9uVxqoOzCms2tKDm2kLbFlHOc+x7NZbUQbZPrHZ89S9XQDOnlsyom0NoHaGj4FYZJuvc1f6zrjHMyrSloND3CM7ftscq1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610929; c=relaxed/simple;
	bh=xUt8nHK2zx9bhwpTxuwzCJ8X6Hz1ZCV2ioiPBKChZfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyqcfAl88/9oj+U3Ws7vKAXxwW+QGnFS/w5TDUYQqyz/CtBoD/jP8tWaaHZp/U1Y4yu0a/IzLZcqSYR/7B0SNo2ufdwZOZ13Q+cEXOdD57/oNqVLpGdzdAT49dS8pLl+L9Er6Aw77HVH1nRIZOlUkRBkpcF9hrr5chgo+36bhi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Hepya0AN; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Hepya0AN"
Received: (qmail 28884 invoked by uid 106); 12 May 2026 18:35:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xUt8nHK2zx9bhwpTxuwzCJ8X6Hz1ZCV2ioiPBKChZfU=; b=Hepya0ANzH5YRZUUBMkq6IedjcS9l8WagTH42U6a7Um1742h8SsylNgGJAGM4Mmwo7J3jAIq/f3FKr74XmZjg4cbBm5TtU472GOIAjNWyMatxPwUK+C4uZxrEnm8FJgNVFw/njxXaaJnTs3Tw39+Yv8vwJDXjUkD8bpJyHsLrKOc8LkhpYaiMzzFwgZO3bLV61i/FzUoGy+/LiB+DQMaeamFbLLGrVlhG/HOOXXNkM7C3O/NM9G9RTCbLcP8aCRMMIV5pF9e4Wt5aTZkrRXSec428G7YGe8OiugLH6HTTX9vW5Sy0LaSI7SpRSLtDMejzBcsJsy0zArTE6kN6VqhOA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 May 2026 18:35:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 52345 invoked by uid 111); 12 May 2026 18:35:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 May 2026 14:35:20 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 May 2026 14:35:19 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] t0006: add support for approxidate test date
 adjustment
Message-ID: <20260512183519.GA70851@coredump.intra.peff.net>
References: <20250318180201.3653-1-taahol@utu.fi>
 <20260512145430.13212-1-taahol@utu.fi>
 <20260512145430.13212-2-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512145430.13212-2-taahol@utu.fi>

On Tue, May 12, 2026 at 05:54:28PM +0300, Tuomas Ahola wrote:

> t0006 uses a hard-coded test date and provides no convenient
> way to override it temporarily.  Add an optional parameter to
> check_approxidate to adjust the time as needed, and demonstrate
> the feature with a new test.

Makes sense, but two small-ish comments:

> +check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' success +48

One, it sucks to have to say "success" here, but is awkward because now
we have two optional arguments. There's nobody passing "failure" right
now, so we could just drop support, though that might be annoying later
when somebody wants to add a failing test. But we could perhaps switch
to allowing:

  check_approxidate --failure 'January 5th yesterday' ...etc

which is fairly natural.

This is something we've run into in many different test scripts, and I
think the harness could do a better job of supporting this. Perhaps with
something like:

  test_expect() {
	if "$GIT_TEST_EXPECT" = "fail"
	then
		test_expect_failure "$@"
	else
		test_expect_success "$@"
  }

  test_fails() {
	# probably needs to be more careful of one-shot with functions
	GIT_TEST_EXPECT=fail "$@"
  }

  # this is a normal passing test snippet
  test_expect 'foo' 'git foo'

  # this one expects failure, but it can be toggled easily by
  # removing the leading "test_fails" wrapper. Not much better
  # than swapping out s/failure/success/ now. But...
  test_fails test_expect 'bar' 'git bar'

  # this one just does the right thing if the helper function
  # is using test_expect under the hood
  test_fails check_approxidate ...

I dunno. It is probably too big a rabbit hole to do before your series,
so mostly I'm just thinking out loud.

> +check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' success +48

The second thing is that "+48" is pretty opaque. It's a relative offset
to some arbitrary point. To some degree the script already suffers from
that (all of the tests are using some arbitrary point), but I think the
offset (without units!) adds a layer of indirection that makes it even
more confusing.

I wonder how hard it would be to just take an arbitrary time instead,
and then you could write:

  check_approxidate 'January 5th yesterday' '2008-12-31 19:20:00' '2009-08-28 12:00:00'

or whatever. There is a chicken-and-egg problem with testing our date
routines and using the date routines to parse out the starting point.
But I think for approxidate, we could be using the strict parser (tested
separately earlier via check_parse) to handle the base time.

-Peff
