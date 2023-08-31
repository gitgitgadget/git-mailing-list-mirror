Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E5EC83F2B
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 07:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjHaHWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjHaHWW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 03:22:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE5BCD8
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 00:22:17 -0700 (PDT)
Received: (qmail 21412 invoked by uid 109); 31 Aug 2023 07:22:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 07:22:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3578 invoked by uid 111); 31 Aug 2023 07:22:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 03:22:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 03:22:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/8] merge: make xopts a strvec
Message-ID: <20230831072216.GA3197833@coredump.intra.peff.net>
References: <20230831070935.GA3197495@coredump.intra.peff.net>
 <20230831071230.GA3197647@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831071230.GA3197647@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 31, 2023 at 03:12:30AM -0400, Jeff King wrote:

> The "xopts" variable uses a custom array with ALLOC_GROW(). Using a
> strvec simplifies things a bit. We need fewer variables, and we can also
> ditch our custom parseopt callback in favor of OPT_STRVEC().
> 
> As a bonus, this means that "--no-strategy-option", which was previously
> a silent noop, now does something useful: like other list-like options,
> it will clear the list of -X options seen so far.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I guess you could argue this is a backwards-incompatible change, but the
> existing behavior of --no-strategy-option is so dumb that I can't
> believe somebody would prefer it (plus revert/cherry-pick already use
> OPT_STRVEC for their matching "-X").
> 
> I didn't bother adding a test since we're just re-using OPT_STRVEC code
> that is used elsewhere.

I only noticed the "revert/cherry-pick" thing while sending this patch
out. But it seems that it was changed recently-ish, and Phillip noted
the same behavior change there (along with mentioning merge.c). So now I
doubly feel this is the right thing to do. :)

-Peff
