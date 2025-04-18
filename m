Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528E21171F
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745013446; cv=none; b=cYMLveeoRc9Td1JgIXAvDFa/jMG4uAknC1w2nLSAEzeFEGxY3AGglzoyA/kzekUi9ls/bPWAF76Db5VwvJGnLaor0iYKkidiRokS7tP1I3vWKQH28aS6P+Rp3l6UTqn084o1+U/fKHj3Qg4Vwd7X9KUYGDGXlhYgxplwx7k+dzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745013446; c=relaxed/simple;
	bh=F8zz5/MYi1ajlReToztw8PsVXUNJWrGXmQ5S4/z80QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX7Au8FJJkfQif5ehz+2bYpQuFjZtiZhWEUj36Y1IFl9vx/Oku9O3XsifbWIlGAWkaRM6PV8P2oQ0xxVODaQ2hsaqALEkhTLs0X/W/yN0VhuYnz9pccZ1Uzud9kjnacifo7AMCpI92NlVaGNriAeoxRgpthrRlm2qk8RgC+WT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aXXcHPLE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aXXcHPLE"
Received: (qmail 20350 invoked by uid 109); 18 Apr 2025 21:57:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=F8zz5/MYi1ajlReToztw8PsVXUNJWrGXmQ5S4/z80QE=; b=aXXcHPLE4GeKamogO03S175OWipBSZDLX9Fv5QMGSoLeBBvdO4TqRB2bseXg2QXgFL72XHplZCtFikdmj3iDswTIltR4GiDBQdhapTyJDtwDl++/fDPGJ0Zb/4x5fw2wIsAwM1AiKSPw0HzuFHU2uIieWiKbP2bRdmSSNhV8SjJt85LyEjr02+NFqyUIolXTSeioU4zJpLAQ9wxNitzVLWEpMsxZC7YD5EeW79HhWkb931O+3komzRhN1TcZjmVl1OnUiLoHM41zDE8F1ToWQkjPglqvhVHLB48L7yFGL/8QrpdvFSJpJf006g3noqrsKCE71UMW4U0wUD6AOXLDRg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Apr 2025 21:57:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8389 invoked by uid 111); 18 Apr 2025 21:57:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Apr 2025 17:57:26 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Apr 2025 17:57:23 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Anthony Wang <anthonywang513@gmail.com>, git@vger.kernel.org
Subject: Re: aw/t9811-modernize, was Re: What's cooking in git.git (Apr 2025,
 #04; Tue, 15)
Message-ID: <20250418215723.GA91116@coredump.intra.peff.net>
References: <xmqqbjsxkn6x.fsf@gitster.g>
 <20250418213531.GA89733@coredump.intra.peff.net>
 <xmqqtt6l9mlj.fsf@gitster.g>
 <xmqqmscd9mbl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmscd9mbl.fsf@gitster.g>

On Fri, Apr 18, 2025 at 02:44:30PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> So I don't know if git-p4 got smarter, or what. But we should probably
> >> back out at least that part of the commit until we figure out what's
> >> going on (where "we" is somebody who cares a lot more about p4 than I
> >> do).
> >
> > Yes, and there was another breakage in that 2-hunk patch in the
> > other hunk I sent out a fix for a few minutes ago.

Oh, sorry, I totally missed your fixes. Obviously, yeah, your patches
look good. ;)

> We seem to have quite a many ubuntu/linux test jobs, none of which
> failed due to the obvious syntax error in t9811, which probalby
> means we are not running p4 tests at all on any of our Linux jobs.

I wondered that, too, but then I pulled the instructions for downloading
p4 from ci/install-dependencies, under the ubuntu heading. I wonder if
that is not triggering for some reason.

-Peff
