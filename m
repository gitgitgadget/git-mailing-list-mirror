Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17C84A35
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771310050; cv=none; b=K8dzo82rWsGCkgbMUoOnOTi/HBqxIa57JK7jk0UNpidnven7HbDcTzLw/ywSzmhbOiqUUhrDnjP1grME0Y+9m46VSAyLkj+lu86GGPvbKNpOZ0pGNfUz3k86ExWZb0llJ1X3W9HZUVDgZYiajYd3T/wlxY64522LKY77Ojced8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771310050; c=relaxed/simple;
	bh=sz2lTenBACY/GjWsgmcmY84pDKBeJdHpar8oFawNYDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn1Z507WHLj49lhxkgI4iZwJ3mhHB0+qYxBgcXcuTWWkyFuvZtaQMWo4VxHcSJYBhTD3uzPsu6luxF5CaO+U9OzaGxUeLqnDzmWYFPgm4+LCPsOdlhOBZdnTNHSGpnZ+kPLXuIqWcz4bLa4Wht4r0YZqf6YbmRUxcYBitcFcS/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fNUYDvRi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fNUYDvRi"
Received: (qmail 60213 invoked by uid 109); 17 Feb 2026 06:34:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sz2lTenBACY/GjWsgmcmY84pDKBeJdHpar8oFawNYDk=; b=fNUYDvRiKTky6mw3YxqcadhVGPo6UtDq7bk8Sz0vhqoAWRC63JKVoLVeCdexNYK7hR6Rp2e9czoNWKksvjnGpcgue8OGfiVSeg8Y+EV/J4bZJwNnarUibK1JgF49GsE2lRIXcvLqYgYHKE66IPxZQoGzIrY8ZO9mNmyF/tapjoglyjct9khmDdYf7huQGFdOqOJKw4d1LsgKXKpH148fDQqFy/A+8pC/iC3fZsEF7cknTLq5kt/dWB27RqlvoiNtht3zHrqam3D8eN011ymgWxUVjw7VWYODWD16k4YZ5O4LxK6XTIGn1iWn5qFRc9ZifhxT409mLMymQtTErFHUfQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Feb 2026 06:34:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 151270 invoked by uid 111); 17 Feb 2026 06:34:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 17 Feb 2026 01:34:05 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 17 Feb 2026 01:34:00 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Mirko Faina <mroik@delayed.space>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] format-patch: fix From header in cover letter
Message-ID: <20260217063400.GA101988@coredump.intra.peff.net>
References: <aZAMr6XOwKkTa55q@exploit>
 <20260216152730.37478-1-mroik@delayed.space>
 <aZQJEDyUyMv4_c1l@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZQJEDyUyMv4_c1l@pks.im>

On Tue, Feb 17, 2026 at 07:22:08AM +0100, Patrick Steinhardt wrote:

> One thing that made me stop though is the folowing sentence in
> git-format-patch(1):
> 
>   Use ident in the From: header of each commit email.
> 
> The option explicitly mentions that we use "--from" for the commit
> emails, only, and that may be read as implying that it's not used for
> the cover letter.
> 
> I don't really know whether that wording is intentional, and I cannot
> come up with a good reason why it should be. But I'd say that the
> wording is something we should adjust.

I think that wording comes from me back in 2013, and I just never gave
any thought to cover-letter generation by format-patch itself. I never
use it (and I probably forgot it even existed, given that most people
would use send-email's cover letter generation, and I do my own thing
with mutt).

So I think the direction of the patch is good, and I agree it would make
sense to clarify the documentation.

-Peff
