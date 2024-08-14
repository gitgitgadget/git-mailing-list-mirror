Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474C29CFB
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723620775; cv=none; b=hE6xWccne213hmFQwe1+hy2OAzxPZm0Tv0PQNVuotXAAepH/3GrOh3EbpQ79guhXsSVs+dOpOQFhWRu4pJH+G0xP2nXrWupq+uOwIBg8VNtVYGXigqqrrWJpmGVkIFsOQLouJljDkX1adQ/gjJfcVTWkAB/51L/5+osFPO1p7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723620775; c=relaxed/simple;
	bh=JppbXpZCTb3MqJBdy5f/fY1FTEBv/jiw17aY59cq0v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiECOTxvjAO3yPjln4Q24BQk/XMIg9VFzalUmxYiHNuVWAddOUfHdOVrQLToW/v7KFAjt2t+/i4/wIu2r10qPNv31GsEWOyj/toEzNDbiT9ffeDsLhsNrLhTrmz1m7sSol3PwIN62jNtTHMrieDm9/4Cf24PbGg0xp8FFnGqEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11751 invoked by uid 109); 14 Aug 2024 07:32:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Aug 2024 07:32:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13562 invoked by uid 111); 14 Aug 2024 07:32:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Aug 2024 03:32:56 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 14 Aug 2024 03:32:51 -0400
From: Jeff King <peff@peff.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mike Castle <dalgoda@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Heads up: GMail regularly marking list messages as spam
Message-ID: <20240814073251.GB2077794@coredump.intra.peff.net>
References: <CA+t9iMyT8fAR_fvQXOer=ivLnNKDnH8g_M8iQiq7gdrnfG7aCg@mail.gmail.com>
 <Zrp7yNKMxhPk6Tyt@tapette.crustytoothpaste.net>
 <20240813-sociable-fresh-whippet-3ee335@meerkat>
 <Zrvbpt3Fkl8yjesP@tapette.crustytoothpaste.net>
 <20240813-rampant-quokka-from-betelgeuse-4bc3c9@lemur>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240813-rampant-quokka-from-betelgeuse-4bc3c9@lemur>

On Tue, Aug 13, 2024 at 08:10:17PM -0400, Konstantin Ryabitsev wrote:

> > And from a personal point of view, it is definitely useful for me, as
> > someone who manages their own mail server, to heavily negatively score
> > all email without DKIM, but I can't do that because vger doesn't add
> > any.  That's the only thing preventing me from doing that.
> 
> There is a small subset of active git mailing list posters who send mail that
> is not DKIM-signed, for example Jeff King:
> 
> https://lore.kernel.org/git/20240813124550.GC968816@coredump.intra.peff.net/raw

Uh oh, now I feel singled out. ;)

It's true that I use only SPF but not DKIM. FWIW, I haven't had a huge
problem with deliverability. But if the world is ready to move on and I
am one of the last dinosaurs holding things up, I'm OK to be told that I
really ought to implement DKIM to participate in the list.

> However, signing their messages with a DKIM signature from vger.kernel.org
> will serve no purpose, unless we also rewrite the From: to match the
> vger.kernel.org domain. The From: field would need to be something like:
> 
>     From: Jeff King via Git Mailing List <foo+somemagic+peff.peff.net@vger.kernel.org>
> 
> This is called "From-munging" and is not acceptable on any mailing list that
> sends and receives patches, because this changes the Author of the patch.
> 
> Thing is, this has nothing to do with vger, because if Jeff emails you
> directly and you set a high negative score for messages without a DKIM
> signature, you won't get his mail either. The fact that it traversed or didn't
> traverse vger.kernel.org has no impact on that.

Yep, agreed with all of that.

-Peff
