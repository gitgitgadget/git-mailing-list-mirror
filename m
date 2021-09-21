Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE424C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 19:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC3B61264
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 19:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhIUTQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 15:16:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:51990 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhIUTQW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 15:16:22 -0400
Received: (qmail 6428 invoked by uid 109); 21 Sep 2021 19:14:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 19:14:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3623 invoked by uid 111); 21 Sep 2021 19:14:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 15:14:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 15:14:52 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
Message-ID: <YUovLNjkFilkcTAU@coredump.intra.peff.net>
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
 <CAPig+cS6DZ5DtSpvdrjjQVs5f=pCKkNwaGxU558Qvt50mi9z-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cS6DZ5DtSpvdrjjQVs5f=pCKkNwaGxU558Qvt50mi9z-A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 03:06:20PM -0400, Eric Sunshine wrote:

> On Tue, Sep 21, 2021 at 2:41 PM Jeff King <peff@peff.net> wrote:
> > When HTTP/2 is in use, we fail to correctly redact "Authorization" (and
> > other) headers in our GIT_TRACE_CURL output.
> >
> > We get the headers in our CURLOPT_DEBUGFUNCTION callback, curl_trace().
> > It passes them along to curl_dump_header(), which in turn checks
> > redact_sensitive_header(). We see the headers as a text buffer like:
> >
> >   Host: ...
> >   Authorization: Basic ...
> >
> > After breaking it into lines, we match each header using skip_prefix().
> > This is case-insensitive, even though HTTP headers are case-insensitive.
> > This has worked reliably in the past because these headers are generated
> > by curl itself, which is predictable in what it sends.
> 
> Did you mean "This is case-sensitive..."?

Whoops, yes. It probably makes a lot more sense with that fix. :)

-Peff
