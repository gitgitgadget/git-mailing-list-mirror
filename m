Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41581357CE1
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159834; cv=none; b=dpGn3TcGzSM13wmtHbz+QllaGBB0/p8SmKM3s+U7vUjZBRG/leO2yWhu2jhREUexPe5nHazqhk9VgZx4y+rBPe9aMJuck4x1/eGrXbevK5jG6FoMgrZqvo+qHdcp4581YlvZCAFybHCMYxatMZaHOluXLLswQtivtx/UNFjZncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159834; c=relaxed/simple;
	bh=3eiO4drIkHIzKq4pBVbpkMaFjUvBJHGalPPGqw8J2SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oc9ELEV4qsJTsSeUxzcC99CIDeIB9cJtew3mMRL/q4/dnHEhapCouh7mJm0x37I0h0F107KinEJSI4phCQf3dcF/4+lXacaKKoyaMaI3BD2W77ycTdYxgsHAwoOxZHaE7BPUwNnEp5azEEDc9n+klc7+VNbxxKshzr6VaIQzfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=W22qidjl; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="W22qidjl"
Received: (qmail 106263 invoked by uid 106); 11 Jun 2026 06:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=3eiO4drIkHIzKq4pBVbpkMaFjUvBJHGalPPGqw8J2SQ=; b=W22qidjlKaTjWutPfQHolkK8d82P8UzeGFIpeg9uYuhWwmriB60YIRNusAZLgl2D2KcHEyRrj3f53rdLCcqe80NrTxme3DeKKdsEuh3+TpXMLdHMPgZXND7uR5uH9OEIla/JmgwYwIE7Rb9zLf9yhD9BvmTpf/6x2lO97lL+3sw/H1dwiNkBk9FAY2NY13SfUvxclvINQ+KY3aGsPcuxZjxkjnxZI+BwGqr5Juzm3fBhCJ0pWgjMgBDYuRXcJD6nMQgm6WlqV8PLKPBZ6Hjom+sfZp/0/Px2Bq2lQhXBJExFCvR2dlgbt82M09xzoQ1k2LvY0+fSk9EfnEitezR9NA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 06:37:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 313909 invoked by uid 111); 11 Jun 2026 06:37:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 02:37:16 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 02:37:11 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] describe: limit default ref iteration to tags
Message-ID: <20260611063711.GA2191159@coredump.intra.peff.net>
References: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>
 <20260609110957.GB1509396@coredump.intra.peff.net>
 <CALnO6CB-9a=P4Os90978YzEH=3iYEHwSbG2oLv9sxVBjBfchMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CB-9a=P4Os90978YzEH=3iYEHwSbG2oLv9sxVBjBfchMA@mail.gmail.com>

On Tue, Jun 09, 2026 at 09:40:25AM -0400, D. Ben Knoble wrote:

> > Given the discussion in earlier rounds and sibling topics, I assume the
> > commit message here was AI-generated. And it's OK in the sense that it
> > is describing what happened and I assume is entirely accurate. But as a
> > human reader, it feels so much more verbose than what I'd expect, as it
> > is full of semi-irrelevant details. Why set --warmup and --runs? Why
> > bother with --command-name, which just means you have to show the
> > commands separately anyway? Is the amount of RAM in the machine
> > important for this test? Surely it could be if it was absurdly tiny, but
> > in general, no, I would not expect it to be.
> 
> [You probably know this] It is common in academic papers to report
> benchmarks with details about the hardware and how they were run to
> contextualize the results and help with reproducibility.

Yeah, I almost drew the same comparison in my original email. I agree
that having every last detail _could_ help with reproducing in the
future. And that's important when producing a high quality dataset or
academic paper. But the tradeoff seems worse in a commit message, where
it is easy to obscure the main point or overwhelm the reader in what is
otherwise a short-ish document.

> Of course, Git's commits do not form an academic paper… so I have no
> real opinion on what to see here. But I've seen a few other mails
> where having perf test outputs or similar was suggested (maybe that
> was to be reserved for the cover letter? idk).
> 
> _If_ we show all the hyperfine details, I think it's reasonable to use
> --command-name to make distinguishing the versions easy, unless it's
> obvious from the path/to/git in each benchmark (which I think I've
> seen from Peff's benchmark reports before?).

Yeah, I tend to copy the various versions to their own executables,
which gives them short names (so you see "./git.old vs ./git.new" or
something). That's not always completely obvious either, though.

The "short" example I showed may have been a little hyperbolic. I'm OK
with hyperfine output in general, and sometimes show it myself. It is
kind of verbose, but occasionally the distribution of values, or user vs
system vs clock times are important. I'm even OK with --command-name if
it makes things more readable.

I guess what I was really responding to is that I think it is helpful
when the incoming data is cut down to the minimal set of useful details.
That helps a reader immediately assess what is important to the point
being made. Humans tend to do this naturally because we are lazy and
do not want to bother typing or pasting the uninteresting details.
Program output (whether AI or just verbose software) has less of that
impulse.

> Someone with better lore skills can probably dig up a few exemplars of
> how to write about performance in a commit message?

Probably searching for emails from René. :)

-Peff
