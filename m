Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5267392C2F
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 02:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777343633; cv=none; b=sLIyTch1qLC7OxwG0/et5RUM5w3Zs9Qo0KGirVNXwopVNR/RSUtfat8wirPLTmCZc2HMx9faEuV5L3hFijRBduyrxFQKBCNAl2/T2htxSCcj8vzASm9Ftz57X1ineJNPM31azVD6ZpFB10h0Jb/Ck081a6EVn8SR0s+34TXz5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777343633; c=relaxed/simple;
	bh=2IcTTREl9mbLz0zNIYXcRbEurCcOtXf3ax/lpWeRVSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mw6hS27cCCWaNGX+Cb3RgssLjbHsjnchcS/ga/TzB844937zKhjjsz6wFC0n5+PJgk7dxBSMDazV6WN85xF8ERQctAJq8jjJcXhOdOqcbaaj7Uj8A3iJaLD0/zmjeOY97Vnnx4R3uGtTzprhW++r3sscciFBpRPMbxiyDXbOhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HRZeYMyt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HRZeYMyt"
Received: (qmail 476571 invoked by uid 106); 28 Apr 2026 02:33:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=2IcTTREl9mbLz0zNIYXcRbEurCcOtXf3ax/lpWeRVSU=; b=HRZeYMytb9UoPWtSE9sQz3VmrF4ZD4duxhjC0rIGc2lCECLOlr8dagZXRUStQSMemM6+w3hFEKL0ZwSsb/eT+AevlSPvzFzWtj3+nSG5s3bbfSn3b1GfM5/G2XVJ5h6WAIOQ8xOQLkKX2x9xkcJaXsgZ6Z941b0+wrP2l9aLoAWgT2jklalzjPjdHY1aCy22JKvhViNmVXBmPLC81jaIbl/yk03VXeLseEqE9kJU7jPhazpumN69iiJH9W0FPKBIsWBAah/KpV7iC1gpde5cUxnLMhospYProMxPvb6JCTOzWDblL7igBVyGLKUaAKi+fB80lcIDlFm1/Jh5y3HQpA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Apr 2026 02:33:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1080860 invoked by uid 111); 28 Apr 2026 02:33:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Apr 2026 22:33:50 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 27 Apr 2026 22:33:50 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5564: use a short path for the SOCKS proxy socket
Message-ID: <20260428023350.GB660154@coredump.intra.peff.net>
References: <pull.2100.git.1777299669889.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2100.git.1777299669889.gitgitgadget@gmail.com>

On Mon, Apr 27, 2026 at 02:21:09PM +0000, Johannes Schindelin via GitGitGadget wrote:

> The SOCKS proxy test introduced in 0ca365c2ed4 (http: do not ignore
> proxy path, 2024-08-02) creates a Unix domain socket in
> `$TRASH_DIRECTORY`. When the trash directory path is long (e.g.
> when running from a deeply nested worktree), the socket path can
> exceed the 108-character limit for `struct sockaddr_un.sun_path` on
> Linux, causing the test to fail with "Path length ... is longer
> than maximum supported length (108)".

OK. We try to work around this with a chdir in our own socket code, but
I guess we're not using it here:

  1. The socket is created by our socks4-proxy.pl script, which just
     feeds it to perl's IO::Socket::UNIX. And it looks like it
     recognizes the long path and complains. We could fix that, but...

  2. The reading side is implemented by libcurl, not by us. And it seems
     to similarly detect and complain. We _could_ work around that with
     a chdir, but it would be quite nasty, as we'd have to do it before
     every curl call. So that's probably off the table.

And so we are stuck with either using a relative path, or a known-small
one.

> Move the socket to `$TMPDIR` (defaulting to `/tmp`) where the path
> is short, following the same approach used in t7528 for the SSH
> agent socket in b7fb2194b96 (t7528: work around ETOOMANY in OpenSSH
> 10.1 and newer, 2025-10-23).

OK, there we went with the known-small solution, since openssh made it
easy to do so. I think that is OK here, but...

>  # The %30 tests that the correct amount of percent-encoding is applied to the
>  # proxy string passed to curl.
> +# Use a short path for the socket to avoid exceeding the 108-character
> +# Unix domain socket limit when the trash directory path is long.
> +SOCKS_SOCK="${TMPDIR:-/tmp}/git-test-socks-%30.sock"

This is a static path in /tmp, so:

  1. Multiple instances of the test suite will stomp on each other
     (e.g., a --stress run).

  2. It creates a tmpdir-race vulnerability if an attacker links that
     path to something precious writeable by the user running the tests.

I think it would be sufficient to use mktemp to get a unique name. We
don't want a file, of course, so we perhaps need "mktemp -d" to get a
temp directory, and then we can use whatever short name we like inside
it.

>  test_lazy_prereq SOCKS_PROXY '
>  	test_have_prereq PERL &&
> -	start_socks "$TRASH_DIRECTORY/%30.sock"
> +	start_socks "$SOCKS_SOCK"
>  '
>  
>  test_atexit '
>  	test ! -e "$TRASH_DIRECTORY/socks.pid" ||
>  	kill "$(cat "$TRASH_DIRECTORY/socks.pid")"
> +	rm -f "$SOCKS_SOCK"
>  '

And the rest of your path can remain as-is, since SOCKS_SOCK will have
the unique name in it.

-Peff
