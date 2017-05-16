Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61FFC201A7
	for <e@80x24.org>; Tue, 16 May 2017 02:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdEPCvY (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 22:51:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:52345 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750784AbdEPCvX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 22:51:23 -0400
Received: (qmail 23784 invoked by uid 109); 16 May 2017 02:51:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 02:51:23 +0000
Received: (qmail 23858 invoked by uid 111); 16 May 2017 02:51:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 22:51:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 22:51:20 -0400
Date:   Mon, 15 May 2017 22:51:20 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        pclouds@gmail.com, johannes.schindelin@gmx.de,
        David.Turner@twosigma.com
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
Message-ID: <20170516025120.xn5dimkuryl33wfk@sigill.intra.peff.net>
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
 <20170516002214.tlqkk4zrwdzcdjha@genre.crustytoothpaste.net>
 <20170516003414.yliltu5fsaudfhyu@sigill.intra.peff.net>
 <2d965a87-36da-23b4-4bc5-97de47f3d7f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d965a87-36da-23b4-4bc5-97de47f3d7f7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 09:55:12PM -0400, Ben Peart wrote:

> > > > +	istate->last_update = (time_t)ntohll(*(uint64_t *)index);
> [...]
> > (I note also that time_t is not necessarily 64-bits in the first place,
> > but David said something about this not really being a time_t).
> 
> The in memory representation is a time_t as that is the return value of
> time(NULL) but it is converted to/from a 64 bit value when written/read to
> the index extension so that the index format is the same no matter the
> native size of time_t.

OK. I guess your cast here will truncate on 32-bit systems, but
presumably not until 2038, so we can perhaps ignore it for now (and
anyway, time(NULL) will be broken on such a system at that point).

-Peff
