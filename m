Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89576C64EC7
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 20:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjBMUx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 15:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjBMUx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 15:53:27 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC91F936
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 12:53:26 -0800 (PST)
Received: (qmail 22154 invoked by uid 109); 13 Feb 2023 20:53:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Feb 2023 20:53:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25536 invoked by uid 111); 13 Feb 2023 20:53:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Feb 2023 15:53:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Feb 2023 15:53:25 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] fetch: support hideRefs to speed up connectivity
 checks
Message-ID: <Y+qjRZTn7DNib1uB@coredump.intra.peff.net>
References: <20230209122857.M669733@dcvr>
 <20230212090426.M558990@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230212090426.M558990@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 12, 2023 at 09:04:26AM +0000, Eric Wong wrote:

>  Sidenote: I'm curious about the reason $(pwd) is used in some
>  places while $PWD seems fine in others, so it doesn't seem to be
>  a portability problem.  I chose $PWD since it's faster.

It sometimes matters; one is a Windows path (with "C:\", etc) and one is
a Unix-style path. Many spots are happy with either type, but it
sometimes bites us when doing string comparisons, or in a few specific
cases. See

  https://lore.kernel.org/git/d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org/

for an example.

-Peff
