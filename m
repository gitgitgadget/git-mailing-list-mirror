Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF0C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 09:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095702076B
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 09:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgKXJLG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:11:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:40016 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbgKXJLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 04:11:06 -0500
Received: (qmail 1244 invoked by uid 109); 24 Nov 2020 09:11:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Nov 2020 09:11:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12972 invoked by uid 111); 24 Nov 2020 09:11:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Nov 2020 04:11:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Nov 2020 04:11:05 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
Message-ID: <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net>
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
 <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
 <20201121002921.GC353076@coredump.intra.peff.net>
 <xmqqd006s7ee.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd006s7ee.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 21, 2020 at 01:54:17PM -0800, Junio C Hamano wrote:

> > I wrote this patch ages ago, and it is still sitting close to the bottom
> > (if not the bottom) of my todo stack, waiting to be investigated. ;)
> 
> Sounds sensible.
> 
> > -- >8 --
> > Subject: [PATCH] send-pack: kill pack-objects helper on signal or exit

Looks like you picked up this patch on a topic branch

I was thinking of polishing it further with a test, but I can't think of
a good way to do one that would not be horribly racy. I even tried to
think of a racy test I could run manually (e.g., pushing and killing in
a loop) but even that is tough (even with the patch, it's racy whether
the push will succeed or not, depending on exactly when you kill the
parent, so there's no automatic way to distinguish the improved cases).

So I think it is still a good idea to do, and what I wrote earlier is
as good a we can do.

René, do you want to wrap up your similar patch for the fetch side?

-Peff
