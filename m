Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B776C1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfG2UQM (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:16:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:54666 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726905AbfG2UQL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:16:11 -0400
Received: (qmail 28277 invoked by uid 109); 29 Jul 2019 20:16:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Jul 2019 20:16:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 597 invoked by uid 111); 29 Jul 2019 20:17:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2019 16:17:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 29 Jul 2019 16:16:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     ardi <ardillasdelmonte@gmail.com>, git@vger.kernel.org
Subject: Re: Settings for minimizing repacking (and keeping 'rsync' happy)
Message-ID: <20190729201610.GG14943@sigill.intra.peff.net>
References: <CA+fZqCXBjA5jsYg7L7X1VhJZXrp9NP+dR1SQWK9fAf9b1jgpCg@mail.gmail.com>
 <20190729094229.GA2415@sigill.intra.peff.net>
 <87tvb55799.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvb55799.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 02:56:34PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The thread I started at
> https://public-inbox.org/git/87bmhiykvw.fsf@evledraar.gmail.com/ should
> also be of interest. I.e. we could have some knobs to create more
> "stable" packs, I know rsync does some in-file hashing, but I don't
> if/how that works if you have 1 file split into N where some chunks in
> the N are in the one file.
> 
> But it's possible to imagine a repacking algorithm that would keep
> producing entirely new packs but arrange for it to be ordered/delta'd in
> such a way that it optimizes for page-by-page similarity to an older
> pack to some degree.

I actually think that's the part that rsync does well. We don't keep
page-by-page similarity, but rsync (and other tools like borg) are
really good at finding the moved chunks. The problem is just that it
doesn't know to compare chunks between two files with unrelated names.

-Peff
