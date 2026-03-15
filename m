Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7F1684B4
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773598598; cv=none; b=ji3V+XdOGOPm2YehGXhh92YvWemA4YA8GcI8Y039qkf2/n4YiCmFc/EpjlhNnCtizGh/rs6M01X4iDQ+rO0P76dNfr7Ls/ahjdbPzqMT8Dru4OGXXUYJq44WxY51EfzTFxYmUZgW8gijIUdse+BNDfQ6rEUOxkvIlylW73tqTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773598598; c=relaxed/simple;
	bh=Vz9PUYKJkgtwj7ruYRPv+kjb21RHEit0tbbnTu9/Jxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/oZtq7iaeCD9VniMu6xkKaw+RGC8fTt0o2L3jCrQ2d3iy8eTfcjqYAHAgnrYob/ETdaTkaays4QKr2wWhEy/Wb28SG+pd7ytQAhrqAtf2mmryNEreSexvdWb33Tn313S500ITKBRelDyq4zW/9dnpvmvxOI1xiyAc5cVknAViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BLoB/moF; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BLoB/moF"
Received: (qmail 10262 invoked by uid 106); 15 Mar 2026 18:16:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Vz9PUYKJkgtwj7ruYRPv+kjb21RHEit0tbbnTu9/Jxg=; b=BLoB/moFadeikgqCRjHY9LNuY84UQIVycJVN0Mi5C+KC4XzivPJLS8YuOWu+U4BF6qDnybSxWjpkey5cZMliqL//PGVzm/DcASoVseuKkLRaKeHX9JqZASCO7HtIV70eJlIfpGPGCq0ZDvIBmoetfw+UaeGW3w3pgmK8Ty/bNxYusEeDPI9UUmXsRaByycD8g3Ra6Rx0eNzzmIzVPgRO6d/vJyf1vOhJS9xi/ic/X23DwRqnW1e2iF0s7jHDTM4BESdphZ/c6swyKl2QWfVcMIjS6tUu+kM63yB53UIK/za0h0I8VnXRM5utMKLt3pLRS9VDEDKDF4MjJUkLsvpPUw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Mar 2026 18:16:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12028 invoked by uid 111); 15 Mar 2026 18:16:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Mar 2026 14:16:29 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Mar 2026 14:16:28 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: Unexpected exit code for --help with rev-parse --parseopt
Message-ID: <20260315181628.GA953713@coredump.intra.peff.net>
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
 <20260315031447.GB926820@coredump.intra.peff.net>
 <abblhCBTgamxPOhD@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abblhCBTgamxPOhD@fruit.crustytoothpaste.net>

On Sun, Mar 15, 2026 at 04:59:48PM +0000, brian m. carlson wrote:

> > And then you don't even need to change the exit code of rev-parse itself
> > (since we'd never hit the "exit $?" that the caller tacks on in case of
> > failure). Though I think it might be reasonable to switch it to 0
> > anyway.
> 
> I can do that as well, even though I think that is actually
> substantially more complicated than the first part.  I'll write up a
> bunch of new tests for these cases in addition.

I would be perfectly happy to leave it as-is. The exit code _shouldn't_
matter anymore if the stdout result (with "exit 0") is being eval'd. So
in that case, maybe leaving it as-is might be the more conservative
choice, if the caller has somehow screwed up the eval and we want to
make sure they still exit.

-Peff
