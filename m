Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40CBC433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1B6613CB
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhEEN6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 09:58:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:45340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233178AbhEEN6K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 09:58:10 -0400
Received: (qmail 18452 invoked by uid 109); 5 May 2021 13:57:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 13:57:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9743 invoked by uid 111); 5 May 2021 13:57:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 09:57:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 09:57:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] streaming.c: refactor for smaller + easier to
 understand code
Message-ID: <YJKkOLvSCSgFRs7r@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 02:33:27PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This is a prep series for my yet-to-be-sent re-roll of [1],
> aka. ab/fsck-unexpected-type.
> 
> Jeff King had a comment in [2] saying it was odd to have an "oi2"
> variable, that was because there was on an "oi" name already defined
> via the new-gone open_method_decl(loose) macro. As we'll see we could
> do without the initial "oi" and a few other types of indirection in
> this interface.
> 
> Junio: Could you eject ab/fsck-unexpected-type while this is being
> considered/cooked? I didn't really see how to address Jeff's feedback
> about that variable name in a way that wouldn't just make something
> like this refactoring part of an even bigger series. I think ejecting
> the functional changes & trying to get this in first is the least
> worst approach at this point. Eventually I'll submit a re-roll of
> ab/fsck-unexpected-type either based on this, or master (if it's
> landed already).

I think my feedback was really just: if that patch didn't refactor
parse_loose_header() to get rid of the "simple" and extended versions,
then you wouldn't have to touch streaming.c at all. It could just
continue to use the simple version.

That said, I don't mind the cleanups here, especially getting rid of the
macros.

-Peff
