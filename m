Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FECC1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 15:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932331AbeCOPf2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 11:35:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:58000 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932274AbeCOPf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 11:35:27 -0400
Received: (qmail 29141 invoked by uid 109); 15 Mar 2018 15:35:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Mar 2018 15:35:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15475 invoked by uid 111); 15 Mar 2018 15:36:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Mar 2018 11:36:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Mar 2018 11:35:25 -0400
Date:   Thu, 15 Mar 2018 11:35:25 -0400
From:   Jeff King <peff@peff.net>
To:     Michele Locati <michele@locati.it>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] filter-branch: return 2 when nothing to rewrite
Message-ID: <20180315153525.GA29265@sigill.intra.peff.net>
References: <20180315130359.6108-1-michele@locati.it>
 <20180315141220.GB27748@sigill.intra.peff.net>
 <CAGen01iZTs1FC3tsuMF9SAS0QcKxN0Sk1CPeZ+YNyh5X8sdgtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGen01iZTs1FC3tsuMF9SAS0QcKxN0Sk1CPeZ+YNyh5X8sdgtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 03:57:15PM +0100, Michele Locati wrote:

> >>  git-filter-branch.sh | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > This should probably get a mention in the manpage at
> > Documentation/git-filter-branch.txt, too.
> 
> Yes, I agree it would be useful. What about this addition right after the
> "Remap to ancestor" section?
> 
> EXIT CODE
> ---------

That seems like a good place (for those just reading on the list, it's
right before the "examples" section).

It looks like we don't have many similar sections, but when we do we
call them "EXIT STATUS" (which seems to match other projects like
"grep").

> In general, this command will fail with an exit status of `1` in case of errors.
> When the filter can't fine anything to rewrite, the exit status is `2`.

s/fine/find/

Do we want to commit to status `1` for everything else? Most of the
C code that dies does so with 128, and I wonder if that could propagate
in some cases. IOW, could we leave room for that and for future changes
with something like:

  On success, the exit status is `0`.  If the filter can't find any
  commits to rewrite, the exit status is `2`. On any other error,
  the exit status may be any other non-zero value.

-Peff

PS I think this is your first patch to Git. I forgot to say: welcome to
   the list!
