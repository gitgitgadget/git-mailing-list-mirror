Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FFBB1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 22:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeKGHin (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 02:38:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:42906 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726462AbeKGHin (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 02:38:43 -0500
Received: (qmail 17887 invoked by uid 109); 6 Nov 2018 22:11:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 22:11:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5216 invoked by uid 111); 6 Nov 2018 22:10:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 17:10:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 17:11:18 -0500
Date:   Tue, 6 Nov 2018 17:11:18 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        andals@crustytoothpaste.net, Junio C Hamano <gitster@pobox.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH/RFC] Support --append-trailer in cherry-pick and revert
Message-ID: <20181106221118.GA9975@sigill.intra.peff.net>
References: <20181104181026.8451-1-pclouds@gmail.com>
 <20181106171637.15562-1-pclouds@gmail.com>
 <871s7y6qs9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s7y6qs9.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 06, 2018 at 06:48:22PM +0100, Ævar Arnfjörð Bjarmason wrote:

> The implementation looks fine to me, but as noted in
> https://public-inbox.org/git/8736se6qyc.fsf@evledraar.gmail.com/ I
> wonder what the plausible end-game is. That we'll turn this on by
> default in a few years, and then you can only worry about
> git-interpret-trailers for repos created as of 2020 or something?
> 
> Otherwise it seems we'll need to *also* parse out the existing messages
> we've added.

Could we help the reading scripts by normalizing old and new output via
interpret-trailers, %(trailers), etc?

I think "(cherry picked from ...)" is already considered a trailer by
the trailer code. If the caller instructs us to, we could probably
rewrite it to:

  Cherry-picked-from: ...

in the output. Then the end-game is that scripts should just use
interpret-trailers, etc, and old and new commits will Just Work.

-Peff
