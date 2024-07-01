Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8B10A09
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719805343; cv=none; b=j2+OQn745wqnPJvZOAPlpe3mccyn0AN3E9WCmS3Kw26fk5IhnPye41qV9SDSRp6LdeniMIIaBtouYlWhdbB8IXVuzXFs21fDkMGQ7ca/n2f9za1QFipUMRUG7DW9PqP2BDT7fGuOVY8Tjp4lPxGs3HhBSjr0Z/kuVDXnsSZRvck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719805343; c=relaxed/simple;
	bh=9DwDi9IvnyTxPTVm/x/93BS6Y9D6hP2843JbZQLKfUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQIGOsoj3uN+yzOQ3JQJRqftwTx9rSKUB6CTGc2KjQ8cGbnMxcPWYCV+H2BSaKEBhBcVOekYDsP9jqCed3apvI9J34d+9ZXv2G7oOJwXp1khPQgfsSvdXpuENHwtXTQeSC1u8dUdtdU+fSxC28Fx+dB/nobKouyckov7eXltBik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16946 invoked by uid 109); 1 Jul 2024 03:42:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 03:42:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8465 invoked by uid 111); 1 Jul 2024 03:42:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Jun 2024 23:42:18 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Jun 2024 23:42:20 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] submodule--helper: use strvec_pushf() for --super-prefix
Message-ID: <20240701034220.GD610406@coredump.intra.peff.net>
References: <fb79ebc4-5ecf-4257-ac2e-39f98db5649c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb79ebc4-5ecf-4257-ac2e-39f98db5649c@web.de>

On Sat, Jun 29, 2024 at 08:01:24PM +0200, René Scharfe wrote:

> Use the strvec_pushf() call that already appends a slash to also produce
> the stuck form of the option --super-prefix instead of adding the option
> name in a separate call of strvec_push() or strvec_pushl().  This way we
> can more easily see that these parts make up a single option with its
> argument and save a function call.

I agree it's more readable (both the code and any GIT_TRACE output). But
also I think the "stuck" form is what we recommend in gitcli(7), since
it is future-proof against optional arguments. So we'd also be setting a
good example.

-Peff
