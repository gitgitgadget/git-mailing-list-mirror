Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE21474B9
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081669; cv=none; b=ZVtDIVf+Bm/d7yJ2q1hsOvVn+B7RzVlgOVyfQO1bGoDSOdveABjOz1w2LlzThYmJ0RHwMa6luvGrXFqMTH9LLeYwLNbq12+4JCnYgZanZ+FI4FTHLzm4O0UU0UPSM0bcDFf1WrfBdQ3bI6e2LyOrgxZ6mr2PE/GbZHE4f0MHFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081669; c=relaxed/simple;
	bh=e5PXWmoKxwCwGoW4CqlRSqESxO6YwCPxx10d8b46x7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2KDKP2tbGO1O2b2A70l9JIf/iNLq3o2zIJJWp1qf942EQYSGn/Sn9OplkW3pRy8jrqSlMVWNJlupH8UQc+3kVS490f5tYqoUWb7Q5h4KAm/o//voP2Dy148A6TOccYsXpMSBbc6D8Bxj7l5ZK9r2RWEgmjh7+VLpi/6RAEMbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eWJJy8FW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eWJJy8FW"
Received: (qmail 9975 invoked by uid 109); 4 Oct 2024 22:41:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=e5PXWmoKxwCwGoW4CqlRSqESxO6YwCPxx10d8b46x7g=; b=eWJJy8FW0TV4bS20q+fFTFZCuffX+HIJZPrwEznYPlHg/YggidVCBb9xI1j0/PgJmF3C4gPMS5P0eybCq45mI3CNclu6XFrdvRg3KL7PFebmxSpQDv0sxlZYq1h8ps+Yj2F2zg7ArM6NqlNr7DFLEO4x7UInTX5N07/ofXE0shJtyOeeLuOLLCbPcw0bbXLtDFzEyf5NjBnmOX0xekQmnnIUOcBML0LWgWwuayuPlRyWKYZG48xHVQVIdbTRbHuEy5aQNtKTxtxTHLyjYhaQ/MEAJmzgmfIGmvMhLNBSL5GFnPQJcrxY9NX3F6GBk6m+uOkhtinnYXVSaDJLLTnG6Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Oct 2024 22:41:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14551 invoked by uid 111); 4 Oct 2024 22:41:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Oct 2024 18:41:05 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 4 Oct 2024 18:41:05 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2] t0610: work around flaky test with concurrent writers
Message-ID: <20241004224105.GB580885@coredump.intra.peff.net>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
 <f3874c7e923846e453499e89f00dd4f8862e4c40.1728055880.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3874c7e923846e453499e89f00dd4f8862e4c40.1728055880.git.ps@pks.im>

On Fri, Oct 04, 2024 at 05:32:16PM +0200, Patrick Steinhardt wrote:

> Work around the issue by disabling the test on Windows for now. While at
> it, increase the locking timeout to address reported timeouts when using
> either the address or memory sanitizer, which also tend to significantly
> extend the runtime of this test.
> 
> This should be revisited after Git v2.47 is out.

This sounds OK to me.

In general, I worry about papering over bugs with a "we'll revisit it
later" note. We may forget about things or never prioritize them. And
the worst-case scenario here is that we might later decide to promote
reftable to the default format, forgetting that concurrency has problems
on Windows.

But given that it's an area you've been actively working in, there's
already been some discussion towards the real fix, and we still consider
reftables somewhat experimental, I feel OK bumping it for now.

Thanks for all the digging on this (from you and from other folks).

-Peff
