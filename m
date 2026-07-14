Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A35429CF6
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065636; cv=none; b=qRIfIPP8GKm7q0OBreA44x4xEMgPMWokRANYA4mcnTWHZEKj7etmgGq1T3lkjLP3EiKRLAxM3Y0CbHjYxy81Sb05TYl3yrkczCA/tc8IxMKx6NkL+MbxRYO4z/wImBhnml8G0vE6jw9yQQBP8uXdj6/DtUaZx9e0zTlEDDgpqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065636; c=relaxed/simple;
	bh=M3zNxPS5H4h+KzRtXoUbwAefKS9jElHgZh49TUpIWm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVuqpWQFMwMZkbvIAiCwevSvOLQbAxUrv5p4BatUDvb9NydlSUjbXOPyBnXO63faLhWbB5srEjhD4kVASXyIZiC/RBrg3BPXo/WO9jdhQvrMfOjIlpFjM7lEku3e+u+gx6atmUS4CrKi7s7d63g4OQUxAmsEuIwK+WCKB4GcM6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iKQPvUva; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iKQPvUva"
Received: (qmail 25869 invoked by uid 106); 14 Jul 2026 21:47:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=M3zNxPS5H4h+KzRtXoUbwAefKS9jElHgZh49TUpIWm4=; b=iKQPvUvaezAHvToNXZjyJbPJDGECQ4achLMeQLPdfLNlNPdApfdCNfzQB0Ju4jxi63FYO4BN2i1AWINPyCo/mMtLXlwOhxEX2Bx9ViIxF/hfLwvW/AvgvIgMvKDkyJPNCjoAvkAHpph9enzgLehnj8gK2fQDPz76HwKPCgSTPkbbHp3KAJ9aRRFWBTrvMwynYBQPAtU4TTwpASaazk6JzCxK+vUgB3F10Miq5U5dKdW++MqmMsGlx6LjRn1nDf+YrAnqijdiDiyq0quIbAdhJLpFaQ6cgI/Fx3dF6Zm6y6kbCGDzjMrcod3g8o+5G7OsdtzSweQXlufaqppQkT1N3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 21:47:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 53424 invoked by uid 111); 14 Jul 2026 21:47:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 17:47:12 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 17:47:09 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] fetch-pack: accept "pack" output for packfile URIs
Message-ID: <20260714214709.GA4095533@coredump.intra.peff.net>
References: <cover.1783982021.git.tnyman@openai.com>
 <alVoA5-fDDPwKPZZ@com-76773>
 <20260714071231.GD2516582@coredump.intra.peff.net>
 <alaCQKXKcWr723Ij@com-76773>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alaCQKXKcWr723Ij@com-76773>

On Tue, Jul 14, 2026 at 11:38:56AM -0700, Ted Nyman wrote:

> > I also think this would all be much nicer with a strbuf (which would
> > let us get rid of the magic numbers), but that is a slightly larger
> > refactor:
> 
> Using a strbuf makes sense. One wrinkle, I think, is that with
> transfer.fsckobjects enabled, index-pack can emit dangling .gitmodules
> OIDs after the initial pack/keep line, which parse_gitmodules_oids()
> still needs to read from cmd.out. Would strbuf_getwholeline_fd() be a
> better fit here, so we don't consume those with strbuf_read()?

Ah, yeah, I didn't think about whether it might have more output. I
_think_ it actually works just fine with more output because the
memcmp() is limited to the hash algo's hex_sz. For the same reason what
I posted works even though it has the trailing newline.

It is a bit subtle, though. Using getwholeline_fd would work (though you
still have the trailing newline subtlety). Or maybe just using
strbuf_setlen() to cut off the output (ironically it is probably more
efficient to read the whole thing in and then chomp it, since
getwholeline_fd will read() one char at a time).

The "cleanest" thing is perhaps xfdopen() followed by strbuf_getline(),
but maybe that's overkill.

I'd be happy with any of the solutions. Or even just keeping the magic
numbers but maybe with a comment explaining what the heck "6" means.

> I'll also fix the --index-pack-args documentation while rerolling.

Great, thanks.

-Peff
