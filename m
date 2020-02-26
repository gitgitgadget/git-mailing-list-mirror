Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B00C4BA24
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 18:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C1324672
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 18:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBZSkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:40:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:55236 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726998AbgBZSkj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 13:40:39 -0500
Received: (qmail 20964 invoked by uid 109); 26 Feb 2020 18:40:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Feb 2020 18:40:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28031 invoked by uid 111); 26 Feb 2020 18:49:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Feb 2020 13:49:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 26 Feb 2020 13:40:38 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Jerdonek <chris.jerdonek@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: create reflog for reflog-less ref
Message-ID: <20200226184038.GB23188@coredump.intra.peff.net>
References: <CAOTb1wc2uMSyc7DMau2cWrWtk=_Z94+CCovORj1dGCrwgJhL=w@mail.gmail.com>
 <20200226023909.GC7911@camp.crustytoothpaste.net>
 <20200226034731.GA2915944@coredump.intra.peff.net>
 <CAOTb1wfWtFsy415k+goRiuLUiVBqtizmmoyxqFdy7xsRhjnBww@mail.gmail.com>
 <20200226094716.GA14546@coredump.intra.peff.net>
 <CAOTb1weTWOsHkbGqmj8mJ-KpkoiteHBDYDxe-j2E0yf3DccjjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOTb1weTWOsHkbGqmj8mJ-KpkoiteHBDYDxe-j2E0yf3DccjjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 02:21:59AM -0800, Chris Jerdonek wrote:

> > The "touch" trick I showed would work for that, but it's not going to be
> > portable going forward. I don't think it would be a bad idea to have
> > some way of triggering a "noop" reflog update via update-ref, where we
> > either create the reflog as empty, or insert a pointless entry going
> > from the current sha1 to itself. But AFAIK that doesn't exist right now.
> 
> Thanks. By the way, this functionality does already seem to exist for ref HEAD:
> 
> $ git update-ref -m my-message HEAD HEAD
> $ git reflog HEAD
> 3ccacdc (HEAD -> master) HEAD@{0}: my-message
> ...
> 
> I don't know why it would work for HEAD though and what's different
> about the mechanism. I thought it might be because it's a symbolic
> ref, but it didn't work for other symbolic refs when I tried (even
> ones that already had a reflog).

I suspect that wasn't really intentional, but just a by-product of the
way we treat HEAD's reflog specially (when we update any other ref, if
HEAD points to it, we'll update the HEAD reflog, too). But I could be
wrong (you'd have to dig in the commit history around that code).

-Peff
