Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0531D8E12
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119648; cv=none; b=hpF7BYzfSggjYMYYKbzFbEBHJx69iNlQI14oA3dDiu7sZlA/cPzW8xciUYcMtsgTgzrl4eXSi19KtiY6Mesw/eUb+D4i/ypldEtWp6WfDrad8h7zuQW7KCzR5Zzw4NgZoz8OsEPCe0BToqAjMi/sIPeF/r9CRjGIry7Tq4CC+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119648; c=relaxed/simple;
	bh=DzzeCA27a5fi5sEORat+n6U3cSuvi0S6qsltvC0hKww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kd7BJfDw96CpHCBIw+oSoBsGWlDrdZ1VEyb2ecLigZ3mOkukmiZAW9bVk1dOhScLxqRGs6VCvFhos6hFRwytxwXdnjS2OAgIt/P61d9V9eGSS2QXNoOTzxXZtqxGxOQeAuDv6u3/t9Qg0PJHVzdkciYGPp4Sa7fB1T/EvDnJDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O9GTYHYd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O9GTYHYd"
Received: (qmail 22008 invoked by uid 109); 17 Jan 2025 13:14:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DzzeCA27a5fi5sEORat+n6U3cSuvi0S6qsltvC0hKww=; b=O9GTYHYdaYOWwPoCdXErFimGhcdOxT2XFFx4emvBE1S+UfvKG2OP/Z6GHyWdNWO8My0ALIVT3fgKvFlKwXJE8H6k/6bACFY3EqcV8hpTaOqWGzUHMf4xdQDc5LbnoIsEXCYxUYRwg/BjiJEyAtbeaPpiiY7wJWtphk5UUeoaRaWDcYfKklxKk3SuD5jYLZdoocoo6f1Dm587bgWeaTDsxz1xlgfza6oyRSWb6megHFc4dVqrh5oaGXsUvA5H7iddLvib1BEP7mWY7COQUM2A1pOOolYm/gISi23Vek5Oa6WZ2VtdQkhe7enU+HUlkeGyUpVX7WSGtJl/G2Dtvf8gxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jan 2025 13:14:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8381 invoked by uid 111); 17 Jan 2025 13:14:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2025 08:14:05 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Jan 2025 08:14:04 -0500
From: Jeff King <peff@peff.net>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [bug] "git bisect old v3.0" takes 21 mins on Linux repo
Message-ID: <20250117131404.GD2893666@coredump.intra.peff.net>
References: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
 <CALnO6CAzN1oeT4tMjJ1Qm4dW0xdVkVKHJ39oJTX8R8E614FH6g@mail.gmail.com>
 <20250116105246.GF773990@coredump.intra.peff.net>
 <20250116125313.GA2301268@coredump.intra.peff.net>
 <20250116135227.GA2323616@coredump.intra.peff.net>
 <xmqqo706u2z0.fsf@gitster.g>
 <19472bf2353.2c31e5fd10001.1997220058832133228@zohomail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19472bf2353.2c31e5fd10001.1997220058832133228@zohomail.com>

On Fri, Jan 17, 2025 at 09:31:56AM +0400, Askar Safin wrote:

> I think "git bisect" is very important part of git.

Me too. But that doesn't make it any easier to figure out a more
optimized algorithm. ;)

In the meantime, here are some other options:

  1. You can manually pick a commit that is around the midpoint of
     history and try it. That will quickly reduce the search space to
     something more manageable. E.g., maybe try v4.0 and v5.0 and use
     those as your initial good/bad starting points (depending on the
     result). Those might not be the exact halfway point, but it's good
     enough to get started.

  2. In a branchy history like linux.git, you can make the problem space
     much smaller by looking only at the history along the first parent.
     E.g.:

       git bisect start --first-parent
       git bisect good v3.0
       git bisect bad v6.13-rc7

     That runs in about 7 seconds for me. It will probably give you a
     merge commit rather than the exact culprit along the second-parent
     history. But with that merge commit, you can start a new, much
     smaller bisection with it as the "bad" and its first-parent as the
     "good".

Both of those are trading a bit of accuracy in finding the exact
midpoint in the early steps. It's perhaps another possible option for
git-bisect itself: if we see a very large number of commits, we could
try to approximate rather than finding the exact answer. In most
histories I'd expect that taking the midpoint of a linearized topo-order
would get you a pretty reasonable outcome. E.g.:

  total=$(git rev-list --count v3.0..v6.13-rc7)
  git rev-list --topo-order v3.0..v6.13-rc7 |
  tail -n +$((total / 2)) | head -n 1

runs in about 2s on my machine. The commit it finds, ed194d136769,
is pretty close to the middle:

  $ git rev-list --count v3.0..ed194d136769
  526863
  $ git rev-list --count ed194d136769..v6.13-rc7
  543312

-Peff
