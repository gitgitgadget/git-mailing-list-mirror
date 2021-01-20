Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBEEC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 00:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4410E23109
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 00:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbhATAJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 19:09:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:60614 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730810AbhATAJe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 19:09:34 -0500
Received: (qmail 16338 invoked by uid 109); 20 Jan 2021 00:08:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Jan 2021 00:08:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14853 invoked by uid 111); 20 Jan 2021 00:08:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Jan 2021 19:08:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Jan 2021 19:08:51 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@gitlab.com
Subject: Re: [PATCH 2/2] ls-refs.c: traverse longest common ref prefix
Message-ID: <YAd0kyBP8LRSEBYw@coredump.intra.peff.net>
References: <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
 <cover.1611080326.git.me@ttaylorr.com>
 <fb8681d12864d724108c524834f9498d91e270e6.1611080326.git.me@ttaylorr.com>
 <YAdmtgUPiGUaXiRX@coredump.intra.peff.net>
 <YAdwvzQCGc5TfXTF@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAdwvzQCGc5TfXTF@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 06:52:31PM -0500, Taylor Blau wrote:

> > I guess they require an explicit '*', but fundamentally it's the same
> > concept (and certainly they are not just single references).
> 
> Yeah, that is the point that I was trying to make. But re-reading this
> patch after knowing that it confused you, I think the clearest way to
> make that point is to drop that second paragraph entirely.

Sounds good.

> > Based on my other poking, I'm not entirely sure that we can return too
> > many results. But I do think it's worth keeping the caller more careful.
> 
> It can return more results, but I don't think that my writing in
> b31e2680c4 is particularly clear. Here's an example, though. Say I ask
> for `git for-each-refs 'refs/tags/a/*' 'refs/tags/a/b/c'`. The LCP of
> that is definitely "refs/tags/a", which might traverse other stuff like
> "refs/tags/a/b/d", which wouldn't get matched by either.

I thought that would be matched by refs/tags/a/*, but it looks like
for-each-ref treats "*" as matching only a single path component. So
really just:

  git for-each-ref refs/tags/*

requires extra filtering already. But AFAICT none of that is true for
ls-refs, which is strictly prefix matching already.

-Peff
