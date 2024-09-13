Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332C1474C5
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726208477; cv=none; b=F+DMAMijoBuG27nlSTwem0pyY8n8wvJb3tNub5KRx7sc/enuSsAo7WFODg/O5Q6UNQQIo5SxNI/AmogR9D6VQBMJeQOvoOK2EJNbfiAY2IFiQe0IxrVWKT5M57MUIqlGqcebTzB4YoC5r/zq6w1RmdxbgHLlsPTaHyrjOqaofq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726208477; c=relaxed/simple;
	bh=Kt2eXmV59Pjqk2TKWfVN2oB4tGZM7dn4mo6tFzIvuyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CauYXcPJR2izWtlEh4L0/cPfhmFokN9pMvckWMvOFnLoWh0WbZfvkOXLvHeZsQ8LDMleC46BjGlIBRdLFH/TtJ/ZLNwsNtPnm5ge+7utzmzlr8YYReWiT2bgUCUTgKst4dESpWCtvYOEspysvuJJNiiKC6eKMJdi+sY56HZudKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23648 invoked by uid 109); 13 Sep 2024 06:21:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Sep 2024 06:21:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32700 invoked by uid 111); 13 Sep 2024 06:21:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Sep 2024 02:21:14 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 13 Sep 2024 02:21:13 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/4] ci: add Ubuntu 16.04 job to GitLab CI
Message-ID: <20240913062113.GA1232933@coredump.intra.peff.net>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <00a9fe6b7d77c16c9fd6dfe746aacf9068a76942.1726206484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00a9fe6b7d77c16c9fd6dfe746aacf9068a76942.1726206484.git.ps@pks.im>

On Fri, Sep 13, 2024 at 07:52:51AM +0200, Patrick Steinhardt wrote:

> In the preceding commits we had to convert the linux32 job to be based
> on Ubuntu 20.04 instead of Ubuntu 16.04 due to a limitation in GitHub
> Workflows. This was the only job left that still tested against this old
> but supported Ubuntu version, and we have no other jobs that test with a
> comparatively old Linux distribution.
> 
> Add a new job to GitLab CI that tests with Ubuntu 16.04 to cover the
> resulting test gap. GitLab doesn't modify Docker images in the same way
> GitHub does and thus doesn't fall prey to the same issue. There are two
> compatibility issues uncovered by this:
> 
>   - Ubuntu 16.04 does not support HTTP/2 in Apache. We thus cannot set
>     `GIT_TEST_HTTPD=true`, which would otherwise cause us to fail when
>     Apache fails to start.
> 
>   - Ubuntu 16.04 cannot use recent JGit versions as they depend on a
>     more recent Java runtime than we have available. We thus disable
>     installing any kind of optional dependencies that do not come from
>     the package manager.

OK, this looks reasonable to me. I do think we could have our cake and
eat it too on the Apache support if we added a GIT_TEST_HTTP2 knob. But
it's probably not all that big a deal in practice, and after another 1.5
years I think we'd drop this 16.04 job anyway (since it will be out of
LTS then).

Thanks for putting this together.

-Peff
