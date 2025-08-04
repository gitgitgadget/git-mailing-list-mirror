Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06036A41
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311348; cv=none; b=EbyahQW9In/pfvrA0/Q0SEcN/ZrqfgKmklS9A+1+ztXauZDTO/kD1q0zpbbNNo98+7+kA/oVXGWFzfGmDeV5dh57Rwq5gjjBIlsEp6nDgSGfHF9d2g4SiDuWcz8Y1I9sviotIFiGxGPKM9jKig4Kfcj2NZEjU0/aNtxgtnBEjwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311348; c=relaxed/simple;
	bh=ke1/BjaBUHCld1MEb1dy4PtZ+7XQn7v50az9mwOSg8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZ8dBAFiufY6PrgC6DMFCQ5kDTStCa37k+aq7GENi14oJmHwD6616acWL/Kvm7jI9XZFxCJkQMT/+qPtJyJBk9XqpWOU68v6GDnky73yJeWDUOGBSjD35pz+Q/iJUAOKMfnLUbIWE4d1iFkarTZ8MCll5d78Z3nz7WXnltG2bxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cFXGes9A; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cFXGes9A"
Received: (qmail 597 invoked by uid 109); 4 Aug 2025 12:42:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ke1/BjaBUHCld1MEb1dy4PtZ+7XQn7v50az9mwOSg8U=; b=cFXGes9Ai86Z3Rqej2kdm661rGH5zxR3ILf8WC12P16pvvi7FwLM9khmWg4I48Xhy7nfBF1+2SYvHgKTTCr+xFMaY27k/JEDy2GNkHlxJiiLmhH5/wH2PkCCpePIff4SdzGIVoVoPxc8f+sgh1XYWbxDb2NFgDC9AyLktWhjNm54iEB1Ykl5wQPk+etUXru6xRzzzGH6o1xTkqzYZodXDVXJ/mHR1h4A40PNVP2Ja7u5EWBzHdVDca/NZiNJrwlUxgaJ1r65izB2O8qJX921Z2edl72tB6Zsj7QiHYmhaKC0FVp4WoXlSMh3MiO42ANsmH/CL+bIS3wIiEkw5rNblQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Aug 2025 12:42:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18824 invoked by uid 111); 4 Aug 2025 12:42:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Aug 2025 08:42:19 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Aug 2025 08:42:18 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Lidong Yan <yldhome2d2@gmail.com>, git@vger.kernel.org, hi@arnes.space,
	michal@isc.org
Subject: Re: [PATCH] diff: ensure consistent diff behavior with -I<regex>
 across output formats
Message-ID: <20250804124218.GA86602@coredump.intra.peff.net>
References: <xmqqikjg47qt.fsf@gitster.g>
 <20250729081820.34626-1-yldhome2d2@gmail.com>
 <xmqqcy9io73j.fsf@gitster.g>
 <20250802102249.GA3738980@coredump.intra.peff.net>
 <xmqqtt2nd7k6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtt2nd7k6.fsf@gitster.g>

On Sun, Aug 03, 2025 at 09:39:21PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > .... It affects all of raw, name-only,
> > name-status, and checkdiff. I know Junio said that --raw should not be
> > affected, but I'm not sure I agree.
> 
> I no longer am sure if I agree.  I do not mind a raw entry that
> would show different object name for preimage and postimage for a
> path to be omitted when --ignore-whatever is passed and the blobs
> compare "equal" under the specified "ignore" criteria.
> 
> The behaviour sounds somewhat incoherent, but that is what the user,
> who passes both --raw and --ignore-whatever to the command at the
> same time, wants.

Yeah, exactly. It definitely is weird, but it feels like the closest
thing to what the user asked for.

Just trying to play devil's advocate on this whole topic: is there
anybody who could complain about omitting these entries from raw or
name-only lists? IMHO it is weird and a bug that:

  git diff --name-only --raw -p -w <commit...>

might show an entry in the name-only and raw lists that doesn't also end
up in the actual patch. For just:

  git diff --name-only --raw -w

it is easy to say "well, why did you pass -w if you did not want
content-level inspection?". But when they are combined, could the
current behavior ever be preferred?

The two counterpoints I can think of are:

  1. Maybe that is an interesting signal to somebody that the diff _did_
     touch that path, but it just had no content-level change. I am
     having trouble imagining why that is useful, but it's not outside
     the realm of possibility. And certainly you could get that
     information separately by running a tree-level raw diff (without
     "-w") followed by a "-p -w" diff (and if you use diff-pairs, that
     second diff can even skip doing the tree-diff again).

  2. 99% of the time, "-w" (or -I, or whatever) will not remove the
     entirety of the change from those files. So we will do a whole
     content-level diff just to say "yep, we still should mention this
     in --raw"). Is the extra computation worth it?

-Peff
