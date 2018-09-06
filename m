Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECF61F404
	for <e@80x24.org>; Thu,  6 Sep 2018 19:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbeIFXmD (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 19:42:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:41562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728826AbeIFXmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 19:42:03 -0400
Received: (qmail 25889 invoked by uid 109); 6 Sep 2018 19:05:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 19:05:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6595 invoked by uid 111); 6 Sep 2018 19:05:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 15:05:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 15:05:12 -0400
Date:   Thu, 6 Sep 2018 15:05:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Tim Schumacher <timschumi@gmx.de>, git@vger.kernel.org,
        pclouds@gmail.com
Subject: Re: [PATCH v3] Allow aliases that include other aliases
Message-ID: <20180906190511.GA23884@sigill.intra.peff.net>
References: <20180905085427.4099-1-timschumi@gmx.de>
 <20180906101658.1865-1-timschumi@gmx.de>
 <20180906145942.GB1209@sigill.intra.peff.net>
 <xmqqy3cezcz5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy3cezcz5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 11:40:14AM -0700, Junio C Hamano wrote:

> Also, normal users who have never seen this loop that implements
> alias expansion would not have a clue when they see "called twice".
> 
> I actually think the caller should also pass cmd to run_argv() and
> then we should use it (and not argv[]) in this die() message.  When
> the original command was foo that is aliased to bar, which in turn
> is aliased to baz, which in turn is aliased to bar, especially that
> "git foo" invocation was in a random script written six weeks ago by
> the user, it would be a lot more helpful to see 
> 
>     "alias loop detected: expansion of 'git foo' does not terminate"
> 
> than
> 
>     "loop alias: bar is called twice".
> 
> given that 'bar' is not something the user called, or written in the
> script she wrote six weeks ago.

Good point. I think Ævar's "print the whole list" solves that, because
items[0] is that first element. But I agree the fundamental message
should be "loop in 'git foo'".

-Peff
