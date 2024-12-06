Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470A191F9B
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733455692; cv=none; b=BYErbqJKAEKZX0jFnk/k6zwV5XZtVIT/KINTAtapf162Tmee/wxLHHxo8o1514wxmMaH/Qx76V7lczXy/IumBtyMAoMOevw0WO4O8eGE1l4CPl/wAAMqyZjh+83HEGStTFn7ddVc4yGWHPZJg7d9zOkCuq3rvwpkiiI/cWxKWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733455692; c=relaxed/simple;
	bh=utrdblqgKSuKT1fVzHCRjQDxZ3zrntwoft5tneHNNwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhKwPfManoU91MqMkm1YTgmGDNxV9GKq/AHJ9U5VghD50NabKVfU1Zr8266cURT5AL+UC7Vvg3abD+zxvxq7E0NisPO8aYnmaEKmivyEtTGb2I0EL8v8nyr8BYZY7QkaZD3kgBFAXPfS3GbKRE5HWydsxcmI4KH8kqoAMK2o6QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=APTSpMNV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="APTSpMNV"
Received: (qmail 4448 invoked by uid 109); 6 Dec 2024 03:28:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=utrdblqgKSuKT1fVzHCRjQDxZ3zrntwoft5tneHNNwE=; b=APTSpMNViBWRkNWeySEAp1H0H85fV7SZcOkKdUy+O+neMZI7SZwuCP2DtQNUaEA+SCL+J6KnuUVXKjh8QuNUTQsYdS6Bc+KXGJn1FYrWD6yKi+0OpSqF1hGrQ8YHRKr6ECvRTXqwzwlvH0T8nBt52gTqOA+7bwgucOer558iKhGMkMQ7sxNtOX9my3QdQ89sd6/1VIhu5aYBjG9oVgACP9E24J7p66wjmLrEuPcTdD+yux9ENu7GLv8dkWMSltyIw3VQiPAh0YQDH3sLY/ld8CfUI4H2uQM9um82cvdEvneovpMGiFLmS6/pL8yG/GCtBWk6TtlzxtIQIO1fcG94nw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Dec 2024 03:28:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13211 invoked by uid 111); 6 Dec 2024 03:28:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2024 22:28:08 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Dec 2024 22:28:07 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	benno.martin.evers@gmail.com, benno@bmevers.de, ravi@prevas.dk,
	jpoimboe@kernel.org, masahiroy@kernel.org
Subject: Re: [PATCH] describe: drop early return for max_candidates == 0
Message-ID: <20241206032807.GA3176362@coredump.intra.peff.net>
References: <20241106211717.GD956383@coredump.intra.peff.net>
 <00270315b83b585f7d62ad1204ca1df93a668791.1733354035.git.steadmon@google.com>
 <20241204232750.GA1460551@coredump.intra.peff.net>
 <20241205201449.GA2635755@coredump.intra.peff.net>
 <xmqqser1zf8q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqser1zf8q.fsf@gitster.g>

On Fri, Dec 06, 2024 at 12:01:41PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Actually, after thinking on this a bit more, I think the solution below
> > is a bit more elegant. This can go on top of jk/describe-perf.
> >
> > -- >8 --
> > From: Josh Steadmon <steadmon@google.com>
> > Subject: [PATCH] describe: drop early return for max_candidates == 0
> 
> OK, so the patch authorship still blames Josh.  But there is no
> sign-off because ... the approach to the fix is so different that
> blaming Josh for this implementation is no longer appropriate?

Oh, whoops. I had originally intended to just write the commit message
and leave him with credit, but then I ended up changing approach.
Leaving him as the author was an oversight.

> > Before we even start the describe algorithm, we check to see if
> > max_candidates is 0 and bail immediately if we did not find an exact
> > match. This comes from 2c33f75754 (Teach git-describe --exact-match to
> > avoid expensive tag searches, 2008-02-24), since the the --exact-match
> > option just sets max_candidates to 0.
> > ...
> > So this:
> >
> >   git describe --exact-match --always
> >
> > and likewise:
> >
> >   git describe --exact-match --candidates=0
> 
> Did the latter mean to say "git decribe --candidates=0 --always", as
> the earlier paragraph explains that "--exact" affects the number of
> candidates?

Urgh, yes, you are correct. I can resend, but I think we should resolve
the questions below.

