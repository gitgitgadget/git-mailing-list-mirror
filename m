Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C4190664
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434778; cv=none; b=bnj4Zj2laHe7PYXLN8G8KcrI4M8CteaXaCiOTQc0QKqWX33n1QIOIFWNNhxhWUtX/uFjCzGnUiPzBWbTbLlWKluP/nxWVPG7CidUXmH85FZcwM69cHlBKeLJKXeG/ruAd5x9EcOqJ7dPkMTzWhTVc5NOoapJI+WWZSspAhFkhgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434778; c=relaxed/simple;
	bh=KzspTVwnLEVLffEgd1JotSI4rx/bO1jqZW9YLeS1YVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCjt/Pw8PGIp1qGyiFui5u+bzGZitzJGvP0Mo9F967jbjOQk5xpXnXh7mhLTCK5rqisLr43aZTzS7z+IiHZd9fQZT0xzbVgjaQ/LU0vIK89vgY1bVusN612sGklzCVOrvoRTDgYowp9hyXoFyaKzi1b+SahQGuJei1uems4ioNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25650 invoked by uid 109); 26 Jun 2024 20:46:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Jun 2024 20:46:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25120 invoked by uid 111); 26 Jun 2024 20:46:14 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Jun 2024 16:46:14 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Jun 2024 16:46:13 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about
 zlib+libcurl
Message-ID: <20240626204613.GE441931@coredump.intra.peff.net>
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>
 <20240621154552.62038-2-randall.becker@nexbridge.ca>
 <xmqqmsnekvir.fsf@gitster.g>
 <016501dac409$7dd5bc00$79813400$@nexbridge.com>
 <xmqqwmmijf6f.fsf@gitster.g>
 <xmqqplsaje6z.fsf@gitster.g>
 <xmqqtthlimtr.fsf@gitster.g>
 <03ef01dac735$f3496ac0$d9dc4040$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03ef01dac735$f3496ac0$d9dc4040$@nexbridge.com>

On Tue, Jun 25, 2024 at 03:29:03PM -0400, rsbecker@nexbridge.com wrote:

> My take on the separate patches and discussion about reporting run-time
> values of libcurl, zlib, and OpenSSL, is that these are being added to
> --build-options not --runtime-options (does not exist yet). I think that
> grabbing run-time values could be confusing to users who expect the
> --build-options even if comparing the two values.

I think that's a valid concern. I assumed we'd show both runtime and
build-time values side by side, clearly labeled, rather than replace one
with the other. I don't see much need for --runtime-options. The point
of --build-options is to gather info about the binary for debugging.
While technically you can swap out the dynamic library whenever you
like, in practice I think it is about asking "what will happen now when
I run git".

Likewise, you could answer that part with "ldd git", but this is about
making it simpler to gather the information in one place.

-Peff
