Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B018B492
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093514; cv=none; b=AmlPkATMvQjU7kY30yowKTrqGEyCoIGiqnWTrdM18km1IT47Gs02hQ0PLvfLIsgo3GCAUdcMjWk4XAgVjP8z7FF4nQSkd7iZWG+NiM+3uJJyGNS0SXXqt1buvqe4UXAOMAaGHCOgcp84lkthNPM1/hVkgn1sLOYHGNBsUjfhP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093514; c=relaxed/simple;
	bh=SNU+poi6WUaU5vuAg9lesTQB5p89UOspmIWLtQtJMUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEd3nVS6zkDIlPK9HUG3M3WDDNQnrvUiNplwYlA4nupogSk7V3cg8H1X7NNr1+SDLWk5V3vMPbWhn1DVG9YwQIYnMvjKgvp2Nb9FYqDijYF4dKYQpcBhxQ01epSVhyhILrPly/jb0asxdbhR3brEKw1Hb3zewgY4xjfCdc+VERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OoZPBHoy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OoZPBHoy"
Received: (qmail 3463 invoked by uid 109); 28 Oct 2024 05:31:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SNU+poi6WUaU5vuAg9lesTQB5p89UOspmIWLtQtJMUE=; b=OoZPBHoyUQ4zYGjEDdwryMI7JjXXSm5ZtN9MASFmST5ra+fJnXYE00OECMI7DujkqpkL8SXn9pGl4qQu8cbwuU71nUKKtFzhj+9u656L6+9ZlxZnBepOBqhHLXqfMcpopyebE8TWLeeEQHPHnoV2VrbokfKhGeH+0KloZdfw3fRFgMBCkzRXY/lpdBJbLcTzJWFXeGRZbbsinN+lj0WhsgUwa8Ry0lRR4q9TnqCrkt0asLsrEiq+h6vCunfYns7oI0/DylSjdIPE0CcLsRyB2AJKdXWCW4jQxkV+l2CDY9tISyYW9jeI9edvWFTr3lqrFBiAzjU+OmQnFWDvwHsO6Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Oct 2024 05:31:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16541 invoked by uid 111); 28 Oct 2024 05:31:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Oct 2024 01:31:41 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 28 Oct 2024 01:31:40 -0400
From: Jeff King <peff@peff.net>
To: karthik nayak <karthik.188@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/20] packfile: avoid using the 'the_repository' global
 variable
Message-ID: <20241028053140.GA2827326@coredump.intra.peff.net>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <ZxbBuyhfq1sFKBIU@nand.local>
 <CAOLa=ZS3XjxdeYxbZCTCdaUzW4jko8ZLaKMvQsvzUnsan2Ho9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS3XjxdeYxbZCTCdaUzW4jko8ZLaKMvQsvzUnsan2Ho9Q@mail.gmail.com>

On Sun, Oct 27, 2024 at 05:23:24PM -0400, karthik nayak wrote:

> While thinking about this over the last few days and also getting some
> advice from Patrick, I realized that we don't need to be this disruptive
> by simply adding the 'repository' variable to the already existing
> 'packed_git' struct. This allows us to leverage this information more
> easily, since most of the functions already have access to the
> 'packed_git' struct.
> 
> This, plus the series by Jeff 'jk/dumb-http-finalize' which also removes
> some existing functions. We reduce the impact to only 3 functions being
> modified.

Yeah, I noticed while working on that topic that we were dropping some
uses of the_repository. And FWIW I had the same notion, that packed_git
should perhaps refer to the repository struct in which it resides.

As Taylor noted this is a tiny bit weird with respect to alternates,
which could exist in another repository (but don't have to! It could be
a bare objects/ directory). But I think from the perspective of a
particular process, we only have one repository struct that covers all
of its alternates for the duration of this process. So it would be OK in
practice. You might be able to get away with just storing a hash_algo
pointer in packed_git, which would be less weird (and is enough for the
bits I looked at, but perhaps not in the more general case).

Looking at odb_pack_name(), it will still need to take a repository
struct, since we sometimes form it before having a packed_git. But for
most calls, I suspect you could have an alternate function that takes a
packed_git and uses both its "hash" member and the algorithm.

Anyway, just my two cents having worked in the area recently.

-Peff
