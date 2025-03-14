Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E38202C3D
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978759; cv=none; b=jZ8GgkNfkCDINEsTAr6dBajBhiZ+Cn8BXOJ0HYwYfqQjHwa2SYSJmtLIFyt5fwd+KpSzXy8PbbWFt5JqBWnMNImzaolGxPNOTKXo6aM16g54sphonppliS56jyf4bdpb9GqrPzoPW1zDiaEQsm13pnOYpuJBX7xbSlVr1O1Bmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978759; c=relaxed/simple;
	bh=SzW1Pi/fTLpb/uKgn9MfDuUbGqWhuo+gsQVylu/BT1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ue5IKp+0l5BVDYexnPELI5r8QvTR1WjGfZ/r2sgbnWBLYZ5nS+kqDwrYkqzY4WoSQc2woqEG/RBvP1Yj6qZH5xzTArNRp6z7aqDEPZByjsRlaUIRzxKZjX7zB6DvRwVlEAjcYg6dusBSXJbzAh+4lEjFUn9aIz95gH+5WBYlz14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Kj3RAWEa; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Kj3RAWEa"
Received: (qmail 23609 invoked by uid 109); 14 Mar 2025 18:59:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SzW1Pi/fTLpb/uKgn9MfDuUbGqWhuo+gsQVylu/BT1U=; b=Kj3RAWEaZkYo7CzEqUiDMTTvuxMe0FKbojUt/lGKNQ6KCLygJ+NM4YTwFGgucY4wv4imdUCHig32d143am9v+RO1G7eIeX0C5+TfkyF3vSwVrghA8GJeqZVYIRE0+0Bz1VNrKsdo6rdddeCk9JRW/ejc+fGAQ2V6Ba4LRAdrNdKyo95+VqVg1qxfn6MBewrXyr2JUFb0kllTBqmv9IOAXm6eDF18m2Id2oW4pINmh1xbh/IC0HKusD0XWbZoSrLU/7HFoOM66He7EVmZ79NCCHWp40wQK5Jnls9PFBkhrVmhcSYAFhk4RtvhUAtdF8NNzYBW192Srxz1IHQjU0QXcQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Mar 2025 18:59:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7972 invoked by uid 111); 14 Mar 2025 18:59:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Mar 2025 14:59:14 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Mar 2025 14:59:14 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, ps@pks.im,
	christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
Message-ID: <20250314185914.GD578421@coredump.intra.peff.net>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250311235720.GA73755@coredump.intra.peff.net>
 <sm5xvh7bipyrlpw45bptlctbuhey7v3qktpskal5dzexomt34f@wgfziyhcf3t6>
 <20250313053329.GC94015@coredump.intra.peff.net>
 <qapd7sijizopaefpxh3slgn7g2ecwdtyhzqzufcypciyv6n3qm@turmldwzipwe>
 <20250314024929.GB114103@coredump.intra.peff.net>
 <xmqqsenfk0ks.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsenfk0ks.fsf@gitster.g>

On Fri, Mar 14, 2025 at 10:02:11AM -0700, Junio C Hamano wrote:

> The developers who know that the revision walk infrastructure is
> shared between rev-list and log may wish that "-z" to mean the same
> thing for these two commands, but the end-users do not have to, no?

I think of them as related in a user-facing way, but it is likely that
my mind is poisoned by knowing too much of Git's internals. :)

> After all, "git log" accepts "-z" but "git rev-list" does not in the
> current system and nobody complained about the discrepancy so far.

Well, rev-list _does_ take "-z", but it just happens that it cannot ever
do anything because you cannot convince it to produce a diff. But even
knowing that is true is probably again a sign of my poisoned mind.

> Having said that, at the plumbing level, my preference is to have
> two independent options "--nul-delimited-{output,input}".  It does
> not prevent us from starting with a single "-z" that works as a
> short-hand that flips both on (and is inconsistent with "git log" at
> the Porcelain level), but we can make "-z" only for output for
> consistency.  As long as we agree on the design to allow us to
> control both sides independently, starting with "-z" that is only
> for output may be the best way forward.

Yeah, I almost suggested earlier having longer, unambiguous names. And
then that punts the issue from "which functionality should be available"
to "which functionality should be mapped to short-and-sweet -z".

I do think it's still worth considering what "-z" should do _now_,
though, because it will be painful/impossible to switch its behavior
later. And people seemed to like the "both input and output" direction.
That would leave the longer names as escape hatches. I.e., I'd expect:

  git rev-list -z --no-nul-delimited-input --stdin

to use newlines for the input and NULs for the output.

-Peff
