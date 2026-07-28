Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676234483A5
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249419; cv=none; b=GFjuZCN/VTNF2ZueztObihaOq5dHJJX2nTTV2I56hWOSMjcfotIL3YvFBgJDLou3P+03siiuMzaobpVTmJl7+brdoPOBLxxss7yvxUITs4CpLpRb7MVYIg263MX6s+htQJ3Z3pr0798f+EQEN6tnXzy4P7omwlb2W5GVkx6itLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249419; c=relaxed/simple;
	bh=qjqQKlL7efv1u3pAJh4dBvA/pfOitisi3Fi0bG07uhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ2KdcT05Q8+Nf5WHw+6pn/hBBomaTf1ioEC/xVNT8ALtWpB6LaL+pI3F3w5JCMqHbsI3FGEPTxnlsNK7LYwvStiuD1HPrH3piJAzeuMC9PppaeB4lLE97h3DxJzBLI8HT+yaVYHKROQvXm1FwUZgWrkaUxC/9zm8PVJhZ2/7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=a37jorHa; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="a37jorHa"
Received: (qmail 80748 invoked by uid 106); 28 Jul 2026 14:36:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=qjqQKlL7efv1u3pAJh4dBvA/pfOitisi3Fi0bG07uhg=; b=a37jorHa5/KijvqlS/avvC8sfLn5zKGfoTiL6BbY6EMrnwZOLUH2vaAcfghmr3zGK1GWdBs+QCvvoouSasvVHtzZLuCcSxVU8KUa2VnKIWRidc82bYBZvXJRkY6NiYr2pX6QcGWMGQcu6HpTci3sv5SEYHx14MQJuSPNxsZjftkIaQWnKCE2j6Rk+i9inOfIvQ2uRGZ5jhkvmDjOZG5cIqpp2gTU9GzAjwUOX7uSdkGVCkZF1TV/0a2YfD7Ltocia8GgdrsCA7Pu+BD9opWNEl1W3WmTZ830bjG0r/5WQGpcu5iJkeMX4BuWdW2e8snQl014Oge8WmKT+U7wg6j1Ww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2026 14:36:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 99682 invoked by uid 111); 28 Jul 2026 14:36:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2026 10:36:54 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Jul 2026 10:36:53 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: [PATCH 0/2] fix serial tests without/with breaking-changes
Message-ID: <20260728143653.GB11894@coredump.intra.peff.net>
References: <amf76F4wxlboLz_A@fruit.crustytoothpaste.net>
 <758dbec3-7657-4342-8b74-7e59cdf88b5e@gmail.com>
 <20260728135532.GA11894@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728135532.GA11894@coredump.intra.peff.net>

On Tue, Jul 28, 2026 at 09:55:32AM -0400, Jeff King wrote:

> But we are in a funny limbo now for WITH_BREAKING_CHANGES. Possibly we
> could pull the value out of GIT-BUILD-OPTIONS (which I guess happens
> already via the environment) and use a prereq to skip the test.

I think we can do even a bit better. Leaving aside
WITH_BREAKING_CHANGES, we should consider what will eventually happen to
these tests when those deprecated commands go away. I think we want to
keep them in preparation for when we have more deprecated commands.

So here's a patch.

It doesn't address the t1517 issue at all. That test can also be
confused by older build products, but I don't think deprecation is
particularly related.  It comes from going to an old version where some
now-vanished command doesn't pass the "-h" test and then traveling back
to the present. Probably it could be more careful about what it
considers a valid command. Right now it checks "git --list-cmds", but in
theory it could be using a list generated from the Makefile.

  [1/2]: t0014: factor out choice of deprecated commands
  [2/2]: t0014: generate deprecated command names dynamically

 t/t0014-alias.sh | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

-Peff
