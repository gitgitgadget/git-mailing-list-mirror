Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB8218AB7
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734710077; cv=none; b=gE+2KNoXOfyhQ7TUjJuEwqhlo1a6DBHTChlJ2IZGkFRehFlx0QWSWiMMLvxepqthCmCdS9EQL1NcN5m/EP2J1uzMeW5aCn8sHqsuM9JL9JPvxNSNY8Sn+D0idLWKRVUZlWac8JcthOYXkIFZTsMYDAjN1O/AWeGjRvj5vFBAFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734710077; c=relaxed/simple;
	bh=ZBe5dAGKt0Nk6CoYmQVoS5R1CjKJG5Sh20vuNyLoKZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEPwt2Z6v7wb4hUpzx3gOm/UlzC6qBDRyfPA3HUmQw6v6FgnZWTWBmqm2WVC+3+6PPF2lYn71aoiN8Rrco13hnMkIWHr/dv4Hy9y6mmBF4svdQTSSS+5f/WoZjT4b+0VSvCKGLJEbQnzzuqmjQ0uTAhCm5utNf+4poEOMXgEoS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=igmF//vT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="igmF//vT"
Received: (qmail 13853 invoked by uid 109); 20 Dec 2024 15:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZBe5dAGKt0Nk6CoYmQVoS5R1CjKJG5Sh20vuNyLoKZs=; b=igmF//vTvfK+KTOAkK6UzRpovUoJCh4tHq06Wzl/GpjgYxZUGvWsoYplao20fd4zs625MBf9JRWtdVpSqNwW7vC+7SbT468gVYd7FKnqwH7LRb42J83Xo5suuqiPIemsjlnfwZV8xZr40Lgw97K/hWsJqA6LjhVAVvY9jkWBGa14Lbr/xurIVSO/1Vnx3R7LFj+SrR9zSYGL2eU8OIHMfUSaiQc34nmHlLZPcAK49BoLkil5a475sNmDvULm4oKQu2+LDMf5iQFUmcIHcns03fvm/E+N7KwUlLVoY/GbM28kDhqGgLL/BCmU81LKltMaRLiNgimB4cx0+3QHbfLAbg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 15:54:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18536 invoked by uid 111); 20 Dec 2024 15:54:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 10:54:33 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 10:54:33 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: respect build info declared in
 "config.mak"
Message-ID: <20241220155433.GC152570@coredump.intra.peff.net>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-4-f1457a5e8c38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v2-4-f1457a5e8c38@pks.im>

On Fri, Dec 20, 2024 at 01:22:48PM +0100, Patrick Steinhardt wrote:

> In preceding commits we fixed that build info set via e.g. `make
> GIT_VERSION=foo` didn't get propagated to GIT-VERSION-GEN. Similarly
> though, setting build info via "config.mak" does not work anymore either
> because the variables are only declared as Makefile variables and thus
> aren't accessible by the script.
> 
> Fix the issue by exporting those variables via "shared.mak". This also
> allows us to deduplicate the export of GIT_USER_AGENT.

This looks good. It fixes the issue, and I am happy that:

>  asciidoctor-extensions.rb: asciidoctor-extensions.rb.in FORCE
> -	$(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@
> +	$(QUIET_GEN)$(SHELL_PATH) ../GIT-VERSION-GEN "$(shell pwd)/.." $< $@

...these spots get even simpler.

-Peff
