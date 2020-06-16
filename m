Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95A7C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B912220786
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgFPOYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:24:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:33304 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgFPOYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 10:24:24 -0400
Received: (qmail 22728 invoked by uid 109); 16 Jun 2020 14:24:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 14:24:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13389 invoked by uid 111); 16 Jun 2020 14:24:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 10:24:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 10:24:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
Message-ID: <20200616142423.GA667151@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <875zbrcpgh.fsf@evledraar.gmail.com>
 <20200616140932.GK666057@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616140932.GK666057@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 10:09:32AM -0400, Jeff King wrote:

> I think with that, we could ditch core.mainBranch entirely, with no
> notion at all of "this branch is special in this repo". We use HEAD
> where appropriate, and otherwise avoid any specialness.

One obvious exception is that third-party tools may want to know the
"special" branch for some reason. But I'm inclined to say that they
should (in this order):

  - consider whether they really need a special branch at all, or if the
    mechanism can be made more generic

  - consider whether HEAD is the best value for a special branch (e.g.,
    GitHub pull requests default to targeting HEAD)

  - rely on per-tool config for what's special (because it really may
    vary between tools, and that's more flexible anyway)

But I'm open to hearing about cases where some tool really wants to know
"what did the user consider the special branch at the time of creation".

-Peff
