Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99C390219
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167296; cv=none; b=CxTS/1ENx2qnfhP7BFG2lhomee/jG2inHjX5db8dZF0ReZYe6fOyBEqSMhe/OYbWptXPMv0SsOoZj7lUaRrydPD59s3zM0bjOcYoJWXKGydbh/sWzymMRbTHVaBDQcOS6zy/zzka2e3Nl2bglFKAvVMMgE3x8xUjZ/9g80Ge6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167296; c=relaxed/simple;
	bh=EM7m1Ks6kUGJN7O+aN8vFupBMq6u/nzaZHAXkk4zVEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbzKJw+irF5+mR+1XEc4fDu+6JIRQmHHOxgwwoHpq/ZA663eFojbfMtJlJrmBZzY3iqzXFPH5MqeMngvRKE2eYX51UTdkcNquc1x4gNZfIZPghqHT3zjP4YbrSuBATl4BZdx/rT7y7tIfb43ocjznjlGHkvGF/oDIqOVGUqusKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XkRN+139; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XkRN+139"
Received: (qmail 107057 invoked by uid 106); 11 Jun 2026 08:41:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=EM7m1Ks6kUGJN7O+aN8vFupBMq6u/nzaZHAXkk4zVEE=; b=XkRN+139fEW8D7bsgmGFYhel/IYat7nz3XgiD2sSsSHXuXUPoHyrlICIq1ZzwzN+Ixv9z28mUZhJi8rdhtGEZCkZQIq++bMe7aLak/hJdfQ1eKwPfmp187JC+9mErO5myPdCBzb8O47ns96U7L/N64NnUaOTmNl1ZrRdJFVyo+RpS13sjtr1pk5RO9ol96xBiuoUTjxXodcYuijqGm0rs84OBI5rKyIU7RRFR9D1z9KScck9S+CHoB0WvpNER7UUWKKIVO3p+ZtnsCwIBs0ss6JgHhZvLOxng+sq0UVQIQ4SgKN9jGM+Sn9hNzVHyzYuHPYBL0hYuGZRz5GbCGtewg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 08:41:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 315210 invoked by uid 111); 11 Jun 2026 08:41:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 04:41:37 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 04:41:32 -0400
From: Jeff King <peff@peff.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] ls-files: filter pathspec before lstat
Message-ID: <20260611084132.GK2191159@coredump.intra.peff.net>
References: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
 <20260609104119.GA1509396@coredump.intra.peff.net>
 <CAJ-ks9mJk-=xp1hW77hAoZwwQAfpMukYO8OvvkLx646-2Z3_kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mJk-=xp1hW77hAoZwwQAfpMukYO8OvvkLx646-2Z3_kg@mail.gmail.com>

On Tue, Jun 09, 2026 at 04:15:41PM -0700, Tamir Duberstein wrote:

> On Tue, Jun 9, 2026 at 3:41 AM Jeff King <peff@peff.net> wrote:
> >
> > On Mon, Jun 08, 2026 at 07:37:15PM -0700, Tamir Duberstein wrote:
> >
> > > +             /*
> > > +              * match_pathspec() is linear in pathspec.nr, so prefilter only
> > > +              * the single-pathspec case. Only entries shown by show_ce()
> > > +              * satisfy --error-unmatch.
> > > +              */
> > > +             if (pathspec.nr == 1 &&
> > > +                 !match_pathspec(repo->index, &pathspec, fullname.buf,
> > > +                                 fullname.len, max_prefix_len, NULL,
> > > +                                 S_ISDIR(ce->ce_mode) ||
> > > +                                 S_ISGITLINK(ce->ce_mode)))
> > > +                     continue;
> >
> > This feels...kind of arbitrary, no? Surely it's also faster with
> > pathspec.nr == 2, and so on up to some nr closer to the size of the
> > total index. It feels weird to be making an arbitrary cutoff based on
> > pathspec performance in calling code like this.
> >
> > It is not wrong, per se, as you are optimizing your case without trying
> > to hurt any others. But what do we do when somebody profiles it and
> > comes along trying to bump the number to 2, or 10?
> >
> > I dunno.
> 
> Yeah, absolutely it's arbitrary. The simplest answer is that others
> are welcome to bump this, provided they make the case for it.

OK. I can live with, I suppose, but I am tempted to say that it should
just kick in always (i.e., removing the pathspec.nr check).

Though I did show a case where the performance regresses, it was pretty
made-up and not something I'd expect in the real world. And you'd see
that same crappy performance with "git ls-files -- $(git ls-files)",
without the "-m".  The real solution is making the pathspec code less
crappy.

-Peff
