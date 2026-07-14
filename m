Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8193EB0EA
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014300; cv=none; b=mgCZMLiwQht2XxDS1dPpHVAeMFmy0o2WkwE8cTAQ7YqiFAoNWQ86g/F9tRhqxnBhzMugFKmRYpejWEIg0Hyo1AqKycfiLzOVhEQv1fo9q6p+5qXCztuNctNRa6qVlv1fAkJnaLp0AAOB2SNs9tT2/xTTJkbVAFfD/Df8LmFmfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014300; c=relaxed/simple;
	bh=ZIPU20w5+V/CrFuhSaTbjTtnkVys1HvEHsQyOK75K10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMTRikJYymPQ/zd/LnGLXLtzYpz+F6F0NCRbq2jYiAWQdnkaD0mfqeVFDPM/SAp0F42y7VUS2RSobEuu2R0hhyIlQNldYCT6Jnd8nyciNQEoCHaIx6NcII4qklRNP4ie4xVVFeC58cTcFiS60F/IXMQPSN21FElqE/F1/+XI5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Cw7gYUPA; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Cw7gYUPA"
Received: (qmail 21860 invoked by uid 106); 14 Jul 2026 07:31:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZIPU20w5+V/CrFuhSaTbjTtnkVys1HvEHsQyOK75K10=; b=Cw7gYUPAa/p1PHux728OIMKrsnE8tiP2rII0RtbJ96W4fQa7zasOKCGXaXo7hfTqOsKAm8niFrZAz50q+0NBeiOUW3mx32k/7CPj3Xq/JtpKF0dTDf862WoyCd/I3PsXZ6m6fJRxb2VivYPCuNi8mAHIsQm0NqMIYZfPQHzRjFMh1My12dOgnX504obk2uhAknjp8Oak6PlFnMF9dOR3et3eK+konXQoi1inQ3g9uhEyoCuK6VKcKHzs+WzJ7B8ZOiqMlYPxXWkRjNFNdnWP7b5s74PnBSYD0Zx6tg9xESD//EoHQhdOnmOjwMku6uRLOvKxOZys4gDfPYZnNO8OPA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 07:31:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 43146 invoked by uid 111); 14 Jul 2026 07:31:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 03:31:42 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 03:31:37 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Ted Nyman <tnyman@openai.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/2] packfile URIs: support concurrent downloads
Message-ID: <20260714073137.GC4058320@coredump.intra.peff.net>
References: <alVn7UWvdWRAG-Vv@com-76773>
 <xmqq4ii2wlo1.fsf@gitster.g>
 <alVs4JO9BNQrXsnO@com-76773>
 <alWiEXbP5vOcCJ7F@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alWiEXbP5vOcCJ7F@com-79390>

On Mon, Jul 13, 2026 at 07:42:25PM -0700, Taylor Blau wrote:

> As some background, my workflow for sending patches to the mailing list
> is to use a script called 'git mail' that effectively runs format-patch
> to build an *.mbox and then opens Mutt in that directory. I then review
> the patches one last time before sending, and then run a macro I have
> bound to 'B', which (effectively) runs <resend-message>.
> 
> For reasons that I cannot quite recall, I chose this workflow many years
> ago when it would likely have been more appropriate to use `mutt -H`,
> which does *not* rewrite Message-ID headers when resending.

You might have inherited the <resend-message> thing from me. I thought I
used it exactly because "-H" insisted on rewriting the message-id, but
it doesn't seem to now. So either I've completely forgotten the reason,
or perhaps the behavior used to be different.

I also like that <resend-message> lets me open the whole mbox and send
each message within a single session. But I never run into the issue
you're mentioning because I write my cover letter separately as a normal
email, and then generate the actual patches as in-reply-to (with some
script magic to pull the message-id from my sent folder).

So possibly my fault for leading you in the wrong direction many years
ago, or your fault for not following my sage advice to the letter. ;)

-Peff
