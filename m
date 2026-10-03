Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3231715A
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790989577; cv=none; b=LQrwye0uvFO3xQDbchXdRCfmaBVUAoMpt4NqcRu76ezOUDjtK3phqTvzWoWp3dZfhdgehCmreAepVjknLkcUprUC3vJVPVYqXztj63h5NIQDwo78EUEBNT5PCgpYqNxaPBgnQc/aaAa51uCXBQSWpbfMlPwYw7kwJvPpke6gLJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790989577; c=relaxed/simple;
	bh=k4VeAq36P8PRpm+Xu9SscDY9E8Mb6yCsn0k37uNLGuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spjt9W0itiu5ldqJ3yo4mjMKNP54So1NYc2rNNwObzDkymfSZxhEnCO2v5zH9JDUne7z6gCx+92er7MVV++xW/lwoFj2zzuK+RFtQW+ybmhd2CM96/88fdYKkot+c+2c0h++W7MJldxTfgEySsve66zG12UwQZTrAV9CUrQs1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=feJU49H1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="feJU49H1"
Received: (qmail 17123 invoked by uid 106); 3 Oct 2026 01:06:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=k4VeAq36P8PRpm+Xu9SscDY9E8Mb6yCsn0k37uNLGuw=; b=feJU49H1b6/pUKhe/bw/CxgtyNXpSyLMp7/48JE/8GWFP1j2zLOYYuto1phyLgANWGiraE2ReUUbo8isOdUVCA/za09iaPi88U+eJRNQAJI+VLSXyFWS4csgQPBRINDrWTxqt+wc5zGjfhLQBJEUxvv7alQ3erkrMBaNdsvLJCaGu9lm3VVUS3LWPgiybwhvEBtcQ9KlcoNyAAxe3s8N30h7n/rg35R2Dt6UiyjI0WBGAZc4Gt62cCBq6+ZuxnW5CvDthB3EfH2Y7xogeoCD5TC/OrFT66sBHh2YEhGHd+rzGThfLRfV2JO1ZYKg3SFhr/onMCrsKSsjDE4ZMlbJyg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 03 Oct 2026 01:06:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 50404 invoked by uid 111); 3 Oct 2026 01:06:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 21:06:16 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 21:06:13 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 2/8] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
Message-ID: <20261003010613.GA839051@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <940953e5c407046ac6789367f3341dc8ea73d07a.1790827875.git.me@ttaylorr.com>
 <20261002231336.GB834759@coredump.intra.peff.net>
 <asBShFkQRWJX4RQU@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asBShFkQRWJX4RQU@com-79390>

On Fri, Oct 02, 2026 at 07:55:32PM -0500, Taylor Blau wrote:

> On Fri, Oct 02, 2026 at 07:13:36PM -0400, Jeff King wrote:
> > So it would have made more sense to me to comment it there. Of course
> > that is hard when there are two such places.
> >
> > I dunno.
> 
> Yeah, me either. I'm happy to change things around if you feel strongly.

I don't. If there were an easy solution I probably would. ;)

> > BTW, is it safe to prepare_revision_walk() twice on the same rev_info? I
> > could believe it works, but I could also believe that there are hidden
> > corner cases, as I don't think it was ever really intended to work this
> > way.
> [...]
> Just as well, there are a couple of spots that I was able to find that
> already call `prepare_revision_walk()` more than once:

OK. That makes me feel like we're in good company, at least. If some
combination turns out to be a problem, we can deal with it later.

>   * In builtin/pack-objects.c::get_object_list() (with the exception of
>     '--path-walk') we call `prepare_revision_walk()` twice when
>     exploding unreachable objects as loose.
> 
>   * In reachable.c::mark_reachable_objects(), we also call the
>     `prepare_revision_walk()` function twice when given a timestamp via
>     `mark_recent`.

I have a feeling that least one of those is my fault, too. ;)

-Peff
