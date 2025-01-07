Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DFC1DFDA2
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233270; cv=none; b=auqzgxEsMYa0mjWmZ+gtZzN9Ow3TLcTyCzy+d8nYKmqtvEggM2oAuH9+yqmr5Mc//uiexAdgZcpvFmS3fkUtnPPR1Xp4aMl9WKKhlZ1NMCKxZeVSu0jrvAhBCv7BAz5U4cQ3pquzhETIYcR8xsh9Oylnnx8r1B/VnJDij5HVHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233270; c=relaxed/simple;
	bh=fb/+wV4Wi31e4xA5WvjHF7VXu0dFzr9S9ik6Y63N/OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbl5pB7F7HXlOJU0aKm+awSEC4KdDZr2FtvqJqU6B85KoJrB0yFnPDBgOcyo+ptJP159Ze7QB51HeeKEyfmLZ+8rfA/7kWQiLlUN4TSWbafE+JDWfENdlW1FQCfCtiC64koqYoBRdsUwY9ejw7TmiIlPADPjNL5pjn5cW/0aMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hnxlyn+u; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hnxlyn+u"
Received: (qmail 28969 invoked by uid 109); 7 Jan 2025 07:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fb/+wV4Wi31e4xA5WvjHF7VXu0dFzr9S9ik6Y63N/OE=; b=hnxlyn+ujKgiiiGSoNGL3xcNP/NyWwhQJJNv+s7DePN+10ZWfxAyeQy5G20YFgl6mmB66rqWFgUiq5zhQoQjECtYTX7i1vxGEbNdW1eqja0J7MYFyWN/hvCOIFBiV/MoqBZwqusTjM8WQ2WyceHCLacg0CJrg72F8IuXo1K6F96idmKQocG3WiZNsgsP8nr34+x9Iw7Pt9YQEy3lI8c/l7m2cZO2Le3SzNVj9VD2DVY0TYUSAXQdWnM7uh1+8ft98qEwZdP3Z3/yJRpxgOio+oYFqpdb/0lqO9id9D+iieMoLMmoROBe3WiTYSWr9KEMTTQrh8r+RO+YfwiC61jnug==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jan 2025 07:01:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21781 invoked by uid 111); 7 Jan 2025 07:01:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2025 02:01:05 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jan 2025 02:01:04 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/6] test-lib: simplify leak-log checking
Message-ID: <20250107070104.GA584401@coredump.intra.peff.net>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
 <20250101201721.GD3305462@coredump.intra.peff.net>
 <Z3fSmSYoWs-a6afW@pks.im>
 <20250103202410.GC3212696@coredump.intra.peff.net>
 <Z3uMyQ-YfQFI8qmH@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3uMyQ-YfQFI8qmH@pks.im>

On Mon, Jan 06, 2025 at 08:56:57AM +0100, Patrick Steinhardt wrote:

> > Plus I don't think "find" propagates the exit code from -exec anyway. I
> > think you can check the exit status with more find logic, so you'd then
> > use a conditional -print for each file like:
> 
> It should. Quoting find(1):
> 
>     If any invocation with the `+' form returns a non-zero value as exit
>     status, then find returns a non-zero exit status.

Ah, right. I tried using ';' to look at individual files, and it does
ignore the code. But of course we don't need to know which logs had
leaks, only that there was at least one.

I think we can make it even simpler, though. I'll post patches in a
moment.

-Peff
