Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1220DD51
	for <git@vger.kernel.org>; Thu,  1 May 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117505; cv=none; b=SXazzqoKoNPCUCq4OAQvbrC/vGvFjF03J0xv1b/nRnuD4Ru0eBPs6Y+rvZMPhwNAfh9d90z17etMtRF7X+jJXLpl3C6ezCO/qXa/us3z2UZStDw03/Eyuh2liG0GU+UpTUP04o8phA+tYB9vm8Vs6kym9iXJPECRNChpbgn3NqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117505; c=relaxed/simple;
	bh=Cb+utMdVHrrSLSXee0NUJ301Ok/sAmTKbAgtQVmahRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRADcR7MVmrazri0C4+d40+zbswh4vW03DLvgIcjCBEU/A4kxEK1x21+LYHJXldW2uF5fnsDvC1DmzUhGlk8cp5mUaNTM55FZAxawm55P+itkeGDw+SK/+a27BSxy30JDIj/AxiFDLU9fie22bsWrYFzUu9mlFMyFvVxEyZxlSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aBsQsfha; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aBsQsfha"
Received: (qmail 24865 invoked by uid 109); 1 May 2025 16:38:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Cb+utMdVHrrSLSXee0NUJ301Ok/sAmTKbAgtQVmahRo=; b=aBsQsfhasS7O8RzAjZTFDZyM6DWxPNTG+1EguMMD17gAh7YmT7RXfCzX9N3TX3s7tVA7RlFv7xYjO1+Go+RTxeBC82mWqptOCByuMSuH1bfW4GUilowFC1fDRB9mfe6PjewBz0wKpKPNDHKK1DpGCW78dSiiIlqlYCNvppngyG50s9rxkzSfPhOey+42QZYjnKinKcOG0zoWTfSFbNvILCV37w307vmyV8uiWXvtS/5ebtScUF63gV8IZSGwfLqneZFGDCcvnbeiggcz4B58v7xbzAPgL56JLSdk54wlL3hSttfbefhoirSyE5ciz6nx9SsLFUTs22Sej6xDxI9VKw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 May 2025 16:38:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8936 invoked by uid 111); 1 May 2025 16:38:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 May 2025 12:38:23 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 May 2025 12:38:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [BUG] rebase: can write reflog with uninit. `action` string
Message-ID: <20250501163822.GE1795346@coredump.intra.peff.net>
References: <20250428194048.149348-1-code@khaugsbakk.name>
 <ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
 <fbc97d6a-2022-4a64-a2ba-5a7255cd81a6@app.fastmail.com>
 <20250429215155.GA36727@coredump.intra.peff.net>
 <6743a9fc-11ca-45ac-bc40-4148f5d85d27@app.fastmail.com>
 <20250501131751.GA1725607@coredump.intra.peff.net>
 <xmqq4iy4z55h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4iy4z55h.fsf@gitster.g>

On Thu, May 01, 2025 at 09:07:06AM -0700, Junio C Hamano wrote:

> >  	va_start(ap, fmt);
> > -	strbuf_reset(&buf);
> > +	strbuf_release(&buf); /* guarantees realloaction */
> 
> I initially thought that this comment may have to be updated in the
> production version, but because we have to freshly allocate for each
> new message for ownership change, this comment still is correct.
> The only difference between the "here is how to expose" and "this is
> part of the smallest solution" is why we want to guarantee it.

This code change is just to stimulate the bug more readily. ;)

I think if we started to actually allocate here, we'd want to switch the
"return buf.buf" at the end to strbuf_detach().

-Peff
