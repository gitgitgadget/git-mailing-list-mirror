Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BB341F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeGTWRb (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:17:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:54596 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728132AbeGTWRb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:17:31 -0400
Received: (qmail 7526 invoked by uid 109); 20 Jul 2018 21:27:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 21:27:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32269 invoked by uid 111); 20 Jul 2018 21:27:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 20 Jul 2018 17:27:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2018 17:27:25 -0400
Date:   Fri, 20 Jul 2018 17:27:25 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: No rule to make target `git-daemon'
Message-ID: <20180720212725.GA3865@sigill.intra.peff.net>
References: <CAH8yC8=oruFBtkndQ0p9N4s23SMvjjrAC_E7zzKRSVbjEwL0FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8=oruFBtkndQ0p9N4s23SMvjjrAC_E7zzKRSVbjEwL0FQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 09:37:08PM -0400, Jeffrey Walton wrote:

> I'm working from the 2.18 tarball on Solaris 11.3 x86_64. I'm catching
> the following when building from sources. This appears to be a new
> issue. It was not present in 2.17.1.
> 
>     gmake: *** No rule to make target `git-daemon'.  Stop.
>     gmake: *** Waiting for unfinished jobs....
>     Failed to build Git

Like others, I don't really have an idea on how this could have
happened. But perhaps "gmake -d git-daemon" could be enlightening?

Mine has:

  [...]
  Considering target file 'git-daemon'.
   Looking for an implicit rule for 'git-daemon'.
   Trying pattern rule with stem 'daemon'.
   Trying implicit prerequisite 'daemon.o'.
   Trying rule prerequisite 'GIT-LDFLAGS'.
   Trying rule prerequisite 'common-main.o'.
   Trying rule prerequisite 'libgit.a'.
   Trying rule prerequisite 'xdiff/lib.a'.
   Found an implicit rule for 'git-daemon'.
    Considering target file 'daemon.o'.

and so on.

> There does not appear to be an option to control building the daemon:
> 
>     $ ./configure --help | grep -i daemon
>     $
> 
> Any ideas on how to side-step it?

There's no official knob to turn, but dropping this line would remove
it:

diff --git a/Makefile b/Makefile
index 08e5c54549..31153a2789 100644
--- a/Makefile
+++ b/Makefile
@@ -684,7 +684,6 @@ EXTRA_PROGRAMS =
 PROGRAMS += $(EXTRA_PROGRAMS)
 
 PROGRAM_OBJS += credential-store.o
-PROGRAM_OBJS += daemon.o
 PROGRAM_OBJS += fast-import.o
 PROGRAM_OBJS += http-backend.o
 PROGRAM_OBJS += imap-send.o

-Peff
