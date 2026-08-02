Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71959299959
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685400; cv=none; b=YLJnYdBMj9ftTSPhgzPGtzzqNBSLuiEOtS3e7YoGkSlYVmI8Rn1mLS+7mDpS9YMc0cZae3Y8hSQv3497dXU9RQWfxQc5hb2GgSvwvlCFlmwbP5SjMZv06FXj8ad/Be6DmxstTlP1KAN6OxXlDxmpyGXoIfdkcW3CQFCzqneCz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685400; c=relaxed/simple;
	bh=X89g41pMqqUniWTygUkLklyEgN94MmHacL/b+DFGDl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMI+qfLfgs8SPc7XbnvD8gAELfHy6VutiPGY5EnPsbfgi+vWqQTFI9QXb9lfQMdD23dU6zQqEEWLpN8eAgblQSgDpVxlHlMCSRhIqmJn1NvgXvTQ9WuPd5pyaVNuAPRdCyawXg1h/A1Yy5cbHl1jkYDv3VdSseQRZzN6L0lbweI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MbRg8Ja2; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MbRg8Ja2"
Received: (qmail 23208 invoked by uid 106); 2 Aug 2026 15:43:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=X89g41pMqqUniWTygUkLklyEgN94MmHacL/b+DFGDl0=; b=MbRg8Ja2a4hq8p5xIdqbwpa6wZtasKZV+dbxs0oOxMremXYEtmpQ6nwvfmCKnN2BaU1DwcXSBJf8ADBSK9Zu3hj0HpHb/nufx8+r0oHENaEnog1g/IH73iI/1UOaGpcOZ9pmQr6C/5glZkvkuXpQQa5ljBQ8zOS4XvGszviywR1+t5wsoNbg7kCNeuYFptatq9oOTZPbsBHCSwjjQgRijI8ogDFTkXkmhLdNAQn4RGpVsXrWeldf4nNLfr8uKfVhTQAvXQjh7MOZDqHfWBoyXoLiaWXhWrS9o6chtW74h3iMmDHv3yRxpCChDXVQqErfyEwLYV6dDb5wLUUM2tfwhQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 02 Aug 2026 15:43:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 33394 invoked by uid 111); 2 Aug 2026 15:43:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 02 Aug 2026 11:43:10 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 2 Aug 2026 11:43:09 -0400
From: Jeff King <peff@peff.net>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	chandrapratap3519@gmail.com, karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
Message-ID: <20260802154309.GA17844@coredump.intra.peff.net>
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
 <20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
 <xmqq7bmaa0sw.fsf@gitster.g>
 <xmqqzez67yg1.fsf@gitster.g>
 <DKDYGQRTSF2W.25OU81K306HJN@gmail.com>
 <20260801231437.GA2097059@coredump.intra.peff.net>
 <20260801232941.GA2097163@coredump.intra.peff.net>
 <xmqqpl015lfl.fsf@gitster.g>
 <DKEGM4BYZ4UW.UVJ1H8IGVF0Q@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DKEGM4BYZ4UW.UVJ1H8IGVF0Q@gmail.com>

On Sun, Aug 02, 2026 at 02:33:49PM +0200, Pablo Sabater wrote:

> I have the doubt of whether this change is desired for this series as
> prep or if I should keep on and later make a cleanup series as this
> doesn't make a change for a user.

IMHO it is worth doing now. I've spent a bit of time looking through
this code and I found it kind of confusing. In particular:

  - there are a lot of semi-opaque structs, like object_info_args. It
    would seem simpler to me to pass those elements around independently
    to the functions that need them. Likewise, we seem to stuff a lot of
    data into the transport struct rather than passing it to the
    relevant functions, even though many of those elements are really
    just used for one function call, and aren't a property of the
    transport at all.

  - it's hard to see who is ultimately responsible for deciding whether
    a field is requested. I _think_ it comes down to sticking those
    strings into the object_info_options struct (which I might have
    called "attrs" or "atoms" or something; they are syntactically
    "options" in the v2 protocol, but I think from the perspective of
    this code that is not what they are).

    One thing you could do is have the caller pass in pointers for
    "types" and "sizes", and use their NULLness as an indication of what
    they want.  That would be more like how object_info works, and then
    it really becomes a low-level protocol details to form those into
    the v2 protocol option strings.

    But unlike local object_info, we sometimes find that the remote is
    not willing or able to provide a particular type. So we have to
    return a flag somehow for "I was / was not able to get types". You
    could do that with a bool in the response struct.

    Or you could flip it on its head. Have the caller provide a bool
    saying "I want types", and then the low-level code is responsible
    for allocating the "types" array, and leaves it NULL if types were
    not available. That means the caller has to clean up the result, but
    they'd have had to clean up their local arrays anyway.

    I _think_ that's what you're getting at with your example below.

  - the protocol makes this unnecessarily complex. In particular, if we
    ask for "type size", the server is free to return them in an
    arbitrary order, or even to omit one of them (even if it told us it
    supported it!). So we have to map their returned ordering onto our
    arrays. Gross. I guess we are stuck with it, though, as the server
    side has been around for a while. And it does indeed choose its own
    ordering independent of what the client sent.

    I also find the framing needlessly restrictive. Rather than one
    pkt-line per item, we get packets with space-separated values. What
    happens when a future item value has spaces in it?

    As a side note, I think this is a good reason not to ship half of a
    protocol implementation. Without seeing both sides, you don't know
    what gotchas are lurking. But once one side ships, then it's hard to
    change the protocol later. This critique may all just me being
    cranky, though. ;)

> What I understood is that fetch_object_info shouldn't use object_info to
> store the results, because it doesn't call read_object_info() like other
> commands like 'info' do. Then, it should use its own data structure to
> hold the results with flags like wants_size and wants_type. Something
> like:
> 
> 	struct object_info_results {
> 		enum object_type *types;
> 		size_t *sizes;
> 		unsigned *unrecognized;
> 		size_t nr;
> 		unsigned wants_size:1;
> 		unsigned wants_type:1;
> 	};
> 
> All three of the pointers are nr long.

Yeah. At first I thought your wants_size is redundant, but I guess if
the goal is for the low-level code to allocate the "sizes" array, then
we cannot use it as a signal (i.e., this is the "flip it on its head"
direction I gave above).

I do think you want to be careful with how wants_size interacts with the
"object_info_options" string list. IMHO it would make things easier if
that string-ification happened deep down, probably in
send_object_info_request(). And then the rest of the code can
consistently use wants_size to see if we want sizes (and checking
"sizes" for NULL to cover the case that the server did not support it).

> This could be done in two patches, as I was going to do a prep to
> prepare the current code (size only) and this patch would add type for
> fetch_object_info().

Yeah, that would make sense.

> > It could be something we may want to
> > clean-up much later after all the dust settles from this year's
> > GSoC.  I dunno.
> 
> So I'm a bit lost about what to do, I'm happy to make that in this
> series or as a cleanup series later after GSoC which ends in a couple
> weeks.

I think the "after the dust settles" suggestion was for changing the
interface of "struct object_info". That all becomes moot if we stop
using it here entirely. So I think you should proceed along the lines of
the object_info_results you showed above.

-Peff
