Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17F41F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 19:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754941AbcJNTNX (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 15:13:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:57616 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753651AbcJNTNV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 15:13:21 -0400
Received: (qmail 23118 invoked by uid 109); 14 Oct 2016 19:12:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 19:12:56 +0000
Received: (qmail 8182 invoked by uid 111); 14 Oct 2016 19:13:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 14 Oct 2016 15:13:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2016 15:12:54 -0400
Date:   Fri, 14 Oct 2016 15:12:54 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Can we make interactive add easier to use?
Message-ID: <20161014191254.stzzffyxk6ih3cwx@sigill.intra.peff.net>
References: <CAHd499AnuVximRgM0MKdq5JC-hwkrhox6bK_KA+XGrawoz2W+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499AnuVximRgM0MKdq5JC-hwkrhox6bK_KA+XGrawoz2W+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 08:20:40AM -0500, Robert Dailey wrote:

> Normally when I use interactive add, I just want to add files to the
> index via simple numbers, instead of typing paths. So I'll do this as
> quick as I can:

I'd generally second Matthieu's suggestion to use a combination of "git
add" and "git add -p". But if you really like the interactive updater,
then the optimizations I can think of are:

> 1. Type `git add -i`
> 2. Press `u` after prompt appears
> 3. Press numbers for the files I want to add, ENTER key
> 4. ENTER key again to go back to main add -i menu
> 5. Press `q` to exit interactive add
> 6. Type `git commit`

We have "git add -p" to avoid having to do a similar workflow just to
get to the "p"atch menu. So in theory we could have a similar shortcut
to get to "u"pdate. I think it's just not in common enough use that
anybody really bothered to implement it.

We also have "commit -p" (and "commit -i") already, though I do not use
them myself.

That would probably take you down to:

  1. git commit --iu ;# obviously a terrible option name
  2. Press numbers, then ENTER
  3. 'q' or ENTER or ^D to exit, and jump into commit message
     automatically.

You can also set the interactive.singleKey config option to turn (2)
into just "press numbers" (which works right now).

> This feels very tedious. Is there a simplified workflow for this? I
> remember using a "git index" unofficial extension to git that let you
> do a `git status` that showed numbers next to each item (including
> untracked files!) and you could do `git add 1, 2, 3-5`, etc.

TBH, that extension sounds a lot more generically useful, as it works at
the shell level. I _think_ I've seen similar features implemented that
are not even git specific (i.e., they work off of existing
shell-completion libraries and just let you pick the options by number
rather than tab-completing). Sorry I don't have any links, though. It's
not something I ever used myself.

-Peff
