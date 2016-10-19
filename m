Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C71920986
	for <e@80x24.org>; Wed, 19 Oct 2016 21:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753522AbcJSVPN (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 17:15:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:59685 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbcJSVPM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 17:15:12 -0400
Received: (qmail 19151 invoked by uid 109); 19 Oct 2016 21:15:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 21:15:12 +0000
Received: (qmail 17844 invoked by uid 111); 19 Oct 2016 21:15:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 17:15:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 17:15:10 -0400
Date:   Wed, 19 Oct 2016 17:15:10 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Raffael Reichelt <raffael.reichelt@gmail.com>
Subject: Re: [PATCH] Add a knob to abort on die() (was Re: git checkout
 crashes after ...)
Message-ID: <20161019211509.mqt5cqy24eu6wptk@sigill.intra.peff.net>
References: <6B2BE996-F696-4EB4-91CA-849D40B8802D@gmail.com>
 <CACsJy8B50daiHWfu7zfVQnn_i_=HbUK3gBPmv1U=EUw7ZyuGPw@mail.gmail.com>
 <20161019134750.GA7256@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161019134750.GA7256@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 08:47:50PM +0700, Duy Nguyen wrote:

> On Wed, Oct 19, 2016 at 08:27:43PM +0700, Duy Nguyen wrote:
> > If you set the environment variable GIT_ALLOC_LIMIT ...  git
> > attempts to allocate more than that ... then it's caught and we get
> > a glimpse of how much memory git may need. Unfortunately we can't
> > get a stack trace or anything like that unless you rebuild Git from
> > source.
> 
> It's moments like this that I wish we had a knob to force core
> dumps. And I often modify die_builtin() to add '*(char*)0 = 1;' to
> force a core dump when I can't figure out some problem based on the
> error message alone.
> 
> So.. how about we do something like this? We could extend it to abort
> on error() as well as die(). Aborting on warning() may be a bit too
> much though. On glibc systems we could even print the back trace
> without aborting, which helps in some cases.

I have been tempted by something like this, too, and have occasionally
resorted to patching in an abort() call to get cores from sub-processes.

I'm not sure how useful it would be in practice in deployed versions of
git, though. You'd have to coach the user into finding the core file and
generating the backtrace from it. Something that called backtrace(3)
automatically would be more seamless (but provides worse information
than gdb), and otherwise it is probably just as easy to ship the user
cut-and-paste instructions to use gdb.

See the previous discussion in this subthread:

  http://public-inbox.org/git/20150424201734.GA4747@peff.net/T/#u

-Peff
