Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E855F1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 23:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfAaXVv (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 18:21:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:57218 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726284AbfAaXVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 18:21:51 -0500
Received: (qmail 25804 invoked by uid 109); 31 Jan 2019 23:21:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Jan 2019 23:21:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30561 invoked by uid 111); 31 Jan 2019 23:21:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 31 Jan 2019 18:21:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2019 00:21:47 +0100
Date:   Fri, 1 Feb 2019 00:21:47 +0100
From:   Jeff King <peff@peff.net>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
Message-ID: <20190131232146.GA7260@sigill.intra.peff.net>
References: <20190122232301.95971-1-nbelakovski@gmail.com>
 <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190122232301.95971-2-nbelakovski@gmail.com>
 <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
 <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
 <xmqq5zud52ut.fsf@gitster-ct.c.googlers.com>
 <20190124183235.GA16580@sigill.intra.peff.net>
 <xmqqd0olj1kj.fsf@gitster-ct.c.googlers.com>
 <20190124212608.GD16114@sigill.intra.peff.net>
 <CAC05385KQPXodr-LymXVK97fBAp5==M=OBr1mRYueGbG1qcepA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC05385KQPXodr-LymXVK97fBAp5==M=OBr1mRYueGbG1qcepA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 12:53:24PM -0800, Nickolai Belakovski wrote:

> So where does that leave us for this series? We could move hashmap
> back into used_atom, but if a user entered
> --format="%(worktreepath)%(worktreepath:)" we'd end up freeing
> worktrees twice. Not that that should stop us - that scenario is one
> where user input isn't sensible and personally I don't think it's
> necessary to protect against such things (unless the user was
> reasonably confused, but I don't see that as the case here).
> 
> I agree with Jeff that a ref-filter "context" would help. And in more
> ways than one, it could help us decide ahead of time whether to check
> if a ref is a branch or a tag before doing a hashmap lookup or just
> skip the check (i.e. if there are no tags within the context, the
> check would only add cost). But I do believe that that would be
> outside the scope of this series.
> 
> I think leaving it as globals is a tiny bit safer and also makes it
> easier to pack it into a context if/when we decide to do that work,
> but as always I'm open to other interpretations.

Yeah, I agree with this: global for now, and then easily moved into a
context struct later (along with all the other existing globals).

-Peff
