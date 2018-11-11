Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78FEB1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 07:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeKKRLo (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 12:11:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:47714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727055AbeKKRLo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 12:11:44 -0500
Received: (qmail 1769 invoked by uid 109); 11 Nov 2018 07:23:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 11 Nov 2018 07:23:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32022 invoked by uid 111); 11 Nov 2018 07:23:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 11 Nov 2018 02:23:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2018 02:23:56 -0500
Date:   Sun, 11 Nov 2018 02:23:56 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 10/10] fast-export: add --always-show-modify-after-rename
Message-ID: <20181111072356.GJ30850@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-11-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111062312.16342-11-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:23:12PM -0800, Elijah Newren wrote:

> fast-export output is traditionally used as an input to a fast-import
> program, but it is also useful to help gather statistics about the
> history of a repository (particularly when --no-data is also passed).
> For example, two of the types of information we may want to collect
> could include:
>   1) general information about renames that have occurred
>   2) what the biggest objects in a repository are and what names
>      they appear under.
> 
> The first bit of information can be gathered by just passing -M to
> fast-export.  The second piece of information can partially be gotten
> from running
>     git cat-file --batch-check --batch-all-objects
> However, that only shows what the biggest objects in the repository are
> and their sizes, not what names those objects appear as or what commits
> they were introduced in.  We can get that information from fast-export,
> but when we only see
>     R oldname newname
> instead of
>     R oldname newname
>     M 100644 $SHA1 newname
> then it makes the job more difficult.  Add an option which allows us to
> force the latter output even when commits have exact renames of files.

fast-export seems like a funny tool to look up paths. What about "git
log --find-object=$SHA1" ?

-Peff
