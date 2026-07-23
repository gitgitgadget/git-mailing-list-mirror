Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BD939D6E7
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784803786; cv=none; b=oBk/m6RPjG/gHG6JZ5jMBXJ15PcYjQvtpQGxSvBzCom/iMH2Mo1D14BlFJnbCA/Xa65RzJyoYdWxrXqy3xc0BM4TmLemod9Cv9FZKiA3KRCmpikv3AOs85FlkAiwN7aHprV9rQuxQ90yp+OJRqnfkk+PdvLxp0T3p/97tG+/7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784803786; c=relaxed/simple;
	bh=lvXQ6KtaQ82OOL77GEyaww+TS8Vqgk0ZxK802Gxc8PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LK+9E90FD5jeXqSu9PeUQPqDR2KE2uLidS7aYzncH9zqKs0WYGpAOhQmk+S9DoT1DpzCWsRIKJO7mo0PvZA9Fqpk4+PlOKCpgpRlQjc8U1cgbr0pQfdkmTOQox2aXiRsBXIYYVvXh4QwEscUFjl+Y3G6LnFjcEA7iPhU35rHeis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=afNVderA; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="afNVderA"
Received: (qmail 24768 invoked by uid 106); 23 Jul 2026 10:49:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lvXQ6KtaQ82OOL77GEyaww+TS8Vqgk0ZxK802Gxc8PQ=; b=afNVderAWSsaZaAXb37xl5iSPs8voW9Tfj/5JEgI8xiy6TNVFJ9Gq3o8TQHvWfm/v3He+kVLx0xR7P1Z5fIkbX1jcZA6iyQkKZHQUQi6DVwSNdYjYJqtr0dGqDGhumyfRYCwZmGpmUOOgmDaBqx0un4dO8Emuf8mSjkd5Qvzn5Vn91zONGd54iuLC4SOauDLWKWomc2ndKwdxH/SdjDMzHMK/aUCE7O0SL9nkqnGtKkdFDTAnl6ih+u+WeRQrkSluVmuCDVTDZYEzyQ52m1krOjn8kLxRUmOElzuylZUOZvMv8ya+Qz8Yt6CFyHid6NQ4PrFz5R8OgLQFczj5Tgppw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Jul 2026 10:49:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20029 invoked by uid 111); 23 Jul 2026 10:49:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Jul 2026 06:49:43 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Jul 2026 06:49:43 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Wolfgang Kritzinger <wkritzinger@atlassian.com>,
	git@vger.kernel.org, jltobler@gmail.com
Subject: Re: Performance regression in connectivity check during receive-pack
 (git 2.54)
Message-ID: <20260723104943.GC604358@coredump.intra.peff.net>
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
 <20260721035733.GA581473@coredump.intra.peff.net>
 <xmqqtsps76f1.fsf@gitster.g>
 <amCuLpT6vYzo1GF8@pks.im>
 <xmqqh5lrrplt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh5lrrplt.fsf@gitster.g>

On Wed, Jul 22, 2026 at 08:49:50AM -0700, Junio C Hamano wrote:

> I suspect several of those 'transactions' are actually misspelt
> 'temporary directories', but I catch your drift.  That said, a
> redesign like that feels more or less independent of the fix for our
> immediate performance regression.
> 
> After all, didn't Peff show us a case where no odb sources were
> being flipped in the middle?  Simply setting up one object store to
> borrow from another via the alternates mechanism demonstrated that
> checking packs across all object stores before hunting for loose
> objects in any of them makes a world of difference.

Yeah, exactly. This is really a regression in alternates performance,
but it just so happens that the quarantine system is built on top of
alternates so we noticed it there.

I'd expect "clone -s / --reference" to have similar problems, and also
for sites like GitHub and GitLab that make heavy use of alternates for
object sharing between forks. And those would pay the penalty on just
about every operation (because we'd expect the alternate to be holding
most of the objects in those cases).

-Peff
