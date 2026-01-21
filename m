Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6608C335097
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769030428; cv=none; b=IY1RdCiTdRzixCQsaMLGXTINCHCtzIjFC1ONBk6bV3Izh3oSkxTM9AvTpkLrmSxEZb55EczbIsATG0l0eIs8xMRbars8gLp22boXuuRctdXRbllRjnf8/+HukdT9Qejd/PSz0L+3Zbdpk9XyaCwccqkg9MrejB3M0TIuwQP3l44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769030428; c=relaxed/simple;
	bh=v2yVHONp9BTOac1ASNRU7rJXDVlsOWT1K/9XSP/CW14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5MY6Q4HGgmg85njnao/QOECHPjpzqVQaNqqFW4exdeJrRbMjLro7M/Wp20fT0gid3q7CXR2HwL4Vyfugvu5XCnuxsS+9Tj73Pstgs33bFz3hpocsjNp+H8m4eS7wGeL2myg60bvXexdB/Hb60ncMnC5LqLTXoVglaZ7Ba6NP8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MOsTSaQG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MOsTSaQG"
Received: (qmail 123844 invoked by uid 109); 21 Jan 2026 21:20:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=v2yVHONp9BTOac1ASNRU7rJXDVlsOWT1K/9XSP/CW14=; b=MOsTSaQGy3cwkb9BsMbaxUBKHU2NqWe1w4PpjNtpCq8rANpyCJI6SYITikposWEzvizTMCgYA6KmvMda9YlVgUlzi/WPNBKddWqA6viJRxutGMQzGk/Y/c2coa+gElXic8trqnLBz0LQYel53QrhDYnWUcJM091rXpg7Dypskz8zCnSp3rdKduQP9sabM3L+M5HlZryFFde584Tuvy9cjUi8Yr3S4Dy+FpT8OsKi+CInocf9d8NlVlErE93Ekc8WoMkIoR2nuPGZpXc1sSca8LC6cQs+Wcek+Vj3d2u/rz5jGGSYVEfB7CllggA8B4NrxERvuYS30VMGErSrI4ALpw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jan 2026 21:20:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 210733 invoked by uid 111); 21 Jan 2026 21:20:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jan 2026 16:20:26 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Jan 2026 16:20:24 -0500
From: Jeff King <peff@peff.net>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
Message-ID: <20260121212024.GC723458@coredump.intra.peff.net>
References: <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
 <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
 <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
 <6ae80903-3cc5-4017-9eac-0b3100b93b04@gmail.com>
 <20260119055947.GA3100271@coredump.intra.peff.net>
 <CAH=ZcbCXAB3vzRbyHkunQh09njyLk4WXvfLVxynXaswEkBv+DA@mail.gmail.com>
 <20260119204010.GA3148606@coredump.intra.peff.net>
 <CAH=ZcbCNeYATxqAeXcGd9kkHzJq2y5BpMrChSzb215EHAjHsbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH=ZcbCNeYATxqAeXcGd9kkHzJq2y5BpMrChSzb215EHAjHsbg@mail.gmail.com>

On Wed, Jan 21, 2026 at 02:00:15PM -0700, Ezekiel Newren wrote:

> What about adding clar unit tests to make sure that different ivec
> types have the same size and layout? e.g. sizeof(IVec_c_void) ==
> sizeof(IVec_u8);
> sizeof(IVec_c_void) == sizeof(IVec_u16);
> sizeof(IVec_c_void) == sizeof(IVec_u32);
> sizeof(IVec_c_void) == sizeof(IVec_u64);
> ...
> 
> As well as other tests for ivec.

I'm a little hesitant in general to have run-time tests for properties
around undefined behavior, just because the compiler is allowed to do a
lot of tricky things when we get into that territory. Plus it is not
really _solving_ the problem, but perhaps just alerting us slightly
sooner than the production code itself crashing and burning.

You'd also need to check the pointer field sizes directly due to
padding. I don't think it's sufficient, due to padding. If one pointer
is 4 bytes and another is 8 (for example), but the element afterwards
requires 8-byte alignment, then the compiler will have to insert 4 bytes
of padding. And the resulting struct size will be the same. You'd have
to more directly check that sizeof(uint_t*) == sizeof(void *), I think.

So I dunno. I am not a compiler expert, nor a rust expert, nor really
know anything about rust/C ABI boundaries. There might be no problem at
all here, and I'm only commenting on what I know is possible (albeit
unlikely) from the C side.

-Peff
