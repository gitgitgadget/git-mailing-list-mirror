Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B1CC388F9
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19EE24671
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 00:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgKQA2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:28:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:59868 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKQA2k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 19:28:40 -0500
Received: (qmail 12636 invoked by uid 109); 17 Nov 2020 00:28:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Nov 2020 00:28:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20640 invoked by uid 111); 17 Nov 2020 00:28:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Nov 2020 19:28:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Nov 2020 19:28:39 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: release refname after use
Message-ID: <20201117002839.GB13516@coredump.intra.peff.net>
References: <7692d2f3-0a3b-91cd-c454-9725b0a395a7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7692d2f3-0a3b-91cd-c454-9725b0a395a7@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 14, 2020 at 11:01:04PM +0100, René Scharfe wrote:

> parse_treeish_arg() uses dwim_ref() to set refname to a strdup'd string.
> Release it after use.  Also remove the const qualifier from the refname
> member to signify that ownership of the string is handed to the struct,
> leaving cleanup duty with the caller of parse_treeish_arg(), thus
> avoiding a cast.

Yeah, I looked at the surrounding code and agree that this is the right
thing to do.

I wondered if it might make  sense for the initialization and clearing
of this "archive_args" structure to go in a pair of matched functions,
but it probably isn't worth the trouble. write_archive() is the only
place where we will allocate and deallocate such a struct (the only
reason it is a type at all is to pass the set of values around the
stack).

-Peff
