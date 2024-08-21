Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58979D1
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278334; cv=none; b=EdtoHZR3GCs/1HKn3y4iIRdtmm8/za0WLlbPMBytCOPg5JHr3hWwdfKlWOgT1CJm3mKtA5w69I1RUIkq5LINoN+QO21Gg65oAC2waZ1VGmP7W6FhtfV51e2ClbiWpCmZLTJfUliPUBdR0Ci7TV7xQTDWBR/RsOaRhWLk1fZlfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278334; c=relaxed/simple;
	bh=T1sD1GUAZsHsc5FAdqPvty7AWsJJRJYI+XeVFWJtFyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hud66hmhksb8kAMaLSz3Lt7xiZTvxO47E9Ohvy6OsotlVa7Zzrl6xGgNIGoxQTlTpAf15nvDJHNsXrwI3eGVMkN/B5A6xy0N2xeo0Nav6Pri9c4yr9cAFrppp15PYMQ7BBi6nxIK1bueO4Xl1pB5kvbqHOaO/vPjkVZW8ss67MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=g+L6h5hm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="g+L6h5hm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B9LwkD0SYRVcPrjoQR8ZpIbLg+MO/sXsZCgDFpniONQ=; b=g+L6h5hmE3Z0y/JIvkp3zrvD7o
	ZpEP4xcpxGTu7YvCg2irE1nWLFygGctH0dJZroeSUILf9O5GOFH7H5nd5RazRNeQheAnwCFPJU4W6
	2K93xZxRLCWQJzAq7bPWNbsHydRJ+MvSs4wjvo2PqjtJzGxej+/4vtiigzS0KK6CEdm+pXoHnQahx
	uqM51/Hn8J6E09ClgGq0/+Qc6LfcvPe1hhVJ8Zfwa4whVqIM65DpOsEoDHhHo/UBMuxmdQkc/9RuY
	9lyvetLtZmt0Fud8ih2RfOPpVKmAlXRyMeTbtzB6Ywr9IQufpqr5yRzuLMVOwrfjGcnR70pual3ek
	rLrMHPjQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1sgt1Q-0073Rx-NY; Wed, 21 Aug 2024 21:37:39 +0000
Date: Wed, 21 Aug 2024 23:37:38 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: Simon Richter <sjr@debian.org>
Cc: git@vger.kernel.org, debian-devel@lists.debian.org
Subject: Re: Representing Debian Metadata in Git
Message-ID: <gbgpxxpikhkykvhug4ugbufqm6bdh44ygiknpzc3khalibwutk@jlebwg4vsvjt>
References: <eb963843-9e2c-49f2-911f-fa36f33f9bfd@debian.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb963843-9e2c-49f2-911f-fa36f33f9bfd@debian.org>
X-Debian-User: zeha

Hi Simon,

* Simon Richter <sjr@debian.org> [240820 09:11]:
> One of the long-standing issues is that there are multiple ways Debian
> packaging can be represented in a git tree, and none of them are optimal.
[..]
> A possible implementation would be a type of Git "user extension" object
> that contains
> 
>  - an extension name
>  - an object type (interpreted by the extension)
>  - type-tagged references to other objects
>  - other type-tagged data
[..]

> Any feelings/objections/missed requirements?

In the current DEP14/DEP18 discussions a lot of discussion was had
about how we should represent Debian things in git; your mail also
goes into this direction.

My *feeling* is we should do the opposite - that is, represent less
Debian stuff in git, and especially do it in less Debian-specific
ways. IOW, no git extensions, no setup with multiple branches that
contain more or less unrelated things, etc.

I think we should move more towards a setup that is easily
understood by people not closely following our Debian-specific
things. We should avoid surprising things, again that would include
the multiple branches and any git extensions.

Before pushing for new ways of representing Debian stuff in git, I
think it would be a good idea to learn from all the other distros
and distro-like systems successfully using git [1]. Debian is not
the only distro that wants to use git to capture changes and
encourage contributions to its packages.

Chris

[1] alpine, homebrew, freebsd ports come to mind immediately. nixos
and others too.

