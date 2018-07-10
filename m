Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B510C1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbeGJSRL (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:17:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:54178 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732205AbeGJSRK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:17:10 -0400
Received: (qmail 28288 invoked by uid 109); 10 Jul 2018 17:50:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 17:50:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29052 invoked by uid 111); 10 Jul 2018 17:50:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 13:50:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 13:50:20 -0400
Date:   Tue, 10 Jul 2018 13:50:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Henning Schild <henning.schild@siemens.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 8/9] gpg-interface: introduce new signature format
 "x509" using gpgsm
Message-ID: <20180710175020.GA25861@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <4a2cf83a63d25776cb1996490240ce3e5df8ada4.1531208187.git.henning.schild@siemens.com>
 <20180710170109.GG23624@sigill.intra.peff.net>
 <xmqqbmbf7zw9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmbf7zw9.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 10:40:22AM -0700, Junio C Hamano wrote:

> > Extremely minor nit, but if there are no other uses of PGP_SIGNATURE etc
> > outside of this array (as I hope there wouldn't be after this series),
> > would it make more sense to just include the literals inline in the
> > array definition? That's one less layer of indirection when somebody is
> > reading the code.
> 
> It is good design-sense to shoot for fewer levels of indirection,
> but I suspect that "'const char **' instead of maximally-sized fixed
> array of strings" would require a named array and constants like
> this:

Yes, I agree with that direction (because it drops the magic numbers and
lets us use existing argv_array helpers).

> [...]
> so we may end up having the same number of levels of indirection
> anyway in the long-term final form.

True, but at least this level of indirection is buying us something. :)

> As readers may be able to read from the above, I also have a
> suspicion that it is a mistake to pretend that "--verify" etc.,
> which merely happen to be common across the variants the series
> covers, will stay forever to be common across _all_ variants and
> that is why the field no longer is called "extra" args but is meant
> to contain the full args.

I'd be fine going in that direction, too. But I don't actually foresee
adding new variants in the future. The point of this series versus the
signingtool one is that it's limited to gpg and gpg-alikes. And I doubt
we're likely to see more than the two that exist.

So even if we do end up adding support for more tools in the long run, I
think it will outgrow this config scheme.

-Peff
