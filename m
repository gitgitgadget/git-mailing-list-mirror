Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811715530C
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132951; cv=none; b=Hcyqi3MEb90ZwRuNzi3xg2GUs302RmVxqpulYG4JkvESSPjWnUSe0hHLDM37FhWSlFbgCcMhj0g9tQToEEL5QjTTWGUZfPNxEa45O1Awv3lOeUvtdY9CZmgyN1AX5hZukN5kWqa0ct2U11bMNpDhpdN3nOw54jd8+bpjRj6LQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132951; c=relaxed/simple;
	bh=4vkNjFCYkJWXpjzKFbg4MfWomcxbBS3uQdCqzoPF9hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0EXoh7VRUyP9TvTjAIGGaJPYXaOk//70sRvnp4ZS8GML7OAQBBlo7KfPTW4qKC58NdBpnw3827Mtvzchi8Y7rXe0v2ByVQ3RaCB3t7eiVgps0stHz6L2ouhoGjbZ8sG/hqrFFiyEuE8+N7Mb+2RtbnQHwlGixSinQliZbVPIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cEEY9iKd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cEEY9iKd"
Received: (qmail 21761 invoked by uid 109); 21 Jul 2025 21:22:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4vkNjFCYkJWXpjzKFbg4MfWomcxbBS3uQdCqzoPF9hc=; b=cEEY9iKdjRxZ7AmNBXGx+EQrilv4FdGh9xi4cGNtEWplM8CAjfQv5gO8nbJqXvFzxRJCoDMbWcvNG2IxifWvaP0uU93d6hZLghHacDyvb5D4BmvdvsgAjVaCjvkY9nVkKXxgSm6CbuHJ9QGYRFy4vvlFINp6QTjcvoFqhw3GcYcnA+W7mpl0yItXNT0l/kgKcVFucapLsMKjBa/xHzC8ClUEeP6+Te4PbwvHGy21C07FGxtJwsyB0yLeUBcmAPTI1ZRbLZO33i1IWT1ZTmbyeaP9qld0V9534Mq9ZXhIb5Ep+gweGR97MEqAh/y5mjQ6/LUBzI4EFlvH9Ogb6B6pWQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Jul 2025 21:22:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17844 invoked by uid 111); 21 Jul 2025 21:22:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Jul 2025 17:22:24 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 21 Jul 2025 17:22:21 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Kyle Lippincott <spectral@google.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	schwab@linux-m68k.org, phillip.wood123@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality via
 '--start-after'
Message-ID: <20250721212221.GA818305@coredump.intra.peff.net>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <xmqqple1gtyg.fsf@gitster.g>
 <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
 <20250717015402.GA2127425@coredump.intra.peff.net>
 <CAO_smVgdaOxiD_494qA+VxkmxNd6c=XqJDcCE2weCTknWfmkkA@mail.gmail.com>
 <CAOLa=ZQPOP0DkK9L5XLmA_uzH7jWwX-ti8AgaEcAF2Mon=w0BA@mail.gmail.com>
 <CAO_smVj4e0XOQyQr5sDyMZ8WPvqcBe2Y33DFHrED7C=VJnm4eg@mail.gmail.com>
 <20250717220929.GB2244266@coredump.intra.peff.net>
 <CAOLa=ZR==xihNsZcNkFPtqb1JbC+EbMHtgF-RUzdwOQp55+MOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR==xihNsZcNkFPtqb1JbC+EbMHtgF-RUzdwOQp55+MOw@mail.gmail.com>

On Mon, Jul 21, 2025 at 02:27:45PM +0000, Karthik Nayak wrote:

> > Applying this ancient patch:
> >
> >   https://lore.kernel.org/git/20171004101932.pai6wzcv2eohsicr@sigill.intra.peff.net/
> >
> > and building with "make SANITIZE=memory CC=clang" let me run t6302 to
> > completion, modulo the bug that started this thread (and which I
> > confirmed goes away both with MSan and valgrind with the fix Karthik
> > posted).
> [...]
> 
> I wonder if an alternate is to use '-fsanitize-ignorelist', since the
> MemorySanitizer is supposed to work with that too [1].

I think you could do that, but it isn't quite what we want: it is
annotating the access of those (false-positive) "uninitialized" bytes.
So you have to mark every spot that touches bytes that come from zlib,
which in Git is a lot of places. And so the patch linked above was an
attempt to silence all of those with a single line: marking the bytes
coming out of zlib as OK.

-Peff
