Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6256C127E0E
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500839; cv=none; b=c50aOuG2HiYgc8vKgwt7BQ9wjS8YSYRNQOTzApwtjCym9+bUFSi9hKyFySMpdOv4vm9B/qaGnzkNbjESaCUAReUrPst9gPA/Ih1597kfEKxjfws60KOvKPZ+BTpTwM/gzyuq50O6y6dII/irzTPjdpq5Lo+2OZoMLNkHtc+zoK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500839; c=relaxed/simple;
	bh=GhzGSj4OnZ+m2XLXLHZ/xxwbwjwmQBM8T3ez5Jn2/co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2EDhwylpmZ2KBhdSWFZjSJVgrxp/xjPIJkrdqyT+uctiUwDXyxdABYRIfrRYbwjYI92hRpGCSQdeZ4KaN1an4DVCCUL+GUtNjxGD81m2ELpo/oTsyD0MVst/hP0fodyHxGZuKaykrHMudBwD0DuKKXIyZu+jErTPQaHEIMSn0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 14360 invoked from network); 23 May 2024 21:47:13 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 23 May 2024 21:47:13 -0000
Date: Thu, 23 May 2024 23:47:12 +0200
From: Marcel Telka <marcel@telka.sk>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/t9902-completion.sh: backslashes in echo
Message-ID: <Zk-5YCKSO32vPKDP@telcontar>
References: <Zkdk7R9GIfsyQjkc@telcontar>
 <xmqqsey8tnny.fsf@gitster.g>
 <Zk-nswiCF-SnyxLE@telcontar>
 <CAPig+cRddr=JTVvkh5xkptag_1C5-z1t9Pzr_OdcGFSVwRg3vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRddr=JTVvkh5xkptag_1C5-z1t9Pzr_OdcGFSVwRg3vg@mail.gmail.com>

On Thu, May 23, 2024 at 05:06:00PM -0400, Eric Sunshine wrote:
> On Thu, May 23, 2024 at 4:32 PM Marcel Telka <marcel@telka.sk> wrote:
> > On Thu, May 23, 2024 at 10:59:13AM -0700, Junio C Hamano wrote:
> > > Marcel Telka <marcel@telka.sk> writes:
> > > > The usage of backslashes in echo is not portable.  Since some tests
> > > > tries to output strings containing '\b' it is safer to use printf
> > > > here.  The usage of printf instead of echo is also preferred by POSIX.
> > >
> > > This has cooked in 'next' for some time already, and I'll merge this
> > > down to 'master' anyway, but this being a script very much speicific
> > > to bash whose built-in echo we are using, the portability argument
> > > of "echo" made in the proposed log message does not quite apply to
> > > this patch.
> >
> > Could you please help me to understand how the bash is used to run the
> > script?
> >
> > $ head -n 1 t/t9902-completion.sh
> > #!/bin/sh
> 
> Looking a bit farther in t9902, you'll find:
> 
>     . ./lib-bash.sh
> 
> And if you look inside `lib-bash.sh`, you'll see that, if the
> currently-running shell is not Bash, it aborts the current script and
> re-runs it under Bash.

Thanks for the pointer!

Interesting.  I came to this issue because the test failed here due to
the echo.  So apparently the re-run under bash didn't happen here for
some reason or bash's echo behaved differently?  I need to dig into it
again to find what's going on.

> But Junio's point was that t9902 is dedicated to testing Bash-specific
> functionality, so the commit message's justification to avoid this
> non-POSIX behavior isn't necessarily a good justification for the
> change. (He wasn't saying that the change itself was unwelcome, just
> that the commit message wasn't convincing.)

Sure.  I understand the point.  I just had an impression that the test
is running under POSIX sh (/bin/sh), not bash, because it failed here
(see above).

OTOH, it seems that the fix is maybe not needed because it is solving a
non-problem.


Thank you.

-- 
+-------------------------------------------+
| Marcel Telka   e-mail:   marcel@telka.sk  |
|                homepage: http://telka.sk/ |
+-------------------------------------------+
