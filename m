Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FCC520984
	for <e@80x24.org>; Wed, 14 Sep 2016 05:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbcINFNL (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 01:13:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:43041 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbcINFNK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 01:13:10 -0400
Received: (qmail 24126 invoked by uid 109); 14 Sep 2016 05:13:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 05:13:10 +0000
Received: (qmail 28938 invoked by uid 111); 14 Sep 2016 05:13:20 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 01:13:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2016 22:13:06 -0700
Date:   Tue, 13 Sep 2016 22:13:06 -0700
From:   Jeff King <peff@peff.net>
To:     kevin@lists.ikke.info
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [RFC 0/1] mailinfo: de-quote quoted-pair in header fields
Message-ID: <20160914051305.vphknpsikyxi3hg3@sigill.intra.peff.net>
References: <20160913152622.2xtyn6mki6p6afsg@sigill.intra.peff.net>
 <20160913234612.22806-1-me@ikke.info>
 <20160913234612.22806-2-me@ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913234612.22806-2-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 01:46:12AM +0200, Kevin Daudt wrote:

> diff --git a/t/t5100/quoted-pair.expect b/t/t5100/quoted-pair.expect
> new file mode 100644
> index 0000000..9fe72e9
> --- /dev/null
> +++ b/t/t5100/quoted-pair.expect
> @@ -0,0 +1,5 @@
> +Author: "Author "The Author" Name"
> +Email: somebody@example.com
> +Subject: testing quoted-pair
> +Date: Sun, 25 May 2008 00:38:18 -0700

So obviously this is much better than including the backslashed quotes.
But I have to wonder why the first line is not:

  Author: Author "The Author" Name

Who is responsible for stripping out the other quotes? I know that they
_do_ get stripped out even in the current code, but it is not clear to
me if that is intentional or an accident.

In Git's world-view (e.g., in commit headers), an ident name continues
until we get to the "<" of the email (or a "\n" terminates the header
line completely). So if mailinfo is converting rfc2822 headers into Git
ident, I'd expect it to fully remove any quotes that are not intended to
be in the name, and everything after "Author: " up to the newline would
become the name.

It's entirely possible I'm missing something subtle about the design of
mailinfo, though.

-Peff
