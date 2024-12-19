Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98913C3F2
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587285; cv=none; b=aZ+nBpWgmkIiJ6JeRvRVKMJmshnLS+D0APjdyfTYTZG7cdecJ0a88I+vc8gVVSp1TODhScV5hyZf9bST+Fs+h2lExemuGojl+sqNyqOaKSlebiXYPl0GJ6Yb4l6O769YMdtUUZ+ItdS7oaKCpsOvV2TaAL7S+eI18RRSxLTPQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587285; c=relaxed/simple;
	bh=cVOHABM2NhRnB/ufLYEEGpg1Vnm1u/wNzqxDGlNjHR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5J8ysa3BruDHmYvyyAtz2OcNE4miiAKatuxXsc5m5nb1goNjUftpc1vmyqwz2dlh6JoLVY4GZRcl8Y3fPuF7DGKXpxG/x2CNCe01u/fqWu/P3QoPGXQhoBl7MWpmTAuM//gXeK+SJnip8N6KC3VikDylPLXdLVoTX8QBuDa2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=E0yjBk30; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="E0yjBk30"
Received: (qmail 19422 invoked by uid 109); 19 Dec 2024 05:48:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cVOHABM2NhRnB/ufLYEEGpg1Vnm1u/wNzqxDGlNjHR0=; b=E0yjBk30lip3EFRGIhSc38ET2qNVia7ovtTm4aJafsC76HIeHa3VvsDSN7Bw8SqHjCR4KP8jv69vXdizavIFbb6j98WFCvYYjrF6fGL8ZiNla9JVQFmnb/jNV1dMyTOlOpCd9ceonOQMe93pbMnNqkiNFzYnm2qjuyF/2zP3hV9wp1U5HRsBOZWHOk/S5cojVy3j1z3sDFutFT5g8Ze9nH8CfM0CBxNDw0g3kJxwdG3JeTlpfMUpLeKGYZoOkmPifbmECJjh3vSfwwdmS9P5m0tDAMhehsWJ/22pbSJyE4pnvHmGzWycynB/dxqnDV296enKWQDW5lC0eMyRY+kO+w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Dec 2024 05:48:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 865 invoked by uid 111); 19 Dec 2024 05:48:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Dec 2024 00:48:01 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 19 Dec 2024 00:48:01 -0500
From: Jeff King <peff@peff.net>
To: Matt Riben <matt.riben@hashgraph.com>
Cc: git@vger.kernel.org
Subject: Re: git-bugreport: core dump in git-difftool when there are no diffs
Message-ID: <20241219054801.GA2311098@coredump.intra.peff.net>
References: <CAJgEbBfca_tFmLm1JojL+JPwvCz96-VJbuQ5xT8iBos8h8QTVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJgEbBfca_tFmLm1JojL+JPwvCz96-VJbuQ5xT8iBos8h8QTVA@mail.gmail.com>

On Wed, Dec 18, 2024 at 12:29:41PM -0600, Matt Riben wrote:

> I get a core dump running `git difftool` when there are no diffs. It is
> easy for me to reproduce this core dump. The attached bug report includes a
> stack trace.

Thanks for a thorough bug report.

This was fixed by 98e4015593 (builtin/difftool: intialize some hashmap
variables, 2024-11-12), which should be in the upcoming v2.48.0 release.

-Peff
