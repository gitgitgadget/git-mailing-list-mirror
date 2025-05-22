Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EB157A67
	for <git@vger.kernel.org>; Thu, 22 May 2025 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893821; cv=none; b=ebl2nZu0/Iqn9Xdd/3KbhGhr5ZJNigpYaN4vh0HF6JOmU/ZOIPlmQagso1c2MrDMDFC+sGX6Trr63gZP4KGA5zySlCzcFY14zRZCaSic72A8vnJCy08cPdvmcZ1Ct6O7fVtG1j5+COTSIQbe2gM4j+7jZDlWgd/uBmB5wllqFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893821; c=relaxed/simple;
	bh=lwxTNVL+Jv7j0YKemi2gEbXFoq4MaCM64UM8XTrCwlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn6T0xWJPys0sMe5PFHhj+vt3edanU8ZC+81e0sTUrNrfCZIas1o+xGjP7XHeOFsfOlW3IrPdJJb3KlWF3t0AO2VlxYJVr78lYdVNW+UrnT8ngyIbigX/ZOFEzF6VFse1SQ7tX023asB1Bz/k3F/Ck73DMFgpBpatwpeAJKvdq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FPnP9yKw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FPnP9yKw"
Received: (qmail 31436 invoked by uid 109); 22 May 2025 06:03:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lwxTNVL+Jv7j0YKemi2gEbXFoq4MaCM64UM8XTrCwlE=; b=FPnP9yKwC3/MP/1SCQBzVQltJCW+14BnCYmWhAxgRamNEZI1rZC8BLeYKGJ2A5UIkBiWNE1GpjbohjSw/phawYNLiyHSkBvPlmTq+TLy6cp1FBGlKBJWGJP73F4f8Ck+/RdE89JsN2ejnbYSMGupH+3XG/j8bC+EMYfWp/p06vo3JU7W/uVrhzMgFWeYUMbnzvoRXGzWI6isy12CULsKPu/nlrr7irV33lBRuPLvp4P2p8Lr6C46BOaTEDOKcvDp1+i+CyZKU4hhiqGcZZ/XsUl/fk5QtwYWXF02zS+bu0LzoopeRAhCtAbJfVmDKhKNkJlCxLPAeYeSmnfL5TO99Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 06:03:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12593 invoked by uid 111); 22 May 2025 06:03:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 02:03:42 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 02:03:37 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH 10/11] bundle-uri: avoid using undefined output of
 `sscanf()`
Message-ID: <20250522060337.GA1137854@coredump.intra.peff.net>
References: <694d8e62-486b-43d4-966c-4fa1e5a95061@crinan.ddns.net>
 <20250516134054.217202-1-phillip.wood123@gmail.com>
 <20250516154250.GA26009@coredump.intra.peff.net>
 <32de776c-9f15-4030-9f78-76384dd6dbb1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32de776c-9f15-4030-9f78-76384dd6dbb1@gmail.com>

On Mon, May 19, 2025 at 10:03:47AM +0100, Phillip Wood wrote:

> > So yeah, we probably do need something new. IMHO we should probably have
> > repo_config_get_u64() or similar (with the appropriate underlying
> > helpers as well) as use it here. But I am happy with any solution.
> I think repo_config_get_ulong() and friends all accept a multiplier suffix.
> That makes sense for things like packSizeLimit but here we're expecting a
> bare integer. It probably doesn't really matter but as one of the code paths
> parses a file that comes from the bundle server we might want to be as
> strict as we can be.

Yeah, I agree it's a little funny to allow suffixes where we wouldn't
expect them. But I do think there may be value in just consistently
accepting them for any numeric config value.

I dunno. I am OK with the more limited solution you proposed.

-Peff
