Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553219539F
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024769; cv=none; b=OeUlfAqPNMt+bzXPzUzulEi5qAzA+jQwDXR8AaVx7St4/w5IYDi5eo/nap8g2cIHx1FPwVQ42H7Vjtg82GxaDCbYs2R346sxQfIOmhvQ154hgNhQvgK++3mEDAPjiKBLfCdgk3m1LnJqJtJEqSshPxciaJ3dmbxqi9nSxSwZ32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024769; c=relaxed/simple;
	bh=xpCxs0SvTos3CR61pqYHCUsaOdW2xGcq28mm0zF+Npo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0LeKpxcV4ipsA06CFvsQGK1NB4+VsnPIuyypKhL1rtNOUX1tmh9xuiIR4n/DHYsN6+gnE0b6EHXwSWnd8gEOq/UWe/o7hjDJ3U/ZBunYtdGyCmNYhvbxiNP9o4g0Hmix/ZpyQrI+fIh84DyaX0aw29VfB24UZRY8/XrlA59/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ox4Rw4UY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ox4Rw4UY"
Received: (qmail 12419 invoked by uid 109); 16 Jan 2025 10:52:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xpCxs0SvTos3CR61pqYHCUsaOdW2xGcq28mm0zF+Npo=; b=Ox4Rw4UY8Hmv166FEslWBqPPQn3RNvnF2m6FuFE5T3cYF9Ko9Zo/x6zmoeR+9k4SprSejILxjKCa+YjY5OYnTbz61v3/wFN6RxhyWnDqpFUWvtO5YqfC7mwLvGzv4yXfoPDkmK4F3WSxuluXG/slwG/5ks0UcsbiBjWQhhvSgs2L6KjgzWBdY78dfXYGWUt9y8cwuOcqEZD4g8+F2x4xPMUB+ptsF2na8zYH0GKsp13/RRVc0TttKYzuGaEmCuXft6tEdFbBranwU/B62Irs4RXhxBkCRQWbCKV6Q9Wsq0KuIJhhfltvfy9SSQYL4bp4KoTFZYD7iG/HvWMvMm3haw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 10:52:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24320 invoked by uid 111); 16 Jan 2025 10:52:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 05:52:51 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 05:52:46 -0500
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Askar Safin <safinaskar@zohomail.com>, git <git@vger.kernel.org>
Subject: Re: [bug] "git bisect old v3.0" takes 21 mins on Linux repo
Message-ID: <20250116105246.GF773990@coredump.intra.peff.net>
References: <19461b87a5c.5a2ea74016716.8214238482389812984@zohomail.com>
 <CALnO6CAzN1oeT4tMjJ1Qm4dW0xdVkVKHJ39oJTX8R8E614FH6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALnO6CAzN1oeT4tMjJ1Qm4dW0xdVkVKHJ39oJTX8R8E614FH6g@mail.gmail.com>

On Tue, Jan 14, 2025 at 05:21:20PM -0500, D. Ben Knoble wrote:

> FWIW:
> 
> $ time git rev-list --count v3.0...v6.13-rc7
> 1070175
> git rev-list --count v3.0...v6.13-rc7  13,57s user 1,41s system 96%
> cpu 15,466 total
> 
> That's a large number of revisions to bisect. Further,

Yeah. I'm not very familiar with the bisect code, but it looks like it's
quadratic. In do_find_bisection(), we have a big list of commits, and we
iterate like this:

        for (p = list; p; p = p->next) {
                if (p->item->object.flags & UNINTERESTING)
                        continue;
                if (weight(p) != -2)
                        continue;
                if (bisect_flags & FIND_BISECTION_FIRST_PARENT_ONLY)
                        BUG("shouldn't be calling count-distance in fp mode");
                weight_set(p, count_distance(p));
                clear_distance(list);

                /* Does it happen to be at half-way? */
                if (!(bisect_flags & FIND_BISECTION_ALL) &&
                      approx_halfway(p, nr))
                        return p;
                counted++;
        }

That clear_distance() call likewise iterates through the list to clear
the COUNTED flags from each. I guess we might be able to traverse down
from the tip of the commit we're operating on, clearing flags there.
Since that's how the flags are set in count_distance().

I suspect it's still quadratic, though, because count_distance() is
traversing separately for each (and in the worst case everything is
reachable from it). But it might still improve things in practice.

-Peff
