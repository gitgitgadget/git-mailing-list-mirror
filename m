Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED87F1DFE03
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290081; cv=none; b=nKYeLAo0irgSr25zOHKIPghIOumtxfd5SwS6Mz30Z5ReegyB7jE1PAmPBegYLgMF7mloFrn+B084dF4K+yyboy2gG7Og/pKUSGCLbmIi7yf5c7Sa7bH1doZQv6R8UL430yMxpM1NHzYDz/XWIbwqw3fk3xIAFLxXAXg7kz3Xv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290081; c=relaxed/simple;
	bh=tZmenbSSOYvWbV+nvkSQ1zZ2sI9LrjAivObVJH0zd6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAWpwVWQ2WK0doGYnGHkb2QsHWna3IXFkSadA81hRTCCwR8Eqnbb+NJws8z4JsWoAUjqpnNQsngOq3E+CXYP+bV4AK/86JvHC2I1jbXH6f+jh3Vx2B5RCUuPp6+wfLshoishzNNs5Zasjavsvv/f4BHQDw6u4DoMLGK38VUZk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c+GxoTDP; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c+GxoTDP"
Received: (qmail 13646 invoked by uid 109); 22 Nov 2024 15:41:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tZmenbSSOYvWbV+nvkSQ1zZ2sI9LrjAivObVJH0zd6E=; b=c+GxoTDPt9miOu8ebPt2gpeUDAXjzT7xXKkoCfKpRg2dwdtxIonoGyS/4sj4ZrHAW2JIyX7ZudbwU/ODx5WplZQ1OcckxztC8g4auF/vDrYNbNi5J/XXwh037EhEIsjmQdT1SntvReQ1jpd7ipfF47OTS3Sp8YJDt18IfMdd8/CvlKcOzYBTgEXIpm+xexU1yf2htREKj0phI8F5Zahh4kca5O2pNC92oIZNYlPPpY5O8Nwyays3nJRF1QOXkbozmyUZxJK3tbEBBZuwX0dj9EyABOo1RZs/GkQvw25HsrBpLDqgVkSWN3CP8d41QATFekBZV2G0YXQL1ynEi3PSKQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Nov 2024 15:41:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5845 invoked by uid 111); 22 Nov 2024 15:41:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Nov 2024 10:41:18 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 22 Nov 2024 10:41:16 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap.c: typofix in `find_boundary_objects()`
Message-ID: <20241122154116.GA1738455@coredump.intra.peff.net>
References: <cf49115db4e8dcd406a17c946659c2eef3ec6045.1732229420.git.me@ttaylorr.com>
 <xmqqiksgdrv8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqiksgdrv8.fsf@gitster.g>

On Fri, Nov 22, 2024 at 09:39:07AM +0900, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > Fix that by correctly assigning the value of 'revs->tag_objects' to the
> > 'tmp_tags' field.
> 
> Makes sense.  This breakage would make no difference in practice
> right now, as {type}_objects members of the rev_info structure have
> always been all flipped on together since their inception at
> 3c90f03d (Prepare git-rev-list for tracking tag objects too,
> 2005-06-29), so the original value of the tag_objects member is
> always the same as that of the blob_objects member.

Yep, I concur.

> A possible alternative "fix" for this typo could be to unify these
> {type}_objects members into a single .non_commit_objects member in
> the rev_info structure; given that we (as far as I remember) never
> utilized the "feature" that, say, we can ask only for trees but not
> blobs for the past ~20 years, nobody knows if the apparent "support"
> for that feature is subtly broken in multiple ways (and one of them
> you just fixed with this patch) and the "feature" may not be worth
> keeping.

I have been tempted to do that, too. But FWIW, I do remember
implementing something that set some but not all of the fields in a
series. Digging in my old branches, I think it may have been for a
reachability check for remote git-archive, where we want to dig only as
deep as the object we are looking for (so if we are finding out if a
tree is reachable, we do not need to ask about blobs, and looking for a
tag needs neither trees nor blobs).

If no such code made it into the project in those 20 years, it may not
worth worrying about too much. But I wanted to point it out as a
plausible use case.

> But neverhteless, this is a correct thing to do unless we decide to
> rip out the support for individual types.  Will queue.

Agreed.

-Peff
