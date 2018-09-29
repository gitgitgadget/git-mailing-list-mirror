Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A53A31F453
	for <e@80x24.org>; Sat, 29 Sep 2018 07:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeI2OYH (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 10:24:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:36148 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727621AbeI2OYH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 10:24:07 -0400
Received: (qmail 10203 invoked by uid 109); 29 Sep 2018 07:56:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Sep 2018 07:56:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4564 invoked by uid 111); 29 Sep 2018 07:56:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Sep 2018 03:56:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2018 03:56:38 -0400
Date:   Sat, 29 Sep 2018 03:56:38 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Lo <wilburlo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Request for examples on git log --format:tformat
Message-ID: <20180929075638.GG2174@sigill.intra.peff.net>
References: <CAOeX3KXASgnyVcZuTAjyXLgnZpeA1FD3XXvSoRd11b9V9jpGFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOeX3KXASgnyVcZuTAjyXLgnZpeA1FD3XXvSoRd11b9V9jpGFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 11:29:32AM -0700, Daniel Lo wrote:

> I was reviewing the tformat parameters on:
> https://git-scm.com/docs/git-log (middle of the page).
> 
> Specifically: %<|(<N>): make the next placeholder take at least until
> Nth columns, padding spaces on the right if necessary
> 
> I found the instructions regard space formatting to be very confusing.
> An example would be helpful to illustrate what the proper space
> formatting syntax is:
> 
> Ex:
> git log --format="tformat:%h %<(15)%an %s"
> 
> 0123456 Author Name Commit message - author name is formatted to be
> padded with space to occupy at least 15 characters
> 
> All of the special symbols %<|(<>) made me confused to what was
> required and what was describing the syntax.

I'm not sure if you're asking for somebody to give an example here, or
suggesting that the documentation should contain an example.

If the former, then an example matching the documentation you quoted is:

  git log --format='%h %<|(15)%an %s'

The difference (I think -- I've never actually use either of these in
the wild myself) between %< and %<| is that the former pads out to N
spaces, and the latter pads out until we've reached the Nth column (so
taking into account all prior content on the line, too).

To see the difference try:

  # pad names to 30 chars
  git log --format='%h %<(30)%an %s'

versus

  # pad out to the 30th column, including the hash
  git log --format='%h %<|(30)%an %s'

versus

  # pad out to the 30th column, but without the hash there should be
  # much more whitespace
  git log --format='%<|(30)%an %s'


If you are suggesting that there should be some examples in the
documentation, I agree (I had to stare at the descriptions and run a few
tests myself to figure this out). I'm not sure if they should go near
the placeholder list, or in the examples section.

-Peff

PS Orthogonal to your question, but one tip: "--format" defaults to
   "tformat:" if its argument contains %-placeholders.
