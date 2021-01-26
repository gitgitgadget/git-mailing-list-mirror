Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9B9C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38D22074A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 12:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhA0M0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 07:26:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:39964 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S314054AbhAZW4E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 17:56:04 -0500
Received: (qmail 27771 invoked by uid 109); 26 Jan 2021 22:55:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Jan 2021 22:55:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4995 invoked by uid 111); 26 Jan 2021 22:55:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jan 2021 17:55:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jan 2021 17:55:21 -0500
From:   Jeff King <peff@peff.net>
To:     Joshua Hudson <jhudson@cedaron.com>
Cc:     git@vger.kernel.org
Subject: Re: Null pointer dereference in error pathway on git pull
Message-ID: <YBCd2ZAumP65yrUK@coredump.intra.peff.net>
References: <1cda3398-7b02-edc5-aaab-c75191124b80@cedaron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cda3398-7b02-edc5-aaab-c75191124b80@cedaron.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 12:31:30PM -0800, Joshua Hudson wrote:

> >git pull
> remote: Azure Repos
> remote: Found 452 objects to send. (157 ms)
> Rfatal: the remote end hung up unexpectedly
> fatal: early EOFs:  81% (367/452)
> fatal: index-pack failed
> warning: unable to unlink '(NULL)': Invalid argument
> 
> 
> So it hits some kind of error (looks like network disconnect) and tries
> to back out; passed a NULL pointer to unlink().
> 
> Apologies if this has been submitted before. A search didn't find it.

Which version of Git are you using? It sounds like the same bug fixed by
6031af387e (fetch-pack: disregard invalid pack lockfiles, 2020-11-30).
That's in v2.30.0.

-Peff
