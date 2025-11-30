Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E814036D51B
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508444; cv=none; b=EOgxOwE3FyoHjy+5O8KH3aRVpo2yPcN5IxYW/JiWGULv4X+2IXk7HUPsfP54ZViBZjMMeksNl9eBMzIkhelydQX+WGEQCSYI5fmwyAGtZCnInKhDLMX4rWvd/bsYFcV69H+LSMH7KMw8G8QgQvAyBML3lp/DHe/lqYcoQDfZ0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508444; c=relaxed/simple;
	bh=SMlJlLCy36IfdT+0QfgV7fl9Pga4drZn3KA1R2XGIyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR2mtvYRxv14u62DeOV6dHRjxb2WpE4zbxtrAhEz9sQJgiWSVreIqN7qtRnjWtoVZYFI3wyYxohtIpfmVJ0g7Ptg7Q7s7538J44i3yQd936ZBdgaLTuldA8EAXumwgAQR3lSNAd1T/zNIHMpX4n91anYCAIjDpCRIq692HmY72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hNevqIKQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hNevqIKQ"
Received: (qmail 170798 invoked by uid 109); 30 Nov 2025 13:13:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SMlJlLCy36IfdT+0QfgV7fl9Pga4drZn3KA1R2XGIyQ=; b=hNevqIKQ2lWSB28xQa6uZNYno2c6N2AbN0RuznJjsbYvq2hWpZldW4haetpoOwGE8waAsrTaJrN5Ep5WpVzoper77ITIyLVwErNMYJ/8GvZqjWeW4FpOd37O9mbhRLTMUQQko3ijDAK9ZzudSD5Qn3jqu0Eoo7ECC+HykRD5bjIqXthNI0AR8qTOJKDhHz9IOYE+8F4ovmGQnpu/poRpBoFuYwN8eZC4n+WxSTjBQmcYwf00VfpRREi9R+uv3kvpyah2zRmcpNDsLJmoOM7SBxa+Xx2/ELudquAisN22u9X+YncTVaDWAG0lbhmA+9QkyQjMXZD6PA40GfC6aDPL8w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 Nov 2025 13:13:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 254731 invoked by uid 111); 30 Nov 2025 13:13:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Nov 2025 08:13:52 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Nov 2025 08:13:51 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/4] more robust functions for parsing int from buf
Message-ID: <20251130131351.GA198697@coredump.intra.peff.net>
References: <20251118091127.GA4175601@coredump.intra.peff.net>
 <20251118091218.GD529192@coredump.intra.peff.net>
 <ca6d99cc-d05c-49fb-ab3c-d7668077d32b@gmail.com>
 <xmqqtsylz2xh.fsf@gitster.g>
 <20251124223023.GA2051672@coredump.intra.peff.net>
 <xmqqms4buix0.fsf@gitster.g>
 <20251126150931.GC4143292@coredump.intra.peff.net>
 <xmqqldjsogip.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldjsogip.fsf@gitster.g>

On Wed, Nov 26, 2025 at 09:22:38AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Hmm, I thought both of those things were reasonably clever. The other
> > obvious way to do it, AFAICT, is to used checked-operation intrinsics or
> > add unsigned_add_overflows() before every operation.
> 
> Yup, but the thing is, I didn't want something "clever".  I prefer
> "clean and obvious" if we add extra code for safety.

Yeah, that's fair. It turns out that one half of that is easy: checking
for overflow as we compute the number). And one half is hard. If you
don't assume a twos-complement style range where the "min = -max - 1",
then you are stuck using INT_MIN. Which is OK for "int", but not for
arbitrary types. We already make the same assumption in git_parse_int(),
etc.

So I went with that approach here, but it is at least documented
clearly.

> > It looks like you merged what I had into 'next'. Where do you want to go
> > from there? I am mostly content to let it be, but we can also try to
> > replace with something like your version.
> 
> That is my preference.  While the topic is still in 'next', or after
> the topic graduates to 'master'.  Either is fine.  And it is fine if
> such an update did not come, too.  After all, this is to deal with
> contents in a locally generated file (.git/index), so a maliciously
> corrupt string that lack the expected whitespace character after the
> digit string is a sign that you are trying to burn yourself and you
> have only yourself to blame, isn't it?  An attacker that can put
> garbage in your .git/index has better ways to fool you by updating
> your .git/config file that sits next to it.  Or teach the sanitizer
> that this code path is already OK somehow?

Yeah, I agree the stakes are low here. Though they were somewhat low to
begin with for the same reason! But I was grossed out enough by the
whole thing that I tried to put together a decent helper for parsing
integers from buffers, and converted both sites here.

I suspect it could be used in other places, too, but I didn't convert
any.

> > Or even, I guess, work on a
> > global strntoi() that could be used everywhere, if we think it is robust
> > enough. (Though technically that name is reserved by the standard, which
> > is a shame, because that is really what this thing is).
> 
> Well, we already use plenty of names beginning with 'str' followed
> by a lowercase letter, like strbuf_foo() and string_list_init().

In the end it was sufficiently different from strtoi() that I decided
not to use that name. It was but one of many bike-sheddable decisions,
which I tried to document. So I guess let the flaming commence. ;)

This is built on top of jk/asan-bonanza.

  [1/4]: parse: prefer bool to int for boolean returns
  [2/4]: parse: add functions for parsing from non-string buffers
  [3/4]: cache-tree: use parse_int_from_buf()
  [4/4]: fsck: use parse_unsigned_from_buf() for parsing timestamp

 Makefile                   |   1 +
 cache-tree.c               |  28 ++-----
 compat/posix.h             |   2 +
 fsck.c                     |  20 +----
 parse.c                    | 162 +++++++++++++++++++++++++++++--------
 parse.h                    |  31 +++++--
 t/meson.build              |   1 +
 t/unit-tests/u-parse-int.c |  98 ++++++++++++++++++++++
 8 files changed, 263 insertions(+), 80 deletions(-)
 create mode 100644 t/unit-tests/u-parse-int.c

-Peff
