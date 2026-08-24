Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5A137EFE2
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595786; cv=none; b=FqBaa5rlt98hNQkIm4WqsU43J2EeIvXVE/IB1qM76WXcKTUBm/kTT7qTHDwgg6LWkEjuGUHDQFYn2CRcOWN34CGUQXOYgW8Sn0zsgBfs/9fq7Qkf0Xk4zBHug/iGODaVIxeUGvFVseYFzy87GKKezy7jKrXrt3N64wXmweZ80Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595786; c=relaxed/simple;
	bh=z/OVsPpL3cPkaAPF4Qf0vneirJ+54e/h708i4vPcGaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acKcDwAYxAYOWid+Hr616e+8MpL+4Pkn7luA7/77rs8oCQ38zDW2/01tWvkvnFr1VtWEiNUEfjaSqEzLEsCXCuvrAOq/UoVJM8tLypjOfbKpp14+zlsBTfqB13iq/q0pn9J2wcNvW/r/iZDrJsMN3CVGRiS+0QUZmCBBTrLcR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OJRcLTXy; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OJRcLTXy"
Received: (qmail 115202 invoked by uid 106); 24 Aug 2026 18:23:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=z/OVsPpL3cPkaAPF4Qf0vneirJ+54e/h708i4vPcGaM=; b=OJRcLTXy5DRkBuEF6Rup+y4Wom9cLhuMi3+Yre30cAk/shdMXnzw4dbpIchf8iABGhx8aEwzsLGQxHk2D00V5zs1DNgbXkgPhahzujrryaLYvOusq5EjnFRDUjmVAKswXjTEQKCg0UJQ/e0CDxzAxLoaV3VYUT/gOGqZigY8I4647CODLuq44DmmVJ8HTz7ztQu1AauGhZeizZFRVSS4hglGDBmrY0WrxP11hFwO2YXYUp8Szy9uoVkMtuF0xQ85HLnFLIwiUKXe8KETq8hG4kjTQmjXIPTGHx9kIx8cgxRbJSySHznYbE9B8U3sh4krI3YTAT8mmPLNEu7y+lTPfw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Aug 2026 18:23:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 145725 invoked by uid 111); 24 Aug 2026 18:23:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Aug 2026 14:23:04 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Aug 2026 14:23:02 -0400
From: Jeff King <peff@peff.net>
To: Anselm =?utf-8?Q?Sch=C3=BCler?= <mail@anselmschueler.com>
Cc: git@vger.kernel.org
Subject: Re: Questions about --ext-diff
Message-ID: <20260824182302.GA177524@coredump.intra.peff.net>
References: <1c1567ec-c81a-45be-8b92-2c995dd34c16@anselmschueler.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c1567ec-c81a-45be-8b92-2c995dd34c16@anselmschueler.com>

On Fri, Aug 21, 2026 at 01:13:13PM +0200, Anselm Schüler wrote:

> I’m unsure what the purpose of --ext-diff is. It seems to me that custom
> diff filters should just always be executed.
> 
> Is --ext-diff a security feature? It seems like it isn’t, since git-diff
> will happily execute the diff filter.
> 
> Maybe I don’t correctly understand what a diff filter is intended to be used
> for. What situation would you want a diff filter to be run by git-diff, but
> not by e.g. git-show?

The external diff is free to do whatever it likes; it doesn't even have
to generate text output. It could open a gui window, for example. So it
may be surprising if you run git-log and suddenly dozens of windows open
as we walk through history.

For git-show, there's certainly an argument that it ought to use the
same default as git-diff (since we are showing about one commit's worth
of diffs in either case). I suspect nobody really though much about it,
and as git-show is implemented as (roughly) "git log --no-walk" under
the hood, it inherited the defaults to disallow external diffs.

For many cases, I think textconv is a better experience. It is less
flexible (you must be able to transform the binary into something
textual, which is then diffed). But because of that it fits more neatly
into existing commands. I may be biased as the author of textconv,
though. ;)

-Peff
