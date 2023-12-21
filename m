Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90C4D580
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22341 invoked by uid 109); 21 Dec 2023 09:59:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Dec 2023 09:59:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22871 invoked by uid 111); 21 Dec 2023 09:59:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Dec 2023 04:59:08 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Dec 2023 04:59:07 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org,
	AtariDreams via GitGitGadget <gitgitgadget@gmail.com>,
	Seija Kijin <doremylover123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] git-compat-util: convert skip_{prefix,suffix}{,_mem} to
 bool
Message-ID: <20231221095907.GC570888@coredump.intra.peff.net>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
 <20231213080143.GA1684525@coredump.intra.peff.net>
 <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
 <20231214220503.GA3320432@coredump.intra.peff.net>
 <99b3a727-36fd-4fa5-a6be-60ae6fc5911e@gmail.com>
 <2d30dc36-6091-4b47-846f-92d3f4a8b135@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d30dc36-6091-4b47-846f-92d3f4a8b135@web.de>

On Sat, Dec 16, 2023 at 11:47:21AM +0100, René Scharfe wrote:

> Use the data type bool and its values true and false to document the
> binary return value of skip_prefix() and friends more explicitly.
> 
> This first use of stdbool.h, introduced with C99, is meant to check
> whether there are platforms that claim support for C99, as tested by
> 7bc341e21b (git-compat-util: add a test balloon for C99 support,
> 2021-12-01), but still lack that header for some reason.
> 
> A fallback based on a wider type, e.g. int, would have to deal with
> comparisons somehow to emulate that any non-zero value is true:
> 
>    bool b1 = 1;
>    bool b2 = 2;
>    if (b1 == b2) puts("This is true.");
> 
>    int i1 = 1;
>    int i2 = 2;
>    if (i1 == i2) puts("Not printed.");
>    #define BOOLEQ(a, b) (!(a) == !(b))
>    if (BOOLEQ(i1, i2)) puts("This is true.");
> 
> So we'd be better off using bool everywhere without a fallback, if
> possible.  That's why this patch doesn't include any.

Thanks for putting this together. I agree this is the right spot to end
up for now (and that if for whatever reason we find that some platforms
can't handle it, we probably should revert and not try the naive
fallback).

-Peff
