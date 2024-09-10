Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144D175D2F
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950239; cv=none; b=HHQMQshMBjGI1TcDMIteWrzy9sLJo1QuteSB9cOhxfaCbZGZ8io19YlpwclFGppTrKqkTvmj0Z1FihxAJbUic5vNz/0+I/zfoHCUaKb7WUWWWdt8wgBryQOWZ9b/BiWs0pe3kbcxbfYoJUiH5xCzjxBGDzI6nbKlIXjnKdOnNkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950239; c=relaxed/simple;
	bh=YACzkEkH6/LQ68j+hXKQxxryFqVNLoRryxyMA28xuk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1342fR7NYq7IMFli5I4sJ31V3/RninorbtOckdbpOL8BvFfAQHKm5uvzz6cugrQuwc2DVosPSLUCA7SSYsYu75uGGZbEVetsViNxX0/ziFEZfTnmY1JPKfiYuxZlqEBYLrrYt4Ohb+RkhMEi+oV3rcQRBNNKbnItXmMuIDTDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3360 invoked by uid 109); 10 Sep 2024 06:37:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Sep 2024 06:37:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29112 invoked by uid 111); 10 Sep 2024 06:37:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Sep 2024 02:37:15 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Sep 2024 02:37:15 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 9/9] ref-filter: add ref_format_clear() function
Message-ID: <20240910063715.GD1459778@coredump.intra.peff.net>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <20240909232118.GI921834@coredump.intra.peff.net>
 <Zt_ijEqdsylYYkNn@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zt_ijEqdsylYYkNn@pks.im>

On Tue, Sep 10, 2024 at 08:09:16AM +0200, Patrick Steinhardt wrote:

> On Mon, Sep 09, 2024 at 07:21:18PM -0400, Jeff King wrote:
> > diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> > index e8db612f95..b3163629c5 100755
> > --- a/t/t6300-for-each-ref.sh
> > +++ b/t/t6300-for-each-ref.sh
> > @@ -5,6 +5,7 @@
> >  
> >  test_description='for-each-ref test'
> >  
> > +TEST_PASSES_SANITIZE_LEAK=true
> >  . ./test-lib.sh
> >  GNUPGHOME_NOT_USED=$GNUPGHOME
> >  . "$TEST_DIRECTORY"/lib-gpg.sh
> 
> Nice! There's also t6302, which has been failing due to all the memory
> leaks in our atom handling, as well. After your series there's a single
> memory leak left to make it pass. So we may want to add below patch on
> top as a low-hanging fruit.

I was afraid to go looking for other almost-there scripts, knowing what
a rabbit hole it can turn into (which I know you are also familiar
with).

> -- >8 --
> diff --git a/ref-filter.c b/ref-filter.c
> index ce1bcfad857..b06e18a569a 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c

This looks plausibly correct to me, but I'm not at all familiar with the
conditional placeholders. I think it would make more sense for you to
wrap it up with a commit message.

-Peff
