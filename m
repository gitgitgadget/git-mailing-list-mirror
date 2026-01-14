Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11C23D294
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411858; cv=none; b=UQtkwdO4TCW5+1fpdvxJBaxq0u5kpuk/61qU2vRViRf8nlNIkV02SrObzgUK3cCWbCTSbS08F3VmGBubXBjyNL0rL6wOjl6O6GE7PjLP2MQDHytVM94l5+DtnSowML5CL5SnpLoCZ555RgLok6a4pQtUEH7EepaBjK59sw/0h8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411858; c=relaxed/simple;
	bh=oIHvSmdei77AopwPg7eKUNRp/qmAuJS+CG1qqYVWdkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfAtHqN769pbHIfc6IRnF8mEJUT9HLX54sR3AUKxB/VFpxo8IKegchwe3WmH2gF72qu4EDCTL3VeTa1u6+ZJmtKq9REGVTjhsPpxU6pOaeYVlKQ00tjIkXtIRtkhEv2TgaDBoJKHKqPRLSGp2PY90yEpaYcPOtxndouCxnHXt7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=V/SeD+Yi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="V/SeD+Yi"
Received: (qmail 40630 invoked by uid 109); 14 Jan 2026 17:30:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=oIHvSmdei77AopwPg7eKUNRp/qmAuJS+CG1qqYVWdkk=; b=V/SeD+YijZHY/BDQx0do4l3u7dYrRz2fzM6T6Bw1+qb2BEFGEIM7fWP09UOUuLgMBNeSCApxN0coQxAJDrcmdFADI2gPs0bYUd9Nj5kOF4/mYBVdpZXXPqjHtuykHBuY09K/ywBR3rmbmrPf5T0YrFqw4WYssPcBhh6vxOUcROMnBUxt+EF7d28GTi037aHemSmH0tk86QHPTRJz010fY8wxn5TmBKKIQBP7hxgHj66Q8YdCNWObTbQ+Iov6RAp/QAI3GHrbWqY+NaXlbfUzNVKyHQfwYKX7UKbS/bn/z8EQ7ZQ3deVEaB9aY0/YzcsKH11G7a6az5ZZ5PJQOg3ipA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jan 2026 17:30:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 67174 invoked by uid 111); 14 Jan 2026 17:30:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Jan 2026 12:30:56 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Jan 2026 12:30:55 -0500
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Lucas De Marchi <demarchi@kernel.org>
Subject: Re: [PATCH v2] remote-curl: Use auth for probe_rpc() requests too
Message-ID: <20260114173055.GD885771@coredump.intra.peff.net>
References: <20260113031929.3746753-1-aplattner@nvidia.com>
 <xmqqfr89lkve.fsf@gitster.g>
 <a919f4cf-8355-43dd-a552-df99325e4cc6@nvidia.com>
 <20260114022057.GA858110@coredump.intra.peff.net>
 <xmqqikd4gu7r.fsf@gitster.g>
 <613b47af-5269-44e3-87f5-d29fba9d73b3@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <613b47af-5269-44e3-87f5-d29fba9d73b3@nvidia.com>

On Wed, Jan 14, 2026 at 08:33:43AM -0800, Aaron Plattner wrote:

> Ooh, neat. I guess I copied the wrong example. I verified that this works
> too, so I can send a v5 for that.
> 
> Is it worth changing up the other cases of this pattern, mostly in
> pack-refs-tests.sh? E.g.,
> 
> 	# Create 15 loose references.
> 	printf "create refs/heads/loose-%d HEAD\n" $(test_seq 15) >stdin &&
> 	git update-ref --stdin <stdin &&
> 
> [...]
> 
> 	# Create 99 packed refs. This should cause the heuristic
> 	# to require more than the minimum amount of loose refs.
> 	test_seq 99 |
> 	while read i
> 	do
> 		printf "create refs/heads/packed-%d HEAD\n" $i || return 1
> 	done >stdin &&
> 	git update-ref --stdin <stdin &&
> 
> I can put together a patch for those.

Yeah, I think they are worth updating. I looked for spots to convert
when I added the feature in b32c7ec02f (test-lib: teach test_seq the -f
option, 2025-06-23). But I missed those ones.

I think I grepped for "for i in $(test_seq ...)", but the use of the
while loop and the $()-substitution meant I didn't see them. Examining
every test_seq call didn't seem worthwhile, as there are hundreds. ;)

Grepping for "test_seq .* |" does yield a few more (e.g., p5551), but
most are false positives. Grepping for "printf.*$(test_seq" gets some
more.

I don't know that we need to exhaustively find all cases. ;) In the
first case above, it does save us a subshell. In the second case I think
it saves us a subshell _and_ the result is much easier to read (because
it avoids the loop and return). So IMHO it's a nice improvement, but
there's diminishing returns to investigating every test_seq call.

-Peff
