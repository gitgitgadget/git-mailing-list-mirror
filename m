Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733B7C35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A09222C2
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgBNGRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:17:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:43164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725893AbgBNGRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 01:17:16 -0500
Received: (qmail 19146 invoked by uid 109); 14 Feb 2020 06:17:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 06:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19234 invoked by uid 111); 14 Feb 2020 06:26:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 01:26:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 01:17:14 -0500
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to force configure script to use curl ?
Message-ID: <20200214061714.GA605125@coredump.intra.peff.net>
References: <A0910AA2-D24B-4DF5-8D39-8E2D8B56955B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A0910AA2-D24B-4DF5-8D39-8E2D8B56955B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 05:08:06PM -0500, Philippe Blain wrote:

> Is there a way to force the configure script to error out if it does
> not find curl (or any one of the optional dependencies that I happen
> to need for my build?)

I don't think so. It would probably be possible for configure.ac to
behave this way. Looking at the code, I think GIT_PARSE_WITH would have
to record the affirmative for "--with" instead of just canceling a
previous "--without", and then the part that does curl auto-detection
would need to complain if it doesn't find curl at that point.

But our use of autoconf is not very extensive, and in fact most
developers do not use it at all. If you know you want curl, you're
better off just overriding it explicitly with the Makefile knob:

  make NO_CURL=

or:

  echo NO_CURL= >>config.mak
  make

Either of those will override the NO_CURL setting done by the configure
script (you can see the full list of knobs set by configure in
config.mak.autogen).

-Peff
