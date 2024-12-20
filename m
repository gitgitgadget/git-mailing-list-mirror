Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448D218AB7
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734710026; cv=none; b=hgfdX00mDhF4ZGXeULhJ6QdiiJiekg5H2YU4wanf04kxsl00+TliN1CaainsfMFakRNlWL0jXSkKo9MJ0C5iqhsPmN76zAj22rNYpciNkQPfQkAmmE9J6Lc2urYANjYbZ6Z9zWHSLX2gGuJOVMmlSJEzrTG+bK2wNZqVKB/G8tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734710026; c=relaxed/simple;
	bh=OZOpVrVGCi5qi9D55Jnal0dvP8y6LSwR3hAkB4UVVXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urXHkYzX/+V/4fN+6xy8/OFpgZkY7KXE9T73UboyeJd7lLPSSBwe3SsdCo2rVXTzpn+Mo0TaEKchbDcjGwsxs5XDvvJGWty80tGbuu+b5LPjK97Zi7MKxZzAikorZo/p7huj9MCEPS3cKERrlw06mCCuDRZyeOWh0ck1AQw28ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cEA/p18k; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cEA/p18k"
Received: (qmail 13824 invoked by uid 109); 20 Dec 2024 15:53:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OZOpVrVGCi5qi9D55Jnal0dvP8y6LSwR3hAkB4UVVXI=; b=cEA/p18kzd1J1SXY+X/PAXtI5PVnsRWDmj50IXNIFElgTJuDw0Lw1P64NWfnkZnrCplXf1smcHujaApiEVeX5rqr7wvE3oR/pAUssg7WxVDbfd8/FkSrdAzDemWpXK92nWkklXlKJmTffLMk6OpjgXAOZz9F4jboPjmuqHBfViXjlItgFglSXiUI/qery2FiJr2UIsCpPujFOonBOzctWdbr45bSJ8wHzmu+HT1R55Refd0F8mYp29O7O4yh7+CqrfGjhj6O/XjAnz4LCKdedUl0bIqTf//UbNh/5rfWoblRhVJqPaoID6R9EZ8poTnonv5wgnSGrrcBiNHO8XV9yw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 15:53:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18520 invoked by uid 111); 20 Dec 2024 15:53:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 10:53:43 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 10:53:42 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 3/5] Makefile: drop unneeded indirection for
 GIT-VERSION-GEN outputs
Message-ID: <20241220155342.GB152570@coredump.intra.peff.net>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-3-f1457a5e8c38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v2-3-f1457a5e8c38@pks.im>

On Fri, Dec 20, 2024 at 01:22:47PM +0100, Patrick Steinhardt wrote:

> Some of the callsites of GIT-VERSION-GEN generate the target file with a
> "+" suffix first and then move the file into place when the new contents
> are different compared to the old contents. This allows us to avoid a
> needless rebuild by not updating timestamps of the target file when its
> contents will remain unchanged anyway.
> 
> In fact though, this exact logic is already handled in GIT-VERSION-GEN,
> so doing this manually is pointless. This is a leftover from an earlier
> version of 4838deab65 (Makefile: refactor GIT-VERSION-GEN to be
> reusable, 2024-12-06), where the script didn't handle that logic for us.
> 
> Drop the needless indirection.

Nice. I think when we can do stuff like this in an actual script instead
of in a Makefile, the result is more readable.

-Peff
