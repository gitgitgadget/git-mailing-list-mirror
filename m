Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECF41A00D2
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 06:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731394197; cv=none; b=HzBiDICEUPaKcTTS8BMqQL1d9qbSl4+dmMF6y9sytiB4+urgRadKCYf25FdIaEVK3kxDDS6OzuESqQbBezJ1vwdI1P6V/EjjbW8iHI5RXE0pMxNsTBYpSlFbOG6QTuuikbhBU5vZJGMLAmukl8Cj2HyxWu/pqDSKXFKAtDYLlgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731394197; c=relaxed/simple;
	bh=7ujN/Oz/TLD7HXZ4KL/zE3jFIP8Y1iwohw6AlqJ4p6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVZJO9VKLvIzHywCz8euvr1mMCv8NT/QRYJvjuYPFkYN5WPZDWB06+DgVEAkW8SUa4GIpNjEzV2Tk1nGShXnuzeZE15ilziNhfr/G1Tasjq1WWCyRg8EyztsZHYGZYUBn/CpP7plrTcRvc5o593PGvY17beBf7rhBYc1Ws02/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VL4UJse+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VL4UJse+"
Received: (qmail 28661 invoked by uid 109); 12 Nov 2024 06:49:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7ujN/Oz/TLD7HXZ4KL/zE3jFIP8Y1iwohw6AlqJ4p6c=; b=VL4UJse+v+YYLYRRrRHs4hL3Nc8TOgnYnB9YmjF+alRkQ0SZdkAi1Eys7gxQtKsq2bxVWUTdp4I21pdc/oFE88PukN48iIsR6j4jUN2dcrk84X0Xsf5yWf8ldINoxt3/dvRrTtL4YMzW9FGX2w5JTI0Pkw2Gwm/LTPMKkKoTNKoVC13WXAef/ZDUf7MWDlmOXU2fE1RKwmICzZ8MkUoK+3tAKyVxnOFTTnsGdSkv9DywtEcNCuh2fmp+s4YTs1aJiMjFzK3oBs6iDQZRmbEXPtuqUIN8RMZmQtRVkzVOja3uTcMIZY3+7d87zhARYyZIPS+Jj8YAkdNdb5Hy0U2gIg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Nov 2024 06:49:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26673 invoked by uid 111); 12 Nov 2024 06:49:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2024 01:49:56 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Nov 2024 01:49:51 -0500
From: Jeff King <peff@peff.net>
To: Eric Mills <ermills@epic.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG REPORT] git fetch --prefetch with incorrect options hangs
 with 2.47.0
Message-ID: <20241112064951.GA619985@coredump.intra.peff.net>
References: <SA1PR17MB6501281EF202EA694CF9DC03CA582@SA1PR17MB6501.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR17MB6501281EF202EA694CF9DC03CA582@SA1PR17MB6501.namprd17.prod.outlook.com>

On Mon, Nov 11, 2024 at 10:15:44PM +0000, Eric Mills wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> I ran `git fetch --prefetch origin main` with git 2.47 on both my
> Windows machine (2.47.windows.2) and my Mac (2.47.0) and it hangs.
> 
> When I downgrade, same command succeeds on
> 2.46.2.Windows.1 / 2.46.2 (macOS).
> [...]
> On Windows, I don't get an error. It hangs indefinitely.
> On macOS, after a few seconds I got the following:
> 
> git(84051,0x20171cf40) malloc: *** error for object 0x600001978390:
> pointer being freed was not allocated
> 
> git(84051,0x20171cf40) malloc: *** set a breakpoint in
> malloc_error_break to debug

Thanks for the report. I see similar heap corruption problems on Linux.
Building with ASan shows a double-free:

  ==646934==ERROR: AddressSanitizer: attempting double-free on 0x502000002450 in thread T0:
      #0 0x7f9ab1cf3918 in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:52
      #1 0x557a1d8082c2 in refspec_clear /home/peff/compile/git/refspec.c:228
      #2 0x557a1ce92a08 in fetch_one builtin/fetch.c:2136
      #3 0x557a1ce9889d in cmd_fetch builtin/fetch.c:2443
      #4 0x557a1cd2e1ca in run_builtin /home/peff/compile/git/git.c:483
      #5 0x557a1cd2f2d8 in handle_builtin /home/peff/compile/git/git.c:749
      #6 0x557a1cd2fb3a in run_argv /home/peff/compile/git/git.c:819
      #7 0x557a1cd30e66 in cmd_main /home/peff/compile/git/git.c:954
      #8 0x557a1d1370c1 in main /home/peff/compile/git/common-main.c:64
      #9 0x7f9ab1233d67 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
      #10 0x7f9ab1233e24 in __libc_start_main_impl ../csu/libc-start.c:360
      #11 0x557a1cd27290 in _start (/home/peff/compile/git/git+0x129d290) (BuildId: cca88fc4d05f503e4aecc54e9437a56865d5eca1)

Bisecting on:

  make SANITIZE=address &&
  bin-wrappers/git fetch --prefetch origin master

turns up my ea4780307c (fetch: free "raw" string when shrinking refspec,
2024-09-24). I'll see if I can figure out what's going on.

-Peff
