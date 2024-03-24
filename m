Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800313ADA
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711267035; cv=none; b=i0c+7+cmWBfU/blwkG39/vI8LyaiErePOhyL3jNn05O+Tgqyfg0aCnn5HMta69/AyI2lV6sHQTrxWVqkioelm+z0tLgBNh7agg2zQAJc2aO45VuEbsz5cFUDqJdDqWDeBrCv8xinqH/ZQW+ySMVpV5EJRhNlHnYD1weEcQyyQDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711267035; c=relaxed/simple;
	bh=xRYLparMb8cHq+15AHO/xYOrRP0Px6vkFsMMnSJsV7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZpaDTLopHiy3r0GZ5uVDJlsx9kjoNgbOvdDHIRVzbUt0ZjIO17rNi1zqGPSpCBZYrMySKJsH/EtsRvhQbCpGwlbptw0JNXssgoLIuaM2xk1nAjCW11jKR2H+tpwHc2vEeoI5ljQyWJDe7ZogNuVwlIPofy+ox0B7gUZ84rMW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=xLSOEPga; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="xLSOEPga"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 431F060392;
	Sun, 24 Mar 2024 08:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711267023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=02dcs6l1Qxr5KBjOn26106BE31lHO6svNa76zshOatY=;
	b=xLSOEPgaCc54+WYQcCOSblG5uxsQAX6VFmTZMNk+ofnFvCU9x+OgpdUvrp9gTD94uuVdt3
	jbyfP8FZMRaI11CQ+0Ne0llEEVUlT8oLHO3fezbIG0HjaiVk+AZftWmSP/QRm09iL2EvFV
	xoeZa+nBuwK1Ewy3navZvG0hURBcMDjTlpRt6BsZ97/OywmgZr8uwS6ars0nf0WDsBGex/
	MXwTdlAtzefni6Cp1XkrdE4M46Ypv6GyApmLiffW6qQGcoK7DFBATFJgj8KQlgE4G8qjej
	02+wD0q86oC17zTUIPZ6GBfx1V52TBTJvmMZm94s9UhSPOnW0mnTw9t0L6kTrA==
Date: Sun, 24 Mar 2024 08:54:49 +0100
From: Max Gautier <mg@max.gautier.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Hans Jerry Illikainen <hji@dyntopia.com>
Subject: Re: [PATCH] editorconfig: add Makefiles to "text files"
Message-ID: <Zf_cSWY9DxVxKZu2@framework>
References: <20240322221813.13019-1-mg@max.gautier.name>
 <xmqqo7b5zy84.fsf@gitster.g>
 <Zf77gyA28KsZdOUs@framework>
 <xmqqr0g0yhoe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr0g0yhoe.fsf@gitster.g>

On Sat, Mar 23, 2024 at 10:36:01AM -0700, Junio C Hamano wrote:
> >>  * Does .editorconfig file allow possibly conflicting setting, with
> >>    a reliable conflict resolution rules?
> >
> > Yeah it does: https://spec.editorconfig.org/#id8
> > TL;DR:
> > - from top to bottom, last matching section wins
> > - if multiple .editorconfig are found (up until one with the root key or
> >   in /) closest to the file wins.
> >> 
> >> What I am trying to get at is if it is possible to make something
> >> along this line to work:
> >> 
> >>     [*]
> >> 	charset = utf-8
> >> 	insert_final_newline = true
> >> 	indent_style = tab
> >> 	tab_width = 8
> >>     [*.py]
> >> 	indent_style = space
> >> 	indet_size = 4
> >> 
> >> I am assuming, without knowing, that the conflict resolution rule
> >> may be "for the same setting, the last match wins" so by default we
> >> always use "indent_style = tab", but if we are talking about a Python
> >> script, it is overruled with "indent_style = space".
> >
> > So it looks like it's possible, if we also add judiciously .editorconfig
> > in subdirectory where we have other files which don't want the same
> > settings, probably:
> 
> That is much less than ideal---I was hoping that we can do this
> with just one file.  My reading of that spec is that in the same
> file it would be the last one wins, so something line what I gave
> you above should work more-or-less as-is?
> 

I read it the same way, I didn't intend to imply using one top level
only was not possible ; sorry for the lack of clarity.

> Also I am not sure if there is any reason why ...
> 
> > - po/
> > - t/
> > - contrib/
> > - .github/
> > - ...
> >
> > Not sure if that's easier than adding stuff to the to the root config
> > though.
> 
> ... t/*.sh should use rules different from those that apply to
> check-builtins.sh at the root level, or contrib/mw-to-git/*.perl
> should use Perl rules different from those that apply to
> perl/Git.pm.  So I think "we need per-directory customization" is a
> red herring.

Oh, I was more thinking about the other stuff under t/ , not she scripts
themselves, there is some .test, .diff, lots of files without extensions
(some css apparently, among other stuff) , and without looking in
details, my best guess is that most of this is test samples (=> I mean
things used by the tests to compare / test processing result).
I don't know if that's supposed to be edited manually though.

But yeah, "per-directory customization" isn't good, it multiplies the
place to look when the config is not correct. I was mentioning by fear
that using only one file would be hard to manage is there is too much
patterns. 

-- 
Max Gautier