> Without this patch, all three give the same result:
> 
>     $ git describe --exact-match --always HEAD
>     fatal: no tag exactly matches '59d18088fe8ace4bf18ade27eeef3664fb6b0878'
>     $ git describe --exact-match --candidates=0 HEAD
>     fatal: no tag exactly matches '59d18088fe8ace4bf18ade27eeef3664fb6b0878'
>     $ git describe --candidates=0 --always HEAD
>     fatal: no tag exactly matches '59d18088fe8ace4bf18ade27eeef3664fb6b0878'
> 
> With this patch, we instead get this:
> 
>     $ ./git describe --exact-match --always HEAD
>     59d18088fe
>     $ ./git describe --exact-match --candidates=0 HEAD
>     fatal: No tags can describe '59d18088fe8ace4bf18ade27eeef3664fb6b0878'.
>     Try --always, or create some tags.
>     $ ./git describe --candidates=0 --always HEAD
>     59d18088fe

Right, exactly.

> > But this interacts badly with the --always option (ironically added only
> > a week later in da2478dbb0 (describe --always: fall back to showing an
> > abbreviated object name, 2008-03-02)). With --always, we'd still want to
> > show the hash rather than calling die().
> > ...
> > has always been broken.
> 
> Hmph, I am not sure if the behaviour is _broken_ in the first place.
> 
> The user asks with "--exact-match" that a result based on some ref
> that does not directly point at the object being described is *not*
> acceptable, so with or without "--always", it looks to me that it is
> doing the right thing, if there is no exact match (or there is no
> tag and the user only allowed tag to describe the objects) and the
> result is "no tag exactly matches object X" failure.
> 
> Or is our position that these mutually incompatible options, namely
> "--exact-match" and "--always", follow the "last one wins" rule?
> The implementation does not seem to say so.

I think you could argue that they are mutually incompatible. But we have
never marked them as such, nor do we do any sort of last-one-wins.
They are two distinct options, but in --exact-match mode, --always is
simply ignored. Which I think is a bug.

> So I am not sure if the "buggy" behaviour is buggy to begin with.
> The way these two are documented can be read both ways,
> 
>     --exact-match::
>             Only output exact matches (a tag directly references the
>             supplied commit).  This is a synonym for --candidates=0.
> 
>     --always::
>             Show uniquely abbreviated commit object as fallback.
> 
> but my reading is when you give both and when the object given is
> not directly pointed at by any existing tag, "ONLY output exact
> matches" cannot be satisified.  And "show as fallback" cannot be
> satisfied within the constraint that the command is allowed "only
> output exact matches".

I think there can be a more expansive reading of --exact-match (or of
--candidates=0), which is: only output a tag that matches exactly. And
then --always is orthogonal to that. There is no other output to
produce, so we show the commit object itself.

Now that more expansive reading is not what --exact-match says above.
But it is the only thing that makes sense to me for --candidates=0, and
the two are synonyms.

> I think the complexity from the point of view of a calling script to
> deal with either behaviour is probably similar.  If you ask for
> "--exact-match" and there is no exact match, you can ask rev-parse
> to give a shortened one, and you know which one you are giving the
> user.  We can change what "--exact-match + --candidate=0" combination
> means to let it fallback, but then you'd need to check the output to
> see if you got an exact tag or a fallback, and for that you'd
> probably need to ask "show-ref refs/tags/$output" or something.
> 
> So I am not sure if it is worth changing the behaviour this late in
> the game?

I think there are really two questions here:

  1. Is the current behavior of "describe --exact-match --always" a bug?
     I'll grant that probably nobody cares deeply, which is why the
     interaction has not been noticed for all of these years. I think
     the semantics this patch gives are the only ones that make sense,
     but I also don't care that deeply. But...

  2. What should we do about the new regression caused by limiting the
     candidate list? I.e., my earlier patches in this topic make us
     behave as if --candidates=<n> was given when there are fewer tags
     in the repo. That runs afoul of the special-casing of
     --candidates=0 when there are no tags in the repo (or you limit the
     candidates to zero via --match).

     If we are not going to address (1) as this patch does, then we need
     another solution. We can internally hold an extra variable to
     distinguish the number of user-requested candidates from the number
     of actual candidates available. But I think my solution to (1) here
     harmonizes the --candidates=0 case with --always, and then the
     auto-adjusted max-candidates case just falls out naturally.

-Peff
