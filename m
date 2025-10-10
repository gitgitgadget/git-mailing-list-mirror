Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F9227E83
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760076248; cv=none; b=Nj9M1YHxrVE1eIo8Rlk1rZPbTpLTdkeGa7SZfMDB9lL6Fo9ivP5BuRXBojw4DUfOiQHkj3kHPFb2QRli8jA0nOD30mrCypGxCsgnDF6cMRUkZEMF8JbJanbL2BOOoC8KE1S87PyUyHVGMRSAvabwOcJW4G07bt27ajmEj2p3mmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760076248; c=relaxed/simple;
	bh=E1J0EgBsyXKOOe+I0w/b6v6BsBUl1+nFGNLDe2YYv7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9K/J8m+7hEluORhAyTt9+XbVXnJWXCKslTg5a/5OTkt57RXsB7GFLoe79hIgjhhIp6LiagWZPJTv4BgINa+mougz+H+P4VDZP7/cBJp2zvy64NfoSeGT7jnAFpCf1tj/EI043dtpyVT+UyqRMVI2Wjc9yDjk0KPkHPG08uF22U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S2dDrywi; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S2dDrywi"
Received: (qmail 182319 invoked by uid 109); 10 Oct 2025 06:04:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=E1J0EgBsyXKOOe+I0w/b6v6BsBUl1+nFGNLDe2YYv7U=; b=S2dDrywiT7gWyQXMEPPr6R2vxd7jHwoAh6MfmLsgT4+56Ep31TvmtdrDNX4yAUhAoCJRHP2Mlz7gMiePdEStdDVxHRLny8snmlVV2MhGRPy6YIYpzMv9SQo35+72LYo0cMKr4Uwc2dLqkp7KUrppVTQH4JmF9B5hhekhrQKT7v5yuDGeKRQ9Qjcuqcw9RdK7V0Uz07OnWqUTAPixMPpj5MCbGZdk3GLnaVzugQMKef13rVwrYwToi/S1Ll9p730OVZu9MGUwzf9Sn3xJl4CehtFXoGBzS22e77whxaTcecmPohUE+PwDHLVYBFJ69lRgtQ+au7YmdbSF/L1ejbQDLQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Oct 2025 06:04:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 283404 invoked by uid 111); 10 Oct 2025 06:04:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Oct 2025 02:04:02 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Oct 2025 02:04:01 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 17/49] builtin/repack.c: pass "packdir" when removing
 packs
Message-ID: <20251010060401.GF1965904@coredump.intra.peff.net>
References: <cover.1759097191.git.me@ttaylorr.com>
 <df75c3130bced8d5489dc9184701a0a544617049.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df75c3130bced8d5489dc9184701a0a544617049.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:08:16PM -0400, Taylor Blau wrote:

> builtin/repack.c defines a static "packdir" to instruct pack-objects on
> where to write any new packfiles. This is also the directory scanned
> when removing any packfiles which were made redundant by the latest
> repack.
> 
> Prepare to move the "existing_packs_remove_redundant" function to its
> own compilation unit by passing in this information as a parameter to
> that function.

OK. I don't think there's anything wrong here, but it feels like we
ought to be able to pull this from the existing "struct repository"
context that's in the existing_packs struct.

I had to dig a little to find it, but I think that always comes from:

  packdir = mkpathdup("%s/pack", repo_get_object_directory(repo));

in cmd_repack(). So we'd have to recreate that string ourselves. It
feels like object_database (or I guess odb_source) should have an easy
way to get the pack directory, but it doesn't seem to.

So I dunno. I think it is mostly academic, as you are just moving around
code here. But as an API, the separate "packdir" argument makes me
wonder if I can pass anything I like to these functions. But really, it
should match the packdir used to create the lists in the existing_packs
struct. So it's kind of a brittle API. I'm not sure how much we should
care for this series, as it is mostly about moving code around, and not
providing some kind of flexible repack API.

-Peff
