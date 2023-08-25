Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B6C3DA6F
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 20:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjHYUip (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjHYUiX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 16:38:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C7E2682
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 13:38:21 -0700 (PDT)
Received: (qmail 26748 invoked by uid 109); 25 Aug 2023 20:38:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Aug 2023 20:38:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1843 invoked by uid 111); 25 Aug 2023 20:38:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Aug 2023 16:38:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Aug 2023 16:38:19 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] leak tests: mark a handful of tests as leak-free
Message-ID: <20230825203819.GC2382334@coredump.intra.peff.net>
References: <cover.1692902414.git.me@ttaylorr.com>
 <b1711c4c817f95011bc477a9485c115b4926c7da.1692902414.git.me@ttaylorr.com>
 <20230824210238.GA940724@coredump.intra.peff.net>
 <ZOj7XqRSmIFxaI3P@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZOj7XqRSmIFxaI3P@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2023 at 03:05:02PM -0400, Taylor Blau wrote:

> > The one in t5571, I mentioned earlier that I bisected to 861c56f6f9
> > (branch: fix a leak in setup_tracking, 2023-06-11).
> >
> > The one in t7516 seems to have been fixed by 866b43e644
> > (do_read_index(): always mark index as initialized unless erroring out,
> > 2023-06-29).
> >
> > I found both by bisecting between v2.39.0 (which shows the leak) and
> > v2.42.0 (which doesn't).
> 
> Much appreciated. I'm happy to fold those details into a new round if
> you think they are useful enough to live in the commit history. I could
> grab your patch as a preparatory step, too. But if you are happy with
> this as-is, I am too.

I would definitely mention them if writing the commit message from
scratch. I'm not sure if it is worth a re-roll or not.

I do think we should apply the racy-thread log fix, though. I thought we
had discussed it at the time, but there doesn't seem to be anything in
the archive. And I was willing to let it go as a weird one-off at the
time, but now that it wasted another 30 minutes of my life discovering
the problem again, I'm in favor of applying it.

Whether it happens as part of your re-rolled series, or is applied
separately, I am OK either way. :)

-Peff
