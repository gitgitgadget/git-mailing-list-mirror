Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBA7C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F60061208
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhECUao (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:30:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:43464 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhECUan (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:30:43 -0400
Received: (qmail 7435 invoked by uid 109); 3 May 2021 20:29:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 20:29:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7204 invoked by uid 111); 3 May 2021 20:29:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 16:29:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 16:29:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] t7415: remove out-dated comment about translation
Message-ID: <YJBdPXkogxeERdi8@coredump.intra.peff.net>
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
 <YI12n+1rbedpwyfW@coredump.intra.peff.net>
 <874kfkxhxe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kfkxhxe.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03, 2021 at 11:46:52AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Since GETTEXT_POISON does not exist anymore, there is no point warning
> > people about whether we should use test_i18ngrep. This is doubly
> > confusing because the comment was describing why it was OK to use grep,
> > but it got caught up in the mass conversion of 674ba34038 (fsck: mark
> > strings for translation, 2018-11-10).
> >
> > Note there are other uses of test_i18ngrep in this script which are now
> > obsolete; I'll save those for a mass-cleanup. My goal here was just to
> > fix the confusing comment in code I'm about to refactor.
> 
> For what it's worth between [1] and [2] I'm not sure what to do about
> the test_i18ngrep cleanup. I think your patch below is fine, but the
> "test_i18ngrep" has mutated into a "grep with debugging", not just
> something needed for GETTEXT_POISON.

Yes, I can see some value in that. Though if that's what it's going to
be, IMHO we should use it consistently and give a better name (test_grep
or something).

> So that part of your patch right now is making it less friendly for
> debugging. I don't care, and think if we want that we'd be better of
> scraping the trace ouput for such common cases and/or use "verbose grep
> [...]" and teach the "verbose" wrapper about these common cases, but
> knowing of that objection + having other outstanding things has been why
> I haven't sent s/test_i18ngrep/grep/g patches.

I was the one who introduced "verbose" long ago, and I did have dreams
that people would do "verbose grep" everywhere. But in the end, we made
"-x" a lot nicer to use, and I think that largely obsoletes it. Using
"verbose" makes the non-x verbose output slightly nicer, perhaps. But
not having to remember to sprinkle "verbose" through the test code (nor
read it) seems like a bigger win to me.

For the same reason, I'm pretty ambivalent about having test_grep. I
suppose one could make a similar argument about "test_path_is_missing",
etc, though some of those helpers are also encapsulating technique
(e.g., test_dir_is_empty).

-Peff
