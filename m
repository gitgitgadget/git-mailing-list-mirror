Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC80BC433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 17:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA3D64DD8
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 17:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhCRRAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 13:00:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:41276 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231853AbhCRRAF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 13:00:05 -0400
Received: (qmail 32574 invoked by uid 109); 18 Mar 2021 17:00:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Mar 2021 17:00:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23290 invoked by uid 111); 18 Mar 2021 17:00:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Mar 2021 13:00:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Mar 2021 13:00:04 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Christian Strasser <christian@avr-fun.de>, git@vger.kernel.org
Subject: Re: Git install crashed nearly whole System
Message-ID: <YFOHFABji5/sDZod@coredump.intra.peff.net>
References: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
 <YE5wFxE5RPew5zrJ@camp.crustytoothpaste.net>
 <b805d53740429a26413cdd4e756db29f95c98052.camel@avr-fun.de>
 <YFOA8ARUwa34tiTl@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFOA8ARUwa34tiTl@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 04:33:52PM +0000, brian m. carlson wrote:

> > I'm a little confused. Is the instruction on "
> > https://git-scm.com/book/en/v2/Getting-Started-Installing-Git" not the
> > official one? As you can see there, the first part is how to install
> > git with your package manager (git-all).
> 
> That is probably out of date, and I'd suggest reporting it to the
> appropriate spot, which is _probably_ https://github.com/git/git-scm.com
> (although it might be a separate repo).  The git-all package has had
> this problem for some time now, so I wouldn't recommend it as the
> default option.

The book content gets pulled in from a separate repo via an automated
process. The right spot here is https://github.com/progit/progit2.

We do recommend just "apt install git" on the downloads page:

  https://git-scm.com/download/linux

though that has created occasional confusion, too (e.g., some people
expect gitk).

> > Should I remove everything form "git-all" and reinstall everything
> > according to your advise? It seems no git daemon is working right now
> > (systemctl | grep git).
> 
> If everything's working for you, there's no need to change it.  It's
> _possible_ to install git-all and not have this problem, but because of
> the way modern versions of Debian and the packages in question are
> configured it ends up tending to have this problem by default.
> 
> In this case, it may be that git-daemon is installed but not configured
> to start, or it may have been removed when you reinstalled GNOME since
> it's not a hard dependency.

Yeah. I think fundamentally this is a packaging issue. It looks like
"git-daemon-*" has been downgraded to "Suggests" in Debian unstable. It
looks like this was done in 1:2.26.0-2 last April. From the changelog:

    * debian/control: downgrade Recommends by git-all on git-daemon-run
    to Suggests. The git-all package is a "batteries included" full
    installation of Git. Automatically running a daemon is not useful
    to most of its users.

So they are already aware of and addressed the problem, but older
releases will still show it.

-Peff
