Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972DDC2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B55D21BE5
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgI2AfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 20:35:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:43874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgI2AfU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 20:35:20 -0400
Received: (qmail 6898 invoked by uid 109); 29 Sep 2020 00:35:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2020 00:35:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13477 invoked by uid 111); 29 Sep 2020 00:35:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Sep 2020 20:35:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Sep 2020 20:35:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
Message-ID: <20200929003519.GB898702@coredump.intra.peff.net>
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
 <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
 <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
 <xmqqk0wdliuc.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0wdliuc.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 01:58:03PM -0700, Junio C Hamano wrote:

> "Nikita Leonov via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Nikita Leonov <nykyta.leonov@gmail.com>
> >
> > This commit makes reading process regarding credentials compatible with
> > 'CR/LF' line ending. It makes using git more convenient on systems like
> > Windows.
> 
> I can see why this is a good thing for "store" and the two updated
> pieces of the test script demonstrate it very well.  
> 
> But it is unclear why and how cache-daemon benefits from this change.
> That needs to be justified.

I suspect it doesn't need touched, because it is internal to git-daemon.
But it does handle CRLF for some lines, because the first patch
modified credential_read(), which the daemon builds on (and which _is_
user-facing via git-credential). So there's perhaps an argument that
these calls should just be made consistent, even though the only one who
would write them is our matching client. If that is the argument to be
made, I think it would make sense to do so in a separate patch, since
there's no functional change.

(I'm also slightly puzzled that anybody on Windows would care about
credential-cache, since it require unix sockets. But maybe in a world of
WSL people are actually able to mix the two. I confess I haven't kept up
with the state of things in Windows).

-Peff
