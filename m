Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F040C433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 11:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73259208B3
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 11:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFQLcg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:32:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:34310 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgFQLcg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 07:32:36 -0400
Received: (qmail 3815 invoked by uid 109); 17 Jun 2020 11:32:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jun 2020 11:32:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24808 invoked by uid 111); 17 Jun 2020 11:32:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jun 2020 07:32:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Jun 2020 07:32:34 -0400
From:   Jeff King <peff@peff.net>
To:     Noel Grandin <noelgrandin@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: filtering on git fetch?
Message-ID: <20200617113234.GA703467@coredump.intra.peff.net>
References: <f6c1377f-6945-b04f-07cf-887c4b7c9f76@gmail.com>
 <20200617083423.GA695303@coredump.intra.peff.net>
 <e3ec6fec-b872-b548-0eb0-d085ca36c99b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3ec6fec-b872-b548-0eb0-d085ca36c99b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 10:42:24AM +0200, Noel Grandin wrote:

> I tried (BTW my version is 2.26.2)
> 
> $ GIT_TRACE_PACKET=1 git -c protocol.version=2 pull -r

Ah, yeah, I think it should be the default in that version anyway.

> and the first few lines look like
> 
> 10:35:59.323490 pkt-line.c:80           packet:        fetch<
> ad0351b84926075297fb74abbe9b31a0455782af HEAD\0 include-tag
> multi_ack_detailed multi_ack o
> fs-delta side-band side-band-64k thin-pack no-progress shallow agent=JGit/5.3.7.202002110540-r symref=HEAD:refs/heads/master

Yep, that's definitely v0.

> Is there something else I need to do on the client-side to make this work?

No, probably the server doesn't support v2. I double-checked myself, and
couldn't get it to speak v2 either.

> Noting that the git server at gerrit.libreoffice.org might be a JGit based
> thing, so maybe I need to log a feature request there to support v2?

Probably.  I'm fairly certain that JGit has supported v2 for a while.
Just poking at `git log` in jgit.git shows some commits adding it around
the 5.0 timeframe. So I'd think the version they're advertising would
have it. I don't know offhand if there's a config option they'd need to
flip on the server.

-Peff
