Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054621F453
	for <e@80x24.org>; Wed, 19 Sep 2018 19:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeITAk2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 20:40:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:53444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727675AbeITAk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 20:40:28 -0400
Received: (qmail 8698 invoked by uid 109); 19 Sep 2018 19:01:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Sep 2018 19:01:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20422 invoked by uid 111); 19 Sep 2018 19:01:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Sep 2018 15:01:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2018 15:01:10 -0400
Date:   Wed, 19 Sep 2018 15:01:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reflog expire: add progress output
Message-ID: <20180919190110.GA14552@sigill.intra.peff.net>
References: <20180919141016.27930-1-avarab@gmail.com>
 <CACsJy8CX8xspbsW7Ta3aOD6LHh55ZaJ0tdrYeWDP_Vyw70NXtA@mail.gmail.com>
 <87tvmljtaz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvmljtaz.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 07:22:44PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Do we have --quiet option or something that needs to completely
> > suppress this progress thing?
> 
> Yes. I also see my commit graph process patches sitting in "next" broke
> the "git gc --quiet" mode, and I'll need to submit something on top
> (which'll be easy), and submit a v2 on this (pending further
> comments...).
> 
> Is there a better way to test that (fake up the file descriptor check)
> in the tests other than adding getenv("GIT_TEST...") to the progress.c
> logic?

The progress code doesn't do the isatty() check at all. The caller has
to do it (and ideally would respect --progress/--no-progress to
override, along with having --quiet imply --no-progress if such an
option exists).

Once you have all that, then you can test --progress explicitly. If you
want to check the isatty() handling, you can use test_terminal().

-Peff
