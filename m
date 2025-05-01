Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F518C011
	for <git@vger.kernel.org>; Thu,  1 May 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746113802; cv=none; b=gpjHArDZk8WIqhybI1m9PnWNmdTLBDgBxkcdo8LFFWVh2nFbutidokn127ORuzdcNtbX6lOqW/CTW+da6XYq35qRu7IOOGyN/iDsoT5SYo7q65BsInp2fZ6sXfWAMGTUo+bcFyW7wR/sIaRcfBdOLxrTX4cwl312Z33X1kA9Pwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746113802; c=relaxed/simple;
	bh=PoFcEg7vXPaeJxTdTK2fuuP1kojb3vbCNOWLjgtDMas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+pD3i62d0kcGa78xvKlg3lfyRTo92cxGlxJklTYq3azy/+rHTN3Cvu8wNZtSytijYtgeCHkxEMayul6m9JF+L5IWYUe1UevSaygPOc/gL1pDrbXAp3LPdW3wpAj4IstjGvckYMHpH2ASsp/eoDWdVj/7BWg5/3R/9dk6ftPGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MqSwWQNc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MqSwWQNc"
Received: (qmail 24504 invoked by uid 109); 1 May 2025 15:36:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PoFcEg7vXPaeJxTdTK2fuuP1kojb3vbCNOWLjgtDMas=; b=MqSwWQNcRungrJe6PwFiq4zVBbtW4Ozkdi/4f1/U0vXGr99AN50JfujDgJYjER+dNOdo6jIQaGZCE2gFzxFQFH1DGyDzHJGMNhUh4YAxt15LPTTs3PH/Z7lKBp4DaSBFv4uZcJyNxjkjkmzqMGGPXmOxEeJek2/77+hMuj3Q4Vhcnonc9fK0gJLiKpNTOxsG9symEEMbkutqeu31cNuRKwZFc5UlyO9QO6iyyoqJeMIwAo8sdsXzd4JqH0GpJ+a+aEo87H0rqigXwS/y1PW7cirn1ISSAt8/ExcqPrVgAhP6Z3UtcfniMYZOkauyA/XP8LikwpipgwN59pwp+uTv2A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 May 2025 15:36:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8121 invoked by uid 111); 1 May 2025 15:36:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 May 2025 11:36:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 May 2025 11:36:38 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Subject: Re: [BUG] rebase: can write reflog with uninit. `action` string
Message-ID: <20250501153638.GA1793056@coredump.intra.peff.net>
References: <20250428194048.149348-1-code@khaugsbakk.name>
 <ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
 <fbc97d6a-2022-4a64-a2ba-5a7255cd81a6@app.fastmail.com>
 <20250429215155.GA36727@coredump.intra.peff.net>
 <6743a9fc-11ca-45ac-bc40-4148f5d85d27@app.fastmail.com>
 <20250501131751.GA1725607@coredump.intra.peff.net>
 <e4ea1e44-af7e-4c24-b0ee-f87091200b90@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4ea1e44-af7e-4c24-b0ee-f87091200b90@gmail.com>

On Thu, May 01, 2025 at 03:36:13PM +0100, phillip.wood123@gmail.com wrote:

> > But I think the way reflog_message() returns the "buf" member of a
> > static strbuf is kind of an anti-pattern, exactly because you can get
> > this kind of subtle re-use. It probably should just return a non-const
> > pointer, handing over memory ownership to the caller. That would require
> > adjusting its other callers, too.
> 
> Getting rid of the static buffer would certainly protect us from the
> use-after-free. The bug here is that we're not calling reflog_message() and
> storing the result in ctx->reflog_message() to create the correct message in
> do_merge(). Looking at your patch, having to remember to copy the string
> returned from reflog_message() is a bit of a pain. I wonder if we could
> change ctx->reflog_message to be an strbuf and update reflog_message() like
> so

Yeah, I agree that would solve the use-after-free. I just wasn't sure if
there would still be a logic bug, though. If we have a sequence like:

  /* somebody sets the variable */
  ctx->reflog_message = reflog_message(...);
  ...
  /* some caller, possibly far away, uses the function again */
  foo(reflog_message(...));
  ...
  /* now the original caller wants to use what it stored */
  printf("%s", ctx->reflog_message);

Right now that is a potential use-after-free because of reallocating the
static storage inside reflog_message(). If we teach reflog_message
to store things in ctx->reflog_message always, that use-after-free goes
away, but will the printf() above print the wrong thing?

I wasn't clear on who is setting the value or why. It could be that
doing so is actually _fixing_ a bug (because it should be printing what
comes from the invocation in the foo() call).

> I'll try and put a proper patch together next week that removes the static
> buffer and starts calling reflog_message() when we're merging.

Great, thanks.

-Peff
