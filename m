Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB7C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7071613BE
	for <git@archiver.kernel.org>; Wed,  5 May 2021 13:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhEENpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 09:45:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:45284 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhEENpH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 09:45:07 -0400
Received: (qmail 18345 invoked by uid 109); 5 May 2021 13:44:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 May 2021 13:44:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9569 invoked by uid 111); 5 May 2021 13:44:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 May 2021 09:44:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 5 May 2021 09:44:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] streaming.c: remove {open,close,read}_method_decl()
 macros
Message-ID: <YJKhKdWlzVjHTKjl@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
 <patch-3.5-06961ee52bb-20210505T122816Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.5-06961ee52bb-20210505T122816Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 05, 2021 at 02:33:30PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Remove the {open,close,read}_method_decl() macros added in
> 46bf043807c (streaming: a new API to read from the object store,
> 2011-05-11) in favor of inlining the definition of the arguments of
> these functions.
> 
> Since we'll end up using them via the "{open,close,read}_istream_fn"
> types we don't gain anything in the way of compiler checking by using
> these macros, and as of preceding commits we no longer need to declare
> these argument lists twice. So declaring them at a distance just
> serves to make the code less readable.

Heh. I have a very similar patch pending. In addition to readability, my
reasons there are:

  - you can't find the functions with ctags, etc, when they're hidden
    behind macros

  - you can't annotate the function interfaces to avoid
    -Wunused-parameter warnings. :)

So I am very much in favor of this (and patch 1 is nice here, too,
because it skips an extra time you'd have to repeat the interface in the
forward declaration).

-Peff
