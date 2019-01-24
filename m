Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529711F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfAXTeU (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:34:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:47822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730445AbfAXTeT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:34:19 -0500
Received: (qmail 10927 invoked by uid 109); 24 Jan 2019 19:34:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 19:34:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31603 invoked by uid 111); 24 Jan 2019 19:34:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 14:34:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 14:34:17 -0500
Date:   Thu, 24 Jan 2019 14:34:17 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
Message-ID: <20190124193417.GA14896@sigill.intra.peff.net>
References: <20190122232301.95971-1-nbelakovski@gmail.com>
 <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190122232301.95971-2-nbelakovski@gmail.com>
 <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
 <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
 <xmqq5zud52ut.fsf@gitster-ct.c.googlers.com>
 <20190124183235.GA16580@sigill.intra.peff.net>
 <xmqqh8dxj1p3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8dxj1p3.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 11:27:36AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If anything, I'd suggest going in the opposite direction, and teaching
> > the worktree code a function for looking up a working tree by ref. And
> > then it can handle its own cache to implement that reverse-mapping
> > efficiently.
> 
> Yeah, that's a thought.  Then "give me a worktree that checks out
> this ref" can be asked outside the context of for-each-ref and
> friends, which is a big plus.

One tricky thing is that we do not store a list of "struct worktree",
but rather generate it on the fly when get_worktrees() is called.

So having an API to ask for one ref's worktree at a time is slightly
awkward. It's only by having (and caching) this full list in
ref-filter.c that we can easily make the reverse-indexed hashmap.

-Peff
