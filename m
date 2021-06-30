Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69CC11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09CF61D62
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhF3CS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 22:18:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:36970 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232101AbhF3CSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 22:18:55 -0400
Received: (qmail 22224 invoked by uid 109); 30 Jun 2021 02:16:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 02:16:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1076 invoked by uid 111); 30 Jun 2021 02:16:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jun 2021 22:16:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Jun 2021 22:16:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Antw: [EXT] Re: git add --interactive patch improvement for
 split hunks
Message-ID: <YNvT+tUlW98dQY3B@coredump.intra.peff.net>
References: <60D45FE4020000A100041FCE@gwsmtp.uni-regensburg.de>
 <YNSnlhbE30xDfVMY@coredump.intra.peff.net>
 <60D9A01C020000A100042099@gwsmtp.uni-regensburg.de>
 <87eecmgrnx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eecmgrnx.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 01:20:46PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > There always was a related bug (IMHO) that showed the context of the
> > previous function even though the actual change was within a new
> > function (that starts within the context lines). So if that bug were
> > fixed, my guess is that the other would be as well.
> > However I don't know how easy or hard the fix will be.
> > Maybe the "definition" of function context is just different; I don't really know.
> 
> Does that bug perhaps have anything to do with:
> https://lore.kernel.org/git/20210215155020.2804-2-avarab@gmail.com/

I think it's similar. The issue is that we search backwards for a
funcname match from the top of the hunk, _not_ from the first changed
line. IIRC, that has been discussed before and considered "not a bug",
but I could be mis-remembering (and it's a tricky thing to search in the
archive for[0]).

The problem with split hunks is different, though; we do not search for
a funcname line at all on the second half of the hunk.

-Peff

[0] I did come up with:

      https://lore.kernel.org/git/1399824596-4670-1-git-send-email-avarab@gmail.com/

    which has discussion between you and me on this very same splitting
    topic back in 2014! Double-curious, your patch there implements the
    same "keep the hunk header on split" we've been discussing here, and
    we were all positive on it. Yet it doesn't seem to have ever gotten
    applied.

    It looks like Junio carried it in "What's Cooking" for almost a
    year, marked as "waiting for re-roll" to handle the squash, but then
    eventually discarded it as stale. :(
