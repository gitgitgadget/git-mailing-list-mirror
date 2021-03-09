Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE732C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 10:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F3F64F2D
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 10:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhCIKqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 05:46:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:56810 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhCIKqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 05:46:07 -0500
Received: (qmail 30123 invoked by uid 109); 9 Mar 2021 10:46:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Mar 2021 10:46:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9322 invoked by uid 111); 9 Mar 2021 10:46:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Mar 2021 05:46:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Mar 2021 05:46:06 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] object.c: refactor type_from_string_gently()
Message-ID: <YEdR7oAcu13F8/d5@coredump.intra.peff.net>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
 <20210308200426.21824-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308200426.21824-2-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 09:04:20PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Get rid of the "gently" argument to type_from_string_gently() to make
> it consistent with most other *_gently() functions.
> 
> This refactoring of adding a third parameter was done in
> fe8e3b71805 (Refactor type_from_string() to allow continuing after
> detecting an error, 2014-09-10) in preparation for its use in
> fsck.c.
> 
> Since then no callers of this function have passed a "len < 0" as was
> expected might happen, so we can simplify its invocation by knowing
> that it's never called like that.

This final paragraph confused me. What does "len < 0" have to do with
"gently"?

I think the answer is just that the non-gentle form never bothered to
take a "len" parameter, so you are doing both simplifications at once.
IMHO it would be easier to understand broken into two commits (but not
necessarily worth re-rolling).

-Peff
