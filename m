Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADEF1CACDC
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176718; cv=none; b=L0S0EEPjm83P+jjdCigPHaB2GDTq15a3wHaocn9jZ8mwu6fKyaED4p/SPZ/msbf8q5EO8cl9dVa6ZG/AC+PEsnXe5Sm16nGg/N/ajtgavbekb+GFGxU2+YySvhYQrM/hXZkOupwCBdM2OPC+7uu9HVyzk/P7YlM6b4jh8pl0xao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176718; c=relaxed/simple;
	bh=dGgbTJnN0IU1c/8yUyY+tq+ShtotcNjxbRQoOXiPpz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=br6WofILhBe2+3F3NGcB4hlg5k9Nj1ckWTFM7ejb2+oRiboa1NXAc1RP58t8BVGfGF7Zzf38WUFGi4hrkDCX+mQVsjnKfXCOiZAcbvrPCaBjNK7g7Mjz0pAJ75TpGDT7jD5Oo8RKiKREV8Jt0o8EZwwDmtmdT6atjAvpSRmlSM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZBsCqGxm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZBsCqGxm"
Received: (qmail 29252 invoked by uid 109); 21 Nov 2024 08:11:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dGgbTJnN0IU1c/8yUyY+tq+ShtotcNjxbRQoOXiPpz8=; b=ZBsCqGxm0Sj9hkIM9k9GahKQ5o7/N3sAWHrNKf8n2UO8hCW7xNV7s2JEpupDgbHnRCVfdLHikiwucJXvveoEpgJRqVedEBISRnjA0J13CWjGeDFM5IltxT+/RWEusY1qG6Kt8+6iyycuvgVebENmdN6shz+MgMNDrBOE9YIUh5f0fMl3xa3XuBSpNhIx2hGO5+1iVcmCfnCLjYj19njuXHFpM0aBxNA5ikkHSr2qMI2/ao63mANN4MHaQ6nhkjkODxcfIW6628elPn4/phYbKsLalxmuDwOywCgNlD1ZmRcdYMo7oECBKuExeUwMMvQqoXsAvC1iwoxKJnmDvQGNGg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Nov 2024 08:11:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22070 invoked by uid 111); 21 Nov 2024 08:11:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Nov 2024 03:11:51 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Nov 2024 03:11:46 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 09/27] strvec: introduce new `strvec_splice()` function
Message-ID: <20241121081146.GA581647@coredump.intra.peff.net>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-9-6154bf91f0b0@pks.im>
 <877c8yti5n.fsf@iotcl.com>
 <Zz3Y35YI9ysFabUJ@pks.im>
 <xmqqcyipijma.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyipijma.fsf@gitster.g>

On Thu, Nov 21, 2024 at 08:13:49AM +0900, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Double asterisks are typically used in contexts where comments should be
> > extracted via tools like Doxygen. We don't do that in Git, so I don't
> > see a reason to have the double asterisk. Our CodingGuidelines don't
> > mention double asterisks, either.
> 
> Should we add an explicit mention that we frown upon double-asterisks,
> even though many have already slipped into our codebase already?

A bit of history:

I'm not sure if "slipped in" is accurate here. IIRC, when I proposed
moving the contents of Documentation/technical/api-* into header files,
there was some push-back that people preferred to be able to extract
them to read as stand-alone, even if we did not support a full tool like
doxygen. But AFAIK nobody ever wrote that tool (or at least if they did
they did not share it with the list). So I started with "/**" as a
mechanism to allow extraction, but it has probably bit-rotted

Looking back in the archive, though, I think "people" was Jonathan
Nieder and "push-back" is probably over-stating his position. This is
the closest thread I found:

  https://lore.kernel.org/git/20141209222337.GA16345@google.com/

I dunno what any of that means for now, though. I am OK officially
declaring the "/**" thing something we we do not care about, if nobody
is using them. I've added Jonathan to the cc in case he has comments.

> I personally do not particularly mind people _preparing_ for that
> someday when somebody starts extracting document snippets out with
> these double-asterisks as clues, but unless/until we decide to (or
> not to) enable doxygen processing on our codebase, let's not insist
> on adding/deleting double-asterisks in new code during the review,
> and let's not churn existing code with a patch that only adds more
> double-asterisks or removes existing ones.

Like you, I would be happy not to see patches adding or removing them in
existing code. To me the point of an official declaration is just to
tell people not to do so. :)

-Peff
