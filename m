Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC3F184EEC
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359889; cv=none; b=fWDzcggW93BUhtQZp8pJ3rjOQtD+rK60EhpMy0MAeA/niRBmnPFuUfcrGfDstCOuUkYKiZuaWbjqFhUdbn6ZbZu7kxLFVXU8leDeY9DAon92Hj1yrKwL+ij6gdKLen4Fb3Ip2DSXyrdwxmbmVVX3yhD5hopHfWWs7m56MUd3aKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359889; c=relaxed/simple;
	bh=fVV/KM9hw0xHqxMhpYoJ2qHltrib9NCj4q/CenIfpC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJy94yXoP4nKzHKHJe8t1glaOuSh8iEsd6q9P+ETSCXQ9r4YV7KYGkfTmXiQy8OmNucQoAlW0CpVj/YblI4JCqf7kI8nhkVawHZ6qU1jyl0BCy/g0x/pWP9x8A9tLSzGUe0vVDb9Ln4zwbn2d1IsSGePeTMwyWyQWFrh2Y9S5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13790 invoked by uid 109); 25 Mar 2024 09:44:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 Mar 2024 09:44:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2245 invoked by uid 111); 25 Mar 2024 09:44:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Mar 2024 05:44:49 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 Mar 2024 05:44:44 -0400
From: Jeff King <peff@peff.net>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pretty: update tests to use `test_config`
Message-ID: <20240325094444.GA254602@coredump.intra.peff.net>
References: <20240324214316.917513-1-brianmlyles@gmail.com>
 <20240325072651.947505-1-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240325072651.947505-1-brianmlyles@gmail.com>

On Mon, Mar 25, 2024 at 02:25:12AM -0500, Brian Lyles wrote:

> These tests use raw `git config` calls, which is an older style that can
> cause config to bleed between tests if not manually unset. `test_config`
> ensures that config is unset at the end of each test automatically.
> 
> `test_config` is chosen over `git -c` since `test_config` still ends up
> calling `git config` which seems slightly more realistic to how pretty
> formats would be defined normally.

I think what you have here is fine, and I agree it's more like what
would happen in practice. The nice thing about "-c" is that it involves
two fewer processes (one to make the config and one to clean up). But
that is really the tip of the iceberg for our test suite.

>  t/t4205-log-pretty-formats.sh | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)

The patch looks good to me. The big thing to be careful about here is
tests which actually require the config state to persist between hunks.
But none of these look to be that type.

-Peff
