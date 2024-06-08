Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA8A4C65
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717846584; cv=none; b=h1SpLdvzOUw5MrxyVlpVRedvpFnkHCNgMwbJOsSdBm35QpL2azEs7gBCLpKwDeN6mXF70lz1TQ1Fv67SgQTzC3gjIpKcUkTQvaz6fy3Yop+es9WHU5HDNAqhWJUx4A4MFkjqFnkN/Zp39uMKoQrZc+FoiTpvC7mWt5hY7QynFgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717846584; c=relaxed/simple;
	bh=DT9uNl0SG1LTQqMjiz7etjCtDYeQJyIP8erNKkWwq0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft+INHlT1b5CC92OiUKBbm4yAtXjPma2ZpurmFkhqrUEwkvzojHP56RRxSt3Lzq6INjrmDn/DSya6+agvzFVtS312cCspikQ0Q+4lFmT90qyiaTq9BriVDRYxCbgD4z08PekLWeZ2ETnsR/+gZ7zUyZu39i8xjgLTd5UDZfgcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9073 invoked by uid 109); 8 Jun 2024 11:36:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 11:36:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29902 invoked by uid 111); 8 Jun 2024 11:36:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 07:36:21 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 07:36:21 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 11/12] refs: implement logic to migrate between ref
 storage formats
Message-ID: <20240608113621.GE2966571@coredump.intra.peff.net>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
 <20240605100318.GA3436391@coredump.intra.peff.net>
 <xmqq1q5buxzx.fsf@gitster.g>
 <ZmFAQ1UT6ePxHtzq@tanuki>
 <20240606070109.GC646308@coredump.intra.peff.net>
 <xmqqwmn2nko9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmn2nko9.fsf@gitster.g>

On Thu, Jun 06, 2024 at 08:41:10AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In my fork I trigger Coverity runs based on my personal integration
> > branch, which is based on next plus a list of non-garbage topics I'm
> > working on. So I get to see (and fix) my own bugs before anybody else
> > does. But I don't see other people's bugs until they're in next.
> 
> I am on a mostly same boat but doing a bit better ;-) in that my
> daily driver is a point marked as 'jch', somewhere between 'next'
> and 'seen', that appears on "git log --first-parent --oneline
> master..seen", and this serves as a very small way [*] to see
> breakages by others before they hit 'next'.
> 
>     Side note: This does not work as well as I should, because my
>     use cases are too narrow to prevent all breakage from getting
>     into 'next'.

Possibly I should base my daily driver branch on "jch". Like you, there
are many parts of the code I won't exercise day to day. But it would
mean I'd do more testing (and CI) on those topics. The big question is
whether that would introduce a bunch of noise from not-quite-ready
topics being merged to jch. It depends how careful / conservative you
are. :)

-Peff
