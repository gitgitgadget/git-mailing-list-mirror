Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79984C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147E2218AC
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391291AbgJOS64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 14:58:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:33302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391288AbgJOS6z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 14:58:55 -0400
Received: (qmail 23971 invoked by uid 109); 15 Oct 2020 18:58:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 18:58:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31928 invoked by uid 111); 15 Oct 2020 18:58:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 14:58:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 14:58:53 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
Message-ID: <20201015185853.GA1108210@coredump.intra.peff.net>
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
 <20201015012636.GA387901@coredump.intra.peff.net>
 <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
 <20201015153849.GA551964@coredump.intra.peff.net>
 <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
 <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
 <f3e4f7ccc36dc214201c1838acce4aff@sebres.de>
 <xmqqo8l3fibz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8l3fibz.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 11:35:28AM -0700, Junio C Hamano wrote:

> "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de> writes:
> 
> > May be this is a sign to introduce real issue tracker finally? :)
> > No offence, but I was always wondering how a team is able to hold all
> > the issue related stuff in form
> > of a mailing list, without to experience such an "embarrassments".
> > Especially on such large projects and communities.
> 
> I do not know if an issue-tracker would have helped, though.  The
> issue was discovered and discussed there the day before:
> 
>   https://lore.kernel.org/git/xmqqimg5o5fq.fsf@gitster.c.googlers.com/

Doh, and I was so proud of myself for diagnosing and fixing it. ;)

I hadn't read either of the threads you linked before today (I found
them in my "catch up on list reading" queue, though likely I would have
declared bankruptcy before reading them anyway).

At least that explains my surprise that the issue was not reported
earlier. It was. :)

IMHO an issue tracker wouldn't really change things here. The original
can be found in the first page of results of:

  https://lore.kernel.org/git/?q=fast-import+leak

(though if you add "-cooking -announce" there is even less noise). I
don't know that searching an issue tracker would do much better.

> By the way, now I know why it looked familiar---the fix largely was
> my code.  And the diff between Brian's from June and Peff's in this
> thread is indeed quite small (shown below), which actually worries
> me.  Was there something in the old attempt that was incomplete that
> made us wait for the final finishing touches?  If so, is the current
> round missing the same thing?  Or perhaps the test was what was
> missing in the old attempt, in which case it's perfect (in the
> attached diff, I excluded t/ directroy as the old fix didn't have
> tests).

Looking over the thread, I don't see any problems pointed out (though
as your diff below shows, the original patch missed the re-ordering
required for the submodule mapping call).

So I'd prefer my patch because of that fix and because of the tests.

-Peff
