Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B62EC433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6D561058
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347746AbhIBWl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:41:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:38388 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347766AbhIBWl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 18:41:26 -0400
Received: (qmail 25230 invoked by uid 109); 2 Sep 2021 22:40:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Sep 2021 22:40:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1436 invoked by uid 111); 2 Sep 2021 22:40:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Sep 2021 18:40:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Sep 2021 18:40:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, hanwen@google.com
Subject: Re: [PATCH 3/3] fixup! reftable: add a heap-based priority queue for
 reftable records
Message-ID: <YTFS2oQz9QEzBe0Q@coredump.intra.peff.net>
References: <20210902053023.44006-1-carenas@gmail.com>
 <20210902053023.44006-4-carenas@gmail.com>
 <YTCU3F+0sKcrym6F@coredump.intra.peff.net>
 <xmqqeea6kaed.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeea6kaed.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 02, 2021 at 01:08:58PM -0700, Junio C Hamano wrote:

> > This will trigger -Wunused-parameter warnings, since the function body
> > is now empty when NDEBUG is undefined. Probably switching the assert()
> > to die() would be better, since the whole point of the function is just
> > to exit on error.
> >
> > If there's a problem using die() from the reftable code, it could also
> > return an error and the caller in the test helper could propagate it.
> 
> I agree that the patch as posted does not help but if this is
> originally an assertion, then it should never trigger in real life,
> so BUG() would be more appropriate than an error return, no?

My thinking was that it doesn't make much sense as an assertion in the
first place. It is not a side effect of "let's make sure things are as
we expect while we're doing some other operation". The whole point of
the function is: is this data structure properly in order.

But I guess you could argue that calling the function is itself a form
of assertion. I don't really care that much either way, so whatever
Han-Wen prefers is fine with me (but I do think it is worth addressing
the warning Carlo found _somehow_).

-Peff
