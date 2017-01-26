Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A1F21F794
	for <e@80x24.org>; Thu, 26 Jan 2017 21:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbdAZVSh (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 16:18:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:45571 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753746AbdAZVSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 16:18:37 -0500
Received: (qmail 30541 invoked by uid 109); 26 Jan 2017 21:18:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 21:18:37 +0000
Received: (qmail 27799 invoked by uid 111); 26 Jan 2017 21:18:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 16:18:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 16:18:34 -0500
Date:   Thu, 26 Jan 2017 16:18:34 -0500
From:   Jeff King <peff@peff.net>
To:     Reimar =?utf-8?Q?D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: "git fetch -p" incorrectly deletes branches
Message-ID: <20170126211834.eplmjcohv3d4zsym@sigill.intra.peff.net>
References: <20170117060428.nanqz5lr4hi6dum6@reimardoeffinger.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170117060428.nanqz5lr4hi6dum6@reimardoeffinger.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 07:04:28AM +0100, Reimar Döffinger wrote:

> Deletes refs/heads/test every second time when run repeatedly:
> 
> $ git fetch -p -v origin master:refs/heads/test
> From https://github.com/git/git
>  * [new branch]          master     -> test
>  = [up to date]          master     -> origin/master
> $ git fetch -p -v origin master:refs/heads/test
> From https://github.com/git/git
>  - [deleted]             (none)     -> test
>  = [up to date]          master     -> test
>  = [up to date]          master     -> origin/master

Hmm. It seems like the problem is that "-p" is saying "the other side
does not have refs/heads/test; we must prune it". But I think it is
probably nonsense to apply pruning to a non-wildcard refspec.


> Also note that this behaviour appears also when fetch.prune=yes
> is set in the config (instead of -p on the command-line),
> which makes it much less obvious and there is no option to turn
> of prune just for that command to work-around this.

There is a separate issue of whether it is sane to apply fetch.prune to
a refspec given on the command line; I can imagine it as surprising, to
say the least.

I think "--no-prune" would disable it, though.

-Peff
