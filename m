Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924522022A
	for <e@80x24.org>; Wed, 26 Oct 2016 12:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967013AbcJZMjq (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 08:39:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:34313 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966666AbcJZMjn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 08:39:43 -0400
Received: (qmail 5508 invoked by uid 109); 26 Oct 2016 12:31:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 12:31:58 +0000
Received: (qmail 10100 invoked by uid 111); 26 Oct 2016 12:32:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 08:32:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Oct 2016 08:31:56 -0400
Date:   Wed, 26 Oct 2016 08:31:56 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 7/7] setup_git_env: avoid blind fall-back to ".git"
Message-ID: <20161026123156.g76z66rxxlkwosht@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net>
 <20161020062430.rxupwheaeydtcvf3@sigill.intra.peff.net>
 <CACsJy8DZWN0RRaDy9w2BVG5pn4FWCY=1YQDsP0V5obrr1wSzZQ@mail.gmail.com>
 <20161025151524.y7wwtetohhqgcvob@sigill.intra.peff.net>
 <20161026102921.GA31311@ash>
 <20161026121058.a2pmf57oc7p2mlsp@sigill.intra.peff.net>
 <CACsJy8AHMJ7OJFKyjYAsPuT0nG=e0RGn59PuX06PJ5pYjinsqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AHMJ7OJFKyjYAsPuT0nG=e0RGn59PuX06PJ5pYjinsqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 07:26:20PM +0700, Duy Nguyen wrote:

> > I'm not sure this is really any convenience over dumping a corefile
> > and using gdb to pull out the
> > symbols after the fact.
> 
> So are we back to forcing core files? I'm ok with that! The only
> inconvenience I see is pointing out where the core file is, which
> should be where `pwd` originally is. On linux we can even peek into
> /proc/sys/kernel/core_pattern if we want to be precise. ulimit can get
> in the way, but I don't if the default out there is enable or disable
> core dumping. Once we got OS info and git version, our chances of
> cracking the core files should be reasonably high.

TBH, most of the time I expect the solution to be walking the person
through:

  git clone git://kernel.org/pub/scm/git/git.git
  cd git
  make

  gdb --args ./git whatever
  break die
  run
  bt

which would cover most cases (reproducible breakage, and not in a
sub-program). It's relatively rare that even I resort to corefiles.

-Peff
