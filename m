Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518E3E95A8
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937943; cv=none; b=fgdSDzNNrMHh1cgZzJ4+Bsh64arINsp0GTK4mT7urKlhR4UmwIR7ZakZdtk/V+XUye6U6fgbdqwpfjf3BRrvdTnPIB7rPCVLDzSkniTrIya5Q/yhHxC78IQ39mCZ8h4CWcoG0wncGIhLJHMhIlMZ9xDVp6KVCfr9w5OYiUqCfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937943; c=relaxed/simple;
	bh=akcCiE5WHL2W/AH4Br6qRNFVSnGreSHTRVn9KQqYGko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5vyKTr8nNR8r38MUKCRNvkfzY32di1LPWi5OSxEDpTpEepemInJju8TzgHEOC8D0SveUJEwsmjjg4h3Zu6Nxlb3W8/Hw3ZjJJnx5knAIt8ysNnaiJKCyNstv/Dnpk/OSqJfL7zpyA6773tSbGidbV7z28wRfDXdAgu1TslwCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZmelCREb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZmelCREb"
Received: (qmail 116970 invoked by uid 109); 20 Jan 2026 19:38:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=akcCiE5WHL2W/AH4Br6qRNFVSnGreSHTRVn9KQqYGko=; b=ZmelCREb6hqNTarSne3IWJSyxnczS3RYrCFnUBZpBdV9ZoHryUmMxjohIHwEGjg5BtiYf0NAyaYdm/o3yRf1KIDh7KBwxWTXhL1L0eoUSJCJIwX9BAYu9l98gB0MXmVGRwWzicaZbJR7TkRig80xoYthI8dd1rW+DH3BArxuaeLXZBkj5nPxWyFn/yyEYetAz3QSVCBleE7buqIBdzYXXu7eVRo3oehaK/6bXVNjrmDphPAgq5WcTePBPik+SoOvqzvOT0quFOnsv0y+kOTvtO4QYHmo4mxm3frOUzCy4veU4DiOum5jT7NYVVDCd9AZHXfVsFPMOICEhFwLPJG/Jw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Jan 2026 19:38:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 184108 invoked by uid 111); 20 Jan 2026 19:38:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Jan 2026 14:38:59 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 20 Jan 2026 14:38:57 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 1/4] remote: return non-const pointer from error_buf()
Message-ID: <20260120193857.GC3295894@coredump.intra.peff.net>
References: <20260119051858.GA1991308@coredump.intra.peff.net>
 <20260119051945.GA1991523@coredump.intra.peff.net>
 <aW3QVkpPPHjKVNLC@pks.im>
 <xmqqikcx3z5x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikcx3z5x.fsf@gitster.g>

On Mon, Jan 19, 2026 at 04:28:42PM -0800, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > This function signature is indeed quite misleading, and I'd argue that
> > it continues to be so even after the change. I guess the intent is to
> > make it a bit easier to print an error in functions that return a
> > string.
> >
> > I'm not really a huge fan of this, but it's not a fault of this patch
> > series, so let's read on.
> 
> I concur.  "If they do not return any useful value, they should be
> void" was my first reaction, but presumably just like "return
> error("message");" is a handy way to give message while signalling
> an error to the caller, these are used to return NULL that signals
> an error?  I do not offhand think of a good longer-term direction to
> improve this one.

Yes, that's exactly the purpose. I don't see many changes that could
let it still fulfill that purpose, though perhaps one could argue that
it is unnecessarily confusing for the small shortening of the code it
provides (and ditto for error() itself).

There is one thing it probably could do: return a "void *" instead. That
would make it applicable to a wider variety of functions. But it also
makes it even more obscure (IMHO), and this is a static-local function
that is only used for functions that return strings anyway.

If we wanted to make it more generic (and I do not think we want to), we
can see that it differs from error() in two dimensions:

  - error() writes to stderr, but error_buf() writes to a strbuf (or
    nowhere if the strbuf is NULL)

  - error() passes along integer "-1" to signal error, but error_buf()
    passes along NULL

So of the four combinations, we have:

  - stderr / integer: error()
  - stderr / pointer: not implemented
  - strbuf / integer: not implemented
  - strbuf / pointer: error_buf()

One could imagine a suite of related functions: error_int(),
error_null(), error_buf_int(), error_buf_null() that provide all four.

But I do not see us clamoring to extend the pattern further. ;)

-Peff
