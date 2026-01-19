Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C2D2367D3
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768802390; cv=none; b=TTBmNF9IBHBF42ZhXSWNye/6OTeeExxoz2OU6KZxpFYUgPQQs4+kE+m+hVp7keHxevmppnrvNUTPLuzsJjsWsBbBS3DZNXw+dutliqqM6ybrG8T2gW+3qqgt6+Adcdcig2r3SApDkPkc3+ab7mgEwY0asSoMQLoE0oh5/lx4VVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768802390; c=relaxed/simple;
	bh=BcoP3tDq+mHFnJK+r1o3UDSAQrpnTxKh1Rh1kU6KxGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1rJ/ng+u3EeDKkRcgugmgmTgQFhAzb1PbxgHBuc6vu1RCkYDZ+14u+9pL7TmlzB0NaqavkxS0syfecq2/Gxn1e3iO2srzQV2BYyIQDKpioghYQ566YQ/ggGUajGBO1DtbHA4mD5hWh9gQnF/6rUTQRzjjzoqNSy1UA5E06oBk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iNMHpH/+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iNMHpH/+"
Received: (qmail 95575 invoked by uid 109); 19 Jan 2026 05:59:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BcoP3tDq+mHFnJK+r1o3UDSAQrpnTxKh1Rh1kU6KxGs=; b=iNMHpH/+C9M5qJeEgqsv3dLdWDUysCEJrvDox2+1GnQH2AqcuekSEcV8M/1zI8WhqtrB7xjLiu/AxjISCXEda+Ro+UOqOAJFQ07Ok45aTqNfBzQ4oinHYhZgo4S+QkWS2/KQO2VmkL7PMV+aJFxTgm1IFbVU72RZSYebtt0QbcAKtsIrp7X1b5VszT46rAHOavMP8u75RHwBIIT6U/9Jxcr+iEsNvoUOPrkT1HWUi4fm5SFG9zI/sKkupT8EELNu72TCWbosL3TQAhkWYIiGGGWKw1Ks1MI68rng/AiYnkdmt6Ao5TxjqM+ybZxiJZxRTktmy4pPuDSw2Vh2/oGweQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jan 2026 05:59:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 154431 invoked by uid 111); 19 Jan 2026 05:59:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jan 2026 00:59:51 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Jan 2026 00:59:47 -0500
From: Jeff King <peff@peff.net>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, phillip.wood@dunelm.org.uk,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] ivec: introduce the C side of ivec
Message-ID: <20260119055947.GA3100271@coredump.intra.peff.net>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <adf1395d201e916f23accc7644d21aff4f58368b.1767379944.git.gitgitgadget@gmail.com>
 <0437b899-5a36-4499-a30a-c2a074a80f7e@gmail.com>
 <CAH=ZcbA_HgEO2T2smn4Yg6gf4sm4jrR8A0ek1v9nqsa1MXbRJw@mail.gmail.com>
 <c2d9a432-0753-4786-8de9-c3dcfe69ac36@gmail.com>
 <CAH=ZcbAogCpqg0RkKg1WjuAcuKyArDs4aP+k=McCs_byDT2Weg@mail.gmail.com>
 <6ae80903-3cc5-4017-9eac-0b3100b93b04@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ae80903-3cc5-4017-9eac-0b3100b93b04@gmail.com>

On Sat, Jan 17, 2026 at 05:40:08PM +0000, Phillip Wood wrote:

> On 17/01/2026 16:14, Ezekiel Newren wrote:
> > 
> > If the size of different kinds of pointers ever differed from the size
> > of void* then wouldn't that make all calls to malloc undefined?
> 
> I believe there are (Havard architecture?) platforms where function pointers
> are a different width to data pointers, and that's why you cannot store a
> function pointer in void*. I agree it would be weird for char* to have a
> different width to int*, I suspect the restrictions on casting from one type
> to another are about alignment.

The standard does allow for different pointer sizes for char and int.
The key thing is that a void pointer has to be able to represent any. So
you can cast a smaller pointer to void and vice versa (and the latter
would presumably throw away some of the bits, which is OK as long as the
void was made from one of those smaller pointers originally).

More discussion at:

  https://c-faq.com/null/machexamp.html

I don't know how malloc worked on those platforms, though. The caller
knows that malloc returns a void pointer, so it could cast to the
smaller format in the usual way at the call-site. But I don't know how
you would tell malloc() in a standard way what type of pointer you
wanted to get out of it. I suspect they may have had specialized
allocation functions. Or maybe it was enough to just throw away the low
bits if you only cared about a word-addressable pointer.

At any rate, yeah, I agree with your original concern that the two
structs are not compatible. The layouts could be totally different. And
not just due to pointer size, but IIRC pointers to different types could
have different alignment requirements. So:

  struct foo_void {
	size_t len;
	void *ptr;
  };

  struct foo_u8 {
	size_t len;
	uint8_t *ptr;
  };

might need different padding to properly align the pointers. In the case
under discussion the pointers are always at the start, though, so I
think it wouldn't matter.

-Peff
