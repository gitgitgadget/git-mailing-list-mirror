Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6613A1E9A
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766821454; cv=none; b=NaknyiQxh0cyPuHHvIMyUBazI06nI1hBYJTXmL2yhxG7rGBlkktbzjeFoEtd+6pFNvi5s/wNwOg/NS5ofAU988emrhEGEQMR+79UPkGs9vzPLWcbKlTHaa/7/pgGFjM791vLxrWRzXodmHtMdhNTWirpcTimdGcWwbQLGnPXPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766821454; c=relaxed/simple;
	bh=jjfQLmdsBxuiywwIp2oivcPQBGf+3CkWmOgppfeuwHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZBYZPhnoHSUTcytwFndEDRzL1DwCEaC2UUvsJmvYq9KwwkLd9Y7ofMRWtbRiNy/dJ8Qs8rbTu+isCTOIFVERlhIdvaMZ1x1UBIxQ3roZUc+1bblduMJeFF07bByPn1c9bgSc9CyEgSVXPm0h8nxDNp7BbcBjhqFRjMasE2+rD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Vs0Jj99Z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Vs0Jj99Z"
Received: (qmail 495670 invoked by uid 109); 27 Dec 2025 07:44:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jjfQLmdsBxuiywwIp2oivcPQBGf+3CkWmOgppfeuwHY=; b=Vs0Jj99ZJkrSXAUo87/+naVSCBtD9Mg/+uH+4dPpQTcQYQWsLV6F00VAM6GVNsNOFM9nH3pStJcD2hB4plsdwJq+JOv/6pEHBWT/vpxqYoIwM+k4f2Eq/u2j+py+2vsOJ4i0HQDXGRKXj8RsCMcqfEeh98HjiqLg2nykdJkxz4z2iKfqmy6xB2uD/e8Hw3TFWIAS/Ej71skqWg1387gRbPMFOysdExHPojXtVLuy3pQR/smooza4+e4VIuQmJ8blXXM/i93WcUzAjnRGXzDSHwy64pxBwbpm1aYaVnx0C04jWXl+V70BAd12mbBW3l2c4yl+EFVMFOKasS6Z5q5bng==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Dec 2025 07:44:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 642964 invoked by uid 111); 27 Dec 2025 07:44:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Dec 2025 02:44:15 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 27 Dec 2025 02:44:11 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: Possible regression: lost diagnostic message when pushing
 non-commit objects to refs/heads/*
Message-ID: <20251227074411.GB2071715@coredump.intra.peff.net>
References: <CABPp-BGL2tJR4dPidQuFcp-X0_VkVTknCY-0Zgo=jHVGv_P=wA@mail.gmail.com>
 <20251224081214.GA1879908@coredump.intra.peff.net>
 <CAOLa=ZSOZz9aGFFeD7tiQ+PRwkMosjcoxfTSk52fQeQq0ghgaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSOZz9aGFFeD7tiQ+PRwkMosjcoxfTSk52fQeQq0ghgaw@mail.gmail.com>

On Fri, Dec 26, 2025 at 11:48:19AM -0500, Karthik Nayak wrote:

> > And then receive-pack can either dump it via rp_error(), giving the same
> > behavior as the old version. Or it can stick it into the per-ref status
> > field. The latter feels more "right" in the sense that the error
> > messages can be reliably attached to specific ref updates in the
> > machine-readable output (rather than appearing willy-nilly on stderr or
> > sideband 2). But I'd guess it would make the output rather unwieldy.
> 
> The second option would be more useful to the user too. Since they can
> act upon that specific update.

The trouble is that the low-level code constructing the "err" buffer is
aimed at writing a human-readable message. So you get the whole string like:

  cannot update ref 'refs/heads/foo': trying to write non-commit object
  d19968fcf0d3193147b827c9e89668d619afd01e to branch 'refs/heads/foo'

That's already somewhat redundant by itself, because
lock_ref_for_update(), the intermediate caller that sticks "cannot
update ref 'foo':" on the front of the string, does not know that its
helper function write_ref_to_lockfile() has already put "foo" in the
error message is returned.

And we get one layer worse when we attach that whole thing to
machine-readable output associated with the ref "foo".

There's probably some clean-up possible here, but it will have to be
done very carefully. If we can check that all of the callers of
write_ref_to_lockfile() mention the refname in their error messages, for
example, then we can simplify what write_ref_to_lockfile() puts in its
error messages.

I'll let you decide how you want to proceed, but IMHO it would be OK to
handle the immediate regression fix by just going back to dumping the
error messages to stderr. And then further cleanup can come on top.

> Yeah, I can polish what you've send. I'll work on it and send something
> soon-ish (I'm taking some time off, but its hard to stay away from the
> laptop).

Sounds good. Enjoy your holiday!

-Peff
