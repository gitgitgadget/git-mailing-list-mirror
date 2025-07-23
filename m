Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE6273D74
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753260388; cv=none; b=EsNrdubRzsrbA7NgxZqhh4XlGxIbPiyIFn+D74q7AoT77DW4ciYXUgYb9IVD8KFEZFZXASucFpr6NkuWn3wsA3samP49ZKT7X/o2V2vfmDGyzlXF+u5GD3+G5or2/C1ISqC6uPjrPE7eEvXJOJV+ziJWCbv1axsPFwgTd/NXYI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753260388; c=relaxed/simple;
	bh=PUiL52deDlTspgEWTBqn8xNEtO4DZHMtt581BYEk7m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+RjcU476jXQ3f3KjnFnjqAiUv/0xPhGYLQUDwYnriTy2uKdWUkuOqSKyx2h22yCzH1L/PxtPM3BPre34mR2zgwCgfBWy5E2JsbQW3opbnp/OuivZBDP2jroRiUdhheGuqWdCFUu0JkvILfLLALzS6RmV0yR0zeBfnmRPcWypxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hlIxuPL+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hlIxuPL+"
Received: (qmail 5243 invoked by uid 109); 23 Jul 2025 08:46:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PUiL52deDlTspgEWTBqn8xNEtO4DZHMtt581BYEk7m0=; b=hlIxuPL+Bzh19Fj3NMGEAEfwtf09Mro7/1MvwtzybWvO6scyem9GI223DBMspwnZEEeqmLsnUKMKfWNzupldWYhApXNTDQmmVhPv4sXAA6G1Ugd5uF3wd0bf/+NlX0D4n0TwcBBaUmaQvMi36+OUPhBCvGpvKW+2LGQDq6Kn/3SldhAbh40hXtQcXz/aMbG7xkvUrwU5qmoZo9n8+EE/1oYV2G8FsvdLd9oiruYrEYnq8sK1A20FG82WJ8RfDdlSH1EAjSmK4zWWh4tbO5XM+xeNaXH+3js1nHGhzJ6nK6vE6WiNN4aPhAw4IAuNuJ+rbjwgTGp+VAJfwjQoVAXKog==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jul 2025 08:46:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13595 invoked by uid 111); 23 Jul 2025 08:46:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jul 2025 04:46:29 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Jul 2025 04:46:24 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak
 and ensure safe cleanup
Message-ID: <20250723084624.GA580010@coredump.intra.peff.net>
References: <20250722174102.1876197-1-lhywkd22@gmail.com>
 <20250722174102.1876197-3-lhywkd22@gmail.com>
 <CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>
 <20250723075513.GA570540@coredump.intra.peff.net>
 <CAPig+cQ2p3muA0-8O_u-rOW0uVGQ_ZE7hcz-7qq8M1U+PdvtpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ2p3muA0-8O_u-rOW0uVGQ_ZE7hcz-7qq8M1U+PdvtpQ@mail.gmail.com>

On Wed, Jul 23, 2025 at 04:11:26AM -0400, Eric Sunshine wrote:

> For completeness, I'll mention that I even had the thought that
> another "fix" would be to tear out all the cleanup code entirely since
> we _know_ that this function will be exiting immediately and the OS
> will clean up any dangling resources.

The reason we have the "cleanup" label at all is because of the memory
leaks. And there the issue is that we build the test helpers with the
same compiler settings as the rest of the code, so SANITIZE=leak will
complain. So I think that is a non-starter.

But if you just meant leaking descriptors, sure, I don't think any tools
complain about that. ;)

-Peff
