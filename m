Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D15202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 06:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbdJUGTY (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 02:19:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:59730 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751104AbdJUGTX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 02:19:23 -0400
Received: (qmail 9829 invoked by uid 109); 21 Oct 2017 06:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 06:19:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22618 invoked by uid 111); 21 Oct 2017 06:19:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 02:19:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Oct 2017 02:19:21 -0400
Date:   Sat, 21 Oct 2017 02:19:21 -0400
From:   Jeff King <peff@peff.net>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: Re: [PATCH v4] commit: check result of resolve_ref_unsafe
Message-ID: <20171021061921.xtocfdfik6ehhwzw@sigill.intra.peff.net>
References: <CGME20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3@epcas2p4.samsung.com>
 <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
 <5fa1f5c6-249e-2aa9-5e9f-c00ebe2c0d9d@samsung.com>
 <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
 <c5f72436-df4e-5c51-d58b-8699dfcfd70c@samsung.com>
 <a9cce39c-e432-d5a7-d9ad-6b67d9e04d23@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9cce39c-e432-d5a7-d9ad-6b67d9e04d23@samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 04:09:30PM +0300, Andrey Okoshkin wrote:

> Add check of the resolved HEAD reference while printing of a commit summary.
> resolve_ref_unsafe() may return NULL pointer if underlying calls of lstat() or
> open() fail in files_read_raw_ref().
> Such situation can be caused by race: file becomes inaccessible to this moment.
> 
> Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
> ---
> Hello,
> I think this way is better for user experience:
> * git doesn't crash;
> * warning is shown;
> * commit has been successfully created then it's safe to show a summary message
> with already known information and without resolved HEAD.

I'm on the fence between this and the die_errno() version. Given that
this would basically never happen in practice, I don't think it matters
too much. And that makes me want to just err on the side of simplicity.
But it's not like this is all that complex, either.

-Peff
