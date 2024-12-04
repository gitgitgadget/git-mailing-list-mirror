Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AE42B9B7
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733356484; cv=none; b=YKlBSbYoW9cDI2S2lfosyt3pRIjsnSnMkADmOW/5A1DJnt/TOWuMlQ1gTKVYraPIDH1NGSKxXLid/jh9RRfWl5ceUyQB84mqI8HQRi6N0AYIw7PiPA5c6+c+/esjJZ+vFyp0GytUxVeiWvg/6Ikgjdhb/J1BZNVx9MxOfHiCZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733356484; c=relaxed/simple;
	bh=vBtuV8wQnpk+vUSNWF5urPzDbLqTuXVKnAcvWcvGRqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR1ipzMm7VkGrQcFLmQiO1wb4tsHcxVlS67s/o9hxIDGZJZyy0F+5PK/VNATzrIZ332qJH/UHARIg9TuCbTBTwmLRuCWr6lHYsxZUAu/9lYN34gVvYUa48wThn9MB4+5yCavdprkuPItAH4KbwRLGPRHwiOvGwdxPabt3Lxo2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SFqJIpWu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SFqJIpWu"
Received: (qmail 19401 invoked by uid 109); 4 Dec 2024 23:54:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vBtuV8wQnpk+vUSNWF5urPzDbLqTuXVKnAcvWcvGRqM=; b=SFqJIpWu77NAMuNbPsBgYe5Qlbd7OHn8xAVcbelKbip6bOdZx8FJAkZ7z6REY+kL+DX0Nsbso5g1IN3+I9Uy/gSeZuYLTqnHKBt30mSGDEXehsp928YJaPuN6gi3kVueuNGPutTvascZSn/w5vhRlK2dbYdkIndbO4TMNwAQ9c1jAuY0yIkHiPyBpXGeC24/6iR/uuOrk40lA5FP+YHIhpmnpT3ggK6U11J+tHdLs+fuV1OZ3CWMJzo3HrkvvGKiKTCM2OtMrURjADXIsDt8esQFUkrNJ8abS+fOK1Pe9h7KPOXSUc+KYjZA2jc80g6j2mQ3IWHsVEoqGejjmqN5kg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Dec 2024 23:54:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28561 invoked by uid 111); 4 Dec 2024 23:54:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Dec 2024 18:54:41 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Dec 2024 18:54:40 -0500
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, benno.martin.evers@gmail.com,
	benno@bmevers.de, ravi@prevas.dk, jpoimboe@kernel.org,
	masahiroy@kernel.org
Subject: Re: [PATCH] fixup! describe: stop traversing when we run out of names
Message-ID: <20241204235440.GA2560861@coredump.intra.peff.net>
References: <20241106211717.GD956383@coredump.intra.peff.net>
 <00270315b83b585f7d62ad1204ca1df93a668791.1733354035.git.steadmon@google.com>
 <20241204232750.GA1460551@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204232750.GA1460551@coredump.intra.peff.net>

On Wed, Dec 04, 2024 at 06:27:50PM -0500, Jeff King wrote:

> > -	if (!max_candidates)
> > +	if (!max_candidates && !always)
> >  		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
> >  	if (debug)
> >  		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
> 
> Yep, this is the same spot I found. I think it's the right place to make
> the fix.
> 
> > Subject: Re: [PATCH] fixup! describe: stop traversing when we run out of names
> 
> This commit is already in 'next', so it's too late to squash in a change
> (though I'd have done this separately anyway, as it's already an issue
> for a manual --candidates=0 setting, as unlikely as that is).
> 
> Can you re-send with a full commit message?

In case it helps with writing a commit message:

I wondered why this line was there at all. It comes from 2c33f75754
(Teach git-describe --exact-match to avoid expensive tag searches,
2008-02-24). The --exact-match option is implemented by setting
max-candidates to 0. So:

  git describe --exact-match --always

has always been broken, but probably nobody ever cared. My series
reduces the max_candidates setting automatically when there is nothing
to find, which means you are more likely to hit the bug.

-Peff
