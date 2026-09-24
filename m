Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A62116F4
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292143; cv=none; b=A/8qWS9Oynid5ZqXeI4HwjkGK9RPStW61BGOD7YldLRuoeT3+HrNvyUuMYI3Pacd5INeyFua1bG/rMQzum5uRVYprlMf73SMDEcv0wa/zHLJptNRDVV6NMk+VccHwO4s0Cx/iyIqf4GRd1tTLwm4rDeYECwuA/43OmegK6D/sV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292143; c=relaxed/simple;
	bh=4sKx/LMihr0E7Ogur1H71kicZ7ltsYnVNDwScX4w7Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlIsuj3oXYwr0x1tH6qe9L2W7PsmrzBRjs//OrUiHbXYVQn2jWw0MbENgttAZAkhF3MXbww6m7GtYkLJNBqmPuE0gzmbRICYRQhkG9AnVuDzU/3qGAF9kCMz7xJvsYogTK1yUk50CIjdklHuMmnln3CVdZpAIFt0sQKU0Q2NVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BfW8sBLP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BfW8sBLP"
Received: (qmail 49117 invoked by uid 106); 24 Sep 2026 23:22:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4sKx/LMihr0E7Ogur1H71kicZ7ltsYnVNDwScX4w7Z4=; b=BfW8sBLP785F0YiCrVXPCIJjJkFnTwBicDIFjZ/e1gcs4H7kyU0V5FMFP0jN61hgiSbQUqfhOlbBWglxZCJuAnVVcJBVWEO2D20TGR8bYI/WyXbtw80GaxrQG1x5EWmzyAdFPISZzAHPGuKyFojJzEuwvTQcYFEdGx9L9bYe3zVSCgP95Yxxqooj+iyUAhDWHTYKVGOOeo1oOBq2/9MKIVtlabuXWEPbX72auCWz+a64VssupPXFPP+m6f4ecafnZlHWEjm+qYNvO/Cb/v5O+z4M3SoD4ISjbv/x2pdRd9LRm2CMo8Fvyrty7u+WjCDiEwFjMY2X7+fbnvapbCRVsg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Sep 2026 23:22:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 197923 invoked by uid 111); 24 Sep 2026 23:22:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Sep 2026 19:22:14 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 24 Sep 2026 19:22:14 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] ci: work around Debian 12's HTTP/2 authentication
 failures
Message-ID: <20260924232214.GA765100@coredump.intra.peff.net>
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
 <20260923164700.GA28538@coredump.intra.peff.net>
 <20260923165348.GA29229@coredump.intra.peff.net>
 <20260923165922.GB29229@coredump.intra.peff.net>
 <xmqqwlsbc2ge.fsf@gitster.g>
 <20260923192514.GA43344@coredump.intra.peff.net>
 <e94a9d4f-567e-83a0-e12a-908082365e77@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e94a9d4f-567e-83a0-e12a-908082365e77@gmx.de>

On Thu, Sep 24, 2026 at 08:59:24PM +0200, Johannes Schindelin wrote:

> I had GPT-6 dig deeper into the issue, since you're right: This should not
> be a CI/Debian-only gate, at the same time I didn't know what was the
> first version with the bug, so I suspected the version range to be subtly
> inaccurate. Turns out that the bug appeared first in cURL v7.88.0. So I
> adjusted your version range in preparation for the next patch iteration.

Great, it feels nicer knowing the actual start point. Your v2 patch
looks good to me!

-Peff
