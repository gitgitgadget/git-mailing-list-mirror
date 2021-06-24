Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9031CC49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 17:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7979B613E3
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 17:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhFXRQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 13:16:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:59700 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232375AbhFXRQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 13:16:32 -0400
Received: (qmail 12511 invoked by uid 109); 24 Jun 2021 17:14:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 17:14:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14344 invoked by uid 111); 24 Jun 2021 17:14:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 13:14:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 13:14:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 0/3] bundle.c: remove "ref_list" in favor of
 string-list.c API
Message-ID: <YNS9Yz+EtVzI+Ui7@coredump.intra.peff.net>
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 05:16:11PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This v2 addresses an omission noted by Andrei Rybak[1]. I didn't
> factor out the "name" into a variable in 2/3 for ease of reading
> 3/3. That's now done.

This all looks OK to me. I left a few small comments on the patches
themselves.

The UNLEAK() thing I suggested for patch 1 does make that patch much
smaller and easier to read, but I suspect makes patch 3 harder (i.e.,
you are reusing the "cleanup" sections there to do the bundle header
release. That could _also_ get UNLEAKed, but at some point it becomes
more clear to actually clean up after ourselves, and I think patch 3
probably crosses that point). So I'm OK to ignore that.

I would prefer to see the "die()" thing I mentioned there addressed, as
well as the ternary thing from patch 3. But neither of them is incorrect
as-is; it's just a style/preference thing.

-Peff
