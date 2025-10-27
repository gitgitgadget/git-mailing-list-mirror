Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006323EAA7
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575117; cv=none; b=CA1xU2mzSpVukSrZJAqGnDvLk9d33jXEiNjkKGZh+8GR6RgOKYs+OEshuO4TJXme7f5toFG2Ev3fxW5kfKwgdzQeoAltzBaJjmq0tF4FxZ4ZfDUm+QERWBJzlWudINO0IEB3rN6R2+9/vDBYbywHf006UDGGbM9q0z1Ea4V8gIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575117; c=relaxed/simple;
	bh=YWInHfzl+eSADgeRucDD5VJV20XwhC4j3iDq5YbNiu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPu18s06WaKUAyvM7zih5jkO7I4jH7Lzkzx12ufuPKh/8ekfczCfLRfREuV6SmmdvHQtF96AmdoWk2kEFdv7UDA5/y/WbBAHUkJJtLAzb8usW9Wo8JI9x8sNB048g7+guyjT1U1rfyxrT9m2y/ACpex5rq5dxutQPwzISCo8Rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=P4A/NLRk; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="P4A/NLRk"
Received: (qmail 357646 invoked by uid 109); 27 Oct 2025 14:25:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YWInHfzl+eSADgeRucDD5VJV20XwhC4j3iDq5YbNiu0=; b=P4A/NLRkDkYd0yVcbXXBAZHvb/jvZAjlp5qvY84TQpnIE6DbBgKLVH5Zn0G4FWuy1ems2OgLmAzsw+3WEsJMxfGuB0G/wcP/wv1JYMWp4LgY8x/aKntlu4bCyCMcZBNO0LF2SxKRxDlcXWEwwmJ0fnW1huJH9Y4mzz7i6mYwV6ZXHdgTYzISUyyZyXrcEIAU7YpZ6k44KdH1pN3HKWa7l5dzlsNWesKQpwQzp8V5ViWjb14sznxZKKnWcnAwg99v2trMVGFhVhuu+93461A9sMrVhTwe6hYTRgYKp+2BnU8bn/Dt1XjoJANWUXjX/oZjad8M9TyQW3IoJzX9yqZddg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Oct 2025 14:25:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 556265 invoked by uid 111); 27 Oct 2025 14:25:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Oct 2025 10:25:04 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Oct 2025 10:25:03 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/10] builtin/maintenance: introduce
 "geometric-repack" task
Message-ID: <20251027142503.GA2758515@coredump.intra.peff.net>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
 <20251024-pks-maintenance-geometric-strategy-v3-3-9b5b3bdb4387@pks.im>
 <20251025191550.GA279793@coredump.intra.peff.net>
 <aP8sJF45dHsVlgqt@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aP8sJF45dHsVlgqt@pks.im>

On Mon, Oct 27, 2025 at 09:24:11AM +0100, Patrick Steinhardt wrote:

> Interesting! I would say that this is an issue in git-repack(1) itself:
> if the geometric repack didn't lead to any new packs, and if all of the
> packs are already covered by a MIDX, then we still rather pointlessly
> regenerate the MIDX even though it won't cover anything new.
> 
> I wonder whether we want a patch like the below one? Problem though is
> that we'd also have to check whether any of the other options have
> changed, otherwise we for example wouldn't generate bitmaps.
> 
> In any case though, I feel like this is a bit out of scope for this
> patch series. Other strategies that write a MIDX behave the same, so
> this is something we can fix later on.

I agree it's out of scope for the series, but the racy test is new. So
we probably at least need to make it un-racy with a comment to address
the root cause later.

The patch you posted looks plausibly correct, though I agree with you
that some thought needs to be given to changing options.

-Peff
