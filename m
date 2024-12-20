Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8A1A9B3E
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684989; cv=none; b=C7V3zugYnUVtWCe7g6y+DRdwSArXEqr/PzLNrxHXEczNdD9UQJb5RGVTjeb0PFlxN6mHuk961cIVshGVc2Ga6OCQsKxWnsoShWGuvWsMaH5e7/5AZtc4c9hmojr+mly+Kn2PyHCTw10xF0s740BJ5QlCYNmCEK4Stl9hVHRdS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684989; c=relaxed/simple;
	bh=8rHhECz+JUE/su4dg5yaj9iJveUhXonlF4Jq5iTjE0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvMxx7Q2U2Fafe4z0zFUJuiOk2wImcCNa3INJ37acetswdEnOFxa6/RYbXiqcDPtWB6mAuzUfyPwdUsWr5Ualbx+DrNqbvhVZwAFHCJHM/Vn1EAHi44GvSPk1WMNZZRxty6MA5XWDnn19ac23v/sZo3+u2zs0u/tRKzvUNVadRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BCOR4UpH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BCOR4UpH"
Received: (qmail 8440 invoked by uid 109); 20 Dec 2024 08:56:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8rHhECz+JUE/su4dg5yaj9iJveUhXonlF4Jq5iTjE0o=; b=BCOR4UpHUj5ApiyNdY7F61P/ogFsVTZiVRo8RxjlLaYLy/scfViL18RUm2D0OPerCYAPopTt7oinw17oSSvtB+2bq+W95LpUc2pdM7QgjakyNTZpohZPvAuPoLPR0nTGfDO4F7m2EIShTSniWitbIja50ygvEMbsQ2SP3ZD5h77PteUOs+SPrDDiaA5r/xLp8OWHiYC5aJZqE2q8ucxUweR9XugtUwTQLnpXOdiPtjdB/U+Zv0OGWv4G0/mJgdgl/lZ+5EBoPhiyoXHftMJpDEE5YgeRa5/HlByBf4a0KYtO9iKTCgTCZ3ezurmB4uPqhWWp+zuJ/IC1oOOWApoAbQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 08:56:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14386 invoked by uid 111); 20 Dec 2024 08:56:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 03:56:26 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 03:56:26 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH 1/2] GIT-VERSION-GEN: fix overriding version via
 environment
Message-ID: <20241220085626.GB133148@coredump.intra.peff.net>
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
 <20241219-b4-pks-git-version-via-environment-v1-1-9393af058240@pks.im>
 <20241220073437.GA2389154@coredump.intra.peff.net>
 <Z2UlpaDFjvl--zau@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2UlpaDFjvl--zau@pks.im>

On Fri, Dec 20, 2024 at 09:45:36AM +0100, Patrick Steinhardt wrote:

> >   version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
> >           $(QUIET_GEN)GIT_USER_AGENT="$(GIT_USER_AGENT)" $(SHELL_PATH) ./GIT-VERSION-GEN "$(shell pwd)" $< $@+
> >           @if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> > 
> > Should we do the same thing for GIT_VERSION? And GIT_DATE, etc? If we're
> > going to do many of these, it might also be easier to just add "export
> > GIT_VERSION", etc, in the Makefile.
> 
> I guess. It'll become quite painful to do this at every callsite, so
> I'll add another commit on top to introduce a call template that does
> all of this for us.

Is there any reason not to just do:

  export GIT_VERSION
  export GIT_DATE
  export GIT_BUILT_FROM_COMMIT
  export GIT_USER_AGENT

in shared.mak? Then you only have to do it once, and no need for
templates.

-Peff
