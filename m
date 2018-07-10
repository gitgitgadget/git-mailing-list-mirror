Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECF31F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbeGJSUI (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:20:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:54208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732368AbeGJSUI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:20:08 -0400
Received: (qmail 27135 invoked by uid 109); 10 Jul 2018 17:19:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 17:19:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28871 invoked by uid 111); 10 Jul 2018 17:20:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 13:20:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 13:19:57 -0400
Date:   Tue, 10 Jul 2018 13:19:57 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] Add merge recursive testcases with undetected
 conflicts
Message-ID: <20180710171957.GJ23624@sigill.intra.peff.net>
References: <xmqqr2kce1mw.fsf@gitster-ct.c.googlers.com>
 <20180709202229.10222-1-newren@gmail.com>
 <20180710044456.GA1870@sigill.intra.peff.net>
 <CABPp-BG5Rn=3MBS+daSJ+2rLsZWcswP3=8zX-F=5ncdzc9y=SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BG5Rn=3MBS+daSJ+2rLsZWcswP3=8zX-F=5ncdzc9y=SQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 08:42:04AM -0700, Elijah Newren wrote:

> > test-lint is supposed to be run automatically as part of "make test" (or
> > "make prove"), unless you've specifically disabled it by setting
> > TEST_LINT. And it does complain for me with your patches. If it doesn't
> > for you, then we have a bug to fix. :)
> 
> Oh, this may be my bad.  Years ago someone pointed out that the
> testsuite could be run under 'prove', which provided nicer output and
> made sure to run the longest tests (e.g. the horrifically slow
> t9001-send-email.sh) first.  So my test alias is:
> 
>    time prove -j7 --timer --state failed,slow,save t[0-9]*.sh ::
> "--root=/dev/shm"

Heh, OK, that makes sense.

> (with possibly different -j settings on different machines) and I just
> stopped running make test.  Didn't learn about the 'make prove'
> target, even though it's apparently now been there for nearly 8 years.

I have:

  GIT_TEST_OPTS = --root=/var/ram/git-tests
  GIT_PROVE_OPTS = -j16 --state=slow,save
  DEFAULT_TEST_TARGET = prove

in my config.mak. That lets me just do:

  make test

from the top-level to get a build-and-test. It also allows just "make"
from the "t" directory to do the right thing.  Slightly annoyingly,
"make test" in the "t" directory does the wrong thing, which bites me
about once a month. ;)

-Peff
