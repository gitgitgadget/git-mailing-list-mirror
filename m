Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660437719
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706592315; cv=none; b=BqyuDSHlz5h8BfVFdUjvaYSYii3droAtQXFOfWuw4zGKU/rkYh6E6g+4bxxZkth9mwKYYtmDPnkZ0H9Dzu+fKXwUYZCpOpfidfiwswih8OHka9l4GttknanFeA0Fjc/Pcru8SKOefXgCuKZYSUb+NtBtqPHWHoHzkoaN9VnflNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706592315; c=relaxed/simple;
	bh=u+GjATizQr+bX35OUkiRBWHyhbLMIY1mT1yBX7k4i+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YShU+9e+qNd55gcxG2REuirs14INGgeMF4O2zKf8qDgMh4MCOYowBtzsqZAUFlprPA4vl8Kz+9SOg5H1DnMFLSv0RusiY80Dg6YzoblhQ6IhqyUNL2QUrRcCx3NNUJIPDJ7BGqAyCVDGeJjPDucghYrdyhF/Qb6P1KIuEQpErcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8572 invoked by uid 109); 30 Jan 2024 05:25:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jan 2024 05:25:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28998 invoked by uid 111); 30 Jan 2024 05:25:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jan 2024 00:25:14 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jan 2024 00:25:11 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Adam Dinwoodie <adam@dinwoodie.org>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] t/Makefile: get UNIT_TESTS list from C sources
Message-ID: <20240130052511.GC154684@coredump.intra.peff.net>
References: <20240129031540.GA2433764@coredump.intra.peff.net>
 <20240129031933.GB2433899@coredump.intra.peff.net>
 <ZbeLcrjIYd4d7PaB@tanuki>
 <20240129174918.GA3765717@coredump.intra.peff.net>
 <CA+kUOanDydgCEax9RFu_xVXkx_LeiSPOoWiUpwAg=EVQxSDJRw@mail.gmail.com>
 <xmqqeddzfywg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeddzfywg.fsf@gitster.g>

On Mon, Jan 29, 2024 at 04:27:59PM -0800, Junio C Hamano wrote:

> > As a result, I'm not surprised this worked without handling $X, but I
> > don't think there's any harm in adding it either.
> 
> OK.
> 
> I wonder if something like this is sufficient?
> [...]

Yeah, that matches the patch I came up with locally. I'll roll that into
v2.

> I am not sure if we
> should lift the building of t/unit-tests/* up to the primary Makefile
> to mimic the way stuff related to test-tool are built and linked.
> That way, we do not have to contaminate t/Makefile with compilation
> related stuff that we didn't need originally.

I didn't quite understand this comment, though. The building of
t/unit-tests _is_ in the top-level Makefile. It's just here in the
recursive Makefile that we need to have the list of built programs.

-Peff
