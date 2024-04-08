Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8FB142E9C
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596190; cv=none; b=eO2dzVMDTVK6BMV/iRhBZFcbUnJULz+HnQVx7movn6iIYYs4Q9qDT43Yy6FPoUcKanGEwhOc11fs+2O9gDcXn1QjUDrOwn7Gbojkl3eEcI6GOJX9sF/gIchtAIQ0GK282fNpuVARv/RO5G1UcnJ1hsslfrSwdA2xsdrjavNc+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596190; c=relaxed/simple;
	bh=eTNqC5Q8n2t+BwVlCQBqR5uPdGuglZh4DCVOEJDTf3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkUr92+irKaPNN2h+Y4Jv9wyp9iy7EHz2YUZPtGJ+xU0OBabuqRelJywu411c9L1LYKoPinMRTt9wEDPGVQbIQqg/DfebQi9Xd+xc6kcZZpi6FM87wHx1AxT7KrieUkPG4Ydtmvnt8jYV0lqO35NjiqfoSRB6JrSunHh5X5ovKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 30837 invoked by uid 109); 8 Apr 2024 17:09:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Apr 2024 17:09:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27255 invoked by uid 111); 8 Apr 2024 17:09:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Apr 2024 13:09:40 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Apr 2024 13:09:38 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [RFC][PATCH] t-prio-queue: simplify using compound literals
Message-ID: <20240408170938.GA1629595@coredump.intra.peff.net>
References: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>
 <20240402204153.GE875182@coredump.intra.peff.net>
 <c6cb255a-72f0-4ac2-81a2-1d8e95570a81@web.de>
 <20240405191714.GA2561807@coredump.intra.peff.net>
 <xmqqedbjtqnr.fsf@gitster.g>
 <20240407012844.GC1085004@coredump.intra.peff.net>
 <xmqqo7ajdc6y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7ajdc6y.fsf@gitster.g>

On Mon, Apr 08, 2024 at 09:57:41AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> We should still be hesitant against the practice to the same degree
> >> that we are hesitant against struct assignment, especially when the
> >> struct is of nontrivial size, or the struct has a pointer member
> >> whose memory ownership semantics goes against shallow copying of the
> >> struct.
> >
> > Good point. There are really two thresholds: is this something that
> > should be totally forbidden, and is this something that is generally a
> > good idea. I think the answers here are "no" and "yes" respectively.
> 
> I agree with your conclusion but I found the above a bit confusing.
> 
> Between "totally horrible, do not even think about it" (0%) and
> "that is of course an excellent idea" (100%), you want to have two
> points "might have some merit but not acceptable" (33%) and
> something else that is less than "of course an excellent idea" but
> still acceptable (66%)?  I would not phrase the last threshold "is
> generally a good idea", though.  "It is not generally a good idea,
> but in this case, it is an adequate solution", maybe.

Sorry, yes, I flipped the boolean on the second one. I should have said
"is it forbidden" and "is it generally a bad idea", in which case the
answers are "no" and "yes".

Or if you prefer, as I stated it, the answers to both are "no". ;)

I.e., it is OK to use here but it is not something we should be doing
all the time. Sorry for the confusion.

-Peff
