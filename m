Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E14309DCF
	for <git@vger.kernel.org>; Mon, 25 May 2026 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703338; cv=none; b=ZpIA3JAazc2CN+99F1YrcA4vt+2ODeB5lBfwrafE1kxKHX29gRPGTpiI7WQPN8zkPms+pQolhgkPbDK8bGaJj/+2gth8nzqkxJOPaKfZl+Vm+F5mlMlT0vVC66Mqh2I36Gq1sU0hOmv7sMijJ6B9DxBl0sGrEv1S0wCT+MZnWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703338; c=relaxed/simple;
	bh=CI3PitbuOdrC2z/rToBJa5OGWchA7sMNRoJHmGn+7TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8RNO1MqvTMiutCG6iGhrEDnd37W4lueHPlHxPzGekNywBnip2wSZ7b+0Y9L0MW10HWCs2+GDj1sUfBZ9UCU3o7xA/A2JAbdeSik1da7PhHylIKq7SNE3U4D4bgCiiufgvNFxBnlEBuvPS61BaClTqq+PYNqi/jBqsFNRFwu0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Du1HWhVx; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Du1HWhVx"
Received: (qmail 11244 invoked by uid 106); 25 May 2026 10:02:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CI3PitbuOdrC2z/rToBJa5OGWchA7sMNRoJHmGn+7TM=; b=Du1HWhVxfK/s7C9auUocFFhm38zR7+Hihs3GTigOHV1NGQpzQ4juMVGhQq5NAHr+vt0/wFqv9UcFqC6eV2Y4ZvdkQVfdrg7vp3gCz6H7VAKzKCroYlxO9HRLxExvO7Eg9pYWple7eD/a2xrx3x/e4fW/Pt9ZYZzQ/ZyCknPJIxsIlQzOLmomyOe0Ypu7TVs2pVG8jBt0K4ortLs9x5z9cjs3Iztv1pxDTY6qw/+UTlbDSh3jAISMlvJU5AuJUXkHfBf9gTLgiZnXSeupH0LXcUpXWwekN79d7zW/AfDA9bORScIOW/nv18TZ/VUaAvuKS7iM845QEOvYwStJWNqSDA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 25 May 2026 10:02:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15187 invoked by uid 111); 25 May 2026 10:02:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 May 2026 06:02:21 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 25 May 2026 06:02:15 -0400
From: Jeff King <peff@peff.net>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/3] commit-reach: deduplicate queue entries in
 paint_down_to_common
Message-ID: <20260525100215.GB3868724@coredump.intra.peff.net>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <1d3751569ba3a5f0c353fb468578d6c5bcd0b738.1779644541.git.gitgitgadget@gmail.com>
 <xmqqpl2kgyvy.fsf@gitster.g>
 <ca39c8ca-ca4c-4954-a1ab-633bfa55f64b@gmail.com>
 <CAL71e4NxpbM8QZYhVA_SSC4vDmAFv-Kpe6qDcurefgPkSSdSnQ@mail.gmail.com>
 <xmqqse7gez5l.fsf@gitster.g>
 <CAL71e4ODJeCJctKg=3o9PKD6Rw3_xHnrjc+zT_MYFc=CdNc59A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL71e4ODJeCJctKg=3o9PKD6Rw3_xHnrjc+zT_MYFc=CdNc59A@mail.gmail.com>

On Mon, May 25, 2026 at 09:53:09AM +0200, Kristofer Karlsson wrote:

> Good catch Jeff! I think it's possible that I missed the flag cleanup case
> here, but it's also possible that I got lucky and it worked anyway.

Well, you did add it to ALL_FLAGS, so it might have been your
subconscious making you lucky. :)

> That said, I think the observation in the other email thread/commit is key
> here. I will reply back in that one, but it seems like this can all be
> simplified using Jeff's idea with an amortized O(1) solution by caching a
> known non-stale entry in the queue, and thus becomes obsolete. I will post
> a new patchset when the discussion slows down.

Nifty, thanks.

> As for general flag management, I will spend some more time thinking about it.
> I don't fully trust static code analysis to work, but some cheap assertion
> based model might give a nice trade-off.

I think it would be really nice if we had per-operation flags kept
outside of the structs completely. If you're a masochist, I fiddled
around a bit with using a hash instead in this thread:

  https://lore.kernel.org/git/20250826055210.GA1031277@coredump.intra.peff.net/

It's sadly (but not surprisingly) quite slow. I do wonder how a slab
would work there, but it would take a bit more surgery. We only allocate
slab ids for commits, and we'd have to do so for all objects if we want
to hold flags.

Probably a dead-end, but it would be neat if all of these flag
allocation worries just went away.

-Peff
