Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1583EC35669
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B4120656
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgBXEUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:20:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:52272 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727202AbgBXEUF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:20:05 -0500
Received: (qmail 5128 invoked by uid 109); 24 Feb 2020 04:20:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:20:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6781 invoked by uid 111); 24 Feb 2020 04:29:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:29:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:20:04 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 01/24] builtin/pack-objects: make hash agnostic
Message-ID: <20200224042004.GA731094@coredump.intra.peff.net>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
 <20200222201749.937983-2-sandals@crustytoothpaste.net>
 <20200223215759.GC564691@coredump.intra.peff.net>
 <20200224034259.GG6462@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224034259.GG6462@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 03:42:59AM +0000, brian m. carlson wrote:

> > Yeah, looks obviously correct (and I think this is new from the
> > pack-reuse patches of mine that Christian sent recently).
> 
> I believe it is, which is why I CC'd you on it.

Heh, yeah. I knew you knew, but was saying so for the rest of the
audience. :)

> > I think it would also be correct to cast the mmap'd bytes to a "struct
> > object_id" given that the struct contains the hash bytes as the first
> > member. I worry a little that we'd get no compiler warning of the
> > breakage if that assumption changes, but it also seems unlikely to do
> > so.
> 
> In the future, struct object_id will get a new member (an algorithm
> value), but I think it's fine to make the assumption that the hash bytes
> are first.

Yeah, I think that would continue to work, although weirdness would
ensue if anybody ever dereferenced the algorithm member in one of the
type-punned structs. If we can avoid it entirely, I think we should (and
it was easy to remove the spot in pack-check).

Patches incoming.

-Peff
