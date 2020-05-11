Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD410C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 15:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A850E206DB
	for <git@archiver.kernel.org>; Mon, 11 May 2020 15:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgEKPm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 11:42:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:43406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726934AbgEKPm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 11:42:27 -0400
Received: (qmail 7286 invoked by uid 109); 11 May 2020 15:42:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 May 2020 15:42:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17754 invoked by uid 111); 11 May 2020 15:42:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 May 2020 11:42:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 May 2020 11:42:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     George Brown <321.george@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] contrib/git-jump: cat output when not a terminal
Message-ID: <20200511154226.GC1415@coredump.intra.peff.net>
References: <xmqqd07cvl9b.fsf@gitster.c.googlers.com>
 <CAFKec1Wj_uK-moVfin3XrTEmmBaAzaJKsh1f8q-3+RBs2-3Jdg@mail.gmail.com>
 <xmqq8si0vfp3.fsf@gitster.c.googlers.com>
 <CAFKec1UGKbaV7wC78i8+uSEizjGkj2bDSfOeucvJORhORvc5KA@mail.gmail.com>
 <xmqqwo5ju47t.fsf@gitster.c.googlers.com>
 <CAFKec1Wy1iT8Z=gNDBn++XLxzGWr0UUiu3AKMU-qaR+jj2yoKQ@mail.gmail.com>
 <xmqqo8qvu0ao.fsf@gitster.c.googlers.com>
 <CAFKec1VGzpxVJV4zak46r_p2gGcw4UanFr7U4U4MSsG7t2A23w@mail.gmail.com>
 <20200511143157.GA1415@coredump.intra.peff.net>
 <xmqqr1vqscuy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1vqscuy.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 11, 2020 at 08:36:05AM -0700, Junio C Hamano wrote:

> > So I'm OK to leave the status quo and let people use the GIT_EDITOR
> > solution in this instance. But I'd also be happy to take a patch for
> > "--no-editor" or similar if somebody wants to work it up.
> 
> I actually would support --no-editor.  One thing nobody noticed so
> far is that "git-jump" is only compatible with editors that support
> the "-q" option from the command line, and "cat" is not among them.

Oh, good point. GIT_EDITOR='cat -- 2>/dev/null' works, but is rather
obscure. :)

> Another thing I was thinking about was a change like the attached.
> Plugging it thru "git var" to allow "git var GIT_JUMP_EDITOR" may
> allow vim users to set it to 'cat' while setting GIT_EDITOR to vim.

I wouldn't use it myself, but I don't have any objection to adding
support.

>  cache.h  |  2 +-
>  editor.c | 33 ++++++++++++++++++++++-----------

You'd presumably need to make git-var understand that GIT_JUMP_EDITOR
should fall back to GIT_EDITOR.

-Peff
