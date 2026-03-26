Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CFB42314C
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546928; cv=none; b=QVZwcUuNCmdWAV3FjKPCSU2Dp2dhOQTKt9N+DCS/9ZQV1CNdB8CAty9kxP6ROFb919BDMU9XhiNfDX7dd+QfZJbi7gFpaHAVtcOJN58gocnZOFt6oIWn2UZXBFVMUlQtAEuRmTS2SXBRfH/dmDaCrAHxgJUNk52y1Ph7ZUZEVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546928; c=relaxed/simple;
	bh=sPE4DJ+tNI/X50T/8nO7v1ver7zIKUgsuTGUtx3KKaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5rC+YuBHEa+ESstTFq+r5dN5iESx3I3rh9fy5QxcoS/gaw07eVMo0vqHrk+hERSfN8eew8utmr5pC6MnvcvsUxJfEZ5AzoGYbNPXWpqQoue7F2ZPSfqifdoWiydJ/P6IcnAY57sMXB7W2a6hK3j97VnMSswepEASC6m6A+OUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=h5UjTFUZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="h5UjTFUZ"
Received: (qmail 154869 invoked by uid 106); 26 Mar 2026 17:42:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sPE4DJ+tNI/X50T/8nO7v1ver7zIKUgsuTGUtx3KKaE=; b=h5UjTFUZYw/GzRbQ3r7m2lHGg3O18OoE8o6PN+t/dbyQRQ0wnXAPSg7bRJXHNQz9Kf/ty+vVb4m+shTAfRCVgdjqJ7BQSh3cK3MaTdlGPXVOnpNMEXFbERtUzdaHvDK6alBfmZGjFcp8YWfHvHSjMuNc4pchS1jyMndgAN3fpXBGEQx1o5Qq5zgZTCD+TO4D6OnfCsvUthTsnIJ/7gt3faDuSC3aBANCMyvxL8r4s2RnYLofWi6JQ5TRHUSFpwm2rvnXvZ8Ytgazu7MbwMYjjD7SRa34zGHeymn98Q4g/VANT6QmP8osgS/celeLReJeLDCXvD7Zhlh+vntQJeTpXA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Mar 2026 17:42:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 214768 invoked by uid 111); 26 Mar 2026 17:42:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2026 13:42:04 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Mar 2026 13:42:04 -0400
From: Jeff King <peff@peff.net>
To: Michael J Gruber <git@grubix.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] do not discard const: the ugly truth
Message-ID: <20260326174204.GC2447148@coredump.intra.peff.net>
References: <cover.1774537954.git.git@grubix.eu>
 <fe9c86af4825a81b2618ae8ffc8be12300058af2.1774537954.git.git@grubix.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe9c86af4825a81b2618ae8ffc8be12300058af2.1774537954.git.git@grubix.eu>

On Thu, Mar 26, 2026 at 04:22:52PM +0100, Michael J Gruber wrote:

> ISOC23 reveals that we mutate argv strings in place. Confess to this
> with explicit casts.

Collin and I looked at this one a bit in the earlier thread:

  https://lore.kernel.org/git/e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com/

I think it is technically legal to mutate argv strings (which is why
this doesn't segfault now), though I think we would prefer to treat them
as conceptually const. You do get a segfault with:

  handle_revision_arg("..HEAD", &revs, 0, 0);

which we fortunately never do (we do pass string literals, but never
with a range operator).

IMHO the right solution here is to teach the revision-parser not to
touch the incoming buffers. We do it only to tie off strings, which can
mostly be replaced with xmemdupz(). That's slightly less efficient, but
I don't think it would be measurable (it's one allocation that tends to
happen a handful of times per program execution, and the rest of the
parsing is going to allocate things like commit structs anyway).

I have some patches in that direction, but I haven't gotten around to
polishing them yet.

-Peff
