Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C898BC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31F22071E
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 17:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfK0RmV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:42:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:34184 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726510AbfK0RmU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 12:42:20 -0500
Received: (qmail 12983 invoked by uid 109); 27 Nov 2019 17:42:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Nov 2019 17:42:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11926 invoked by uid 111); 27 Nov 2019 17:46:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Nov 2019 12:46:23 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Nov 2019 12:42:19 -0500
From:   Jeff King <peff@peff.net>
To:     ryenus <ryenus@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: No tab completion for git version?
Message-ID: <20191127174219.GA12023@sigill.intra.peff.net>
References: <CAKkAvaywyh2bY4tHX2XvugM9V8NBUfG-hM_TyK-Ob7Pzm+6xBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKkAvaywyh2bY4tHX2XvugM9V8NBUfG-hM_TyK-Ob7Pzm+6xBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 06:19:27PM +0800, ryenus wrote:

> Tab completion works for `git --version`, but not `git version`.
> Of course, it would work with a custom executable script git-version on PATH.
> 
> Interestingly, it works even if the git-version script is an empty file.

It's because git-version isn't mentioned in "git help -a", from which we
generate the completion list. That comes from command-list.h, which in
turn is generated from command-list.txt, which doesn't mention
git-version as a command. And we can't add it there until it has a
manpage (since we pull the oneline description from the synopsis).

It might not be a bad thing to have a manpage. For example, the
--build-options is undocumented.

cmd_version() is also weirdly in help.c, not builtin/help.c, which might
be worth fixing.

-Peff
