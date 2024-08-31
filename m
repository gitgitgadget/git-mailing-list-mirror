Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536E81E
	for <git@vger.kernel.org>; Sat, 31 Aug 2024 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725072007; cv=none; b=XweByLh2aUwtBbD9z3g4RkDTFyLlpZ4o39mHtU+2FP7iQIWVXidaJh9Fi+hpzrCBPeyYAHp2KtgeQnv2Q74Gh3iQDxMd6yo9VHIqPDbywd09jxzQi68vMvgzhrabqZjOq0J4WikVXtstOTOVbiFY2YGgCGjacqMazWQ6IX9Ax0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725072007; c=relaxed/simple;
	bh=oavJ77eu6z+Txi7b1ziZZAQFUUTupvGajX8CpLviXFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK86zV2hCKO+qv9yCeeA4tEZflkSlWnf7E0WG9puttXIVm8gu1ZI10WZtc2vTIg+odtG1/iO/Ojng8NfbSkM+RGSoTfOPe+jHfbIaLzboGoD4+oy93WY9ugB6jnI3wN/eCvu3tp16j5E36uaVc57kQ2+EcMiAAyUAqSyvGd3uhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17742 invoked by uid 109); 31 Aug 2024 02:40:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 31 Aug 2024 02:40:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30315 invoked by uid 111); 31 Aug 2024 02:40:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Aug 2024 22:40:05 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 Aug 2024 22:40:02 -0400
From: Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/terminal: mark parameter of git_terminal_prompt()
 UNUSED
Message-ID: <20240831024002.GA2150243@coredump.intra.peff.net>
References: <d8c5e920-aff7-4e4b-af77-0d3193466b57@ramsayjones.plus.com>
 <20240829222612.GA445751@coredump.intra.peff.net>
 <44804f4c-26af-4d23-b044-ec32a13b549c@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44804f4c-26af-4d23-b044-ec32a13b549c@ramsayjones.plus.com>

On Sat, Aug 31, 2024 at 02:40:22AM +0100, Ramsay Jones wrote:

> > Here's a potential commit message for the patch:
> > 
> >   If neither HAVE_DEV_TTY nor GIT_WINDOWS_NATIVE is set, the fallback
> >   code calls the system getpass(). This unfortunately ignores the "echo"
> >   boolean parameter, as we have no way to implement that functionality.
> >   But we still have to keep the unused parameter, since our interface
> >   has to match the other implementations.
> 
> Yes, this reads well. Do you want to send an updated patch or shall I?

I assumed you would. Thanks!

> > As an aside, I wonder if cygwin could be using either /dev/tty or the
> > Windows variant. But that's obviously a separate patch, and either way
> > we'd want to fix this fallback code in the meantime.
> 
> Yes, this is what I meant by '... it should not even be trying to compile
> that code ...' ;) ie I was expecting HAVE_DEV_TTY to be set on cygwin (which
> does have /dev/tty).
> 
> However, there may be reasons for it not being set - I haven't had time to
> look into it yet.

I doubt there is a good reason. When I introduced HAVE_DEV_TTY ages ago
(2011, apparently!) I kept the conservative default as-is to avoid
disrupting other platforms. So I suspect it is simply that nobody on
Cygwin noticed the lousy fallback behavior, or knew that there was an
alternative (the most obvious problem is that when we prompt for a
username, what the user types is not visible).

Testing welcome, of course. :)

-Peff
