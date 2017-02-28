Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,WEIRD_PORT
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154FE201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 21:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbdB1U7o (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:59:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:36003 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbdB1U7D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:59:03 -0500
Received: (qmail 18785 invoked by uid 109); 28 Feb 2017 19:58:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 19:58:03 +0000
Received: (qmail 29530 invoked by uid 111); 28 Feb 2017 19:58:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 14:58:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 14:58:00 -0500
Date:   Tue, 28 Feb 2017 14:58:00 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http: attempt updating base URL only if no error
Message-ID: <20170228195800.tghcnbtjg3qjrhrv@sigill.intra.peff.net>
References: <20170228025311.6347-1-jonathantanmy@google.com>
 <20170228132814.wp3cq4ilp7syinqy@sigill.intra.peff.net>
 <6127c0a7-800d-fcf3-c6e2-17533347f07e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6127c0a7-800d-fcf3-c6e2-17533347f07e@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 10:48:52AM -0800, Jonathan Tan wrote:

> > Running your included test, we get:
> > 
> >   fatal: unable to access 'http://127.0.0.1:5550/redir-to/502/': The
> >   requested URL returned error: 502
> > 
> > but the error really happened in the intermediate step. I wonder if we
> > should show the effective_url in that case, as it's more likely to
> > pinpoint the problem. OTOH, we do not mention the intermediate redirect
> > at all, so they might be confused about where that URL came from. If you
> > really want to debug HTTP confusion, you should use GIT_TRACE_CURL.
> 
> Yeah, if we mention the effective_url, I think that there would need to be a
> lot more explaining to be done (e.g. why does my URL have
> "info/refs?service=git-upload-pack" tacked on at the end). It might be
> better to just recommend GIT_TRACE_CURL.

Indeed. Your comment made me realize that my suggestion was the exact
opposite of the earlier d5ccbe4df (remote-curl: consistently report repo
url for http errors, 2013-04-05). :)

Given that we don't see a lot of questions on the list about this,
either it doesn't come up much, or they are capable of finding
GIT_TRACE_CURL or GIT_CURL_VERBOSE on their own. So I think we can leave
the message as-is.

-Peff
