Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA8311F42D
	for <e@80x24.org>; Thu, 24 May 2018 17:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034039AbeEXREf (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 13:04:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:51590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1034036AbeEXREd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 13:04:33 -0400
Received: (qmail 4824 invoked by uid 109); 24 May 2018 17:04:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 May 2018 17:04:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27222 invoked by uid 111); 24 May 2018 17:04:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 May 2018 13:04:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2018 13:04:30 -0400
Date:   Thu, 24 May 2018 13:04:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: No way to set fsck.<msg-id> when cloning
Message-ID: <20180524170430.GA14876@sigill.intra.peff.net>
References: <87vabd6pp2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vabd6pp2.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 05:25:29PM +0200, Ævar Arnfjörð Bjarmason wrote:

> When I do:
> 
>     git -c fetch.fsckObjects=true clone git@github.com:robbyrussell/oh-my-zsh.git
> 
> I get:
> 
>     error: object 2b7227859263b6aabcc28355b0b994995b7148b6: zeroPaddedFilemode: contains zero-padded file modes
>     fatal: Error in object
>     fatal: index-pack failed
> 
> The docs (https://git-scm.com/docs/git-config#git-config-fsckltmsg-idgt)
> say you can override this with -c fsck.zeroPaddedFilemode = ignore, but
> I see in builtin/fsck.c that just fsck_config() knows about this, and
> indeed this works *after* you clone the repo when you use 'git fsck'.
> 
> I don't have time to fix this now, but what's the best approach here?
> Make all the relevant commands copy what fsck_config() is doing, or
> should fsck_object() be lazily looking up this config by itself?

I think the relevant commands need to do it themselves. We already have
receive.fsck.*. I don't think there's an equivalent for fetching, but
there probably should be. But fsck_object() doesn't have the context to
know which set should be used.

-Peff
