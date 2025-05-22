Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759F83D76
	for <git@vger.kernel.org>; Thu, 22 May 2025 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927900; cv=none; b=FKGVdJlLNxDgpMAkgZj4T6W7CxWZaUChyrNlIeid6HGg89dSVxqD1BooUZJj/pA/A1ssi5VqtVuFB+hGOpNAYQK+CZOGC4pSxkRyP1t21uzgRPCMT6s6iL1sX7xFQQXtcXAEYAmKIoz4AzfN/f+bsHufFfr6eQAWB2ySs9RKXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927900; c=relaxed/simple;
	bh=qJGpGOWrzn+al4Q5HvzE17WrCbMXE5JfX8hTMFzH+kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwoCRrquWWRlKUSZXsa3iBTeEkK2ICqjHXeU/e+USs6c8OXmLiMn3TAeYecVji2S6gRAee5UQbgMzY+CNnOTlBY6Vo5sL02qKTSBv5VtstbD4sUgNxaY21Eag/BEyOifwAsSFa3lw/4NF72IhfLlyBgpWd/14HJpEicBLYPTEEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SN6XUq/k; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SN6XUq/k"
Received: (qmail 415 invoked by uid 109); 22 May 2025 15:31:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qJGpGOWrzn+al4Q5HvzE17WrCbMXE5JfX8hTMFzH+kU=; b=SN6XUq/kZQStMDQAje2x7T5EI6WPj8rhWldLv6REfZOmeP3pGmrpjn9xJkpc21yaJmcaFyJi+4b2OPXpnjpCI9fYdzBDQA5f1lU3Toj9JtDjsjPUWmWYRXLpOkKffHVzELMx2cvDMoGor3awl3FO2pCVTcBn4+Z0z+jdMa+Byg7+Pw7XyXdtnmYOclWR5qRaahcVO6SH7G+1LdVN/N9DXzkSQNs/v2tAMM9auLJZs1B5AwlVXlhH7xanEgVEF5WQr6E2FgzAjmMCMr0Op5ELUMIvEQDoLK3cSx3mI9CUgmfAKoeMqmEsCGeU2jkZe2yLMkHv1Us1RglkVrI9n5dy6Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 15:31:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19242 invoked by uid 111); 22 May 2025 15:31:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 11:31:38 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 11:31:36 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/4] fetch/receive: use batched reference updates
Message-ID: <20250522153136.GA1150962@coredump.intra.peff.net>
References: <20250514-501-update-git-fetch-1-to-use-partial-transactions-v1-0-7c65f46493d4@gmail.com>
 <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>
 <xmqqy0usmprh.fsf@gitster.g>
 <CAOLa=ZTyE9myZqy8UHe=YeZ-diy0Q1UDTBTB3d1XGC09XvshAQ@mail.gmail.com>
 <20250522060044.GB1135327@coredump.intra.peff.net>
 <CAOLa=ZQhaPXS1y5zkRv2CQ_S5=8+XRg_A1snXHVYXz3uvVgZSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQhaPXS1y5zkRv2CQ_S5=8+XRg_A1snXHVYXz3uvVgZSg@mail.gmail.com>

On Thu, May 22, 2025 at 01:50:18AM -0700, Karthik Nayak wrote:

> > If we store and return a "void *" pointer as we do now, but accept a
> > const pointer via strmap_put(), then we're casting away potentially
> > important const-ness without the caller even seeing it. I think it's
> > safer for the client to do the cast explicitly (since they are the ones
> > who know how they plan to use it).
> >
> 
> But isn't that the case now anyways? We always lose the const-ness since
> we only accept a 'void *'. But by only changing 'strmap_put()' to accept
> a 'const void *', but storing and returning a 'void *'. We simply modify
> the current construct to also say that any data received is not
> modified. But I do see your point, we'll have to cast there anyways and
> might as well do it on the client side.

Right, there is no winning here in the type system. But by pushing the
cast onto the calling side, it is more visible and closer to the code
that knows how the result will be used.

> > I don't think we can really represent what we want in C's type system.
> > But if we wanted a safe(r) interface that didn't involve type-casting,
> > we might be able to do something like:
> [...]
> Agreed, and then there is additional load to ensure users will use
> 'strmap_put()' and 'strmap_put_const()' as required and simply not cast
> away.

That part I'm not too worried about, since casts are easy-ish to catch
and flag in reviews. But I'm not sure if it's materially making the
world a better place to have the extra complexity.

-Peff
