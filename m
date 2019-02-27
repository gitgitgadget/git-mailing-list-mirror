Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3838D20248
	for <e@80x24.org>; Wed, 27 Feb 2019 16:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfB0QFH (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 11:05:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:59988 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725854AbfB0QFH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 11:05:07 -0500
Received: (qmail 5275 invoked by uid 109); 27 Feb 2019 16:05:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Feb 2019 16:05:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7012 invoked by uid 111); 27 Feb 2019 16:05:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 27 Feb 2019 11:05:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Feb 2019 11:04:57 -0500
Date:   Wed, 27 Feb 2019 11:04:57 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>, hi-angel@yandex.ru,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 1/1] worktree add: sanitize worktree names
Message-ID: <20190227160457.GA30817@sigill.intra.peff.net>
References: <20190221121943.19778-1-pclouds@gmail.com>
 <20190226105851.32273-1-pclouds@gmail.com>
 <20190226105851.32273-2-pclouds@gmail.com>
 <20190227120859.GB10305@sigill.intra.peff.net>
 <CAPig+cRJZBvwsptPOzx3oPSOnt6+uGLoyOr_JbUnku4kdSwdgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRJZBvwsptPOzx3oPSOnt6+uGLoyOr_JbUnku4kdSwdgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 09:23:33AM -0500, Eric Sunshine wrote:

> > If we just cared about saying "is this worktree name valid", I'd suggest
> > actually constructing a sample refname with the worktree name embedded
> > in it and feeding that to check_refname_format(). But because you want
> > to actually sanitize, I don't think there's an easy way to reuse it.
> >
> > So this approach is probably the best we can do, though I do still think
> > it's worth renaming that function (and/or putting a big warning comment
> > in front of it).
> 
> The above arguments seem to suggest the introduction of a companion to
> check_refname_format() for sanitizing, perhaps named
> sanitize_refname_format(), in ref.[hc]. The potential difficulty with
> that is defining exactly what "sanitize" means. Will it be contextual?
> (That is, will git-worktree have differently sanitation needs than
> some other facility?) If so, perhaps a 'flags' argument could control
> how sanitization is done.

I agree that sanitize_refname_format() would be nice, but I'm pretty
sure it's going to end up having to duplicate many of the rules from
check_refname_format(). Which is ugly if the two ever get out of sync.

But if we could write it in a way that keeps the actual policy logic in
one factored-out portion, I think it would be worth doing.

-Peff
