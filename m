Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A78321B9D9
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453906; cv=none; b=ifPnAj+hTgBzrKghWDjnnKoIwJlw0jfv7M3u4ORl22fm5RuFyypiHsROqb3uzNbMB3no1GdfTno5xYg4dDoPqPFd5ODMLwdCSvdwineO7Eo3u+8cKjJoRQwYAU7TZ/wEH7NhrtJwcI8d30kwJeZv7be5+p6SwQxD8VBS9rcSaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453906; c=relaxed/simple;
	bh=H4JTg3lDIkBaES/jsDKtIpKq8oC1QUqeyodw8uAviec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqAJweUISUtTWlhEIDfeQ8SSf1t9fhJ4ul/cEzUdunyRrNc5CezpaLoexco/pLfqZE7X2JpS54Q8l31BhLYCihrNEPDFLgbndnLs5gxtyYa4VOZNx5cW1ErpK2/lTYeyNQ5ect4gf6dDuA9lOB1ias/dBxdWoe4qdhsVozg0A8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0QMW5PkO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0QMW5PkO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81CCC4CEE3;
	Mon, 31 Mar 2025 20:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743453904;
	bh=H4JTg3lDIkBaES/jsDKtIpKq8oC1QUqeyodw8uAviec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0QMW5PkO4jV+BO6uF1VcXgJigfZ5hsGNycAZ3IQhcukcy0r1ZNc3ThBu1rfLobdxr
	 0s+JaejFJvUZ8YGJAXgTt/jA4LQ4oXCCehRXgdWJz5UylyO7ghsZMadG/uA/XRvKPc
	 bbOGf9YDNWMCx0ZSM/O+c+MhB/43V12tNJWcn1WA=
Date: Mon, 31 Mar 2025 16:45:03 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: MegaBrutal <megabrutal@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: How to get git-daemon to work in a post-CVE world?
Message-ID: <20250331-thistle-wolverine-of-jest-b11d9b@lemur>
References: <CAE8gLhmKtV-Kz4jYT6r1NanmGdAyzd0CumVGsVnVpePQPAtnzQ@mail.gmail.com>
 <20250331-devious-woodpecker-of-temperance-b18608@lemur>
 <CAE8gLh=1bqA6UTR4wAX1u1naic2cSGiekz0jLKxWeaxBKa=xiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE8gLh=1bqA6UTR4wAX1u1naic2cSGiekz0jLKxWeaxBKa=xiQ@mail.gmail.com>

On Mon, Mar 31, 2025 at 10:15:00PM +0200, MegaBrutal wrote:
> > > I'm new to the list, just thought it's the best place to talk about
> > > Git. I'm running a public read-only git server with git-daemon. I've
> > > recently noticed that my repos can't be cloned and found that
> > > particular CVE which made git to verify the owners of the git repos.
> > >
> > > fatal: detected dubious ownership in repository at '/srv/git/mgsautils.git'
> > >
> > > The feasible solution is to declare the directory safe in .gitconfig.
> >
> > You can set global values in /etc/gitconfig, e.g.:
> >
> >     [safe]
> >       directory = /srv/git/*
> 
> Thanks! While it is much more convenient to set it in one global
> /etc/gitconfig than individual home directories, I encountered the
> following problems:
> 
> 1. It doesn't do anything with the other error I get, when the
> problematic directory is '.'. I still keep getting that error message.
> 2. Git daemon doesn't seem to resolve the '*' wildcard, i.e. with the
> wildcard I get the original message back which complains about
> '/srv/git/mgsautils.git', despite it should be covered by
> '/srv/git/*'. When I supply the full path, however, the error message
> is still about '.'.
> 
> I even performed a whole Ubuntu release upgrade to get a new version
> of Git, but 2.43.0 acts the same. Seems like git-daemon is more
> stricts than plain git – what might be the problem?

2.43.0 is not very new. I believe in that version it only supported setting
that to '*' as a wildcard, so the following should work for you, hopefully:

    [safe]
      directory = *

-K
