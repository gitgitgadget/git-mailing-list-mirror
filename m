Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5CC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C738613D8
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhFBURa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:17:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:44458 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhFBURa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:17:30 -0400
Received: (qmail 2427 invoked by uid 109); 2 Jun 2021 20:15:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Jun 2021 20:15:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20783 invoked by uid 111); 2 Jun 2021 20:15:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Jun 2021 16:15:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Jun 2021 16:15:45 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
Message-ID: <YLfm8cqY6EjQuhcO@coredump.intra.peff.net>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local>
 <YLfgy94sbmStC0mR@coredump.intra.peff.net>
 <YLfl4jkuwSCiNrrS@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLfl4jkuwSCiNrrS@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 04:11:14PM -0400, Taylor Blau wrote:

> Subject: [PATCH] compat: introduce git_fsync_with_restart()
> 
> Some platforms, like NonStop do not automatically restart fsync() when
> interrupted by a signal, even when that signal is setup with SA_RESTART.
> 
> This can lead to test breakage, e.g., where "--progress" is used, thus
> SIGALRM is sent often, and can interrupt an fsync() syscall.
> 
> Add a Makefile knob FSYNC_NEEDS_RESTART to replace fsync() with one that
> gracefully handles getting EINTR.
> 
> Reported-by: Randall S. Becker <randall.becker@nexbridge.ca>
> Signed-off-by: Jeff King <peff@peff.net>

Probably Helped-by might be more appropriate. But regardless, I
definitely give my S-o-B for anything I contributed.

>  Makefile          |  8 ++++++++
>  compat/fsync.c    | 10 ++++++++++
>  git-compat-util.h |  6 ++++++
>  3 files changed, 24 insertions(+)
>  create mode 100644 compat/fsync.c

This looks as I'd expect. But after seeing Eric's response, we perhaps
want to do away with the knob entirely.

-Peff
