Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66A9202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 13:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbdGFNb2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 09:31:28 -0400
Received: from continuum.iocl.org ([217.140.74.2]:59870 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbdGFNb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 09:31:28 -0400
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v66DVOP01584;
        Thu, 6 Jul 2017 15:31:24 +0200
Date:   Thu, 6 Jul 2017 15:31:24 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Flurries of 'git reflog expire'
Message-ID: <20170706133124.GB1216@inner.h.apk.li>
References: <20170704075758.GA22249@inner.h.apk.li> <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 05 Jul 2017 04:20:27 +0000, Jeff King wrote:
> On Tue, Jul 04, 2017 at 09:57:58AM +0200, Andreas Krey wrote:
...
> I seem to recall that using --stale-fix is also extremely expensive,
> too. What do the command line arguments for the slow commands look like?

The problem isn't that the expire is slow, it is that there are
many of them, waiting for disk writes.

> And what does the process tree look like?

Lots (~ 10) of

          \_ /usr/bin/git receive-pack /opt/apps/atlassian/bitbucket-data/shared/data/repositories/68
          |   \_ git gc --auto --quiet
          |       \_ git reflog expire --all

plus another dozen gc/expire pairs where the parent is already gone.
All with the same arguments - auto GC.

I'd wager that each push sees that a GC is in order,
and doesn't notice that there is one already running.

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
