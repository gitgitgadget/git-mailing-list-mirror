Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167FFC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6798613E8
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhGAQt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:49:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:38938 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhGAQt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:49:58 -0400
Received: (qmail 28383 invoked by uid 109); 1 Jul 2021 16:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 16:47:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17525 invoked by uid 111); 1 Jul 2021 16:47:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 12:47:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 12:47:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 7/8] serve: add support for a "startup" git_config()
 callback
Message-ID: <YN3xnjSN49HUzBSW@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
 <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
 <patch-7.8-0a4fb01ae38-20210628T191634Z-avarab@gmail.com>
 <YN3wvy6fhD4V+FA3@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YN3wvy6fhD4V+FA3@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 01, 2021 at 12:43:43PM -0400, Jeff King wrote:

> I dunno. Maybe the solution is for ls_refs() to just do a separate
> config call to pick up the operation-specific bits, like:

By the way, I think both currently and after the patch I showed,
ls_refs() has the same "bug" that we fixed for upload_pack_v2() a while
ago: in a v2 world, a client could request "ls-refs" over and over, and
each time we'd load the hiderefs config, appending duplicate config to
the list each time.

In practice this doesn't happen because unlike "fetch", which clients
must do many rounds of, clients usually issue only a single ls-refs. So
it may not be worth worrying too much about. I guess a malicious client
could convince us to very slowly allocate an arbitrary amount of memory.

-Peff
