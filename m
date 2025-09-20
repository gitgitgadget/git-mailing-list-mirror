Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4431F12E0
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758347319; cv=none; b=XlRsm3ZT5x6XMGajbC4e59osmUemDU9rvmVxxWJz0VNf5xMA7C/XnlsjybCE/ka4CAOgwDY4t/qoofBripEksebuya3kR8bQNMdJ7nR6KSkziNXQJicEPulMZVpoQg0m4lT8IdU1tnjG6Rdh7dKed83V5D4KR1dJ5zfEYAPO2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758347319; c=relaxed/simple;
	bh=EMHFE4TcIYZZt6L0wPQLbmP6W+rY05rH844Z0WLOZF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMY41S8yadYE+mVqtBe+5cP4X6TtWXe755VSt+1y07a26Yr2KVeOQBXHuTslRhii1TceN1zep7wS/srNlBOUnU0c4e4g/qrfy7oomu/otyGlGI4dsNZfD2wZMKQY1BxW15sePp7B57z2vUbXY1mGQAAV6wAQAKd9HBjosQQC70g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TEQ7lM/C; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TEQ7lM/C"
Received: (qmail 137640 invoked by uid 109); 20 Sep 2025 05:48:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=EMHFE4TcIYZZt6L0wPQLbmP6W+rY05rH844Z0WLOZF8=; b=TEQ7lM/CfRQRhlvWzO1PDhVjNE9B5R2E5OSEm6yHW5rmIsP2MVhE9PwPcPtRYXGIVj+/57Pzyzbyl9Es88Pp3tkPpn/8hUYzEw90F0IytJ4HSULv3voBP0mONcvsVoSgXmoA0xtolc7dqXGH+a7VIWB67hoqZksjAyjNdhpGjrK4FcLW9VLaV8UUGC5QRU04X5WJrTcNVbSf2UelbqBzv3NJZdY9YScAdKTFcTXzZR14G83JATgJn5GREU18NCqYzj1N9GcUUTEhUzZLqv1Oyby6ylkI3sPuGpTV+xMhsC+cPvXpwqr4LktNIJJR+NYF59c8CWKAAw5rCaxs5ChgdA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 20 Sep 2025 05:48:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 215563 invoked by uid 111); 20 Sep 2025 05:48:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 20 Sep 2025 01:48:29 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 20 Sep 2025 01:48:28 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/6] revision: add wrapper to setup_revisions() from a
 strvec
Message-ID: <20250920054828.GA996396@coredump.intra.peff.net>
References: <20250919223351.GA3906184@coredump.intra.peff.net>
 <20250919224847.GC594545@coredump.intra.peff.net>
 <CAPig+cRSQAs79oVmNqvfqhEr6K3T1FR13NwbE50A5CCMJ8RqSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRSQAs79oVmNqvfqhEr6K3T1FR13NwbE50A5CCMJ8RqSA@mail.gmail.com>

On Sat, Sep 20, 2025 at 01:10:50AM -0400, Eric Sunshine wrote:

> On Fri, Sep 19, 2025 at 6:51 PM Jeff King <peff@peff.net> wrote:
> > The setup_revisions() function was designed to take the argc/argv pair
> > from the operating system. But we sometimes construct our own argv using
> > a strvec and pass that in. There are a few gotchas that callers need to
> > deal with here:
> > [...]
> > We'll start by converting all of the call-sites which the
> > free_removed_argv_elements option. There should be no behavior change
> > for them, except that their "shrunken" entries are cleaned up
> > immediately, rather than waiting for a strvec_clear() call.
> 
> There is some grammatical problem with the first sentence of this
> paragraph which makes it difficult to decipher.

Urgh, sorry. Should be:

   We'll start by converting all of the call-sites which use the
   free_removed_argv_elements option.

-Peff
