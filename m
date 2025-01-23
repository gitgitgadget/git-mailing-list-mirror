Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C214BF87
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658258; cv=none; b=UuHTAz4CumDx66MGJIgVt+h++AEykVgpDS7eEyJoU6zbqhAo2vK0PT1tmVDFBX44klsJcJjptMm6t8Egcif+5mW7RHsTc8/n6S4JM4gExkPhNAO/tQHoPpXCEc/R8naHYM2GoBQWAqUChs6y1cmKtUMRY+CWNNw0jsrp5qQenf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658258; c=relaxed/simple;
	bh=NwThHqUxGf8DnvMjWWzE8t7JVnECS1n4Qa6G+YCGI54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NanRRsg7t9pXVcFZU2uhTnuT371Yt9DqTkUF0V21oKlFizccL5jCr082exXa0qVlTgpTSsE4AqQmbvgeEK3/9xaErULp2w+jIOVbIro8stjNY3BY6RCjYzeiNxR9KQc5b7LbjAABErkggA+RSMqXRCcJpBaQFB1KjalhNvl6BRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GgzYFkUr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GgzYFkUr"
Received: (qmail 30340 invoked by uid 109); 23 Jan 2025 18:50:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NwThHqUxGf8DnvMjWWzE8t7JVnECS1n4Qa6G+YCGI54=; b=GgzYFkUrrgjyTA8VXeALfLysIQ0fkciTrrLk2Xumi3Yd7O5x9rMa4+E0qrSDYgwfvGK/fB2Fl/RwCiak6XDyQoYsh2MDtdieh/FQwxbvnLP/jR4rDE2jmsUW+3Wpg9jAHdP7AWpM0akHArlpdIe9r/Xe3LtYjFllawwlHHy6jQvDDGI2P3VOnKCuUp3ZTd8oNY8qUhmrylRXXwCyMwFbfUsmKdeqBEqgJ+NmpvlPsbP4RzymKVrNtb+yi07w7nat15I61V3kd3nMFqLZzbav/975QoJcKX5v3uHm7/2KoWLGuRxcXMs+bb7tefDIDUVbLMx+3b77YYUo4xBCwjYTIw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Jan 2025 18:50:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30242 invoked by uid 111); 23 Jan 2025 18:50:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Jan 2025 13:50:55 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Jan 2025 13:50:53 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/8] hash: introduce unsafe_hash_algo(), drop unsafe_
 variants
Message-ID: <20250123185053.GA3928656@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737653640.git.me@ttaylorr.com>
 <xmqqwmelqt75.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmelqt75.fsf@gitster.g>

On Thu, Jan 23, 2025 at 10:30:06AM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > (This series is based on 14650065b7 (RelNotes/2.48.0: fix typos etc.,
> > 2025-01-07)).
> >
> > Here is a hopefully final version of my series to harden the unsafe hash
> > algorithm changes added in v2.47.0. The only difference from last time
> > is that hash_algo_by_ptr() now returns GIT_HASH_UNKNOWN for NULL and
> > unsafe variants, which is a strict improvement from both v3 of this
> > series and the status-quo on master.
> >
> > As usual, a (small) range-diff is included below for convenience, and
> > the original cover letter is as follows:
> 
> Thanks.  I'll mark it for 'next', unless there are any further
> comments.

Nope, it looks good to me.

-Peff
