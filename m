Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773264A1E0F
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264824; cv=none; b=bRPlx/LcE6GuAap2YwjpubbtcVl8CRLeeo+n/OsSAGFQMqCpngJaJtr0kj938KMq7KjFNLlD3H5CHrES1pBym1iXjc9mqXa6WuM1vGCDvXKPvC/dc7YkIJzcUUWf/AeczNkOgfhI/+X35ST8Yj05PZu55Ijv3i31sLc6jGaGdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264824; c=relaxed/simple;
	bh=mvTLsL9Zws8/N1AcIBvhYPUk9T/yAZf6BaQpu47RjyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmrNKz3kMsTCmBeKhLv6kXzcsU3HtNyZ7ZBby6V8Sph1tlGFH3AhYU791oYpu6Mw1qHdmWbvXh+rIvN/Z2J9RvAUtrO02/t7am1p8TVQepYzM3Z89JzXGtoC8pUmexOrEgB8V6uZGQLqpKgOhL+rrTtsAnvY3bw++seu1FeIn+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=h4yaaAjZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="h4yaaAjZ"
Received: (qmail 48246 invoked by uid 106); 24 Sep 2026 15:47:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mvTLsL9Zws8/N1AcIBvhYPUk9T/yAZf6BaQpu47RjyQ=; b=h4yaaAjZuyo7r5EdFJT9XsREqZAJxjDDMhX0LiqffUsI8XmMF/9yBpOj+5ZFLzBL9eDKrc1hfTm6e/aEKW0ANlKmdqX3ZzAD+H2cMbsdxEeLuFKQwv/leQzX1ghpIvzZyekBH6qM4PQ/Q3mXxfKeHGCOKmG8oBZfAhXDKstsD0k+TSSpZDbP1A+/ZlJfdPIyXpfydVdh8cAsX1sC3sBU9vKRsO1FeQWElaKKCwcns0Y18s991Dt9GVs75vqfq+1l5c5AyPS+KjOQDa2XEcVoR+apdoX8EzsatrUGzvVAF6M6QmMz1kF9PN9edOmtgR91LhaV20Ev4B4llc708eYDZw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2026 15:47:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 193188 invoked by uid 111); 24 Sep 2026 15:46:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2026 11:46:59 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 24 Sep 2026 11:46:59 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	git@vger.kernel.org, r.norouzi@proton.me
Subject: Re: [PATCH v2] reflog: fix default expiry periods
Message-ID: <20260924154659.GA736248@coredump.intra.peff.net>
References: <20260922165433.591551-2-pushkarkumarsingh1970@gmail.com>
 <20260923102140.25475-2-pushkarkumarsingh1970@gmail.com>
 <xmqqpky3ahvo.fsf@gitster.g>
 <arUvtE67n5_MFM4C@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arUvtE67n5_MFM4C@pks.im>

On Thu, Sep 24, 2026 at 04:12:04PM +0200, Patrick Steinhardt wrote:

> > >  #define REFLOG_EXPIRE_OPTIONS_INIT(now) { \
> > > -	.default_expire_total = now - 30 * 24 * 3600, \
> > > -	.default_expire_unreachable = now - 90 * 24 * 3600, \
> > > +	.default_expire_total = now - 90 * 24 * 3600, \
> > > +	.default_expire_unreachable = now - 30 * 24 * 3600, \
> > >  }
> > 
> > and the fix is very straight-forward.
> 
> Is this something that we want to fast-track for Git 2.56?

The breakage was in v2.50.0, so it is not a new regression. OTOH it
seems quite obvious and low-risk. I'd be OK either way.

-Peff
