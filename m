Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E8AC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 19:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbhKVTO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 14:14:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:36592 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239713AbhKVTO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 14:14:26 -0500
Received: (qmail 22070 invoked by uid 109); 22 Nov 2021 19:11:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 19:11:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23869 invoked by uid 111); 22 Nov 2021 19:11:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 14:11:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 14:11:18 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t7006: clean up SIGPIPE handling in trace2 tests
Message-ID: <YZvrVj8w8j2Fb14O@coredump.intra.peff.net>
References: <xmqq1r4b8ezp.fsf@gitster.g>
 <20211024170349.GA2101@szeder.dev>
 <YZqSgu4XjPWnURju@coredump.intra.peff.net>
 <YZrCmPb5AIW8YYQ0@coredump.intra.peff.net>
 <YZrOLy03s5ZWMQ+t@coredump.intra.peff.net>
 <xmqqa6hxlysf.fsf@gitster.g>
 <YZsh6mnjuKbbIrw8@coredump.intra.peff.net>
 <YZsih3ar+g1ZTZOc@coredump.intra.peff.net>
 <xmqq5yskn3ir.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yskn3ir.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 09:49:32PM -0800, Junio C Hamano wrote:

> > That's a lot more tedious "if (!in_signal)" checks, but:
> >
> >   - we don't have to duplicate any of the actual application logic
> >
> >   - we'd now cover the extra cases for waitpid failing or returning the
> >     wrong pid (previously if waitpid() failed we'd still look at status,
> >     which could contain complete garbage!)
> 
> Yeah, the repeated "if (!in_signal)" look a bit ugly, but fixing
> that "we only deal with ifexited in in_signal case" to do the right
> thing would make the code even more annoying and harder to maintain.

OK. Let me see if I can clean this up into a full series that actually
fixes the race you saw, and breaks down the other fixes a bit more.

-Peff
