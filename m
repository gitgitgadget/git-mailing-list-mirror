Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C3DEED8
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 03:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776743299; cv=none; b=giNmIBOnbt5jcbmUQywvR1WEOJF+WS1xMLdjJQ5cayQaOQVHFaimTVy1EJhEJzW/iC5BPlQeTk2cDeLIkKrufWchNkk4kizUi0sQOqliwgqFtAVvEgLgyeDbo6GoZxPH8pOIpJx2s4BrwVklMtoN6mHSvpWB6+/9R7pUZSQz6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776743299; c=relaxed/simple;
	bh=0XFjD6L9gGA4Ju/PLxErE9BxfZ0FA8uqmsyloqU2rts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQIAkCO3qEb8mFxr5ZuTbVmueGzRxsxrm2rGATfdmzTxxWis1Up9j8C3cifWrGPaIN+MvqMFdTCqp+tv2fD+BNWarMtdI7rbF0s4q47Tqxqss2hrxYDEQmGvTEIEBK34RPnWeP6c1hdEXCILNfzgzWINuOjjqCdOexTPnhiok2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MZVEi/XW; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MZVEi/XW"
Received: (qmail 411395 invoked by uid 106); 21 Apr 2026 03:48:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0XFjD6L9gGA4Ju/PLxErE9BxfZ0FA8uqmsyloqU2rts=; b=MZVEi/XWibdHNBXxK0Ml7Vno4Zz0AJITfpbgrIj/AQZktuYJKkV/1FpgDntFnelGTJ7nIj7Jd8lZXbJAL0zdIZW65GhmqdBeWv7hpSKMAaJLCO3QK3Wp+07e8BXqrOQesvrSstzPss+/vzjjh0OYh/lZxVJabWPc+Dn2FV1lSqg1YzR2sLkdSb+DAvc/puzZs55J655Kx1pUcVusxElq6ciG+CyxkJi8wnWRfFujlJpj81Q2gQY0pwurjG/vVB7qaJyaouzcUPp4O3/3BlD5qyNcpX2PdXZHXFQ1r7dSCquVDBThDRYaN9vmiVORLIysykm7xdQgs+3lP7c36CrlZg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Apr 2026 03:48:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 941635 invoked by uid 111); 21 Apr 2026 03:48:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Apr 2026 23:48:16 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 20 Apr 2026 23:48:16 -0400
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <20260421034816.GA1883014@coredump.intra.peff.net>
References: <20260418164736.2367523-2-mroik@delayed.space>
 <C60EE993-97DA-45F7-89DE-2F97ABB0F685@gmail.com>
 <aeUZUqSQI8FvRUco@exploit>
 <CALnO6CACfSyzyguX4623Dk3y+QEM_Dbmfko8dTyM1p3JxBjZFg@mail.gmail.com>
 <aeUqSltEWIWaPDh3@exploit>
 <20260420002118.GB1238475@coredump.intra.peff.net>
 <aeXxC8eR0Mn3dGEn@exploit>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeXxC8eR0Mn3dGEn@exploit>

On Mon, Apr 20, 2026 at 11:33:25AM +0200, Mirko Faina wrote:

> > But we should keep "--reverse --reverse" working as before, as there is
> > no other way to countermand a previously-given reverse option, and
> > because it has always worked.
> 
> What about a triple reverse? That would mean the original reverse choice
> is lost and it defaults to the historical "after", which I'm fine with,
> but this will need some extra caveat in the documentation :')

If "--reverse" means "reverse after", then:

  --reverse=before --reverse --reverse

is back to reversing after. You could also make it retain before/after
if you stored that as a separate bit. I.e.,:

  reverse=before:
    revs->reverse = 1;
    revs->reverse_when = REVERSE_BEFORE;
  reverse=after:
    revs->reverse = 1;
    revs->reverse_when = REVERSE_AFTER;
  reverse:
    revs->reverse ^= 1; /* flip reversing */
    /* do not touch reverse_when! */

And then the triple-reverse takes you back to reverse=before. I'm not
sure if that is more or less confusing, though. ;)

At any rate, I agree that the behavior should be mentioned in the docs,
especially since "--reverse" is not a true synonym for "--reverse=after"
because of the override vs negation behavior.

-Peff
