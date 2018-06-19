Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E921F403
	for <e@80x24.org>; Tue, 19 Jun 2018 20:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755486AbeFSUxO (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 16:53:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:48972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755453AbeFSUxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 16:53:12 -0400
Received: (qmail 8964 invoked by uid 109); 19 Jun 2018 20:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Jun 2018 20:53:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17887 invoked by uid 111); 19 Jun 2018 20:53:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Jun 2018 16:53:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2018 16:53:10 -0400
Date:   Tue, 19 Jun 2018 16:53:10 -0400
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>
Subject: Re: t5562: gzip -k is not portable
Message-ID: <20180619205310.GA30710@sigill.intra.peff.net>
References: <5ee7a65d-63e1-aa6a-c3c1-663c092d0efe@web.de>
 <xmqqk1quvegh.fsf@gitster-ct.c.googlers.com>
 <CAPig+cT2xkR=LbAJLCdeynGkiPysakbVna61cfrtgO3kKh85+g@mail.gmail.com>
 <117d2657-067a-6fe6-3713-de7a5aa75a11@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <117d2657-067a-6fe6-3713-de7a5aa75a11@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 10:40:16PM +0200, Torsten Bögershausen wrote:

> 
> 
> On 06/19/2018 08:22 PM, Eric Sunshine wrote:
> > On Tue, Jun 19, 2018 at 2:06 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > Torsten Bögershausen <tboegi@web.de> writes:
> > > > t5562 fails here under MacOS:
> > > > "gzip -k"  is not portable.
> > Very odd. Stock /usr/bin/gzip on my MacOS 10.12.6 _does_ recognize -k,
> > and the test does pass.
> 
> This is the test box running Mac OS X 10.6 speaking.
> The -c seems to need even -f.
> But this doesn't work either:
> 
> gzip 1.3.12
> Copyright (C) 2007 Free Software Foundation, Inc.
> Copyright (C) 1993 Jean-loup Gailly.
> This is free software.  You may redistribute copies of it under the terms of
> the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
> There is NO WARRANTY, to the extent permitted by law.

Ah, that's it. "-k" came about in gzip v1.6. That's 5 years old, but
obviously some people are still running it.

"-c" goes back quite a while and should be safe, I think.

> expecting success:
>     gzip -f -c fetch_body >fetch_body.gz &&
>     test_copy_bytes 10 <fetch_body.gz >fetch_body.gz.trunc &&
>     gzip -f -c push_body >push_body,gz &&
>     test_copy_bytes 10 <push_body.gz >push_body.gz.trunc
> 
> ./test-lib.sh: line 632: push_body.gz: No such file or directory

Typo in the ">" redirect (comma instead of period)?

-Peff
