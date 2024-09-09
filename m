Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7813B2B0
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913265; cv=none; b=IcnvHNB5VUEl5BTEr1dzNSHGP1wHXQeFtXQO+TeLCMtgiOgQ/5PNaWRGmo1u7Xi8QuTKVkL6utrs4FZmP6+1BInvErN+uhbTdP6KWqr2CopzQzlGRdt4hBJ7+cqKXaA5lnMSgInwVNqLyA2mwcSg+UcUlIV7TRw5j8wdbDgNiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913265; c=relaxed/simple;
	bh=cOPpg0S514AjCu1hE0NOZ5nSC7yHKMSdIvxJ9GmAV14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nax6rbJYWyMGHr8lkzX68CDOn5rIA3QV2pCMzXhYZuv5C2oMjq+zBWUp2jfDyuLjS4h0KZAZNIjP63FTn0iC1yDChei9geOR1lJuGSYd67V6NqjkqPTBbJMQMjpDJPGGBtZj+DO4YTi69vq50Mohlxk54k4mD+rMuvfFcUltRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31000 invoked by uid 109); 9 Sep 2024 20:21:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Sep 2024 20:21:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22577 invoked by uid 111); 9 Sep 2024 20:20:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Sep 2024 16:20:58 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Sep 2024 16:20:58 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: header signatures for hash transition?
Message-ID: <20240909202058.GA348398@coredump.intra.peff.net>
References: <20240908233636.GA4026999@coredump.intra.peff.net>
 <Zt7Deq2vzZKSTbfU@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zt7Deq2vzZKSTbfU@tapette.crustytoothpaste.net>

On Mon, Sep 09, 2024 at 09:44:26AM +0000, brian m. carlson wrote:

> > We still separately find the start of the in-body signature and return a
> > "size_t nonsiglen", though it's a bit awkward (it's counting from the
> > body start, and I am coming from the subject start, but if we assume
> > they're contiguous, it's just a little pointer math). So if this
> > approach is still useful in the long run, I can work around it. But my
> > initial approach (before digging in the history) was to drop the
> > separate buffer, something like the patch below, since it also drops
> > some useless extra copying of the tag contents.
> 
> It was probably that this code was to fix one or more of the
> signature-related atoms in the tests, but I can't speak to it more than
> that.  I trust that you'll make a suitable change that fixes the issue,
> but I'm afraid I can't be more help than that.

OK, thanks. I'll proceed with something like the patch that I showed
earlier. It shouldn't change any existing behavior, but I wanted to make
sure I wasn't going to make life harder for you in the future.

-Peff
