Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5693C9EE9
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739788; cv=none; b=Bd1OI8xat8UGB7vX4AH0V664dURhySnQ1nSXKL1kGGvG+Ghx9Jfa3zG0ZYgkjTI1eEoZ2cndsr1zpVgBnygg+nA9l8TlqW4QOe/rFZn0ZiAqxRvmLJU5gdL8I/mf+O30WBZN3J7XaWPxcjLt9NTpypRPHKM9CfEn6woSmUjbkZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739788; c=relaxed/simple;
	bh=/0EYtrOiEnk36IQzlBn5WmikIqBCL3Ouv0lneoaWHcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiH2OY/Rin3QfhtHX02LGh6o0SaFX5CXHGy1ibtL+zdEfqbWU0dTyPj+Jiub5c46D65Yrc/tIOVdK29Wvuoy0kMqldLDvmGvmkABF3goUsWsKpx0AHctc2Q2RSHALssHmgCqUvD+YcilznBen0gF6UoRQ7B73BcNpGMmKURnLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BGvpBpUN; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BGvpBpUN"
Received: (qmail 61750 invoked by uid 106); 14 Aug 2026 20:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/0EYtrOiEnk36IQzlBn5WmikIqBCL3Ouv0lneoaWHcE=; b=BGvpBpUNfeZsqdbNpN7RJXtiHVgbezU2AS8k1I+VIuvxHQXqn/e9QjD0rzMRAzEwlfpfNtSO4HuRH4nZmSIvAs0R0Zn3TZwyjm2kw3QXEfNMTBlXR/FvNsnvaRggvOgsZcYCMkrwqsE/H0Z44FlSupVDS/+OoYBzXk+eCmjA64R4PCHpbQZqR76E8oAquDQMOj7Uq+Ra6EJQelOfTP7VU4qjsA0PoR0cCEk1trU351booDlKLWT0Ae002FrxhjvXk1O76hzmOyTG1Owr1F9riqp25GsluT6tohOYGZefxc/bAaQ+sBWg6BNK3JXNvLnDWhk1ENrshhzm6wrJmrwGjw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2026 20:36:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 61933 invoked by uid 111); 14 Aug 2026 20:36:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2026 16:36:25 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Aug 2026 16:36:24 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <20260814203624.GC2575854@coredump.intra.peff.net>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
 <20260814171724.GB2563235@coredump.intra.peff.net>
 <xmqqpkzkmsmo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpkzkmsmo.fsf@gitster.g>

On Fri, Aug 14, 2026 at 12:03:43PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > How bad is a duplicate alternate? It's a minor performance issue, I'd
> > think. We would add its packs to the list (though hardly ever look
> > through them, as the "first" copy would satisfy most requests, and the
> > unused second copies end up at the back of the MRU list). You'd only pay
> > the extra lookup cost for an object which we fail to find entirely,
> > which is rare-ish (mostly speculative lookups for fetches).
> 
> There may be a future application to be written to go through list
> of alternates---enumerate all objects that exist in the first one,
> and then remove them as duplicates to other alternates.  Oops, there
> was a duplicated entry and we ended up removing the objects from the
> first one registered under a different spelling.

Yeah, that would be dangerous. You _might_ even be able to trigger that
now with an object directory that points to itself as an alternate, and
then doing "git repack -adl" or similar. I don't recall offhand whether
we normalize the names or if we'd be fooled by symlinks. Or for that
matter if we are even careful about comparing alternates to the main odb
directory.

I hate to be cavalier about conditions that could cause data loss, but
at the same time...it kind of feels like you'd have to be _trying_ to
shoot yourself in the foot to create such a situation.

> > Alternatively, I think we could probably make the check more thorough in
> > a similar way. Always consider a pair of case-insensitive matches as
> > possible duplicates, and then for each possible duplicate use stat() to
> > check their st_dev and st_ino values. That keeps things cheap for normal
> > cases, and we pay only the stat() before de-duping. It's correct and
> > doesn't rely on the repo, though it is a bit more somewhat complicated
> > code.
> 
> Hmph, I prefer not to trust st_dev and st_ino on platforms where
> case insensitivity can possibly become an issue, though.

Yeah, I would prefer not to go down that road, either. There are a lot
of complexity and portability headaches. I offered it mostly as a "you
probably _could_ do this super-carefully" option, but my take is that we
don't need to be super-careful.

> > [1] Even on a single filesystem I think case-sensitivity check is not
> >     completely sufficient either. We know that filesystems do more
> >     complicated one-way transformations than just case folding, like
> >     unicode normalization or even removing some funky code points.
> >     We'd miss those "equivalent" spellings.
> 
> macOS?

Naturally. :)

-Peff
