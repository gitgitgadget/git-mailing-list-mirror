Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7517581
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490245; cv=none; b=MzGVrkkR6kgJ0JnCnIGcBPhP2LFmF1UqSphQHr1KOwSqlW6G3/97RXvfmZB995Zdfkw0Wumx/aQVMoXD2llfjNGCsM0fDt+lOKBnDRPcc+6vtgzxDzhRo+hKXWXIAx2RkZs/97kfBJpDatpyQOaxcH/WTXw2bW/17ou5uNl8MQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490245; c=relaxed/simple;
	bh=iIRYjYRPkq0YPhx80S6HUuY5DUYhTlhQg2Sbni1URqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2Zq4esVo9ShNKM/86V1uKSwCeR6jJkh3D6huiZxwuUV5QO7nEKDe8mgw8/XVk41Wx+5RCzFiCjmvb6ajpkmkZiRYP0mcejDeE3QtCnvGKzlBwUKtvcWOctEiZif2eorTmUoevoCmhydlidPAA3biMzBp0fb2PG2uX64w+1m5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24520 invoked by uid 109); 15 Mar 2024 08:10:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 Mar 2024 08:10:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29785 invoked by uid 111); 15 Mar 2024 08:10:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 Mar 2024 04:10:46 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 Mar 2024 04:10:41 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 16/16] config: allow multi-byte core.commentChar
Message-ID: <20240315081041.GA1753560@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
 <20240312091750.GP95609@coredump.intra.peff.net>
 <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
 <20240315055944.GB1741107@coredump.intra.peff.net>
 <6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>

On Fri, Mar 15, 2024 at 08:16:53AM +0100, Kristoffer Haugsbakk wrote:

> > Mostly I was worried that people would take "char" in the name to assume
> > it could only be a single byte (I had originally even started the new
> > sentence with "Despite the word 'char' in the name, this option
> > can..."). And that is not just history, but a name we are stuck with
> > forever[1].
> 
> Missing footnote or referring to my footnote?
> 
> My suggestion was to use a `core.commentString` alias. Which might
> matter for new answers to questions about its use. It might not matter
> if in practice most people get their config tips from 1500 point
> StackOverflow question about how git-commit(1) keeps swallowing their
> GitHub issue numbers (due to automatic linewrap) from 2011.

Heh, missing footnote. I was going to say "we could introduce
core.commentStr or similar", but after your comment I searched in the
archive and see that you did indeed already suggest it.

I'm not sure if it would make things more or less confusing to have two
related values. One nice side effect is that the new variable would be
ignored by older versions of Git (whereas by extending core.commentChar,
you end up with config that causes older versions to barf). That
probably doesn't matter that much for most users, but as somebody who
works on Git I frequently run old versions for bug testing, bisection,
and so forth.

> > I actually do think the "string" nature is mostly uninteresting, and I'd
> > be OK leaving it as an easter egg.
> 
> To my mind a string subsumes a char (multi- or not). Like in programming
> languages: some might be used to single-char `#`, but I don’t think they
> do a double take when they see languages with `//` or `--`.

Hmm, good point. I was mostly focused on UTF-8 characters, but "//" is
quite a reasonable thing for people to try. It is probably a better
example than "foo".

> > What your suggestion doesn't say is that multi-byte characters are
> > OK. But if we think people will just assume that in a modern UTF-8
> > world, then maybe we don't need to say anything at all?
> 
> Given that we’re mostly in the context of a commit message, an
> ASCII-only restriction would feel archaic.
>
> I guess it depends on what the *normal* is in the documentation at
> large. As a user I’m used to Git handling the text that I give it.

Right, that's what I was asking. To me "character" means an ASCII byte,
but I think I might be archaic myself. ;) If most of our readers would
just assume that multi-byte characters work, perhaps it is confusing
things to even mention it.

> > It actually does not have to be UTF-8.
> 
> Good point. Unicode is more appropriate.

I think other Unicode encodings are likely to have problems (because
they embed NULs). Specifically I was thinking that you could probably
get away with latin1 or other 8-bit encodings. But again, I really hope
nobody is doing that anymore.

So anyway, adapting your original suggestion based on discussion in the
thread, maybe squash in (to the final patch):

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c86b8c8408..c5a8033df9 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -523,9 +523,8 @@ core.commentChar::
 	Commands such as `commit` and `tag` that let you edit
 	messages consider a line that begins with this character
 	commented, and removes them after the editor returns
-	(default '#'). Note that this option can take values larger than
-	a byte (whether a single multi-byte character, or you
-	could even go wild with a multi-character sequence).
+	(default '#'). Note that this variable can be a string like
+	`//` or `⁑⁕⁑`; it doesn't have to be a single ASCII character.
 +
 If set to "auto", `git-commit` would select a character that is not
 the beginning character of any line in existing commit messages.


That's assuming we don't want to go the commentString route, which would
require a bit more re-working of the patch. I'm also open to a more
clever or pretty multi-byte example if we have one. ;)

-Peff
