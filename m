Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4AAAD2C
	for <git@vger.kernel.org>; Thu, 23 May 2024 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716504348; cv=none; b=ZBleG5IGcxgL2eCzXJ+GUi4AT/aY7cqSYFe2GY8MMXQL6iXXyJA3i1FTBvy3FzRqQqJMXZLnoINRa9UDWLZEUq3dhlBqqK/gXMzF4FSZpVGcLyVDjXqzmVzOOoRjUaZpFMJHxhMEpiBTjr06Smak8HDeD3BZmpbL0rHKicLb/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716504348; c=relaxed/simple;
	bh=aw3ScFdMJ4CMmD1+IbG9j26OO70UijxCyHrHnakddRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yh+9WKMWSFPs0wJU5OfwvHXRSwEXr1EgDVVylzSXHEskCtrHRGKGcfZrWYsnsy7Cjz/9Cs8nuDkDsf/WPFN3fxeEJpqH1udvmkhJRjSgZtbvIQqoQAZDr7WPH6+5iIkgskYc4mZVJFiVCTrvs0GVLxB3bIZpEGQ6l5vGa7No7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 17132 invoked from network); 23 May 2024 22:45:43 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 23 May 2024 22:45:43 -0000
Date: Fri, 24 May 2024 00:45:42 +0200
From: Marcel Telka <marcel@telka.sk>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/t9902-completion.sh: backslashes in echo
Message-ID: <Zk_HFkm2aymJXGZU@telcontar>
References: <Zkdk7R9GIfsyQjkc@telcontar>
 <xmqqsey8tnny.fsf@gitster.g>
 <Zk-nswiCF-SnyxLE@telcontar>
 <CAPig+cRddr=JTVvkh5xkptag_1C5-z1t9Pzr_OdcGFSVwRg3vg@mail.gmail.com>
 <Zk-5YCKSO32vPKDP@telcontar>
 <Zk_FiYd8uk-P5jIi@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk_FiYd8uk-P5jIi@telcontar>

On Fri, May 24, 2024 at 12:39:06AM +0200, Marcel Telka wrote:
> On Thu, May 23, 2024 at 11:47:13PM +0200, Marcel Telka wrote:
> > Interesting.  I came to this issue because the test failed here due to
> > the echo.  So apparently the re-run under bash didn't happen here for
> > some reason or bash's echo behaved differently?  I need to dig into it
> > again to find what's going on.
> 
> Okay, I found the cause.  Bash on OpenIndiana is compiled with
> --enable-xpg-echo-default so escape sequencies are expanded by default.
> 
> > OTOH, it seems that the fix is maybe not needed because it is solving a
> > non-problem.
> 
> There is a problem, but definitely the justification in the commit
> message is not accurate because we do not care about POSIX here at all.
> Also maybe it would be better/simpler to use `echo -E` instead of
> `printf`, but I'm not sure here.

Reading again the commit message I proposed[1] I think it is okay.

[1] https://lore.kernel.org/git/Zkdk7R9GIfsyQjkc@telcontar/

-- 
+-------------------------------------------+
| Marcel Telka   e-mail:   marcel@telka.sk  |
|                homepage: http://telka.sk/ |
+-------------------------------------------+
