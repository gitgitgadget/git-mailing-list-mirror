Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FEDFC01
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710482388; cv=none; b=G3VKoYRG/V2Uyju/IH33Q2byQRQZsAzmIJ4J8pTCmGhqHjF2U/jk0FuxtaXCL++ApaSalIe4hPV12qe/T1zuMvdPEmjZO24bgdJPU56XyIoXgPtulWy4/9Ua3AciVqQG7g9azgRijmFXfDC4si+6o72F144QGk8pgwwCgDxBRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710482388; c=relaxed/simple;
	bh=VS02FBDYMGpKbrFvYmB0vLgmg7h0nV5eTuMN8B9y1s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDc6fGB69vCGORLgtBBU2kwTgRRMYGprblu2XK05cdEyg91wI9EZGXtw/Op66hb9GA4teQTquG5/8drBZ5cXyBNmej58Cm3U9WT2Qwrkxesv9dRuaR2nE9NimgFiyMWy0CwQii6mlMiDm3TTg8idLa8pEDQRJ10uG9ZIVn+X+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23007 invoked by uid 109); 15 Mar 2024 05:59:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Mar 2024 05:59:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28649 invoked by uid 111); 15 Mar 2024 05:59:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Mar 2024 01:59:48 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 Mar 2024 01:59:44 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 16/16] config: allow multi-byte core.commentChar
Message-ID: <20240315055944.GB1741107@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
 <20240312091750.GP95609@coredump.intra.peff.net>
 <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>

On Wed, Mar 13, 2024 at 07:23:25PM +0100, Kristoffer Haugsbakk wrote:

> Thanks for your work on this. Now I can use dingbats as my comment char.

Truly we have entered a golden age of technology. ;)

> > @@ -523,7 +523,9 @@ core.commentChar::
> >  	Commands such as `commit` and `tag` that let you edit
> >  	messages consider a line that begins with this character
> >  	commented, and removes them after the editor returns
> > -	(default '#').
> > +	(default '#'). Note that this option can take values larger than
> > +	a byte (whether a single multi-byte character, or you
> > +	could even go wild with a multi-character sequence).
> 
> I don’t know if this expanded description focuses a bit much on the
> history of the change[1] or if it is intentionally indirect about this
> char-is-really-a-string behavior as a sort of easter egg.[2]

Mostly I was worried that people would take "char" in the name to assume
it could only be a single byte (I had originally even started the new
sentence with "Despite the word 'char' in the name, this option
can..."). And that is not just history, but a name we are stuck with
forever[1].

Certainly "char" is an ambiguous term, though. I didn't mean to leave
char-is-a-string as an easter egg; that's what I meant by
"multi-character sequence". Certainly "string" is a shorter way of
saying that. ;) But I wasn't sure its meaning would be obvious without
the word "multi-character". Giving an example as you suggested does
help that.

That said...

> Maybe it could be more directly stated like:
> 
>   “ Note that this variable can in fact be a string like `foo`; it
>     doesn’t have to be a single character.

I actually do think the "string" nature is mostly uninteresting, and I'd
be OK leaving it as an easter egg. What your suggestion doesn't say is
that multi-byte characters are OK. But if we think people will just
assume that in a modern UTF-8 world, then maybe we don't need to say
anything at all?

> (Hopefully UTF-8 is implied by “foo”. Or else “føø”.)

It actually does not have to be UTF-8. If you use an alternate encoding
in your editor (and probably set i18n.commitEncoding to match), I think
everything might just work. (Though to be clear, I think anybody using
non-UTF8 in 2024 deserves our pity either for being crazy or for being
stuck working on an antiquated system).

-Peff
