Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1C21FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbdEaVW1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:22:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:60796 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbdEaVW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:22:26 -0400
Received: (qmail 15909 invoked by uid 109); 31 May 2017 21:22:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 21:22:25 +0000
Received: (qmail 8762 invoked by uid 111); 31 May 2017 21:23:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 May 2017 17:23:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 May 2017 17:22:24 -0400
Date:   Wed, 31 May 2017 17:22:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elliott Cable <me@ell.io>,
        Dennis Kaarsemaker <dennis.kaarsemaker@booking.com>,
        Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: persistent-https, url insteadof, and `git submodule`
Message-ID: <20170531212224.bhn36sa4g5ns54aj@sigill.intra.peff.net>
References: <CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com>
 <1495230186.19473.7.camel@kaarsemaker.net>
 <1495230934.19473.10.camel@booking.com>
 <20170520070757.jekykxagzze3t2wy@sigill.intra.peff.net>
 <CAPZ477PoSXqahxaQVpO+m==vng==o4vQahrg_WA8Oeh7wmoW0w@mail.gmail.com>
 <20170531045051.ctoo7sv3f66xurdf@sigill.intra.peff.net>
 <CACBZZX6LQRW=78R-rkeUKmDCRUmN52SjkShSjDC5AgV5o7T6iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6LQRW=78R-rkeUKmDCRUmN52SjkShSjDC5AgV5o7T6iQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 04:23:49PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > It really is an issue of the user knowing about the problem (and how to
> > solve it), and I don't think we can get around that securely. So better
> > documentation probably is the right solution.
> >
> > I'll see if I can cook something up.
> 
> I was going to say: A way to have our cake & eat it too here would be
> to just support *.insteadOfRegex, i.e.
> "url.persistent-https://.insteadOfRegex="^https://".
> 
> But in this case, even if we can just do un-anchored string
> replacement, isn't a way around this just to do
> "url.persistent-https://.insteadOf=https://" & untaint & document that
> you should do that?

I think we already do the second form, and that's what Elliott ran into.
The problem is that it is not clear if "persistent-https" is safe to use
for submodules. _We_ know that it is because we know what that remote
does, but Git doesn't know that. You would not necessarily want:

  [url "ext::ssh-wrapper "]
  insteadOf  = "ssh://"

to kick in for a submodule. That's a fairly insane thing to be doing,
but the point is that we don't know if the rewritten protocol is ready
to handle "tainted" URLs that come from an untrusted submodule file.

-Peff
