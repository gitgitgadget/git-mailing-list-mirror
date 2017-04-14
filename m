Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668A020970
	for <e@80x24.org>; Fri, 14 Apr 2017 20:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbdDNUIg (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 16:08:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:33716 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752597AbdDNUIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 16:08:35 -0400
Received: (qmail 6452 invoked by uid 109); 14 Apr 2017 20:08:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Apr 2017 20:08:32 +0000
Received: (qmail 3920 invoked by uid 111); 14 Apr 2017 20:08:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Apr 2017 16:08:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Apr 2017 16:08:30 -0400
Date:   Fri, 14 Apr 2017 16:08:30 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test
 script
Message-ID: <20170414200829.ahqignx3pkhbuepg@sigill.intra.peff.net>
References: <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
 <CAM0VKjmuCjLBFAErXP06wu0+-7SdWVMaVu_g25Q4V-uQz8T1uA@mail.gmail.com>
 <20170412005011.46tr4mgsxk7chgfz@sigill.intra.peff.net>
 <CAM0VKjkuoCotm8FB5qdTQsC0SaJiwBA9dXmdLJdSs8NwLdY8fQ@mail.gmail.com>
 <20170413163701.33zjwrgnlfxjfwjo@sigill.intra.peff.net>
 <CAGZ79kY6TmEV38NkYJwkb5=Bu69tCjx6k+t6An5_52h8rEo5-Q@mail.gmail.com>
 <20170413175701.5ogpe7qbflbkgljm@sigill.intra.peff.net>
 <CAM0VKjmK0ib+sjf0sMPeiK7DrwHq1dJ58ZhDdp6HZsuQdb-eRw@mail.gmail.com>
 <20170413191236.3usecfgkjujhblo6@sigill.intra.peff.net>
 <CAM0VKjkVUPPsvpAu1WXeNg7sv1_V=Uxhhevf9fVkZvk9WERwwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkVUPPsvpAu1WXeNg7sv1_V=Uxhhevf9fVkZvk9WERwwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 09:35:08PM +0200, SZEDER Gábor wrote:

> >> diff --git a/t/test-lib.sh b/t/test-lib.sh
> >> index 13b569682..d7fa15a69 100644
> >> --- a/t/test-lib.sh
> >> +++ b/t/test-lib.sh
> >> @@ -763,7 +763,7 @@ test_done () {
> >>
> >>                 test -d "$remove_trash" &&
> 
> I'm not sure under what circumstances the trash dir could be missing at
> this point...

Yeah, I don't really see the point of that line. Our whole goal is to
remove it anyway.

> >>                 cd "$(dirname "$remove_trash")" &&
> >> -               rm -rf "$(basename "$remove_trash")"
> >> +               rm -rf "$(basename "$remove_trash")" || exit 1
> 
> ... but when it is already removed, then I think we should not exit
> with error here.
> Nothing that a pair of {} wouldn't handle.

I suppose so. It might be worth being picky just on the principle that
if it _is_ gone that's unexpected and we'd prefer somebody notice and
figure out why.

> > Replacing it the "exit 1" with a "die" that has a message is probably a
> > good idea, though.
> 
> If we can't 'cd' or 'rm -rf', then they will tell us why they failed
> anyway, most likely including the name of the trash directory.
> Do we really need more error messages than that?

I just meant something like "tests passed but test cleanup failed;
aborting" so that the user has a better idea what is going on. But since
it shouldn't happen, maybe that doesn't matter.

-Peff
