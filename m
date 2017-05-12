Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283392023D
	for <e@80x24.org>; Fri, 12 May 2017 08:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757392AbdELIpS (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 04:45:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:50199 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757112AbdELIpR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 04:45:17 -0400
Received: (qmail 1932 invoked by uid 109); 12 May 2017 08:45:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 08:45:15 +0000
Received: (qmail 22264 invoked by uid 111); 12 May 2017 08:45:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 04:45:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 04:45:14 -0400
Date:   Fri, 12 May 2017 04:45:14 -0400
From:   Jeff King <peff@peff.net>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     =?utf-8?B?0KDQsNC50YbQuNC9INCQ0L3RgtC+0L0=?= <anton@smarthead.ru>,
        git@vger.kernel.org
Subject: Re: Git credential helper store flushes randomly
Message-ID: <20170512084513.duj7sesylo7jdd3w@sigill.intra.peff.net>
References: <cdedf063-5f53-04c9-5ac0-2acf7e26696e@smarthead.ru>
 <20170512082058.ivvsmzc44cildp7l@sigill.intra.peff.net>
 <vpq1srucwj1.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vpq1srucwj1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 10:24:50AM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The only time it should remove an entry is when Git asks it to. And the
> > only time that happens is when Git sees the credential rejected by the
> > server (e.g., an HTTP 401 even after we fed the stored credential). I
> > don't know why that would happen unless there's some non-determinism on
> > the server.
> 
> I did see a case like this where the server was broken temporarily and
> rejected one login attempt. In this case the credential store deletes
> the entry for that user, and when the server is repaired, the store
> still has the entry deleted.

Right, that's inconvenient if your server is flaky, but is the expected
behavior. Git has to throw away the credential so it can stop trying it
and actually prompt you on the next try (and save the result then if it
works).

-Peff
