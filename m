Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355B220248
	for <e@80x24.org>; Mon, 18 Mar 2019 21:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfCRVW3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 17:22:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:55498 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726832AbfCRVW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 17:22:29 -0400
Received: (qmail 10478 invoked by uid 109); 18 Mar 2019 21:22:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Mar 2019 21:22:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23814 invoked by uid 111); 18 Mar 2019 21:22:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 17:22:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 17:22:27 -0400
Date:   Mon, 18 Mar 2019 17:22:27 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 4/4] gc docs: downplay the usefulness of --aggressive
Message-ID: <20190318212227.GD29661@sigill.intra.peff.net>
References: <20190318161502.7979-1-avarab@gmail.com>
 <20190318161502.7979-5-avarab@gmail.com>
 <20190318202824.GA24222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190318202824.GA24222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 01:28:24PM -0700, Jonathan Nieder wrote:

> > +Using this option may optimize for disk space at the expense of
> > +runtime performance. See the `--depth` and `--window` documentation in
> > +linkgit:git-repack[1]. It is not recommended that this option be used
> > +to improve performance for a given repository without running tailored
> > +performance benchmarks on it. It may make things better, or worse. Not
> > +using this at all is the right trade-off for most users and their
> > +repositories.
> 
> This part kind of feels like giving up.  Can we make --aggressive have
> good runtime read performance so we don't have to hedge this way?
> E.g. is this patch papering over a poor choice of --depth setting in
> --aggressive?

I thought we already did that, in 07e7dbf0db (gc: default aggressive
depth to 50, 2016-08-11). As far as I know, "--aggressive" produces
packs with similar runtime performance.

It is possible, if it finds more deltas due to the larger window, that
we'd spend more time accessing those deltas. But if the chains aren't
long, the base cache tends to perform well, and delta reconstruction is
about the same cost as zlib inflating. And we have a smaller disk cache
footprint.

-Peff
