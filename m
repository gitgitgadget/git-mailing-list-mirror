Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A442304BB7
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169776; cv=none; b=eyghGjIFE/TdFF3fyBbw5quWgfa0jaLPNL9wcLI3WttQOv8Lof6Etbbuf3/FQ/k6vjrmoB4UCEtmsMAzOXdKp4BrmaK1ygC7Hqslv1Z7Rvp03ouTmelrEDWH3qDLi4WKJMYdWRrakE9qA+cCC1BcgmWhEJvzAghJDSPBUB8cdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169776; c=relaxed/simple;
	bh=H3pjZHH6kmU0zrRpf023ouj2aKOsTObWcPFD9GPA4tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyRNjxbHFJaPn+bYanBaxB2dPKa6p/mPrvEchHD+S+0osxX3TCdsY2UMHo2lbT0MFfjBy5E6OD2RZGQ8TvdqyuKGtXMuBYC3o0pndEqOrVuIB2YTEmHRuMwbUzx/rz7equBSh/DxnR7S7D4SHs7dZW8mRiiCUoeM1uCDsPmKBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HHsbs4as; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HHsbs4as"
Received: (qmail 107351 invoked by uid 109); 26 Nov 2025 15:09:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=H3pjZHH6kmU0zrRpf023ouj2aKOsTObWcPFD9GPA4tQ=; b=HHsbs4asjXL5llL1MnCAXWNBPTAFxKI0r5cL7K6az104G2u7KgVdGf/IQyifA17jeRM9UYQ5eB0QrpkRFxg2OJlNt2z869QHfCf9SWCECcj2in9JtpcbnTs9Dbf+hlGDiUan1hM2rg/UuY+HZJzY/FWPET5j2P+Lt4IzszFfV3P8+09elufQ1njo5jBlW9b4A3e2bQSqySAmE8kr5kKZ19sKtDsrt2XxM6xGAYo8L2oQ/rl7C74yl/LZsAORiLJrJgJxADfawybRu0fm7Qh/kahZphbxH5DhchtKyOTEaBrvRaEWLbw/HiLfK+hx0kAaUyGp/OXntQYYM9Yauu1cgg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Nov 2025 15:09:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 189915 invoked by uid 111); 26 Nov 2025 15:09:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Nov 2025 10:09:32 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Nov 2025 10:09:31 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/9] cache-tree: avoid strtol() on non-string buffer
Message-ID: <20251126150931.GC4143292@coredump.intra.peff.net>
References: <20251118091127.GA4175601@coredump.intra.peff.net>
 <20251118091218.GD529192@coredump.intra.peff.net>
 <ca6d99cc-d05c-49fb-ab3c-d7668077d32b@gmail.com>
 <xmqqtsylz2xh.fsf@gitster.g>
 <20251124223023.GA2051672@coredump.intra.peff.net>
 <xmqqms4buix0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqms4buix0.fsf@gitster.g>

On Mon, Nov 24, 2025 at 03:09:47PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Looking over what you wrote below, it seems pretty reasonable to me.
> > What do you consider unfinished in it?
> 
> Two things I am unhappy about are that (1) parsing the digit
> sequence that represents abs(x) into unsigned int while catching
> wraparound and (2) checking if 'val' that has abs(x) would fit in a
> signed int when 'negate' is applied.  For both of them, there ought
> to be a better way to write, and perhaps there may be a clean way to
> do both at the same time that is easier reason about.

Hmm, I thought both of those things were reasonably clever. The other
obvious way to do it, AFAICT, is to used checked-operation intrinsics or
add unsigned_add_overflows() before every operation.

It is true that for the general case of: "x = y + z" or "x = y * z", you
cannot determine overflow strictly from checking that x < y. But I think
given that we know "z" must be small, it works in this case.

It looks like you merged what I had into 'next'. Where do you want to go
from there? I am mostly content to let it be, but we can also try to
replace with something like your version. Or even, I guess, work on a
global strntoi() that could be used everywhere, if we think it is robust
enough. (Though technically that name is reserved by the standard, which
is a shame, because that is really what this thing is).

> Or perhaps introduce cache-tree-version-2 index extension.  If there
> are other things we may want to fix while we are at it, that would
> be a better way to spend our engineering resource, but I offhand do
> not know of anything gravely lacking there that we may want to fix
> (there are little things like how the pathnames are sorted that I
> regret the way it was implemented, but that does not motivate me
> enough).

I read your other email laying out the v2 concept, and I didn't disagree
with anything. It just feels like a bigger engineering effort and a
bigger risk that the transition does not go as smoothly as we expect for
solving a very small implementation problem. But like you say, I do not
have a laundry list of cache-tree things I'd like to fix either. I think
the transition being worth it would depend on that kind of list.

-Peff
