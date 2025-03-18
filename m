Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59063FE4
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742264498; cv=none; b=hbkXblnymIV572N6g4rqohMg51BRLAHmk8LjERTZWOBBFw7E3cul5GcmEOOoiMvOQ9YfBlF9uVWGKQCC5QBEyBWwgeBXLXjKKjGXM+C/Dm9F9M2eT84UDoNAz5VcfuElUd4bwovPWa8hXmRk86SJEa378J/196Z7uOB6/+iRUPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742264498; c=relaxed/simple;
	bh=CaWrkYBkWbXG8dVHFmLNxb5X3MhOn7cw+8oFGMQg7J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYwVavIJk2eX4dKkzUBfa5UxGzpla2rTKCks+p33Pu9BBSanC5BEH6fgqskL1Lu6j/+WadwNZy6YTLSg+P8cHzGlhgbn5S5C0fKqAO+byXmZ5Yfe8ERcQe+GMr66PPUZksnMMJBzJRbJxGOxpji4AFxolWwMvIoDRzNlG78Kda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=g9fBfbmI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="g9fBfbmI"
Received: (qmail 26902 invoked by uid 109); 18 Mar 2025 02:21:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CaWrkYBkWbXG8dVHFmLNxb5X3MhOn7cw+8oFGMQg7J0=; b=g9fBfbmI7wO04RKPFdOlmSQBifTQruUIgFNqy6UzBROJrrnjeHrLR9PbAfBvm6M4kbiisLf4GIAARPNCpag8hlch2K9zMxo2ZZgFrfRTtpt+80RKPMjKrD/46nDlzDEbqSPgJj4pk1p7pw1HNTNWKuaylgt0Kb/VzdsOKZWQJ2NJ/rE4rfvjMpH61NQ/oy7WsYSvSxRPLG2tP6LUXZiD4a3K+mfbLjjQyF6t0Hqu/+h9aIhzEaakLiGxyqxFqh/9081R09ohAhv5bh5dwM2+nvH4j9DGwjYAURWkZDGtfiIjj4b0gfWjeB13c4ofzSoeIviTpcaAjClH+FniKjv8ew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 02:21:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4008 invoked by uid 111); 18 Mar 2025 02:21:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 22:21:35 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 22:21:34 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 00/13] midx: incremental multi-pack indexes, part two
Message-ID: <20250318022134.GD1473033@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741983492.git.me@ttaylorr.com>

On Fri, Mar 14, 2025 at 04:18:12PM -0400, Taylor Blau wrote:

> This is a new round of my series to implement bitmap support for
> incremental multi-pack indexes (MIDXs). It has been rebased on current
> 'master', which is 683c54c999 (Git 2.49, 2025-03-14) at the time of
> writing.

I read over this and didn't find anything objectionable (I left a few
comments here and there). I think I've said this before with big
bitmap/midx series: the biggest issue is that it's hard to know what you
might have missed. Especially in terms of corner cases. So it all looks
reasonable to me (including the overall design), but ultimately I think
it's more fruitful to put it through the paces on real-looking data than
it is to try to go over every inch of the midx code with a fine-tooth
comb. And I'd guess the eventual fate here is for this code to get
exercise on GitHub, which would help with that shaking out.

So mainly I tried to look for things that might hurt the non-incremental
cases, and didn't see anything (modulo one or two questions about
micro-optimizations, though I expect the answer there is "nothing big
enough to measure"). So if this can progress towards the "shaking out"
phase, and has the potential to hurt only people who turn on the new
feature, that seems like a good path to me.

-Peff
