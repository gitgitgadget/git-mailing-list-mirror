Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B01F938
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 00:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782693284; cv=none; b=l9jc8aUL9PzBJ42l1Z0ThDNVhII3pOm8LrUVbDFmS7apWgoFZMSDtG/wljYnQj1gDvsL7jWO5XDg+y706JuEHGaMnb51mgso5YynVD5TcW6BYeeSxDdDoVzbFQ3C5Srru4dqTNTG/DWNV2uqf4Bqwnbfk03Ie/Mzj/OBezrR1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782693284; c=relaxed/simple;
	bh=X07GKoi3JwIbvD/mSCYKrmAB5LfMbjekvdufaWWG4rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edYXpK0+0Wkf1Vn+uU9Xc+6IbBAacqXfC2bLdbxP8oi6VjWjU3T7J/ixU9NdXSC+yFvU6QiW/l6230EWnHM+d+CI560HSrq83jq5gJ0SZXzaZRJAONAodp9b8ZClCiJ0adZY9KYRlXc2DpynOlZ7TUv1DohrC2AhRhHlZUWADGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NVInn/f1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NVInn/f1"
Received: (qmail 59542 invoked by uid 106); 29 Jun 2026 00:34:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=X07GKoi3JwIbvD/mSCYKrmAB5LfMbjekvdufaWWG4rU=; b=NVInn/f1FmCjS8t359xTOTumywGDgO29x8V4Yggxri6KTQZdxY3VRQbfNX7b7kF1z7N16QOBOe+r4G/TwGkM8/m5d0IkLUHEbdPm67g4qWCy0juZIRHxHWmx9RaX7odCShhXy9NMUWaq1JKlJUw5si6SgHAfoCLBWlWky8Juiqo5STFbxigh0BJZiwKksLpfNU3qRdFy6ZItLbBKPGxi1+I2P6GLZMfJ4sAHijxv33ar0Kj4p1r+LX47GUx3v9po791iSM73GNHeVGPQ9P5HnaG6ygp0HSKBUzUFaB14O6zZxMsNESnHTiCJQ8dZ0X1lR3u6vUekjkrFJWZeNxfVIg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jun 2026 00:34:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 121467 invoked by uid 111); 29 Jun 2026 00:34:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jun 2026 20:34:41 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jun 2026 20:34:34 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo <mmontalbo@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/3] t5551: put many-tags case into its own repo
Message-ID: <20260629003434.GA1228461@coredump.intra.peff.net>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080345.GB107826@coredump.intra.peff.net>
 <xmqqh5mm1gsf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5mm1gsf.fsf@gitster.g>

On Sun, Jun 28, 2026 at 02:44:32PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> > index e236e526f0..cd851f24b8 100755
> > --- a/t/t5551-http-fetch-smart.sh
> > +++ b/t/t5551-http-fetch-smart.sh
> > @@ -397,15 +397,16 @@ create_tags () {
> >  }
> >  
> >  test_expect_success 'create 2,000 tags in the repo' '
> > +	git init "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
> >  	(
> > -		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> > +		cd "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
> >  		create_tags 1 2000
> >  	)
> >  '
> 
> While all the other repositories used in this tests are bare
> repositories, this new one is a non-bare repository.
> 
> It shouldn't make any difference, but since I noticed it...

Ah, yeah. It should work either way, but it is slightly confusing for it
to be non-bare. I'll wait to re-send (though if nothing else comes up,
it may be simpler for you to just amend on your side).

-Peff
