Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B984C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F02F23AFE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 21:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgLHVQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 16:16:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:56942 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbgLHVQf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 16:16:35 -0500
Received: (qmail 15129 invoked by uid 109); 8 Dec 2020 21:15:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Dec 2020 21:15:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5212 invoked by uid 111); 8 Dec 2020 21:15:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Dec 2020 16:15:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Dec 2020 16:15:54 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Cloning empty repository uses locally configured default branch
 name
Message-ID: <X8/tCgWcJXHW7VRZ@coredump.intra.peff.net>
References: <X8+iu/0nPfd0lrSn@coredump.intra.peff.net>
 <20201208200649.998740-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208200649.998740-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 08, 2020 at 12:06:49PM -0800, Jonathan Tan wrote:

> > I would worry how clients handle this bogus entry in the ref
> > advertisement. It looks like the actual Git client is OK, but what about
> > jgit, libgit2, etc? That's not necessarily a deal-breaker, but it would
> > be nice to know how they react.
> 
> That bogus entry is defined in the protocol and JGit both produces and
> consumes that line. Consumption was verified by patching Git with my
> patch and running the following commands in separate terminals:

Ah, indeed.

I forgot that we went through all of this a few years ago for your
eb398797cd (connect: advertized capability is not a ref, 2016-09-09). I
stand behind the "it was probably originally an error in the protocol
documentation" from [1], but at this point I think we can say it's a
supported part of the protocol.

All of this is moot, of course, if we only do the v2 solution. :)

-Peff

[1] https://lore.kernel.org/git/20160902233547.mzgluioc7hhabalw@sigill.intra.peff.net/
