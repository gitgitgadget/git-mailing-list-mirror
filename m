Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F81D86FF
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733092310; cv=none; b=eOxB9Kb5Ylz3kpc3Qo2iVbtBrEHMWGc9Ai4gq3Dsfl6FIR5FZ96lR2YDgOQrGB0N4FVMwFK/p57u8+5qwpC+yYzajFLIxHDgwiqWHH7WoCNU0u41UpMJJnKC9SnJJdG9PF5NbSVR2fRMmXDRqu6UqOlFoo5GBq5E5fFXCTyctCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733092310; c=relaxed/simple;
	bh=J+fKm9yLscFlMlu0HPtHNNCpXoXteEz2LzghrWilV2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCyViXQLU8oM810g00pfNafSdLgU5OD61/pmlCP5EOB9+HwFCjpZgDPuU7tCuc9l8vBKuMeBzcATHZ7H6EIJXEd96yac4hKji4PKo1+4geMmF/XwFKsE4Emu6OKXuw8C1cnt3qZqg5ogoeFk1VfZr7y6HqXwWj/6i7aFID15nUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ejA8tkfG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ejA8tkfG"
Received: (qmail 4335 invoked by uid 109); 1 Dec 2024 22:31:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=J+fKm9yLscFlMlu0HPtHNNCpXoXteEz2LzghrWilV2A=; b=ejA8tkfG53LCL+CtgYzrT92NCXfjF/2R3P7iu4iSj9gRK3hwV4bJMbspLgBc7e6xsgVseG5Vbh+eX4LWvsGOZoKWdljccfOPMMsiHfC5SsZzztxzHe8EGJSwFqoOj/qDybgwiDv1r01dgfzbXfg/mI9fIQlOL5z/HUHGZHBmPMLkmN8Y7qFFpLWEzpxI9u+rnVyY1kBQwyX3uQaFsWoj3xKB8Kh9HIfcm4IPaG+hKDPjZycoJ9autvIjNo5UtISuoYv6cOU/ow6GeqviTzYyFe/9IP7OI5NCAwL8ImhvSqGeLnerzvpUtM2qazB8EWCUielOXUXbvmAw3SFK2BpUag==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 01 Dec 2024 22:31:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14667 invoked by uid 111); 1 Dec 2024 22:31:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 01 Dec 2024 17:31:46 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 1 Dec 2024 17:31:46 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Extending whitespace checks
Message-ID: <20241201223146.GI145938@coredump.intra.peff.net>
References: <xmqqbjy5bc6m.fsf@gitster.g>
 <20241127150429.GD2554@coredump.intra.peff.net>
 <xmqq7c8os07x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7c8os07x.fsf@gitster.g>

On Thu, Nov 28, 2024 at 08:53:06AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But it seems like a very deep rabbit hole to start adding in
> > shared-library line validators, because I think it ends in "now
> > compile this before I agree to apply the patch".
> 
> I am not sure I understand your conclusion.  Who is telling that to
> whom?  Somebody sends a patch that creates a file that requires a
> special validator and the maintainer gives the validator and tells
> the contributor to go use it to make sure their addition passses
> before resubmitting?
> 
> I was hoping that the ability to add extra validators is more of an
> enabler (than requirement and hindrance) for those who choose to be
> extra careful.  It is similar to CFLAGS in our Makefile that allows
> you to use options to enable more strict compiler warnings than what
> other developers usually use, to notice certain class of problems
> others may miss.

Yes, we who introduce the mechanism to create plug-ins do not have to
worry about writing those plug-ins ourselves. But we do have to maintain
the plug-in interface, and respond to complaints when it is not rich
enough to do what people want to do. So I was merely pessimistically
foreseeing where this may end up. ;)

Of course...

> Shared-libraries and plug-ins remain to be solution in search of
> problem at least for this project.  I do not really need CSV comma
> counter, but I thought it may give a good excuse for those who want
> to play with Rust and other stuff ;-)

...if playing with the plug-in interface is the point, none of that may
matter. :)

-Peff
