Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7A0C83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 17:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjH1RnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 13:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjH1RnD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 13:43:03 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFF3E8
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 10:43:01 -0700 (PDT)
Received: (qmail 30987 invoked by uid 109); 28 Aug 2023 17:43:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 17:43:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1532 invoked by uid 111); 28 Aug 2023 17:43:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 13:43:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 13:42:59 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/log.c: prepend "RFC" on --rfc
Message-ID: <20230828174259.GA3007263@coredump.intra.peff.net>
References: <20230828125132.25144-1-sir@cmpwn.com>
 <20230828144215.GA2537587@coredump.intra.peff.net>
 <ae22b71b-73ea-4634-bd2a-4b64082be955@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae22b71b-73ea-4634-bd2a-4b64082be955@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 05:30:36PM +0100, Phillip Wood wrote:

> I agree it sounds like a good change but if we're going to change it than I
> think we should ensure
> 
>     git format-patch --subject-prefix=foo --rfc
> 
> and
> 
>     git format-patch --rfc --subject-prefix=foo
> 
> give the same result. That would mean dropping rfc_callback() and using
> OPT_BOOL() instead of OPT_CALLBACK_F(). We could add the "RFC " prefix just
> before we add the re-roll suffix.

Good catch. That should also make the leak issue easier to solve, too,
as we'd hold the string (and free it) in the main cmd_format_patch()
function. This is exactly how the "reroll_count" feature works
currently.

-Peff
