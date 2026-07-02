Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87535836E
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970654; cv=none; b=uhKzNFXeAWa9sKyQiMo4TbNXsuPRP6E0PorL2ZqFV/d6rruw0KICcytFO3tGEJoXQhbA0uxtoZoHtA1tQNwjmrWi6j8kwLP2vYCawLEIEr6QIoTw6cHon4ndUnvppJ2J2qxIveqy3/Pd4FQvCR40zgI5dPTwjRvQLO8sB4aU9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970654; c=relaxed/simple;
	bh=T6N1K9glA5DZJdPH0Ry30EGGaC6ln6q8sLCGFvgU0dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHkSI5QFXTRHxm24VgTeUSof/YKUEpKI7GHRGaiuRd0rEQOf5otclYdaKvNf5lETUKn2W3suMI4Wwbmtz5Z2kJqzPscPPj41/XfR1uZLajAZfmsAWOKCsrRx/tc41UCJGgMMKXucgMQW6siUztkxV15nbF+Yt2t9rZg/BkOi29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XjaIczVp; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XjaIczVp"
Received: (qmail 84797 invoked by uid 106); 2 Jul 2026 05:37:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=T6N1K9glA5DZJdPH0Ry30EGGaC6ln6q8sLCGFvgU0dI=; b=XjaIczVppGif3U5DnYL3HZDjA6RlGR/87kyB5Us4Mrlu2ivioSjEKP7RUED4022WKtvEO3r0vZkoIbJZq7uhgNHwukvur+9n7hJlqFrOOfyCXMs0Mm/7wd3k6qz1HLaOflgRjV5Xingdy/z91pd6xKk5CvnWaWhlcv9udYkICYWG7c+L9qQaX61I4XwodK7GYcknpa2xvKR1K95yOW16CpR9iRSVVfFvYg++RuicmYr/P8pxW5nD27dzcHsCwncB3I0+htDz6O389xWG3r+SlyF5A8c6vabEV1ZfmlXrIaIrgeQ8eADPcbKLB51wSHn0u9FbtvVyvaVJ5NofvxO5Tw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 05:37:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 176938 invoked by uid 111); 2 Jul 2026 05:37:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 01:37:24 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 01:37:24 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] t1517: skip svn tests if svn is not installed
Message-ID: <20260702053724.GA3437623@coredump.intra.peff.net>
References: <20260316220742.1286157-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-1-sandals@crustytoothpaste.net>
 <20260701212442.1430084-2-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701212442.1430084-2-sandals@crustytoothpaste.net>

On Wed, Jul 01, 2026 at 09:24:39PM +0000, brian m. carlson wrote:

> +test_lazy_prereq SVN '
> +	test_have_prereq PERL && test -n "$NO_SVN_TESTS" && perl -w -e "
> +		use SVN::Core;
> +		use SVN::Repos;
> +		\$SVN::Core::VERSION gt '1.1.0' or exit(42);
> +	"
> +'

The single-quotes in your inline perl will be interpreted as ending (and
restarting) the lazy-prereq snippet. So you actually get a bare:

  $SVN::Core::VERSION gt 1.1.0 or exit(42);

fed to perl (no quotes around 1.1.0). We sometimes catch these cases
automatically it results in an extra argument to test_expect_success,
etc. But here you are unlucky enough that it does not (and anyway, we do
not seem to have the same safety check for test_lazy_prereq; we'd just
ignore the extra arguments).

And of course being perl, it doesn't complain. I'm not sure how it is
interpreted, but I doubt the use of "gt" is right. My version of
SVN::Core is 1.14.5, which is (correctly) more than "1.1.0", but is
(incorrect) not more than "1.2.0".

I think the "gt" bug is inherited from lib-git-svn.sh (unless I'm just
holding it wrong), but the single-quote one is new (it happens at the
top-level in the original).

-Peff
