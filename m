Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B3482021E
	for <e@80x24.org>; Thu,  3 Nov 2016 18:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760082AbcKCSu4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 14:50:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:38237 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758875AbcKCSuz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 14:50:55 -0400
Received: (qmail 7639 invoked by uid 109); 3 Nov 2016 18:50:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 18:50:55 +0000
Received: (qmail 15563 invoked by uid 111); 3 Nov 2016 18:51:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 14:51:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 14:50:52 -0400
Date:   Thu, 3 Nov 2016 14:50:52 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103185052.q46x4hlcwne7kpc5@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
 <20161103175327.nn2yasvlsxsy22be@sigill.intra.peff.net>
 <20161103182428.j3r574evsk7ypfie@sigill.intra.peff.net>
 <20161103184538.GE182568@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161103184538.GE182568@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 11:45:38AM -0700, Brandon Williams wrote:

> On 11/03, Jeff King wrote:
> > 
> > So this seems like a reasonable direction to me. It obviously needs
> > documentation and tests. Arguably there should be a fallback "allow"
> > value when a protocol is not mentioned in the config so that you could
> > convert the default from "user" to "never" if you wanted your config to
> > specify a pure whitelist.
> 
> Yes I agree there should probably be a fallback value of 'never' maybe?
> What you currently have preserves the behavior of what git does
> now, if we did instead have a fallback of 'never' it would break current
> users who don't already use GIT_ALLOW_PROTOCOL (well only if they use
> crazy protocols).  We could ease into it though and start with default
> to allow and then transition to a true whitelist sometime after this
> change has been made?

I don't see the value in moving the out-of-the-box install to any
default except "user". Right now the experience of using a third-party
helper is something like:

  cp git-remote-hg /somewhere/in/your/PATH
  git clone hg::whatever

We restrict its use in submodules by default, which is unlikely to bite
many people. But if we started falling back to "never" all the time,
then that second command would break until you officially "approve"
remote-hg in your config.

I was thinking of just something to let people decide to have that level
of paranoia themselves (especially if they want to just set up a
whole-system white list via the config without bothering with
environment variables). Like:

  git config --system protocol.allow never
  git config --system protocol.https.allow always

That behaves exactly like:

  export GIT_ALLOW_PROTOCOL=https

except it just works everywhere, without having to tweak the environment
of every process.

> > Do you have interest in picking this up and running with it?
> 
> Yep! Thanks for the help in shaping this.

Great, thanks. I'm happy to review or discuss further as necessary.

-Peff
