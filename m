Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D041C8613
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742848122; cv=none; b=dBbyACuTXdMPHSpOX647EmtN9YQLYRki2wtkwxSV6ypqycCqoS0zvLMusZlVk8MJoqwWiaoWsW62dq4QJShwmEMQBOm73RU+vO2agG7TIUeb9v1l6wFjOuw0f0wuUcGXmSysMJSUpIMrvHbFZtzg0qfS+qx3iYL/Cla5D/oyER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742848122; c=relaxed/simple;
	bh=QL0zNWCSLfiMiI7ImpPSEhdX9MCBpjx/mmZcO0JkyjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INeeWVZERgHjRa8DaGaPTgN7pFBMl949y0XjgF8kdX+I0q3n9bBY/ZzaPacmiWpAHEqjUbSqBtQ2UJajHgC2zPe5uycfSfs/qWpPhgD6Y+noiG1g+k1joXkhgKZO81fDisiY7s5fiTvbp6FqW4tzfeNeNHfqwRxVgKwfXcWwDqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ifMYB3kY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ifMYB3kY"
Received: (qmail 23011 invoked by uid 109); 24 Mar 2025 20:28:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QL0zNWCSLfiMiI7ImpPSEhdX9MCBpjx/mmZcO0JkyjA=; b=ifMYB3kYnt+ghgvDpsPG51cW31BgShjv6BbtaIWgjvG1ca4SU5dvg5WLDsXgaEP6uZHRIhtrKYS5k4uE8p7g6QCSbg2vLEAyUtLui4kY/jwV8RG2kDgzwD7qUcH/yt9P1Ly+cyVDov6PHYlfQX69wFYKlj/LV9c2376dROpn9xH47o4Pprnq2beOqnQD/scDrHAa+gWDjbaDScW8pZwxaI/VNXXMqK/YO/oAVk2gbZBV0152ZlhE3Jl06pki8M6ZLk6zX0ghh1oiaWomiMZdPZa0L02ykO4AiMw8u/wGiii7Wurh7dVT3uI4gh7Ge996tRCariu5SmzqDawPqr98RA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Mar 2025 20:28:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4762 invoked by uid 111); 24 Mar 2025 20:28:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Mar 2025 16:28:38 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Mar 2025 16:28:38 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ayman Bagabas via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Chris Torek <chris.torek@gmail.com>,
	Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: Re: [PATCH v3] shell: allow overriding built-in commands
Message-ID: <20250324202838.GB777700@coredump.intra.peff.net>
References: <pull.1930.v2.git.git.1742688740650.gitgitgadget@gmail.com>
 <pull.1930.v3.git.git.1742743771108.gitgitgadget@gmail.com>
 <20250324032550.GA690093@coredump.intra.peff.net>
 <xmqqy0wvov5n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0wvov5n.fsf@gitster.g>

On Sun, Mar 23, 2025 at 10:27:32PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So it seems like a reasonable goal. A more restricted approach might be
> > to provide a more formal hook/plugin interface. E.g., to run a hook
> > script with the command name and arguments, and have it return
> > success/failure to allow the to proceed.
> >
> > That's not quite as flexible (in your approach I could replace what
> > upload-pack is doing entirely, cache its output, and so on). But it
> > might be harder for admins to screw up. I dunno.
> 
> Yeah, we usually try not to be overly flexible for that reason, but
> given that "git shell" is so limited that rewriting its services
> wholesale is not all that much of a deal, I think it is OK.
> 
> I however wonder if it is worth admins' time and effort to add
> features to "git-shell" using this new facility, or if they are
> better off using something more established like gitolite once they
> want to go fancier beyond what the basic "git-shell" offers.

Yeah, I left my general opinions on git-shell unspoken. ;)

For features, I think you are probably better off with something like
gitolite (which I think does have some access control).

For security, I'd be a little scared of git-shell, just because it's not
run all that frequently and we've had issues with it before (e.g.,
integer overflows). If you're taking requests from untrusted clients,
you're probably better off configuring http service.

I also imagine there may be restricted shell implementations that are
more general and more battle-hardened, that you could configure to only
run a few commands. But I haven't looked at that space (because again,
I'd suggest just git-over-http).

-Peff
