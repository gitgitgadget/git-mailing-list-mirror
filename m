Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241FD1F453
	for <e@80x24.org>; Thu,  4 Oct 2018 23:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeJEGNv (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 02:13:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:42090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725998AbeJEGNv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 02:13:51 -0400
Received: (qmail 7605 invoked by uid 109); 4 Oct 2018 23:18:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Oct 2018 23:18:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31942 invoked by uid 111); 4 Oct 2018 23:17:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Oct 2018 19:17:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Oct 2018 19:18:05 -0400
Date:   Thu, 4 Oct 2018 19:18:05 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     l.s.r@web.de, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/5] fetch-pack: load tip_oids eagerly iff needed
Message-ID: <20181004231805.GA17146@sigill.intra.peff.net>
References: <20181004221406.GB28287@sigill.intra.peff.net>
 <20181004225205.176593-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181004225205.176593-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 04, 2018 at 03:52:05PM -0700, Jonathan Tan wrote:

> > Or I am even OK with leaving the existing tablesize
> > check. It is a little intimate with the implementation details, but I
> > suspect that if oidset were to change (e.g., to initialize the buckets
> > immediately), the problem would be pretty apparent in the tests.
> 
> I am OK with this too, except that (as far as I can tell) the point of
> this patch set is to replace the internals of oidset, so we no longer
> have the tablesize check. Unless you meant the khash analog of
> tablesize? I would be OK if all tablesize references are replaced with
> the khash analog in the same patch that the oidset internals are
> replaced.

Yeah, in khash it's n_buckets, but it's basically the same thing. René's
original patch did that update, and we were musing on whether there was
a way to avoid crossing the module boundary so intimately. Hence the
patch you saw. :)

-Peff
