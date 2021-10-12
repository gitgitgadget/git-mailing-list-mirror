Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F254DC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0736023F
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbhJLUrt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:47:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:38014 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233748AbhJLUrs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 16:47:48 -0400
Received: (qmail 1617 invoked by uid 109); 12 Oct 2021 20:45:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 20:45:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16409 invoked by uid 111); 12 Oct 2021 20:45:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Oct 2021 16:45:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Oct 2021 16:45:45 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Waite <alex@waite.eu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
Message-ID: <YWXz+eFDxElPbZUF@coredump.intra.peff.net>
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g>
 <2883c3a9-a44f-4b24-acac-5ed573319d27@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2883c3a9-a44f-4b24-acac-5ed573319d27@www.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 08:00:55PM +0200, Alex Waite wrote:

> From a user perspective, a URL containing an underscore in the
> hostname works for everything else (including all other git
> operations), but not with pattern matching. It took me a couple hours
> to figure out /why/, as GIT_TRACE does not provide debugging for how
> git config rules do (or don't) match patterns.

One thing I noticed here: url_normalize() does complain about parsing
this URL, but we don't propagate its error message to stderr. Perhaps we
should do so with warning(), but I'm a bit afraid that we may be relying
on this code to silently ignore invalid urls (i.e., showing the error
would cause some other innocuous cases to start issuing noisy and
useless warnings).

-Peff
