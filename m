Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403011F5827
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340771; cv=none; b=TgZ+fmEwfY8afJy2FidU3En0CDVNTP1FmTA9rmpTwJTCwKfCbgAL8AXlJRT6kvH2U+ZtRvMFPVUmj89AWjUOtwZMA4kteAe7RReyxHJlw3yvVIgNotquys7GUndwY9++Qw+Cpe5PbK3py4ZWevfMPberWDQbw+tv+6KA2UfDQE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340771; c=relaxed/simple;
	bh=CdW+W85Zuzfa1LjFfV2BAyeuMQWVfxEPGzfndkRHnYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clnIQVbQYn9o/aOQSb1p1II0qEVQ5WDkesGvx/pls6wyoXLwJg08M9rbsIcPUBJlubW4jvBX8rZYAlDfJ/Z/YUODv37Um1KWjSVfVMZFR5E8kws7O8XAObwgmxDvib6prE5amT5A1b0p1vxJTIyF8v265vcvUeAJMRJCHbc8M4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gdxVunj+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gdxVunj+"
Received: (qmail 924 invoked by uid 109); 15 May 2025 20:26:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CdW+W85Zuzfa1LjFfV2BAyeuMQWVfxEPGzfndkRHnYs=; b=gdxVunj++WZfpbRcLmypRqJfteDDaZtUf1UGhrgo4afHeNMc1cY/idmHbwvH/kcsJa3uV6kbDtkxfslYw/4CSShJr74Xt15GNkM2HL8wXvvxPfLxSE8mTJtbW/0a9t0/UjIOZ4zCasbw0FBcVQndiNxkQO+QKlLtD3Kc8gRyNF7FaQ7JXp9jSLY8x1Rc++51O1q8amNN76FZiRvtW02BlrpHv8SdXmDVsvcVVN5QKSKzybvYDhbpue1g55ITq0gLKF7qaq8HWidi3mvolmd3f0FUx1Pxb3r7U4HQA9AOzHyHPxodlam3cdZ1Liqn4yqEwwULhfskd9nyvZwOXNcI0w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 20:26:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30896 invoked by uid 111); 15 May 2025 20:26:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 16:26:09 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 16:26:07 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/11] sequencer: stop pretending that an assignment is a
 condition
Message-ID: <20250515202607.GL3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <7a54005bd26ac17cb6d99a2e18932f97575d4aca.1747314709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a54005bd26ac17cb6d99a2e18932f97575d4aca.1747314709.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:49PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Let's help all of this by turning this into the more verbose, more
> readable form of an `if` construct that both assigns the pointer as well
> as returns 1 if all of the conditions hold true.

I see Junio already reviewed this one, but just so I can say I read all
of the patches: yes, I also agree the result is easier to understand. :)

-Peff
