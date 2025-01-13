Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1180230D2D
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736749569; cv=none; b=kYOK4+run42MmsgkSz0y/gg/Nz2pcVVyctVJ6tktw6osmmSKnsqJEaom8mOZq1JL/1VCsuFY+wOJnOL/MhIrtZ5mvO6OzVtV01dzWPrQCzvvCOLhnjklRe85I2Ykn8SXzTwxOW2ciBJ7WAFl1qaU+mDklrq6GpFIRZZqH3AJ2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736749569; c=relaxed/simple;
	bh=/eMfKcdV3N5mCBXO/gcAl4U856K0Md+sTEOFIy5KHfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkEKgkMwgHGyZLTYA6tMzkaS9ovxN3shdmxz/1gkWIa/Iwm3XrR8niKdVSG00MwFn1c8vm1+uBUmxaHimj0UJSbr7Kjy+I0QQrRESXrQ5X+LhMolqorI7vUVtMp8x3KSRUclJ2/MkSXwe96Z/z/lnKfcwwNUwJORLfJpWRrgR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KGu/zKEW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KGu/zKEW"
Received: (qmail 11976 invoked by uid 109); 13 Jan 2025 06:26:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/eMfKcdV3N5mCBXO/gcAl4U856K0Md+sTEOFIy5KHfM=; b=KGu/zKEWuVF2p+uSScM2vMLo4W6k2V7hKHuidQeMAC2bgo13XCf2gQMf4CdP2idMd9H5Ly8razaIpawpH9PP15n3hZkwj70MECBrid/cMcrezyUvRX/zKJ6voH4CEQ02V7f2OEoSgw+c6ckwvno8y77pwD1a6Sm0keVHkxtDPlEsdYHqQKxGOCrJ3eQ2N9kTlThe/7ZqtC6pCdxKrUKjOkC9w/BE+Mm4rEmBBAXKUGWVuaVB5l+o++XZYzqFLBElEHWYiFj4N7W6NALRNce9M7xcYLU7yWXTlN6urARViKiApRN6Fa+6b5LRwx2CVwACOsNYnCf1Fm1yxSgHnTWs3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Jan 2025 06:26:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17576 invoked by uid 111); 13 Jan 2025 06:26:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Jan 2025 01:26:06 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Jan 2025 01:26:01 -0500
From: Jeff King <peff@peff.net>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Olly Betts <olly@survex.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: git grep: ^$ false match at end of file
Message-ID: <20250113062601.GD767856@coredump.intra.peff.net>
References: <20250109235255.GA3418@survex.com>
 <20250110114308.GB1014503@coredump.intra.peff.net>
 <20250110120223.GC1014503@coredump.intra.peff.net>
 <87r05ahljt.fsf@igel.home>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r05ahljt.fsf@igel.home>

On Fri, Jan 10, 2025 at 01:59:18PM +0100, Andreas Schwab wrote:

> On Jan 10 2025, Jeff King wrote:
> 
> > but it is weird to me that patmatch() will match "^$" to the end of the
> > buffer at all. It is just calling regexec_buf() behind the scenes, so I
> > guess this is just a weird special case there, and may even depend on
> > the regex implementation.
> 
> Shouldn't the matcher be called with REG_NOTEOL in that case?

Perhaps. If regexec_buf() is assuming we are feeding lines, then without
REG_NOTEOL it thinks the end of the buffer is the end of a line. Which
makes sense, but trips up this case because we are not feeding lines,
but rather a whole buffer. So the final newline is not the start of an
empty line, but the true end of the buffer.

But what if the buffer doesn't end in a newline? In the example, the
file is something like "content\n".  But what if it was just "content"?
Then the end of the buffer really is the end of a line, isn't it? And
REG_NOTEOL would not be appropriate.

So without REG_NOTEOL:

  [this is wrong, per the report]
  $ echo content >file.txt
  $ git grep --no-index -n '^$' file.txt
  file.txt:2:

  [this is right]
  $ printf content >file.txt
  $ git grep --no-index -n '^$' file.txt
  $ echo $?
  1

and with it, like this patch:

diff --git a/grep.c b/grep.c
index 4e155ee9e6..7e3b6d9474 100644
--- a/grep.c
+++ b/grep.c
@@ -1467,7 +1467,7 @@ static int look_ahead(struct grep_opt *opt,
 		int hit;
 		regmatch_t m;
 
-		hit = patmatch(p, bol, bol + *left_p, &m, 0);
+		hit = patmatch(p, bol, bol + *left_p, &m, REG_NOTEOL);
 		if (hit < 0)
 			return -1;
 		if (!hit || m.rm_so < 0 || m.rm_eo < 0)

we get:

  [this is now right]
  $ git grep --no-index -n '^$' file.txt
  $ echo $?
  1

  [and this stays right]
  $ printf content >file.txt
  $ git grep --no-index -n '^$' file.txt
  $ echo $?
  1

but:

  [without REG_NOTEOL, this matches]
  $ printf content >file.txt
  $ git grep --no-index -n 't$' file.txt
  file.txt:1:content

  [but with that flag, it no longer does]
  $ printf content >file.txt
  $ git grep --no-index -n 't$' file.txt
  $ echo $?
  1

So I do think "\n" at the end of the buffer is a special case. Perhaps
we should always omit it, and then leave REG_NOTEOL unset, making the
end of the buffer consistently the end of the final line. Like this,
which no longer matches "^$" but does match "t$":

diff --git a/grep.c b/grep.c
index 4e155ee9e6..c4bb9f1081 100644
--- a/grep.c
+++ b/grep.c
@@ -1646,6 +1646,8 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 
 	bol = gs->buf;
 	left = gs->size;
+	if (left && gs->buf[left-1] == '\n')
+		left--;
 	while (left) {
 		const char *eol;
 		int hit;

-Peff
