Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B94DA09
	for <git@vger.kernel.org>; Fri, 10 May 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372186; cv=none; b=s9eAmKHMvoMz5g1EkeVJU1UKigVQv2gHojkghU5Q4shN01cu0fywtCmF+AZ3WMdgOilO8DXpkIHerkXqx5JRmUkDfdNPaGnP0QE0QvA+bm6P/m9DuAwFT7/8wwXlweG0/5PIlygeUTY374tYi7x7+PBV+TKaJoB2Dn4C90R9h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372186; c=relaxed/simple;
	bh=s6cuThzsdSUvXdOzZfxcBKurEiJZz0Js6jHHVO2Knbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4TMoRbjkfHqxBdaY/cHr1ETXaGopCmgBNtVTUX4wzH1iW3aKc1w+QuWz1frV1FYpDw6xIqrJcZOFoLVGBZY3fio2cCwBrS27157obFqmIPWZKs9dm0Yg0Iw1hKPIm76IWylI0IckxXLNmk8CD5GwmUqAthGawx9TJ2cQQwxisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18999 invoked by uid 109); 10 May 2024 20:16:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 May 2024 20:16:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12433 invoked by uid 111); 10 May 2024 20:16:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 May 2024 16:16:26 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 10 May 2024 16:16:23 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
Message-ID: <20240510201623.GF1954863@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162415.GB1708042@coredump.intra.peff.net>
 <Zj3F_paYzkQUC9fC@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zj3F_paYzkQUC9fC@tanuki>

On Fri, May 10, 2024 at 09:00:14AM +0200, Patrick Steinhardt wrote:

> > We'll eventually have to bump "gcc-13" to "gcc-14" here, and so on. I
> > don't think we ever cared about gcc-13 in particular; it's just that
> > older versions of the runner image had some ancient version which we
> > wanted to avoid.
> 
> As an alternative we could munge PATH such that Homebrew's GCC is found
> before Apple's.

Ideally, yeah, but it's not just a PATH issue. AFAICT there literally is
no "gcc" in any PATH, only the version specific ones (even if you "brew
install gcc").

So you'd need something like:

  for i in /usr/local/bin/gcc-*
  do
	# rely on sorting of glob to do last-one-wins
	gcc=$i
  done

-Peff
