Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04370268684
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740554862; cv=none; b=o/jF05sJQ/neFh1O0ay0g/2dwTwAkF33LpjYRkjZhewKlsveMyI9pKTZ62t3oBWhNf/V37d5DvLHcPEYvuVUmxmrIYLQQKVXRwc7pSSSD/lUzRHxRs+ZwS79+HPln7ezgI5MdQoD78jfeAMfw5vUdvbkF/hYE6cMUGcm5HmDswE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740554862; c=relaxed/simple;
	bh=HCrI9dUUUDBpI3TU8OampV2yJeSaTw+3Ychi3/Bu2GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nie4WghZihQuOF+liyzz4PSWQN3Vn5NIcJ+/G8EegplOOouwV0cDczD54MLdurN34bsk8wDrfAy/UihHmsa4FQDH4f8w3SWWSEi1keLtePHB3xzhRcngAnYovCvoJRsFxCR31p6T+wg/e9uN73AlINcVv5esZY0J8kHIiMVa4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ga7mR6hG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ga7mR6hG"
Received: (qmail 5567 invoked by uid 109); 26 Feb 2025 07:27:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HCrI9dUUUDBpI3TU8OampV2yJeSaTw+3Ychi3/Bu2GQ=; b=Ga7mR6hG2mhrIOCfgnyn1frEhT880Ef9Zmjpq9cTsHYQ15rDd+H3aSoQr7KyVY5YXvjwKaHj97qq3yxJhdKJWiQN5b4ijB8bkaaEHmM9pX8jz+zw1BJIwqfnxG/+gyM1BEsVFmrzbPHLPH58Yyyh/6dJ02LJqeSvtWMQOovbw8ULg0Jll6aZo0T7SCjdfc/RfTfnN+g1cA7MMZRjHIXB9EHSDqKdCliO2irs6EYiqJOQ1yZiPrQruDc1PLWVdR/gEdcNkHh/HXUXdJD92DdQCdGxWkRa/C9AgJi/dPXKWb9ZoW3LYaCMc5OY87oqll8XcDSjrmqIwQjeZWCjhVXVig==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Feb 2025 07:27:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20845 invoked by uid 111); 26 Feb 2025 07:27:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2025 02:27:32 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Feb 2025 02:27:31 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: win+Meson test failures due to ps/build-meson-fixes-0130 topic?
Message-ID: <20250226072731.GA20372@coredump.intra.peff.net>
References: <xmqqo6ypiz9w.fsf@gitster.g>
 <Z76qYgV7B2eUJHiP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z76qYgV7B2eUJHiP@pks.im>

On Wed, Feb 26, 2025 at 06:45:06AM +0100, Patrick Steinhardt wrote:

> > I'll also note that in one of my earlier attempts (which had
> > ek/mingw-rename-symlink merged before po/meson-perl-fix), one of the
> > 10 "win+Meson test" jobs failed ("win+Meson test (7)" to be exact).
> > Rerunning the failed test succeeds, so there must be something flaky
> > in t0610-reftable-basics test that is exposed by this change,
> > perhaps?
> > 
> >   https://github.com/git/git/actions/runs/13528071468/attempts/1
> >   https://github.com/git/git/actions/runs/13528071468/attempts/2
> > 
> > As the ps/build-meson-fixes-0130 topic has 13 changes, and each
> > iteration in the above exercise took somewhere around 20 minutes, I
> > won't dive into the topic myself to identify which one of these
> > individual topics causes the breakage.  This however gave me enough
> > to go on to today's 'master' integration (mainly, by mark the topic
> > to be held in 'next' until this gets resolved, and deal with the
> > other topics).
> 
> Hm, interesting. I didn't notice those issues in our CI. Thanks for
> diving into it, I'll figure out what has happened here.

I spent a little time poking at this yesterday. Here's what I found in
case it helps.

I arbitrarily picked t0210 to poke at because it's short and it was
failing. Interestingly, the failing command was clone, with the client
complaining that it did not understand the server's protocol version
response.

Running with GIT_TRACE_PACKET shows that we got a line:

  version 2\r\n

And the extra "\r" confuses the parser. So perhaps something in the
build changed that is affecting how CRLF is output by standard
functions? That would explain why we see failures all over the test
suite. I didn't dig into any other cases, though.

-Peff
