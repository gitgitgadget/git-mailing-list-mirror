Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93C61FA14
	for <e@80x24.org>; Fri, 26 May 2017 18:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944487AbdEZShG (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 14:37:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:58579 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932235AbdEZShF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 14:37:05 -0400
Received: (qmail 19602 invoked by uid 109); 26 May 2017 18:37:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 18:37:04 +0000
Received: (qmail 31838 invoked by uid 111); 26 May 2017 18:37:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 14:37:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 May 2017 14:37:02 -0400
Date:   Fri, 26 May 2017 14:37:02 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: filter-branch does not require re-export of vars
Message-ID: <20170526183702.jrjkykhldz74pquq@sigill.intra.peff.net>
References: <20170526173654.4238-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170526173654.4238-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 07:36:54PM +0200, Andreas Heiduk wrote:

> The function `set_ident` in `filter-branch` exported the variables
> GIT_(AUTHOR|COMMITTER)_(NAME|EMAIL|DATE) at least since 6f6826c52b in 2007.
> Therefore the filter scripts don't need to re-eport them again.

Some old shells keep separate values for the internal and exporter
versions of variables. I.e., this:

  foo=one
  export foo
  foo=two

would continue to export $foo as "one", even though it is "two" inside
the script.

However, I think POSIX mandates the behavior you'd expect. And the only
shell I know that misbehaves in this way is Solaris /bin/sh, which we
have already declared too broken to support. According to

  https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Limitations-of-Builtins.html#export

it sounds like there are some other antique shells which may do the
same (it doesn't cover this case explicitly, but the "coexist" cases it
mentions are likely to behave in this way).

At this point, I'd be inclined to remove the text as you suggest and
either make a small note at the bottom of the page, or just omit it
entirely and assume that anybody on an old non-POSIX shell can fend for
themselves.

-Peff
