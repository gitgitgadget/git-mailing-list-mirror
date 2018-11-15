Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D6C1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 09:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbeKOTu0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 14:50:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:40286 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729039AbeKOTu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 14:50:26 -0500
Received: (qmail 11343 invoked by uid 109); 15 Nov 2018 09:43:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 09:43:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13932 invoked by uid 111); 15 Nov 2018 09:42:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 04:42:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 04:43:20 -0500
Date:   Thu, 15 Nov 2018 04:43:20 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] ref-filter: don't look for objects when outside of a
 repository
Message-ID: <20181115094320.GA18790@sigill.intra.peff.net>
References: <xmqq5zytpa65.fsf@gitster-ct.c.googlers.com>
 <20181114122725.18659-1-szeder.dev@gmail.com>
 <20181115093844.GA14218@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115093844.GA14218@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 04:38:44AM -0500, Jeff King wrote:

> Is SOURCE_NONE a complete match for what we want?
> 
> I see problems in both directions:
> 
>  - sorting by "objectname" works now, but it's marked with SOURCE_OBJ,
>    and would be forbidden with your patch.  I'm actually not sure if
>    SOURCE_OBJ is accurate; we shouldn't need to access the object to
>    show it (and we are probably wasting effort loading the full contents
>    for tools like for-each-ref).
> 
>    However, that's not the full story. For objectname:short, it _does_ call
>    find_unique_abbrev(). So we expect to have an object directory.

Oops, I'm apparently bad at reading. It is in fact SOURCE_OTHER, which
makes sense (outside of this whole "--sort outside a repo thing").

But we'd ideally distinguish between "objectname" (which should be OK
outside a repo) and "objectname:short" (which currently segfaults).

-Peff
