Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 560591F453
	for <e@80x24.org>; Wed,  1 May 2019 18:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfEASXZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:23:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:46056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726004AbfEASXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:23:25 -0400
Received: (qmail 23390 invoked by uid 109); 1 May 2019 18:23:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 18:23:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20917 invoked by uid 111); 1 May 2019 18:24:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 14:24:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 14:23:23 -0400
Date:   Wed, 1 May 2019 14:23:23 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     David Carson <DCarson@extremenetworks.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: add 'ls-remote' option to limit output records
Message-ID: <20190501182323.GD4109@sigill.intra.peff.net>
References: <560CCADB-511B-495E-B86B-F294486C088C@contoso.com>
 <CAGyf7-G+FEDVe=WiVVNJr1ALn-ryA4862qbjdDCNXM+LhpjORQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-G+FEDVe=WiVVNJr1ALn-ryA4862qbjdDCNXM+LhpjORQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 26, 2019 at 12:32:51PM -0700, Bryan Turner wrote:

> >         $ git ls-remote -n1 --tags --sort=v:refname origin "v*"
> [...]
> With the v2 wire protocol, the client could provide a prefix (like
> `refs/tags/`, or potentially `refs/tags/v`) to reduce what the server
> included in the ref advertisement, but even the v2 protocol doesn't
> have anything for telling the server "Version parse these names and
> then return the first N". That means the parsing, sorting and trimming
> for the advertised tags would still all have to happen locally. (I'm
> sure someone can correct me if I've misstated what protocol v2 can do
> for filtering, but I don't see any "ls-refs" options that look like
> they enable anything other than prefix matching.)

No, that sounds right. The "--tags" in the original command should cause
v2 to ask only for refs/tags/. But because of the way ls-remote matching
works, "v*" is not a pure prefix match, and would find
"refs/tags/foo/v1.2.3". So we can't use protocol-level matching to ask
for "refs/tags/v*".

There are no provisions in the protocol for sorting, nor for limiting
the output.

I didn't check, but I suspect some hosting-platform APIs might be able
to answer this with a single query.

-Peff
