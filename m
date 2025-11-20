Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA3310620
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627012; cv=none; b=Z7slz12sHwYSOC9cpKymYzEqIq2yJziQHsMPjkcnNclvYYcbaKAtcm1TbjAz6ZTxz2LpN/HbKw03SG7G93RolJiv3RO3bqrrRtPXLBhX3+52WnwiYznzUCsTUtpjetrGU4K9qvMEJnI1qJvpYGsfV6P0FFyGhKUMYNr8EAxGpxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627012; c=relaxed/simple;
	bh=DLD+sVBrfoyCcDRv80Oj0FZRO8JLOCdCki1qIs+KeFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le+WBUfpuf1Ltj5jagFCuMkfXHAVyRqGBovfK+QSrTEWmgsvE5a1LFYNqIJ9gagGMpXgRDLtmvO2hpek+sVh5e/w7q+JAB6tgK2igxgHm+EY2OtzyWFqPdlDrmL112Nv5H+QLUPXMpVpznW4jN5iXswF1lHYj+/w7oGiPKLBwn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JuzrozjY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JuzrozjY"
Received: (qmail 41748 invoked by uid 109); 20 Nov 2025 08:23:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=DLD+sVBrfoyCcDRv80Oj0FZRO8JLOCdCki1qIs+KeFs=; b=JuzrozjYqrGIrMj2Z1RvO6/ZDNxl3TyKhrLV5zgiDG1b8eFy9opV4K6r3yvIXQD3Gk0XJ/jTj2Q/dT+DNtepauGqYKIUbWnd73gkz90P0l5Z4+BTlgux0kuy1Z3d2RcnHRvEgmhyMjITN2hKj8aud0aKvor+H26sr4wQzKvKq2TeOBHFlNmtXAAYyoH13UPx03+GyMOcaySwpbTVM1RYN8aJ+ITGaRzqIc3RJzBuNu5F9yGrWwh5tZM6GOKZAH5A7z7LfgaWnwrr20mLipB+uUmmLdrnVATwErIGsaoZk2XhkC0GYxjsZYlG3G0AP0fh29c+WtXPT3K1e2ftU4t3Qg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Nov 2025 08:23:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 62543 invoked by uid 111); 20 Nov 2025 08:23:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Nov 2025 03:23:33 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 20 Nov 2025 03:23:28 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
Subject: Re: [PATCH] wrapper: simplify xmkstemp()
Message-ID: <20251120082328.GD1283645@coredump.intra.peff.net>
References: <058c5722-30f5-4bc5-90f5-24e4c6f3ff8f@web.de>
 <xmqqbjl0iax6.fsf@gitster.g>
 <20251118094621.GB530545@coredump.intra.peff.net>
 <3b1cb53a-6427-4626-a768-1961e25514f8@web.de>
 <xmqqqztvc51s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqqztvc51s.fsf@gitster.g>

On Tue, Nov 18, 2025 at 03:08:31PM -0800, Junio C Hamano wrote:

> When somebody asks:
> 
>     On this and that platforms, mkstemp() is natively available.
>     Why are we using git_mkstemp_mode() instead?
> 
> after seeing this patch, I am tempted to say "Why not?"  Are there
> legitimate answers to my "What not?"
> 
>  - the platform native one could be more performant?
>  - the platform native one could be more secure?
>  - using the platform native one, we can lose out custom code?
> 
> None of the ones I can come up with offhand sound very legitimate.
> 
> One upside might be that doing so would make the behaviour more
> predictable, in that even on a platform with native mkstemp(), we
> would use the same implementation as what we use on Windows.  But
> I do not know how much upside it is in practice, either.

I think predictability cuts both ways. The system mkstemp() will behave
more like it does on the rest of that platform, but maybe less like Git
on other platforms. Using Git's implementation will be consistent across
platforms, but maybe inconsistent with the rest of the current platform.

I think the "consistent with the rest of the current platform" ship may
have already sailed, though. We already use our custom git_mkstemp_mode() on
every platform for most tempfiles. And now even those few xmkstemp()
calls will do so (after René's first patch).

My suggestion was mostly: if we are going to use custom code at all,
then let's at least do so always, and not ever use the system mkstemp().

> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 398e0fac4f..0e6bd266cc 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -446,6 +446,8 @@ static inline int git_has_dir_sep(const char *path)
> >  
> >  #include "wrapper.h"
> >  
> > +#define mkstemp(template) git_mkstemp_mode((template), 0600)

So this patch implements what I was thinking, though I probably would
have made it more explicit: add mkstemp() to the banned list (not
because it's evil but because it's unportable) and force callers to use
git_mkstemp_mode() explicitly.

-Peff
