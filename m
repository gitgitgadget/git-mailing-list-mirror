Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783720E031
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744094793; cv=none; b=dZ2IqiQ2sAOGUSZ8lAjUYT8YNHrHKzRbQXRQWys22BiCXVhfUmthEM8lO5QzrELGs2Up8pZegD/s/OCl5FvCP6gDkhfH7q931czpbWkJ21EFLAN3efzOMWRGPYnvveZnAoj/mrg2HzKpgvotylQK9NIwjezFfCkW/02W+TjcMY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744094793; c=relaxed/simple;
	bh=IXh95ks8oCTa9e67r1Xhupdvj7M2wpB5y5ruQeX4Drg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcjVrpdoAViBGKQHyc1UD3gL3bpYFhe2jfNnKYka9pRrkr88fUmgMt/iCA7U4pTyytQ/kr/6KcMkspjkPb1D/7tOq+lC5n7971Co8aKAeCaVagflzmYDCykoKcVlatsrpnZUKQ2RoM5VAtEDp7MIdyZ9jkeuBvg/Fr4AsYxOw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=W8yXKedu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="W8yXKedu"
Received: (qmail 4808 invoked by uid 109); 8 Apr 2025 06:46:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IXh95ks8oCTa9e67r1Xhupdvj7M2wpB5y5ruQeX4Drg=; b=W8yXKeduheZASuIWH3ISHOFJ5050wyr5Oq5vw+wMlBoOCkXfwLFT4PAnDiJeHvnrL7t0qa79xgoe+V8UkrxyoZ94c8EOfGZGhak4pczYD3QdFPse4lkDfD4QcuzUs8Zh0xDUlbE9sZ70UHvidHu9uf6D98Pf7MeWumFNXpUT+wVCpp29tP6TAxZwX4+U7/VgnuSeGY+L+H2356MfDh9jUS4ZxC9A5ZXciBGvu8YU/41zVwExYHNX8S33buoE7YdR+Sz3nZPD3IoB7yarsz1RNVloEzsqQMJvw86ga07e3p4Z9nZQ+QMS9VcOi943A+66T5Xx085i1Srt3bJdz32o/A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Apr 2025 06:46:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5094 invoked by uid 111); 8 Apr 2025 06:46:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Apr 2025 02:46:20 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Apr 2025 02:46:19 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] refs/packed: fix BUG when seeking refs with UTF-8
 characters
Message-ID: <20250408064619.GA1957411@coredump.intra.peff.net>
References: <20250404-b4-pks-packed-backend-seek-with-utf8-v1-1-6ceb694e3bd7@pks.im>
 <20250404205740.GA780449@coredump.intra.peff.net>
 <Z_CJnBWReJeZKC9x@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z_CJnBWReJeZKC9x@tapette.crustytoothpaste.net>

On Sat, Apr 05, 2025 at 01:38:36AM +0000, brian m. carlson wrote:

> > Ah, good catch. I think this signed-ness issue has come up before, long
> > ago, but I don't remember the context. In theory any stable ordering is
> > OK for sorting, but of course cmp_packed_refname() chose to use unsigned
> > in order to match strcmp(), and the standard defines it as interpreting
> > the bytes as unsigned. One of the enjoyable quirks of C.
> 
> I'd agree it's a quirk, but I'm not sure I'd call it enjoyable.  Anyway,
> this does seem like the right solution and I agree matching strcmp is
> the right decision here.  I also think unsigned byte comparisons are
> more intuitive, honestly.

My sarcasm may have gotten lost in the wires. ;)

And yes, I think unsigned byte comparisons are more intuitive, too. The
fact that "char" is (or according to the standard _might_ be) signed is
confusing, especially in a world of unicode.

> > It's possible some filesystems might be unhappy with this character, but
> > I guess we can see if anybody screams.
> 
> I very much doubt that's going to be a problem.  Windows uses UTF-16
> internally, so it will have no problems with Unicode; macOS only allows
> UTF-8 in its file systems and I know it gracefully supports emoji; and
> other Unix systems don't care one way or the other because it's just
> some bytes.  Even ISO9660 with Rock Ridge or Joliet extensions will work
> here, as will FAT, UDF (used on DVDs and some hard disks), and 9P.
> 
> Certainly somebody could try something very esoteric, but I expect other
> things will break as well.  I'm okay with favouring testing things we
> know many people _are_ using (emojis and Unicode) over things very few
> people are using (very esoteric file systems[0]).

Good point that people are doing this in practice anyway. The worst case
is probably that we flush out some interesting limitations, learn more
about the world, and add a small prereq flag to the test.

-Peff
