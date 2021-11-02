Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285ECC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046CD60EE3
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKBOWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:22:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:51406 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhKBOWg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 10:22:36 -0400
Received: (qmail 2726 invoked by uid 109); 2 Nov 2021 14:20:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Nov 2021 14:20:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5739 invoked by uid 111); 2 Nov 2021 14:20:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Nov 2021 10:20:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Nov 2021 10:20:00 -0400
From:   Jeff King <peff@peff.net>
To:     Dmitry Marakasov <amdmi3@amdmi3.ru>
Cc:     git@vger.kernel.org
Subject: Re: pull.rebase config option broken in 2.33.1
Message-ID: <YYFJEASSimMhEsYz@coredump.intra.peff.net>
References: <YYFEE/2g3SiM04zx@hades.panopticon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYFEE/2g3SiM04zx@hades.panopticon>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 04:58:43PM +0300, Dmitry Marakasov wrote:

> After update from 2.33.0 to 2.33.1 the pull.rebase = true option
> no longer works: `git pull` no longer tries to rebase (however manual
> `git pull --rebase` works fine):
> 
> % git config pull.rebase
> true
> % git pull
> fatal: Not possible to fast-forward, aborting.
> % git pull --rebase
> Successfully rebased and updated refs/heads/local-fixes.
> % git pull
> fatal: Not possible to fast-forward, aborting.
> % grep -C1 rebase .git/config
> [pull]
> 	rebase = true
> [rebase]
> 	autostash = true
> 
> After downgrade to 2.33.0:
> 
> % git pull
> Current branch local-fixes is up to date.

This looks like the same bug discussed in:

  https://lore.kernel.org/git/CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com/

There's a fix in that thread. It's currently in "next", but didn't quite
make the cutoff for the upcoming v2.34.0.

-Peff
