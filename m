Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2B61F404
	for <e@80x24.org>; Wed, 12 Sep 2018 05:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeILK7W (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 06:59:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:46724 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726149AbeILK7W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 06:59:22 -0400
Received: (qmail 9608 invoked by uid 109); 12 Sep 2018 05:56:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Sep 2018 05:56:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24466 invoked by uid 111); 12 Sep 2018 05:56:41 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Sep 2018 01:56:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Sep 2018 01:56:26 -0400
Date:   Wed, 12 Sep 2018 01:56:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Max Kirillov <max@max630.net>, git@vger.kernel.org,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>
Subject: Re: [PATCH] http-backend: treat empty CONTENT_LENGTH as zero
Message-ID: <20180912055626.GA13642@sigill.intra.peff.net>
References: <20180910052558.GB55941@aiede.svl.corp.google.com>
 <20180910205359.32332-1-max@max630.net>
 <20180911034227.GB20518@aiede.svl.corp.google.com>
 <20180911040343.GC20518@aiede.svl.corp.google.com>
 <xmqqk1nrq4su.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1nrq4su.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 11:15:13AM -0700, Junio C Hamano wrote:

> > That said, a quick search of codesearch.debian.net mostly finds
> > examples using straight comparison, so maybe the patch is fine as-is.
> 
> I do not think we would mind terribly if we do not support
> combinations like gzipped-and-then-chunked from day one.  An in-code
> NEEDSWORK comment that refers to the production in RFC 2616 Page 143
> may not hurt, though.

It's pretty common for Git to send gzip'd contents, so this might
actually be necessary on day one. However, it looks like we do so by
setting the content-encoding header.

I really wonder if this topic is worth pursuing further without finding
a real-world case that actually fails with the v2.19 code. I.e., is
there actually a server that doesn't set CONTENT_LENGTH and really can't
handle read-to-eof? It's plausible to me, but it's also equally
plausible that we'd be breaking some other case.

-Peff
