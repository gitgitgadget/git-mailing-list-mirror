Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7C2283142
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784448484; cv=none; b=UeSeMZ61mIGhfZH836nuj+K9NENbv7v1MtZyPM9jJ+qEwPMwmg0IbP6HOQIMdvhWT3zcAzLtqHqAnhro+12RsUGW8BOBWIdDY8dciZWy7nLD2DB5KMLg0nHsDnNH1EZDhymb09+Ag2yCxDmHEr4SLSawXCB2zSNwRLnECFUnzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784448484; c=relaxed/simple;
	bh=cvFB6F2bl6P39h5mb+56cJAeyGqbPP0ryHkboPEYJbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1PO679WhV0wZPxZTlR3rLt2B59TunakYraK5tj2YG4UlvsC+1nfNduhbREnkIELH8EiybM1v1FEmPs0zZEpSpm1hOdx6gnPRsS01nXX2WZ6UsH2PqxQrZQytuuoQxKn9BQ5gHRWiuSg4Ui18QblhYjqgzJh72cJiyXWzBOKJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AWrMBgaT; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AWrMBgaT"
Received: (qmail 70774 invoked by uid 106); 19 Jul 2026 08:07:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cvFB6F2bl6P39h5mb+56cJAeyGqbPP0ryHkboPEYJbA=; b=AWrMBgaT2+PQGLhmpY+3Uv7YQt3RF3FwNLx10+JA64d4Y14srWxAvj7BlkUjPjE7wDfJJXWi72P++OEIiT5fIyMo1IISqnHiiNSpPONPqdbzC3J0MAE+mfXUryJZRqpr+4P5mYo0GYdTtY2FGVJJmIwfufPIcutyK732mrNQJhVs95pHNf9YvQldN26+bo8oayxEI9zY9Y5PMi6fjgP6Hl/1IfFMvhcJ5fJxGvtn61sty0vmQGPluN4HtEgb6VuVUkSnejx0lm1UGea533B/rtNNwvrfWvCvXh7/+dgK1UTUKv5kj3yqxCogqU2SKJu8aVdvH/tI9J2qMKlRLQy8OQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jul 2026 08:07:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8373 invoked by uid 111); 19 Jul 2026 08:07:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 19 Jul 2026 04:07:57 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 19 Jul 2026 04:07:54 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/2] Rust hash cleanups
Message-ID: <20260719080754.GA429688@coredump.intra.peff.net>
References: <20260719010842.17991-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260719010842.17991-1-sandals@crustytoothpaste.net>

On Sun, Jul 19, 2026 at 01:08:40AM +0000, brian m. carlson wrote:

> Peff recently sent out a series to fix several memory leaks with our
> hashing code when not using the default block algorithm.  This series
> follows up with a few fixes to our Rust hash code, which calls the C
> code, to fix various memory problems.

Both of these look good to me (modulo my almost-zero knowledge of the
Rust bits).

I was worried at first that I had introduced new problems with my fixes,
but I think these are both pre-existing issues (really just variants of
the cleanups I did in the C code).

For patch 1, an alternative is to switch git_hash_clone() to _not_
require initialization. But it introduces the leak problem in the
opposite direction. E.g., hashfile_truncate() wants to overwrite
existing state, so it would now need to discard() before cloning. I
doubt it's worth the effort or risk of regression to save the tiny bit
of effort spent on a few init-then-overwrite cases.

So the approach taken here makes sense (and obviously this is just
following the C code's lead anyway).

-Peff
