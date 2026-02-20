Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475B30DD3B
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771590548; cv=none; b=A8ogjOKGwdWzYQ9BiI9UUvQQeMwCMhDwnBc9roEVRfsfsPvpgUIpkop5QnnY9MU10kLEWf0zf3gwfLTo1mCROrkdFxPL1AqhQtf2Jiak308M3KGIcHTqRzuZzCKuGqR5qRAX+6P3s6RL2CzJ6lBhelvD9cIWAglV3DFy9nB4BI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771590548; c=relaxed/simple;
	bh=zkg1079HHxTxp4Jdo5l+2HjZb3xqjV2yLgHSnqu6e+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCcdkvKEXqBDiW8zT15cxQ1k4Sbzkf2sYCXcExUBFn86CN0z2Oecyxssj15u1CvP6MHSWNzd9ZAwURnQUyTKPwgaCed1HPqtfx2rXgNrCCiPaAn15Shcv/OdTKuSiIvS7Eclc6NYyqoI9gkWdlmwbtfagVhf1NWC4YpsboWXqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BUk4Only; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BUk4Only"
Received: (qmail 16645 invoked by uid 109); 20 Feb 2026 12:29:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=zkg1079HHxTxp4Jdo5l+2HjZb3xqjV2yLgHSnqu6e+A=; b=BUk4Onlyo87iPx8y7IHe8R3zlp8jIKIm7RdvwdLm9R1DgjQD5Tly+sIN/Ar+CyBFbLN4g0RJFJNVDFzCAZg/2DBoXaDPNU1YnZ3MuQtggAlWsCZ5EI0tgNosLIh/m/lJ/ETICQoIxj5yul/ggp/N49dE7suMMD7urCbbx3WpuWBNhQtrH0R4yqjBkpJ/oXqiFUunxrob6Rnku6RV16n+k0LyjvvWsqdV0js29h1wE7x6RaW6ThvKW2CNK/rWwq3QLr3aEWyrKYQ4H4Migxg+lEKc+yvNL8V1JNAldSbX2CSwdGiQnJvdAVNM2tK6iPQm0lz1pfMYBDSqC++JjRtPzw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Feb 2026 12:29:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25508 invoked by uid 111); 20 Feb 2026 12:29:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Feb 2026 07:29:00 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Feb 2026 07:28:59 -0500
From: Jeff King <peff@peff.net>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 1/2] format-patch: make format.noprefix a boolean
Message-ID: <20260220122859.GA612853@coredump.intra.peff.net>
References: <CV_format.noprefix_boolean.39c@msgid.xyz>
 <format.noprefix_boolean.39d@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <format.noprefix_boolean.39d@msgid.xyz>

On Wed, Feb 18, 2026 at 09:26:17PM +0100, kristofferhaugsbakk@fastmail.com wrote:

> This is a breaking change. And as far as breaking changes go it is
> pretty benign:
> 
> • The documentation claims that this config is equivalent to
>   `diff.noprefix`; this is just a bug fix if the documentation is
>   what defines the application interface
> • Only users with non-boolean values will run into problems when we
>   try to parse it as a boolean. But what would (1) make them suspect
>   they could do that in the first place, and (2) have motivated them to
>   do it?
> • Users who have set this to `false` and expect that to mean *enable
>   format.noprefix* (current behavior) will now have the opposite
>   experience. Which is not a reasonable setup.
> 
> Let’s only offer a breaking change fig leaf by hinting about the
> previous behavior before dying.

Thanks for following through with this. I probably would not have
bothered with even the fig leaf, and just considered it a bug fix. But
since you bothered to write it, I don't object.

-Peff
