Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD201F516
	for <e@80x24.org>; Thu, 28 Jun 2018 14:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966579AbeF1O1I (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 10:27:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:58210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965966AbeF1O1H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 10:27:07 -0400
Received: (qmail 13999 invoked by uid 109); 28 Jun 2018 14:27:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Jun 2018 14:27:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20176 invoked by uid 111); 28 Jun 2018 14:27:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Jun 2018 10:27:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jun 2018 10:27:05 -0400
Date:   Thu, 28 Jun 2018 10:27:05 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated
 docs
Message-ID: <20180628142705.GB15799@sigill.intra.peff.net>
References: <20180627045637.13818-1-tmz@pobox.com>
 <20180627141430.GA13904@sigill.intra.peff.net>
 <20180627150352.GJ20217@zaya.teonanacatl.net>
 <20180627164443.GK20217@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180627164443.GK20217@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 12:44:43PM -0400, Todd Zullinger wrote:

> I wrote:
> > Jeff King wrote:
> >>      (Related, there's a build target in the local Makefile for using
> >>      asciidoctor; does it need updated, too?)
> > 
> > I didn't test asciidoctor specficially, but it also respects
> > the ASCIIDOC_EXTRA parameters, so I think it will work just
> > as well.  I'll try to confirm that later today.
> 
> Testing confirmed that asciidoctor works fine with this as
> well.

Thanks for checking.

> Somewhat tangentially, I looked at using asciidoctor for the
> Fedora packages last year and one issue that kept me from
> using it then was the '[FIXME: source]' it includes in the
> footer of the manpage.  When I dug into it at the time, it
> appeared this was due to no <refmiscinfo> declaration
> (similarly missing for manual, and version).  It wasn't
> clear whether it was possible to include a custom header
> template in plain asciidoctor.  I got the impression that it
> would require using a custom backend, which in turn required
> the rubygem 'tilt' for processing.
> 
> I spent about an hour poking around with it and decided that
> I'd put off building with asciidoctor until that was fixed.
> I felt that displaying '[FIXME: source]' wass worse than
> simply not including the version.
> 
> It's always possible that I was doing something wrong in my
> use of asciidoctor (I just set USE_ASCIIDOCTOR).  Or maybe
> the Fedora packages are missing some dependency which I
> missed.

Hmm. I don't typically use asciidoctor locally (to be honest, I do not
typically build the documentation at all locally, and just read the
source when I need it). But just setting USE_ASCIIDOCTOR seems to work
fine for me out of the box. I'm on Debian unstable, asciidoctor 1.5.7.1.

At this point I think we still consider the original asciidoc as our
officially supported platform, and mostly are happy if things also work
with asciidoctor. But my impression is that there's no more development
work happening on asciidoc, and the path forward will be asciidoctor. So
at some point we may need to flip that.

One nice thing about switching to asciidoctor fully is that it can do
direct manpage generation. So we could eventually drop the docbook/xmlto
dependencies (right now even with USE_ASCIIDOCTOR we still go through
the xml step).

> It might also be that we need some adjustments similar to
> https://patchwork.kernel.org/patch/10360207/ to get the
> mansource attribute passed on to asciidoctor.  I only just
> ran across that patch and haven't had a chance to test
> sometime similar in the git manpage build.  That looks
> promising though.

Yeah, we have to do similar tricks on git-scm.com to handle things
like linkgit. Our implementation there is quite horrible (regex search
and replace!). It would be wonderful if we could write real ruby
snippets to handle extended cases, and then the git-scm.com doc builder
could just reuse that logic instead of hackily reimplementing it.

Anyway, that's all well outside the scope of your patch today, I think.
:)
