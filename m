Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC32C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8E064D9F
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBPMze (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:55:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:33990 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhBPMzd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 07:55:33 -0500
Received: (qmail 12982 invoked by uid 109); 16 Feb 2021 12:54:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 12:54:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23636 invoked by uid 111); 16 Feb 2021 12:54:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 07:54:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 07:54:50 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Blake Burkhart <bburky@bburky.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] fsck: make symlinked .gitignore and .gitattributes a
 warning
Message-ID: <YCvAmkO8ZQnlp4m9@coredump.intra.peff.net>
References: <YCsBA002yv8XpppM@coredump.intra.peff.net>
 <YCsBRUQkrAm8l2gz@coredump.intra.peff.net>
 <87y2foaltl.fsf@evledraar.gmail.com>
 <YCsc0OePtrotjeg5@coredump.intra.peff.net>
 <xmqqtuqcsrkt.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuqcsrkt.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 05:56:50PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That said, they'd probably want to checkout those old commits, too. So
> > we probably do need a config override, even if it's a broad one ("trust
> > me, this repo is OK, just allow symlinks for these special files").
> 
> Is this about the check that is overly strict for some existing
> projects that kept the jk/symlinked-dotgitx-files topic in the
> 'seen' so far?

Yes.

> On the fsck end, we know we can demote the error level per
> repository, but I wonder if we should make checkout/clone honor the
> same setting?

What would the default be? If it's permissive, then it feels like we are
not really solving much, as anybody who wanted to be careful can already
inspect the tree contents. This is about avoiding surprises in the
default config.

If it's to forbid by default, then yes, I think the "trust me this repo
is OK" I gave above would be a viable path forward.

> I think GITMODULES_SYMLINK has been there for quite some time at
> "error" level and we do want to discourage it to be a symbolic link,
> so I am not quite sure what the demoting of these two achieves.  Why
> aren't we having a similar issue on .gitmodules that is a symbolic
> link?

I think it's just less common to have symlinked .gitmodules. To be
clear, I think symlinked .gitignore is also pretty uncommon. Back when
we discussed this originally in 2018 I scanned most of GitHub and came
up with only a handful of repositories that did so.

-Peff
