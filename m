Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC88BC43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 02:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863E720796
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 02:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgIECzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 22:55:35 -0400
Received: from aibo.runbox.com ([91.220.196.211]:33900 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgIECze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 22:55:34 -0400
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1kEOMU-0002Q0-Lv; Sat, 05 Sep 2020 04:55:30 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1kEOMS-0006Bh-Vi; Sat, 05 Sep 2020 04:55:29 +0200
Date:   Sat, 5 Sep 2020 02:55:18 +0000
From:   Emma Brooks <me@pluvano.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v2] gitweb: map names/emails with mailmap
Message-ID: <20200905025518.GA1524@pluvano.com>
References: <20200808213457.13116-1-me@pluvano.com>
 <20200809230436.2152-1-me@pluvano.com>
 <20200810100249.GC37030@coredump.intra.peff.net>
 <20200811041728.GA1748@pluvano.com>
 <20200811045509.GA81227@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811045509.GA81227@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-11 00:55:09-0400, Jeff King wrote:
> On Tue, Aug 11, 2020 at 04:17:28AM +0000, Emma Brooks wrote:
> 
> > On 2020-08-10 06:02:49-0400, Jeff King wrote:
> > > There was a little discussion in response to v1 on whether we could
> > > reuse the existing C mailmap code:
> > > 
> > >   https://lore.kernel.org/git/20200731010129.GD240563@coredump.intra.peff.net/
> > > 
> > > Did you have any thoughts on that?
> > 
> > I think it's probably not worth the effort to make the necessary changes
> > to "rev-list --header" Junio mentioned, just for gitweb.
> 
> Yeah, I agree that probably doesn't make sense to change "rev-list
> --header". I wonder if git could be using "rev-list --format" instead,
> though, and asking for the specific things it wants. That could improve
> more than just this case, too (e.g., the C code would be parsing and
> normalizing author/committer idents, which could make handling of badly
> formatted ones more consistent with other Git tools).
> 
> It may be a big change, though. I don't know the gitweb code very well.

This idea works in my testing, and it should be a small change.

However, I couldn't find a way to get "rev-list --format" to separate
commits with NULs. Is there a way to do this that I'm missing? I was
able to try the concept in gitweb by switching the "rev-list --format"
call I would've used to a similar log call, and it seems like a fairly
small change.
