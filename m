Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A6BC54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 18:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiIHSPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 14:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiIHSPj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 14:15:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F075F7D5
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 11:15:35 -0700 (PDT)
Received: (qmail 28243 invoked by uid 109); 8 Sep 2022 18:15:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 18:15:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23318 invoked by uid 111); 8 Sep 2022 18:15:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 14:15:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 14:15:34 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: LSan curiosity in t1300
Message-ID: <YxoxRus2NjsYmM63@coredump.intra.peff.net>
References: <Yxl91jfycCo7O7Pp@coredump.intra.peff.net>
 <xmqq8rmtrbfq.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rmtrbfq.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2022 at 11:03:05AM -0700, Junio C Hamano wrote:

> > But if you run this in a debugger, you'll find that under -O2 the "key"
> > variable has been optimized out! So LSan is producing the wrong result
> > due to the optimization. It doesn't know that "key" is conceptually
> > still reachable.
> 
> Yikes.  
> 
> Is that related to the cause of the other patch from you, i.e.
> wanting to get "registers" but unable to?  If they manage to get the
> value of the register that holds 'key', would this disappear, I
> wonder?

I don't think so. t1300 fails consistently for me with -O2, and it
doesn't have the "register" message (and never came up as one of the
racy losers). I think the "register" thing is mostly just a harmless
warning that doesn't change the output, but simply confuses our "did
lsan produce any logs" check.

-Peff
