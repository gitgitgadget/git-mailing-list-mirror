Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83E1B87CE
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 05:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743052464; cv=none; b=meSH1T7Gsqi4ERvOsapWpVjnLRxigSYD1XqbX2XrxOuXeEGDAyxdHgyY0gKk852EJo/BLKEK5iNqS6L7bqQyJdrP78TcyJU6TiD6H0o44OZV2tA33t2hJx7QjufBZxS0bdGbyCvsdeSgxt3Gp/KrzV4/mVm9BwJLwMdHiacRrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743052464; c=relaxed/simple;
	bh=htX/G/8UlwVcH3EiAWMbaPmv38iD7AYkAF5Hak2dK+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMbGDEDAzKhkv720bhQeQgejXStBjvWQ4v6NF9jYoLtvt5mNQ97ZjOjcOsvG2lF2A/JYEy5IFJtrbFeDtYkFQF5GziTmQmgjD8Zv4Bm7VmcU0U/DanULVL+EqsDn+tQWyye78qC+dTX/reP3iwlQO3FUVGyr5rsIg/5SKhK/4Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Cs2XWkgV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Cs2XWkgV"
Received: (qmail 18747 invoked by uid 109); 27 Mar 2025 05:14:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=htX/G/8UlwVcH3EiAWMbaPmv38iD7AYkAF5Hak2dK+c=; b=Cs2XWkgVJjCnE/Ad5fsgCJc4wLAo0Yrnk/sv8Z0xAdLkkzsbZXRU8CubMEZDVB/h8q8fll57UMcL5er6d+1et4TU6P2yqZPvDC7g1mVkEKm3ChXRxvBqA71afKri9WqhRATq/Njb7tQmYxjSkyw35LWAn/hnEcORiEfqcfZ5ErADqvGs5kbX4TxgYvTxXwk3HV48bsQgEPjFPopeEfefoXNpNhThKbP5bzRhcAXMccmA5SM9HlMKRaPkrC+khKhri4Z32+ik5W63w/7oJ5pJlot3QT0eUZaB48TKbeGHulNo/NqaFmIhqm92DWV3baXlIlVFxlf/LGD1o5SXdBAuTA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Mar 2025 05:14:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26940 invoked by uid 111); 27 Mar 2025 05:14:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Mar 2025 01:14:19 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 27 Mar 2025 01:14:19 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] detect-compiler: detect clang even if it found
 CUDA
Message-ID: <20250327051419.GA3042475@coredump.intra.peff.net>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
 <pull.1889.v2.git.1742945534.gitgitgadget@gmail.com>
 <2f6f31240fe6ce5f8efab662af477540a0f966ca.1742945534.git.gitgitgadget@gmail.com>
 <20250326174127.GA2508080@coredump.intra.peff.net>
 <CAPig+cR+ESNg4tV1G6jbKKeRKABD053qZcG0BoFuQ7aC+1tGYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cR+ESNg4tV1G6jbKKeRKABD053qZcG0BoFuQ7aC+1tGYw@mail.gmail.com>

On Wed, Mar 26, 2025 at 02:07:10PM -0400, Eric Sunshine wrote:

> On Wed, Mar 26, 2025 at 1:44 PM Jeff King <peff@peff.net> wrote:
> > On Tue, Mar 25, 2025 at 11:32:14PM +0000, Johannes Schindelin via GitGitGadget wrote:
> > > Let's unconfuse the script by letting it parse the first matching line
> > > and ignore the rest.
> >
> > Makes sense. I wondered if this:
> >
> > >  get_version_line() {
> > > -     LANG=C LC_ALL=C $CC -v 2>&1 | grep ' version '
> > > +     LANG=C LC_ALL=C $CC -v 2>&1 | sed -n '/ version /{p;q}'
> >
> > might be more readable with "grep -m1", but it looks like "-m" is not in
> > POSIX. So what you wrote is probably safer.
> 
> It's probably an indication that I've done too much `sed` programming,
> but I find Dscho's version more obvious. That aside, your response
> made me take a closer look at what Dscho wrote and I noticed that it
> is syntactically flawed, at least for BSD-lineage `sed`. Testing on
> macOS reveals that this is indeed so:
> 
>     % LANG=C LC_ALL=C cc -v 2>&1 | sed -n '/ version /{p;q}'
>     sed: 1: "/ version /{p;q}": extra characters at the end of q command
> 
> The problem is that the `q` function takes no arguments, but
> BSD-lineage `sed` thinks that the closing `}` is an argument rather
> than a terminator. Fixing this requires inserting a terminator after
> `q`, which will be either a newline character or a semicolon. So, the
> correct form is:
> 
>     sed -n '/ version /{p;q;}

Heh, I think it was the braces and semicolons that made my spider-sense
tingle, probably because I've been bitten by those subtleties in the
past.

I think just "/foo/p;q" works on GNU sed, but no idea if it does
elsewhere. What you wrote seems the safest.

-Peff
