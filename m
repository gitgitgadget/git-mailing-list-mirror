Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACAED20248
	for <e@80x24.org>; Thu, 14 Mar 2019 00:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCNAp1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 20:45:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:50134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726412AbfCNAp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 20:45:27 -0400
Received: (qmail 31861 invoked by uid 109); 14 Mar 2019 00:45:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 00:45:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17930 invoked by uid 111); 14 Mar 2019 00:44:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 20:44:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 20:44:10 -0400
Date:   Wed, 13 Mar 2019 20:44:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] reflog expire: don't assert the OID when locking refs
Message-ID: <20190314004409.GJ31968@sigill.intra.peff.net>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
 <20190313235439.30439-6-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313235439.30439-6-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 12:54:39AM +0100, Ævar Arnfjörð Bjarmason wrote:

> The locking protocol for reflogs involves getting a *.lock file on the
> loose ref[1] (even if the actual ref is packed). This isn't needed to
> expire the reflog, and needlessly results promotes reference update
> contention to hard errors in e.g. "gc".

This first paragraph threw me off. It sounds like you are saying we
don't need to take a lock, but we absolutely do. It's just that we don't
need to care about the lock having some particular value. Which you do
go on to explain, but I think it would be more clear by simply removing
this first paragraph.

> If we instead lock the reference without considering what OID we last
> saw it at, we won't encounter user-visible contention to the extent
> that core.filesRefLockTimeout mitigates it. See 4ff0f01cb7 ("refs:
> retry acquiring reference locks for 100ms", 2017-08-21).

I think this part is true. I'd love to get a confirmation from Michael
Haggerty, who has spent way more time thinking about ref and reflog
locking than any mortal should have to. Hopefully he even still
remembers some of it. :)

-Peff
