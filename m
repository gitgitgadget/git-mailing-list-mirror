Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FC5C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE910221E9
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 19:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbhANT5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 14:57:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:56396 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbhANT5x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 14:57:53 -0500
Received: (qmail 17519 invoked by uid 109); 14 Jan 2021 19:57:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Jan 2021 19:57:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17519 invoked by uid 111); 14 Jan 2021 19:57:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Jan 2021 14:57:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Jan 2021 14:57:12 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev'
 files
Message-ID: <YACiGJO+kqz2yleZ@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
 <xmqqwnwgx9rm.fsf@gitster.c.googlers.com>
 <10326ece-f433-4793-336e-a30786bf1f2f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10326ece-f433-4793-336e-a30786bf1f2f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 07:07:08AM -0500, Derrick Stolee wrote:

> >> + * If a '.rev' file is present, it is checked for consistency, mmap'd, and
> >> + * pointers are assigned into it (instead of using the in-memory variant).
> > 
> > Hmph, I missed where it got checked for consistency, though.  If the
> > file is corrupt and has say duplicated entries, we'd happily grab
> > the data via get_be32(), for example.
> 
> Even if the consistency check is just verifying the trailing hash, that
> seems like something that requires O(N) before performing a lookup. Perhaps
> this was copied from somewhere else, or means something different?

For the .idx file, we check that the size is what we expect. This is
important because it lets us access the mapped bytes in normal use
without having to do a bounds check.

It looks like we do the same for the .rev file here, which is good.  If
calling that "checked for consistency" is too strong, I don't think it's
a big deal to drop the wording (we do not make any such claim for
open_pack_index()).

-Peff
