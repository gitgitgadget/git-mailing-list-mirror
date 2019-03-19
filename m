Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77C1F20248
	for <e@80x24.org>; Tue, 19 Mar 2019 02:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfCSC7s (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 22:59:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:55930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726915AbfCSC7s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 22:59:48 -0400
Received: (qmail 28314 invoked by uid 109); 19 Mar 2019 02:59:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Mar 2019 02:59:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26101 invoked by uid 111); 19 Mar 2019 03:00:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 23:00:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 22:59:46 -0400
Date:   Mon, 18 Mar 2019 22:59:46 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190319025945.GB6173@sigill.intra.peff.net>
References: <20190317144747.2418514-1-martin.agren@gmail.com>
 <20190319024645.GA6173@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190319024645.GA6173@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 10:46:46PM -0400, Jeff King wrote:

> > Let's instead try to stay as close as possible to what asciidoc.conf
> > does. We'll make it fairly obvious that we aim to inject the exact same
> > three lines of `<refmiscinfo/>` that asciidoc.conf provides. The only
> > somewhat tricky part is that we inject them *post*-processing so we need
> > to do the variable expansion ourselves.
> 
> One thing that asciidoctor buys us that asciidoc does not is that we
> might eventually move to directly generating the manpages, without the
> XML / Docbook step in between. And if we do, then all of this XML
> hackery is going to have to get replaced with something else. I guess we
> can cross that bridge when we come to it.

I see there was some discussion of that in the side-thread, too. Just to
give my two cents: I think that's where we want to go eventually, but I
also think that while we are maintaining a dual asciidoc/asciidoctor
tool chain, it's probably crazy not to go through docbook, just because
it keeps so much of the pipeline the same for both tools.

So in my mind, the endgame is that we eventually drop asciidoc in favor
of asciidoctor. The repo at:

  https://github.com/asciidoc/asciidoc

says:

  NOTE: This implementation is written in Python 2, which EOLs in Jan
  2020. AsciiDoc development is being continued under @asciidoctor.

I'm not sure when is the right time to switch. If we can get the output
at parity, I don't think asciidoctor is too onerous to install (and we
don't have to worry about ancient platforms, as they can use
pre-formatted manpages).

-Peff
