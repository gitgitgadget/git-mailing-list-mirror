Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC97029B0
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753598750; cv=none; b=cgdt1tHL4faSYJsre+oEH/kwnK5apLeuTV9RmhL90UspfJQlgZqi3je+peXAugqbZJq44zA5qgZc7nnY4jxU6puuzXPLTcDsM6boGyqFX6tSOPIald6EXLTeTOYKcFG0gJDPIKylgzU3MujkshRYzicq7sDGx8Tqh9AyTWHgWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753598750; c=relaxed/simple;
	bh=ys2bY2ShxfrDyth+c+MRIzVLWmGnvneakPIAJSxJ7oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hq6oZBDY9iW0AXVbkgyFe7bV/ErDyp6wV+6FLQa2LGKdmrS3uDLUWQ59PAwaE/q2un3zHfTQfZuCoyofaJ7AoXsUqUf0IyRruD9KurepGDvwC9I7MJChcVnwqTm6EooDgBJ8LR25q2piDbesSf7PvJmTEMUrfusZav4MvIxnrak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hgqDTvRH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hgqDTvRH"
Received: (qmail 10895 invoked by uid 109); 27 Jul 2025 06:45:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ys2bY2ShxfrDyth+c+MRIzVLWmGnvneakPIAJSxJ7oE=; b=hgqDTvRHEEUMkANl2HXj0Wu324BqLqtdyKKWZvOiMj+1WqzlWdb7pJzsIglePmwFnsn4KJ0Pz32iFRqVxvWSLV52Eo4/iRn0qGTGcvI1PMgYdo0uf1PlCyT/B7HdNLQBBgAbmmpM4LTdtW5Xz3DvDJLu0uQzW+J83v2lCXFKCqlSIAgegQ6hBe3wAGjU5hhYEdlqN2ktp1SH333W73O84URr9aipPPTBwtqFwEbSP89U2PQHAgHCGH+kY/2Syq21zER42rRKdjMuPxF/z7Ug+Fz0+5DiI8UxI72lRhvvNBYpk8XPeGwTFhoPqFrwVkUHIJmDlfdLWNZ4G602hCon5Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Jul 2025 06:45:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24231 invoked by uid 111); 27 Jul 2025 06:45:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Jul 2025 02:45:47 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 27 Jul 2025 02:45:42 -0400
From: Jeff King <peff@peff.net>
To: Todd Zullinger <tmz@pobox.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, git@vger.kernel.org
Subject: Re: [BUG?] git-daemon 2.49.0 in F40 no longer exports user
 directories
Message-ID: <20250727064542.GA3091411@coredump.intra.peff.net>
References: <aIOslkzu-x8K9o_C@shell.armlinux.org.uk>
 <20250726075136.GA3032762@coredump.intra.peff.net>
 <aITd13mTx8t1dQbO@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aITd13mTx8t1dQbO@teonanacatl.net>

On Sat, Jul 26, 2025 at 09:53:27AM -0400, Todd Zullinger wrote:

> I was curious, so I took Peff's recipe and gave it a try. 
> 
>     sudo dnf -y install git-daemon
>     sudo systemctl enable --now git.socket
>     mkdir ~/public_git
>     git init --bare ~/public_git/repo.git
>     git -C ~/public_git/repo.git --work-tree=. commit --allow-empty -m foo
>     sudo git config --system --add safe.directory ~/public_git/\*
>     git ls-remote git://localhost/~test/repo.git
> 
> And that fails as it does for Russell.  I suspected SELinux,
> which is enabled by default on Fedora.  With luck, you have
> not already ruled that out.

Interesting. That would explain why I didn't see the problem on my
Debian system.

I am still puzzled why Russell would see the message he does, though.
From my read of the code, seeing "not in directory list" but not seeing
"...does not appear to be a git repository" implies that enter_repo()
succeeds, but ok_paths is non-empty and forbids it.

Probably not that important if your suggestions here solve his problem.
But of course if you can easily satisfy my curiosity by running through
a debugger, I'd be happy. ;)

It might just be that I'm mis-reading the code.

-Peff
