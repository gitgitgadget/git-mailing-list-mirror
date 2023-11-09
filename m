Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305531A61
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EFE2139
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:03:10 -0800 (PST)
Received: (qmail 31251 invoked by uid 109); 9 Nov 2023 18:03:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 18:03:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7881 invoked by uid 111); 9 Nov 2023 18:03:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 13:03:10 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 13:03:08 -0500
From: Jeff King <peff@peff.net>
To: Alejandro Colomar <alx@kernel.org>
Cc: git@vger.kernel.org
Subject: Re: git-send-email: Send with mutt(1)
Message-ID: <20231109180308.GA2711684@coredump.intra.peff.net>
References: <ZUocFhmPHstwKCkZ@devuan>
 <20231107174803.GA507007@coredump.intra.peff.net>
 <ZUqDwnmu9d1dD1tb@devuan>
 <20231107201655.GA507701@coredump.intra.peff.net>
 <ZUv3gjjmuqvCaJEd@debian>
 <20231108212702.GA1586965@coredump.intra.peff.net>
 <ZUz6H3IqRc1YGPZM@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUz6H3IqRc1YGPZM@debian>

On Thu, Nov 09, 2023 at 04:26:23PM +0100, Alejandro Colomar wrote:

> I've tried something even simpler:
> 
> ---8<---
> #!/bin/sh
> 
> mutt -H -;
> --->8---
> 
> I used it for sending a couple of patches to linux-man@, and it seems to
> work.  I don't have much experience with mutt, so maybe I'm missing some
> corner cases.  Do you expect it to not work for some case?  Otherwise,
> we might have a winner.  :)

Wow, I don't know how I missed that when I read the manual. That was
exactly the feature I was thinking that mutt would need. ;)

So yeah, that is obviously better than the "postponed" hackery I showed.
I notice that "-H" even causes mutt to ignore "-i" (a sendmail flag that
Git adds to sendemail.sendmailcmd). So you can just invoke it directly
from your config like:

  git config sendemail.sendmailcmd "mutt -H -"

Annoyingly, "-E" doesn't work when reading over stdin (I guess mutt
isn't willing to re-open the tty itself). But if you're happy with not
editing as they go through, then "-H" is then that's enough (in my
workflow, I do the final proofread via mutt).

-Peff
