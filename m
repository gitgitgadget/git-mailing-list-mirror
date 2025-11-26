Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167F130BBAB
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170034; cv=none; b=km1Fa2BTPR0pJ3bCVGADMELCTaDow/o91JdV2LIRq5s1jVP3NSeBG/h14XjzI8N/F9zJsEjhkb5+P33DbRf5U5SPRjUkW3AggiCFUVKU9VMEgHWSC3v03surOFxnHsZwkq+WuwTMTqOFCc050V7pw0wGa36Rybv/VfHZq7Y0S88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170034; c=relaxed/simple;
	bh=fK/Fjr+p1llFD+UkrGhwcS8gC55REkQEGNbVgYdkU1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHvstXx1RpXevLr+Mrn6ZXPmVD9un84Dn2Q9yz/4B2LPmUzZKISGNCJB2ElrqflbEghgxODQ4G5h8Pz49R6DsVxZQiOeZh9dAefEh4amdgmPYMn13Bk0A/hr3Sjrp8ZaVSozsZsF5UypEj58BXG0J/4WMGiN/43QRWAkmXsbRos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Lbafc1GI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Lbafc1GI"
Received: (qmail 107381 invoked by uid 109); 26 Nov 2025 15:13:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fK/Fjr+p1llFD+UkrGhwcS8gC55REkQEGNbVgYdkU1A=; b=Lbafc1GIeQpjcjnhCrGpnAdAnb7UZuJxNUsAQScpzHbFfl84GQvvzl3wKk2AdAPyCRy+HH/cmux5vO5pOy4Y165hdbk+GomeCYmUDG8tQsQaYHAgEvVF1x96HzoUQpy0bB//JQym32WNnpigKly4NE3IcEU32ECPLuhhC8/skpBZUKwOAFdHWKmwt2anHHzm5ooa8X99iooKim3yfYZuAm3xDqctloKa86w+YNMw++y+8ykOVT3ZHwEz2UVQgzOA+7QKcL4Di4zb0pG6pidxRqNK6k+19WJwESyU8lo3Y6uhs2uOQdBGEe8DC3udnZLAjFvdkO49tD3Dg9LelPor4w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Nov 2025 15:13:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 189983 invoked by uid 111); 26 Nov 2025 15:13:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Nov 2025 10:13:50 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Nov 2025 10:13:49 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Han Jiang <jhcarl0814@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: `git config get --type=path` results in segmentation fault on
 value starting with `:(optional)`
Message-ID: <20251126151349.GD4143292@coredump.intra.peff.net>
References: <CANrWfmQUuGKWPc6JCzeCaa9t98ag_Lyk0G_Prtd8YmqP-TiRpg@mail.gmail.com>
 <20251120075019.GA1283645@coredump.intra.peff.net>
 <xmqq1pls8xeu.fsf@gitster.g>
 <20251125002828.GA2353309@coredump.intra.peff.net>
 <xmqqa50budxc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa50budxc.fsf@gitster.g>

On Mon, Nov 24, 2025 at 04:57:35PM -0800, Junio C Hamano wrote:

> Hmph, I tend to disagree; this was not driven by ease of
> implementation at all.  Rather, :(optional) cannot be an attribute
> of a variable; it is an attribute of individual setting of a variable.
> 
> For example, imagine that you want to say "the system wide fallback
> is in this file in /etc, but you can override it with a file in your
> home directory", and you want to say that only once in the system
> wide configuration file so that it applies to all users, without
> each end user having to specify that they do want to override it in
> their Git configuration file.
> 
> You can write this in /etc/gitconfig
> 
>     [default]
> 	editorConfig = /etc/editorConfig
> 	editorConfig = ':(optional)~/.editorConfig'
> 
> and ask what path default.editorConfig file is.  As long as large
> enough user population agrees what the name of the file under their
> $HOME to control the behaviour, this would work better than telling
> them "you can override default.editorCondfig in your per-user
> configuration file", as it is one fewer thing to configure.
> 
> And this is possible only if we consider that what the system
> pretends not to have seen is per :(optional) definition.

Yes, I agree that the code as-is opens up that workflow. But it forbids
the flipside, which is: "the sysadmin set up a path in /etc, but I do not
ever want to use that; I want to use my file if present, or nothing".

Now which is more likely, I don't know. I've never wanted to do either. ;)

The workflow I suggest would also perhaps be more elegant if there was a
way to "unset" a variable. We allow that in some cases for list-like
variables, with an empty entry to reset the list. But usually for
single-valued variables, we assume that last-one-wins is enough.

-Peff
