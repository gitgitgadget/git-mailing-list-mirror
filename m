Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92BEF1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405843AbfIFREx (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:04:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:42220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726936AbfIFREx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:04:53 -0400
Received: (qmail 20607 invoked by uid 109); 6 Sep 2019 17:04:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 17:04:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5060 invoked by uid 111); 6 Sep 2019 17:06:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 13:06:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 13:04:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, stolee@gmail.com,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
Message-ID: <20190906170451.GB23181@sigill.intra.peff.net>
References: <cover.1567563244.git.me@ttaylorr.com>
 <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
 <20190904030456.GA28836@sigill.intra.peff.net>
 <xmqqsgpao06z.fsf@gitster-ct.c.googlers.com>
 <20190906063503.GB5122@sigill.intra.peff.net>
 <xmqqk1alnyxz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1alnyxz.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 09:59:04AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So far so good. But now imagine we call parse_commit_buffer() again, and
> > we re-parse. How does that interact with the half-parsed state? Some of
> > it works OK (e.g., lookup_tree() would find the same tree). Some not so
> > much (I think we'd keep appending parents at each call).
> >
> > I guess this might not be too bad to handle. Value fields like
> > timestamp_t are OK to overwrite. Pointers to objects likewise, since the
> > memory is owned elsewhere. If we see existing parent pointers in an
> > object we're parsing, we could probably free them under the assumption
> > they're leftover cruft. Likewise for the "tag" field of "struct tag",
> > which is owned by the struct and should be freed.
> 
> Yeah, or clear them before returning with .corrupt bit set?

This was my attempt to avoid dealing with a .corrupt bit. :)

-Peff
