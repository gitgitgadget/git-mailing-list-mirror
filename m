Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A211DE2C2
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909903; cv=none; b=gmTmNGZ8+nmuzeg3OgS5xSnNGliFsFjT63dFvgBue1/0y96ulUwBaE9eOXMOufGB6K7VFAbx3Ysf/sAaOgqkpDZbvUfokA30DUrCmCXbYZr+nx6v8AOSSmGWQsV5D99aLlGnmTMuWouJdkweNOwmPAyBIs7plVbQ8CipQqGpcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909903; c=relaxed/simple;
	bh=dCESFRm10fLJ3UK9jQZ5QCEKwPuA7qYpMCIvpEsM4fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQzUQpfRIDRh9YcYUUUVsJDv3cg+H6HbslOKdUK04SK91Mf/+85U2bG3EWpmPRfU+2kUcVHqO2/RHk+UNy1u33ADRAXBExhwKeOQqQc5//dnTQVBT6YWGc1Jc9dxJDJGCISLvqj+5msJVS0QxNKv5uKul4C9l5Bu1WPTU8AZ/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YeKFEcv1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YeKFEcv1"
Received: (qmail 194053 invoked by uid 109); 3 Sep 2025 14:31:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=dCESFRm10fLJ3UK9jQZ5QCEKwPuA7qYpMCIvpEsM4fs=; b=YeKFEcv1izLsy4ksfvbgSqLHDogF8ySrD1VlCKxxuw5Xor69WJSKGriGHAEWVHxVd8/HsaJE6s9DCTOjIUOlBvCt/qckpPGFCO9XQyN8nnGd8AyzFlWw9Lb94rb/EP2/rZ+jS26vpnPUT9VVOeLl9NMF5a2oFLtG5Q4WWxfo+350mIBe5F+TJ+rOA4SLF9lV28wAdGMf9siGasNIwFSsDJNjK4TfwaXioV2uzKpeXALdozLF/BY5qRAHzJPFlVKGE2shdAWCd7JT4urKeSVxyCk6LkJqqSM75uEA8403f4v5I1veXhiY46ao4T/n8oeW0x5/I1hL3EEqMjlZ+7H7NA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Sep 2025 14:31:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 341841 invoked by uid 111); 3 Sep 2025 14:31:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Sep 2025 10:31:34 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Sep 2025 10:31:34 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
Message-ID: <20250903143134.GA1884731@coredump.intra.peff.net>
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
 <20250824103117.GA250458@coredump.intra.peff.net>
 <6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
 <20250825073403.GA332447@coredump.intra.peff.net>
 <cb192b28-d85a-4866-a312-df4408cae93e@web.de>
 <20250902123834.GA711442@coredump.intra.peff.net>
 <05b8e161-9087-4eb8-b049-6e99ff288af7@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05b8e161-9087-4eb8-b049-6e99ff288af7@web.de>

On Tue, Sep 02, 2025 at 08:51:37PM +0200, René Scharfe wrote:

> > I suspect it won't make a big time difference. The old code should have
> > been optimized down to a single word load, and now we have two word
> > loads and an xor. That probably isn't important compared to the actual
> > 5-word memcmp() we have to do in order to verify that we found the right
> > bucket anyway.
>
> I see slightly worse performance, but within the noise.
> 
> However, just stacking two words won't do if only a few bits of the
> resulting hash will be used to find a bucket.  We could mix in more bits
> and smear them all over, but if that's done by a deterministic function
> then it could be applied during the construction of manipulated object
> hash values as well, no?

I think the difficulty in manipulating scales as the number of bits
increases. So yeah, if you are worried about the low 8 bits, then
XOR-ing in another 8 bits is not going to do much. But your table is
only 256 items long, so you don't care much either way.

At even 16 bits, it gets hard for the attacker to choose the low 16 bits
_and_ the low 16 bits of the next word (you mentioned a project earlier
which claims 28 bits). If you XOR in a third word, now your 16-bit hash
is using 48 bits that the attacker has to control. And so on.

> Perhaps salting with a random value determined at runtime would help.
> Not XORing it in (pointless if the other value is controlled by the
> attacker, as the result would still collide), but using it as a mask to
> choose the bits to take from the object hash?

I think that would work, but XOR-ing the higher order bits is easier to
do and I think produces a similar effect. Let's shrink the problem for a
second. Imagine sha1 was 16 bits, and we wanted to create an 8-bit hash
to use in our table.  The attacker creates two objects with binary
hashes:

  object a: 10111001 11110111
  object b: 01001000 11110111

They collide in the lower 8 bits, but we don't want them to. In your
scheme, as I understand it, we'd come up with a 16-bit mask that has
exactly 8 bits set, like:

  11010110 01011000

and then picking only the bits where the mask is "1", we get:

  object a: 10111001 11110111
      mask: 11010110 01011000
    hash a: 10100110

  object b: 01001000 11110111
      mask: 11010110 01011000
    hash b: 01000110

So I agree that is hard to foil without the attacker knowing which bits
you'll pick. You've made their job 8 bits harder, because they now have
to control all 16 bits to get their collision.

But if we instead XOR the words of the object hashes together, we get:

  object a[hi]: 10111001
  object a[lo]: 11110111
        hash a: 01001110

  object b[hi]: 01001000
  object b[lo]: 11110111
        hash b: 10111111

So you're flipping bits "randomly". It's not truly random, but is coming
from the rest of the hash the attacker provided. But for any bit they
want to control, they have to control that position in both words. So
they're back to needing to control all 16 bits to get their desired
hash.

And as somebody who just hand-computed those answers, I can tell you
that the XOR one is much simpler to do. ;)

-Peff
