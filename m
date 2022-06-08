Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F07DC43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 23:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiFHXYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiFHXYr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 19:24:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F2A3BC3D0
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 16:24:17 -0700 (PDT)
Received: (qmail 6167 invoked by uid 109); 8 Jun 2022 23:24:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jun 2022 23:24:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Wed, 8 Jun 2022 19:24:16 -0400
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Ing. Martin Prantl Ph.D." <perry@ntis.zcu.cz>
Subject: Re: [PATCH 2/2] remote.c: reject 0-length branch names
Message-ID: <YqEvoB3Bskpykh1w@coredump.intra.peff.net>
References: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>
 <f947cf221c0b5320d0b7438b88a0d94a5bd3a70b.1654038754.git.gitgitgadget@gmail.com>
 <220601.86leug261j.gmgdl@evledraar.gmail.com>
 <kl6lilpke31e.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lilpke31e.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 01, 2022 at 09:55:57AM -0700, Glen Choo wrote:

> > Are we confident that this is just bizarro config that nobody would have
> > had in practice? In that case I think it's fine to start dying on it.
> >
> > But as I understand we previously just ignored this, then if there's any
> > doubt about that perhaps we should start with a warning?
> >
> > Or are we really confident that this is an edge case not worth worrying
> > about in that way, and that we can go straight to die()?
> 
> The case I want to make is even stronger than that - this is an edge
> case that _we_ shouldn't worry about, and we should tell the _user_ that
> their config is bogus.

It's a tradeoff, isn't it? We don't know how the user ended up with this
config, what they were trying to do, nor how common it is. Clearly the
config makes no sense and is broken, but by alerting the user, we are:

  - maybe doing some good, because now they know that whatever they were
    trying to do didn't work, and can clean up the broken config

  - maybe doing some bad, because it was not (and is not) hurting
    anything to have config that nobody bothers to do anything with. But
    if we die, now the user is presented with a situation that they know
    nothing about, and must resolve it before continuing with their
    unrelated work.

-Peff
