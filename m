Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE03220960
	for <e@80x24.org>; Thu, 13 Apr 2017 17:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbdDMR5J (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 13:57:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:33036 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753261AbdDMR5I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 13:57:08 -0400
Received: (qmail 25616 invoked by uid 109); 13 Apr 2017 17:57:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 17:57:05 +0000
Received: (qmail 25313 invoked by uid 111); 13 Apr 2017 17:57:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 13:57:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Apr 2017 13:57:01 -0400
Date:   Thu, 13 Apr 2017 13:57:01 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test
 script
Message-ID: <20170413175701.5ogpe7qbflbkgljm@sigill.intra.peff.net>
References: <CAM0VKj=4Utapk9iFasChkPSdkWxB5WiHtpZGPUYKMC5LKrnGXw@mail.gmail.com>
 <20170410163557.gn3mlcalfhhncbtt@sigill.intra.peff.net>
 <CAM0VKjkdqjbkqOF6ucymtuBAAgBVJQ6SGe4Ep2gqVBtNp=s_CA@mail.gmail.com>
 <20170410170154.qwzaolflrvsduwzd@sigill.intra.peff.net>
 <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
 <CAM0VKjmuCjLBFAErXP06wu0+-7SdWVMaVu_g25Q4V-uQz8T1uA@mail.gmail.com>
 <20170412005011.46tr4mgsxk7chgfz@sigill.intra.peff.net>
 <CAM0VKjkuoCotm8FB5qdTQsC0SaJiwBA9dXmdLJdSs8NwLdY8fQ@mail.gmail.com>
 <20170413163701.33zjwrgnlfxjfwjo@sigill.intra.peff.net>
 <CAGZ79kY6TmEV38NkYJwkb5=Bu69tCjx6k+t6An5_52h8rEo5-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY6TmEV38NkYJwkb5=Bu69tCjx6k+t6An5_52h8rEo5-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 10:55:08AM -0700, Stefan Beller wrote:

> On Thu, Apr 13, 2017 at 9:37 AM, Jeff King <peff@peff.net> wrote:
> > Ah, OK, that makes more sense. I can detect it reliably by just checking
> >
> >   ! test -d $root/trash*
> >
> > in my stress-test after the test successfully completes.
> 
> Would we want to report such an error from the test suite itself?
> (My line of thinking is that this is a similar issue to broken && chains,
> which we do report).

Yeah, I had a similar thought. I can't think of any reason why it would
trigger a false positive, as long as we account for test-failure and the
--debug flag properly. I don't think we can just drop the "-f" from the
final "rm", because it may be overriding funny permissions left by
tests.

-Peff
