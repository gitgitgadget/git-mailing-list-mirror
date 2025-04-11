Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C6220F08E
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389540; cv=none; b=LbSTtgF9AbBuLqHqa1xT+Y3f7KAHbiSQkPS7LFTQFM2sTR+BjIx0opTgwnmm51IsIADgBwcNT2RE0ExSbYK9Gve74x4xdR6HxJCjWMZoLJsbVJx1JA8p2Vl8GFiF6jkY1xRvVc9eUZgRvf58Bt8fEsw+nIeT7WMW23tNpQeWG38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389540; c=relaxed/simple;
	bh=0ToDcmyrUf3sTZ4IynwkXjpXfMh4xJRQRK/bMKcf1+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJMFUj1GDT0Ufk94OWem89ADk2TXXcdsOqXE+tEQMEX6GpJMZ+kvtnJeuB38E28E5TCVJVJo6gTL1QACk7Vl6yovl0Us5nWc2LPg8kopM6VQroWG77MNbTl27ptW6L6wizr9XBPc+u0TW9tO9iqxMy2zEYm0EzbijOjGLBRjLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iWYnG/AI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iWYnG/AI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D635CC4CEE2;
	Fri, 11 Apr 2025 16:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744389540;
	bh=0ToDcmyrUf3sTZ4IynwkXjpXfMh4xJRQRK/bMKcf1+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWYnG/AIGGuy02IcuOr+z5DkHWwwqddgQ2Gnu2yOvdNC+dpWy0pwO91bOWZJTd8UX
	 3zrzD+xe2ktCXe3bQGS37hgNUHqRB3m0Qw0d8L7U81iYKN4qoAF56zZqSoBSSLfwsn
	 f4X7A73DujcBYcmn7ykslVSz0XRxPlqVJGCvYB1I=
Date: Fri, 11 Apr 2025 12:38:56 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Nico Williams <nico@cryptonector.com>, Martin von Zweigbergk <martinvonz@google.com>, 
	Git Mailing List <git@vger.kernel.org>, Edwin Kempin <ekempin@google.com>, 
	Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <20250411-arboreal-ultra-dachshund-f34a54@lemur>
References: <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <xmqqv7rdqkla.fsf@gitster.g>
 <Z/a+AVopz+HLa1eL@ubby>
 <20250410134426.GB13132@mit.edu>
 <xmqqy0w8ng5r.fsf@gitster.g>
 <20250411154839.GC648081@mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411154839.GC648081@mit.edu>

On Fri, Apr 11, 2025 at 11:48:39AM -0400, Theodore Ts'o wrote:
> On Thu, Apr 10, 2025 at 09:18:56AM -0700, Junio C Hamano wrote:
> > Thanks to the "cover for iteration N is a direct response for
> > iteration N-1" and "cover is marked as [PATCH 0/$n]" conventions,
> 
> Even if the cover for iteration N isn't a reply-to the cover for
> interation N-1, b4 will search based on the subject line for a cover
> letter with higher version number, and this mostly works.

Note, that we try to use the series change-id for this, if we find it. We only
fall back to matching by subject (+author) if that's not present.

> My one (admittedly minor) pain point is where someone replies to a
> patch series with something like "you should really also fix FOO", and
> then someone replies with a single patch (without a cover letter,
> possibly created with git; possibly not) that addresses issue FOO.
> 
> This can confuse "b4 am -c" into thinking that the patch to address
> FOO was in fact a newer version of the patch being reviewed.  It's not
> a big deal; I can deal with this manually.  But having a patch set ID
> would help with this.

I'm not sure there's ever going to be a clear "do what I mean" solution here.
We try to pick the most common course of action in such case, which is to
assume that it's a quick followup bugfix for the patch.

> I'd also love if lore.kernel.org and maybe b4 also had an automatic
> way to get at the older versions of the patch series, and the patch
> set ID would help with the automation.

You can, for patches sent with b4 that contain change-id. E.g.:
https://lore.kernel.org/all/?q=changeid%3A20250313-a4-a5-reset-6696e5b18e10
https://lore.kernel.org/lkml/?q=changeid%3A20250313-try_with-cc9f91dd3b60

-K
