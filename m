Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B5185B7D
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209836; cv=none; b=ZMjafnO+zd89n1HMh4SlOBDZzvmd3QwZ+pMRf9nafXxgJ0Pg+I3pKxXpVaR0WYmE0gUZ8gIqoJdsQ0Vr+F5U+F25iKdioBzGG2S8JpKDPxKnHaTXVEwZXFw7nbvmwR5LXn9swvH8HiDi9dJJr3ivWATfa0V8qAsLI+zNOiiOOZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209836; c=relaxed/simple;
	bh=UFIbxK80BjWRdIeWuhHbHcOZMWvpo1SZ8/zp+23tsJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dd05AKgPAGSRxS84LjHA83UOJsjdNFmOZFZa8Vk3/cZrFebfH8A/JlpcGOWWCz12j2kKEUI4dBlJJzmpqu+lv4sKtf22Pwq37KqOA7brdc9TdOXYg357EO6RU39mPGq58IlcTBdiVS4ld7B2JqPjjs/knMaot5vj3tbC7WYX+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23841 invoked by uid 109); 13 Sep 2024 06:43:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Sep 2024 06:43:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1178 invoked by uid 111); 13 Sep 2024 06:43:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Sep 2024 02:43:52 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 13 Sep 2024 02:43:52 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/4] ci: add Ubuntu 16.04 job to GitLab CI
Message-ID: <20240913064352.GA1234648@coredump.intra.peff.net>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <00a9fe6b7d77c16c9fd6dfe746aacf9068a76942.1726206484.git.ps@pks.im>
 <20240913062113.GA1232933@coredump.intra.peff.net>
 <ZuPeJqOg2GFqqOxa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuPeJqOg2GFqqOxa@pks.im>

On Fri, Sep 13, 2024 at 08:39:34AM +0200, Patrick Steinhardt wrote:

> > OK, this looks reasonable to me. I do think we could have our cake and
> > eat it too on the Apache support if we added a GIT_TEST_HTTP2 knob. But
> > it's probably not all that big a deal in practice, and after another 1.5
> > years I think we'd drop this 16.04 job anyway (since it will be out of
> > LTS then).
> 
> Note that we _do_ run the Apache tests, but only for HTTP/1. That's what
> the "auto" setting does automatically: Apache starts up just fine
> without the HTTP/2 module and thus we run all tests that don't rely on
> HTTP/2. On the other hand it fails to boot with HTTP/2, and thus we skip
> over these tests automatically.

Right, what I mean is that we would not notice if that job started
skipping the HTTP/1 tests (e.g., because we changed something in
apache.conf that didn't work on that old distro). We know it works now,
but our ideal config going forward is "skip the HTTP/2 tests if needed,
but fail if the HTTP/1 tests do not run".

-Peff
