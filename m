Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D101F404
	for <e@80x24.org>; Mon,  5 Mar 2018 20:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeCEUiJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 15:38:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:47870 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932215AbeCEUiH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 15:38:07 -0500
Received: (qmail 18430 invoked by uid 109); 5 Mar 2018 20:38:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Mar 2018 20:38:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29817 invoked by uid 111); 5 Mar 2018 20:38:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Mar 2018 15:38:57 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Mar 2018 21:38:02 +0100
Date:   Mon, 5 Mar 2018 21:38:02 +0100
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com, gitster@pobox.com, pclouds@gmail.com,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180305203802.GB5953@sigill.intra.peff.net>
References: <20180207011312.189834-1-bmwill@google.com>
 <20180228232252.102167-1-bmwill@google.com>
 <20180228232252.102167-14-bmwill@google.com>
 <20180303044338.GD27689@sigill.intra.peff.net>
 <20180305182155.GB72475@google.com>
 <20180305182914.GD28067@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180305182914.GD28067@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 05, 2018 at 10:29:14AM -0800, Jonathan Nieder wrote:

> >> It also accepts "refs/h*" to get "refs/heads" and "refs/hello".  I think
> >> it's worth going for the most-restrictive thing to start with, since
> >> that enables a lot more server operations without worrying about
> >> breaking compatibility.
> >
> > And just to clarify what do you see as being the most-restrictive case
> > of patterns that would should use?
> 
> Peff, can you say a little more about the downsides of accepting
> refs/h*?
> 
> IIRC the "git push" command already accepts such refspecs, so there's a
> benefit to accepting them.  Reftable and packed-refs support such
> queries about as efficiently as refs/heads/*.  For loose refs, readdir
> doesn't provide a way to restrict which files you look at, but loose
> refs are always slow anyway. :)
> 
> In other words, I see real benefits and I don't see much in the way of
> costs, so I'm not seeing why not to support this.

"git for-each-ref" only handles "/" boundaries. I think we used to have
similar problems with the internal for_each_ref(), but I just checked
and I think it's more flexible these days.  One could imagine a more
trie-like storage, though I agree that is stretching it with a
hypothetical.

Mostly my point was that I don't see any big upside, and the choice
seemed rather arbitrary. And as it is generally easier to loosen the
patterns later than tighten them, it makes sense to go with the tightest
option at first unless there is a compelling reason not to.

-Peff
