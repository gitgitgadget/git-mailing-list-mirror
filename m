Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645D218AA0
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754128020; cv=none; b=GVFzX0OYR4ahoOIZ9O75IHqkK+hiWQLta6Zdxxs9azshY7Fv7BPkHqfQOzy8Zn1reLDgqZMdc7x6zFwsTB/HRiuumXomyVG61f0JAEdhWkfw+rLBoAXa890kzaDxeoQ54B7VtZWY2ecgUtEuN/yAuKHq+x8pBurpa2UnLTcsA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754128020; c=relaxed/simple;
	bh=GSUL8mqnZhXDHxHsdBeWFt1ofBh09mCffR+IhYa/cAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbkBf4sCK0ye9UwWk0s0vQnFD8sYmw1NwPHf3zdjvraCJNaM6MZtWzLomLRNeH6e/HA0PwyCguYRyTCA1IV90z+TjZtSyxYbB/D7Pu5B6sMe+mAsK0Q2hrfvIDpQXFm9OTbhdpKxaWBVCk18hMhZNCA2kdAxEgQAiS0NnNNZpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bmwzQz4d; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bmwzQz4d"
Received: (qmail 9009 invoked by uid 109); 2 Aug 2025 09:46:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GSUL8mqnZhXDHxHsdBeWFt1ofBh09mCffR+IhYa/cAY=; b=bmwzQz4dy4l0hvqQl+uJZg+IfyQat+tFFuMkjWfr90PSnkD/XHmKtmulgaXaQFHoW5dX79OQJivQsoZU6ZXXcM+O42hvL8Yb5Flm2+Ll1p1XZ38hYUjhS7Xb1jBpidmauWlLFxwrfot4aCVfwnAadKuda3lZqSPj9AEcZFIJdFzDODpvjoECWfm1zJUH0sAtjfDwyU79I12VxyuBHnt1vwHLD6UZzGY9Ad81ptWuU0e9X2+dCFIPaUYF30bRXoykkn9gOMf0Wsi2K7qL76Gwln5/kLTfVcAjOTVsEZT+J20VielREeWzIxEPlsL0TPiHFAzvhEI1ZMmdbDLS90MPyA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 09:46:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11731 invoked by uid 111); 2 Aug 2025 09:47:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 05:47:02 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 05:46:57 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: Why does git-grep appear to treat exclude pathspecs differently?
Message-ID: <20250802094657.GG3711639@coredump.intra.peff.net>
References: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
 <xmqqv7nezdw2.fsf@gitster.g>
 <CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>

On Wed, Jul 30, 2025 at 05:49:29PM -0400, D. Ben Knoble wrote:

> which eventually dies as noted. However:
> 
> - looks_like_pathspec() only checks for long magic, as you noted
> - setup.c:check_filename() looks for short-magic, too, but only
> considers ":^" to work like a pathname if we're excluding everything?
> 
> I think what I find confusing is that, while this is definitely a DWIM
> case for git-grep, it doesn't seem to do DWIM :) We are verifying that
> the remaining arguments are filenames, but couldn't they really be
> full pathspecs, as long as they aren't revisions?
> 
> The difference for "^:<path>" from ":^:<path>", just to complete the
> story, is that in setup.c:check_filename() we try to stat whatever
> comes after ":^":
> - for the former, that's <path> and we are ok
> - for the latter, that's :<path>, fail.
> 
> So it seems like the places that check for short-magic should also
> consider the optional trailing colon?

Yeah, I'd think so. But it's worse than that, even. According to the
glossary definition you showed:

  In the short form, the leading colon `:` is followed by zero or more
  "magic signature" letters (which optionally is terminated by another
  colon `:`)

we allow multiple bits of magic. So the code in check_filename() that
looks for ":/", ":^", etc would be fooled when seeing more than one
character, like: ":/^exclude-from-root". AFAICT there are only two short
magic types, so I guess nobody has really run into this before.

Also, I guess this function ought to be respecting the literal_pathspecs
global? The actual pathspec parser does.

If we can, we probably ought to be feeding the paths to a function like
pathspec.c:parse_element_magic() and then checking the resulting flags
(and skipping past the prefix as it indicates).

-Peff

PS I didn't even know that we allowed multiple short items or a trailing
   colon until your email! Hidden corners of Git.
