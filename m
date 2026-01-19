Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D52EC0B5
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768855215; cv=none; b=L0wKqHeF0fasn5Lg/EkgFn4ep/ovpG183ntgWA1DACEa+DKCwWSzijEySkmmYi49kr3uAZ9StsFkkKXf3F+dRZrttnxI3mT5s14dn5YOgn2afBnxiKAdkawVUFGonn1iHvgOHT3d8PFmn+NUiePsmdrnlnq/nGd9Qoqwhjdcajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768855215; c=relaxed/simple;
	bh=ohqyUPyghYvhhWnGIgDlIPNOlcxAFaq3OW0ctpZ2Y38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OE/qvCY4hBChzXCIWYpEZ5tARSvzkWH153D/3cl8E76Fns/M1dpAA8xMn8EOT+tEV/HAGNxJEEeyQXX0V3BDTM02vmOUh/e0Vu8t80Zs0y8Vay2cCrqTEpj1uhQxy+CQhI14Mbjg6aGkc/HNzu30It3h6ehDQWtcy1HkOaxaf+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=edcM/Xg9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="edcM/Xg9"
Received: (qmail 103555 invoked by uid 109); 19 Jan 2026 20:40:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ohqyUPyghYvhhWnGIgDlIPNOlcxAFaq3OW0ctpZ2Y38=; b=edcM/Xg9EmXyA2WpeG+lZy2xWiNVEuwbHhAFnEPK6rold6sXAL7/4n6iD9c5OFuqDQerQ+gorOCG2OjoMWJE94SY1E4gMthNhfxcARdslcETdWTw2fvwzvm+BOns3o/3pfi0pibsV7GU43oEWC9jSTd/arjBbEpcKLde7AOGkW6G4B1AMdTQomXWfty4ferWUzVxSd3G4ncfJKqwhCXgZsLrXfZU1gNLiTUpzmCxvV/3sJ3rm/WtUMIvB110ntkwS1s5mRmokV2tptZg1lB6zfbizpYB7I5xMP1C45pHFOwEP5BtxmfVGSz3hNKNPlZCZgxiyn0lDjls4hDKXoQRVw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jan 2026 20:40:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 165429 invoked by uid 111); 19 Jan 2026 20:40:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jan 2026 15:40:13 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Jan 2026 15:40:10 -0500
From: Jeff King <peff@peff.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
Message-ID: <20260119204010.GA3148606@coredump.intra.peff.net>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
 <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
 <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
 <6ae80903-3cc5-4017-9eac-0b3100b93b04@gmail.com>
 <20260119055947.GA3100271@coredump.intra.peff.net>
 <CAH=ZcbCXAB3vzRbyHkunQh09njyLk4WXvfLVxynXaswEkBv+DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH=ZcbCXAB3vzRbyHkunQh09njyLk4WXvfLVxynXaswEkBv+DA@mail.gmail.com>

On Mon, Jan 19, 2026 at 01:21:04PM -0700, Ezekiel Newren wrote:

> Ok..., is there a way to pad a field to the largest size needed so
> that this also works on the harvard architecture? If C isn't even self
> consistent then how are these structs going to be passed between C and
> Rust (which is THE point of ivec)?

If you make a union of the pointers, it will require the largest size
and the strictest alignment requirement. So:

  struct foo {
	union {
		void *v;
		uint8_t *u8;
	} ptr;
	size_t len;
  };

would be a single struct you could use to store a void pointer _or_ a u8
pointer. The one thing you shouldn't do there, though, is assign via one
union member and read from the other. So I don't know if that helps you
or not (I confess I have not followed this rust discussion at all, and
know nothing about rust/c ABI compatibility, and just got roped in on C
esoterica).

> Or do we just tell the arcane Harvard architecture "too bad" Git won't
> run on it anymore?

Minor nit: the Harvard architecture is one where function pointers are
not the same as data pointers. An int/char distinction can happen even
on more common (von Neumann) machines.

But I think we can rephrase your question as: are there real-world
machines we care about that will have different pointer sizes, or can we
ignore this issue for practical purposes?

I don't know the answer. I suspect it probably is OK for Git not to run
on the machines mentioned in that C faq. But:

  1. Sometimes there are subtle implications of undefined behavior that
     may cause a compiler (even for a sensible machine) to do unexpected
     things. I don't know offhand if that is the case here.

  2. There are some modern platforms in which pointers are a bit more
     opaque than just numeric addresses. For example, we've had a few
     patches dealing with questionable pointer usage to make things work
     on CHERI Arm systems. I'm not sure if any of that would matter
     here, though (IIRC, it was mostly that pointers were unexpectedly
     large and had matching alignment requirements, but all of them
     equally so).

-Peff
