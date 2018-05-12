Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD6A31F42D
	for <e@80x24.org>; Sat, 12 May 2018 09:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750778AbeELJsw (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 05:48:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:37150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750722AbeELJsv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 05:48:51 -0400
Received: (qmail 25582 invoked by uid 109); 12 May 2018 09:48:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 12 May 2018 09:48:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13827 invoked by uid 111); 12 May 2018 09:48:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 12 May 2018 05:48:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2018 05:48:50 -0400
Date:   Sat, 12 May 2018 05:48:50 -0400
From:   Jeff King <peff@peff.net>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git send-email: incorrectly parses email address with comma
Message-ID: <20180512094849.GI28279@sigill.intra.peff.net>
References: <9a35041b-8333-9533-4344-08d6ef99c9c9@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a35041b-8333-9533-4344-08d6ef99c9c9@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 10:21:46AM +0200, Heinrich Schuchardt wrote:

> Git send-email allows to combine multiple email addresses in one
> parameter, e.g.
> 
> --to="a@example.com, b@example.com"
> 
> But email addresses may contain commas themselves:
> 
> --to="LASTNAME, firstname <firstname.lastname@example.com>"
> 
> This may lead to an error:

If the name contains syntactically relevant metacharacters, it can be
quoted. So as a workaround, you can do:

  --to='"LASTNAME, firstname" <firstname.lastname@example.com>'

I think rfc822 actually requires even names with just spaces in them to
be quoted, but git-send-email and most other mail programs are pretty
lax about allowing just about anything outside of the <>, so people tend
not to bother.

> If the string preceding a comma is not a valid email address do not
> split it off.

That might work as a heuristic, though "is a valid email address" is a
notoriously hard thing to check. Possibly looking for an "@" would catch
most common cases, though.

-Peff
