Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2112AD2A
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734710516; cv=none; b=kE2ZF+rUqlXzDG1VYfEmjGNA8XAU3o/NuA3p7NogNQgPKbT3u/QmJ1KnUNmzmw4p8iHFVs/onLC4J2/0RasSdqTHz1qrAq15E3lPHMkf4OG9pCHl52KDen5DALxW1ThNK8pmk30YZCqpcjkLMSMO3wn4ADOSsc7NDoq80sahVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734710516; c=relaxed/simple;
	bh=F38i9GRpBmlRTily38e2z8Y586Aoa4ke5t40Z3rxhqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6puAo7Lv9fwsi+WPTdXWGJGPA52Q3AP+nwD0n+z92V9R11LHXhQrggScXLZ0akeVipu3t1VyY7lYdYnLAGmLMN5HBKLhMDYCwK89xH4MjG8V+bT3jKxZVgA0qzTx63nMR5pnfMho/+PwTTShsfudDw20Rt/czlw2pBvzv998Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B8oxrAOA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B8oxrAOA"
Received: (qmail 13960 invoked by uid 109); 20 Dec 2024 16:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=F38i9GRpBmlRTily38e2z8Y586Aoa4ke5t40Z3rxhqY=; b=B8oxrAOAo3sAZHf24ao7ggSdEGcEBE6lEf8c99kuvMrc8MZapVo7tKmdgtuFRgKH7GHNZ7ZAepcJN2tH5gyUSWzgIUJQwDO39utQss2Eujq6jwetyGJvp1I0sbmFKjU4niIfT+BCOwLCxawUysVp9vUe+GmukfKhfnCQBZgkkoAupxt4OaUsl/1FJLJqw8f79xL2jjJXrxfKKV515tAkfANdq2j2T+ZgazzB8DjNNGElTSNWmZtf6mGufXbG4EqusSdBZDZamMelklFIucU8W17PAD40ghEc65e5NwWCIxDqVma/9vWscqrqunR5GOQa+ASicsC9Fm1PYkytul39Bw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 16:01:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18703 invoked by uid 111); 20 Dec 2024 16:01:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 11:01:53 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 11:01:53 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] prio-queue: use size_t rather than int for size
Message-ID: <20241220160153.GE152570@coredump.intra.peff.net>
References: <20241220084949.GA132704@coredump.intra.peff.net>
 <20241220085337.GA133148@coredump.intra.peff.net>
 <xmqqh66yfk89.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh66yfk89.fsf@gitster.g>

On Fri, Dec 20, 2024 at 07:27:18AM -0800, Junio C Hamano wrote:

> > Sorry, just realized that "diff --check" (and apply) complains about the
> > indentation here. It's a TAB followed by 14 spaces, instead of two TABs
> > followed by 6 spaces. I guess caused by me lining things up manually.
> 
> "git am --whitespace=fix" with or without "-3" corrects such
> glitches just fine, and "git am --whitespace=error" correctly stops
> me from applying such a patch.
> 
> What is worrysome is "git am -3 --whitespace=warn" does not seem to
> catch it (without "-3" it works just fine).  I do not know offhand
> if this is a recent regression or not.

Interesting. I noticed with stock "git am" (I sometimes "reset --hard"
and reapply my own patches because I made tweaks to the commit message
while sending).

Looks like it does not warn even going back to v2.0.5 (my stock "this
was a long time ago" version). Curiously if you accidentally try to
apply the patch a second time, it does notice the problem.

So I agree it's a bug, but I think it has been around for a while.

-Peff
