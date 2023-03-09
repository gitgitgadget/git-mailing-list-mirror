Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C5C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 06:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCIGGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCIGGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 01:06:39 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D179287D8B
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:06:37 -0800 (PST)
Received: (qmail 6231 invoked by uid 109); 9 Mar 2023 06:06:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 06:06:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28282 invoked by uid 111); 9 Mar 2023 06:06:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 01:06:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 01:06:36 -0500
From:   Jeff King <peff@peff.net>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Better suggestions when git-am(1) fails
Message-ID: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
References: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
 <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2023 at 10:17:11PM -0500, Jeff King wrote:

> On Wed, Mar 08, 2023 at 09:15:53PM +0100, Alejandro Colomar wrote:
> 
> > I had the following error already a few times, when some contributors,
> > for some reason unknown to me, remove the leading path components from
> > the patch.
> 
> The reason is probably that they have set diff.noprefix in their config,
> and git-format-patch respects that. Which is arguably a bug. There's a
> little discussion in this message, along with references to some
> previous discussions:
> 
>   https://lore.kernel.org/git/ZAWnDUkgO5clf6qu@coredump.intra.peff.net/

So here's a patch series which I think should help with the sending
side. Most of it is just filling in gaps in the code and tests for
current features. Patch 4 is the actual change. Patch 5 adds an
equivalent option just for format-patch. I'm not convinced anybody
really wants it (which is why I split it out), but it's probably worth
doing just in case.

  [1/5]: diff: factor out src/dst prefix setup
  [2/5]: t4013: add tests for diff prefix options
  [3/5]: diff: add --default-prefix option
  [4/5]: format-patch: do not respect diff.noprefix
  [5/5]: format-patch: add format.noprefix option

 Documentation/config/format.txt |  7 ++++++
 Documentation/diff-options.txt  |  5 ++++
 builtin/log.c                   | 17 +++++++++++++
 diff.c                          | 33 ++++++++++++++++++++++----
 diff.h                          |  2 ++
 t/t4013-diff-various.sh         | 42 +++++++++++++++++++++++++++++++++
 t/t4014-format-patch.sh         | 16 +++++++++++++
 7 files changed, 117 insertions(+), 5 deletions(-)

-Peff
