Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24853203C1
	for <e@80x24.org>; Thu, 17 Nov 2016 22:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbcKQWVr (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 17:21:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:44517 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbcKQWVq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 17:21:46 -0500
Received: (qmail 13689 invoked by uid 109); 17 Nov 2016 22:21:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Nov 2016 22:21:46 +0000
Received: (qmail 29205 invoked by uid 111); 17 Nov 2016 22:22:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Nov 2016 17:22:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Nov 2016 14:21:42 -0800
Date:   Thu, 17 Nov 2016 14:21:42 -0800
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mike Rappazzo <rappazzo@gmail.com>,
        "Vanderhoof, Tzadik" <tzadik.vanderhoof@optum360.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: merge --no-ff is NOT mentioned in help
Message-ID: <20161117222142.mca6lmhj5mvl4gbp@sigill.intra.peff.net>
References: <2C8817BDA27E034F8E9A669458E375EF2BE63B@APSWP0428.ms.ds.uhc.com>
 <CANoM8SX91JAvJ6EAE6=wavPutUG4ZU1BY-A=5EobW=8zrdEcjw@mail.gmail.com>
 <2C8817BDA27E034F8E9A669458E375EF2BE689@APSWP0428.ms.ds.uhc.com>
 <CANoM8SVXeeZsc40xgVqZep_9oT=J2h4mOO0Ksn+kb0g8Ct=KrQ@mail.gmail.com>
 <xmqqr36anibl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr36anibl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2016 at 09:10:22AM -0800, Junio C Hamano wrote:

> People interested may want to try the attached single-liner patch to
> see how the output from _ALL_ commands that use parse-options API
> looks when given "-h".  It could be that the result may not be too
> bad.

The output is less ugly than I expected, but still a bit cluttered IMHO.
I was surprised that the column-adjustment did not need tweaked, but the
code correctly increments "pos" from the return value of fprintf, which
just works.

Looking at the output for --ff, though:

   --[no-]ff             allow fast-forward (default)

I do not think it's improving the situation nearly as much as if we made
the primary option "--no-ff" with a NONEG flga, and then added back in a
HIDDEN "--ff". I thought we had done that in other cases, but I can't
seem to find any. But it would make "--no-ff" the primary form, which
makes sense, as "--ff" is already the default.

Another option would be to teach parse-options to somehow treat the
negated form as primary in the help text. That's a bit more code, but
might be usable in other places.

-Peff
