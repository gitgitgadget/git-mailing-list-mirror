Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BC11F404
	for <e@80x24.org>; Mon, 10 Sep 2018 13:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeIJSbQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 14:31:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:44734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727970AbeIJSbP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 14:31:15 -0400
Received: (qmail 5828 invoked by uid 109); 10 Sep 2018 13:37:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Sep 2018 13:37:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7215 invoked by uid 111); 10 Sep 2018 13:37:20 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 10 Sep 2018 09:37:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2018 09:37:04 -0400
Date:   Mon, 10 Sep 2018 09:37:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 17/21] range-diff: populate the man page
Message-ID: <20180910133704.GC5233@sigill.intra.peff.net>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
 <pull.1.v6.git.gitgitgadget@gmail.com>
 <8c5543a0667fffe0cb0684427f726fdfb75b28d0.1534159977.git.gitgitgadget@gmail.com>
 <87lg8a7wj2.fsf@evledraar.gmail.com>
 <20180909165431.GA17224@localhost>
 <87k1nu7fm0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1nu7fm0.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 09, 2018 at 07:19:51PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> And then I turn that into:
> >>
> >>     # @{u} because I happen to be on 'master' and it's shorter to type
> >>     # than origin/master...
> >>     git range-diff @{u} 38b5f0fe72...718fbdedbc
> >
> > I don't understand what you want with that @{u} or 'origin/master' in
> > the first place.  It's unnecessary, the three-dot notation on its own
> > works just fine.
> 
> Maybe I've been using the wrong mode all along, I passed over by habits
> from tbdiff, which were surely copy/pasted from somewhere.
> 
> Looking at the git-range-diff manpage though it recommends <base> <rev1>
> <rev2> over <rev1>...<rev2> when the topic has been rebased, which is
> usually the case for e.g. a topic that's submitted to git.git (usually
> be the time feedback has been gathered & a re-submission has been made
> Junio has pushed another "master").
> 
> So isn't "<base> <rev1> <rev2>" the right thing to use over
> "<rev1>...<rev2>" for git.git use? I think so, but I'm not sure.

The problem with <rev1>...<rev2> is that it finds the actual merge base,
not the beginning of the topic. So if you have a 5-patch topic, but the
first two patches weren't changed in the rebase, it won't show them at
all!  I made this mistake in [1], for example.

For a force-push, though, you may not care about seeing the topic as a
whole, and that mid-topic merge-base could be just fine. So pasting just
the "A...B" works.

I don't think your "@{u} A...B" makes any sense. You're giving _two_
bases, which is weird. But even if you wanted to ignore the "..." base
as a convenience to users of fetch, @{u} does not necessarily have
anything to do with the @{upstream} of the topic at "A". You really want
branch@{u}, which is on a separate part of the fetch output line (and
your branch@{u} and the remote's are not necessarily the same, either;
in this case you probably do not even have that branch checked out).

-Peff

[1] https://public-inbox.org/git/20180821195102.GB859@sigill.intra.peff.net/
