Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5861F453
	for <e@80x24.org>; Wed,  6 Feb 2019 18:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfBFS3x (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 13:29:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:34798 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725784AbfBFS3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 13:29:53 -0500
Received: (qmail 8812 invoked by uid 109); 6 Feb 2019 18:29:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 18:29:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4059 invoked by uid 111); 6 Feb 2019 18:30:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 13:30:01 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 13:29:51 -0500
Date:   Wed, 6 Feb 2019 13:29:51 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] core.abbrev doc: document and test the abbreviation
 length
Message-ID: <20190206182950.GB10231@sigill.intra.peff.net>
References: <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net>
 <20190204161217.20047-1-avarab@gmail.com>
 <xmqq36p3uxq2.fsf@gitster-ct.c.googlers.com>
 <20190204233235.GB2366@sigill.intra.peff.net>
 <87r2cnkta8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r2cnkta8.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 12:50:23AM +0100, Ævar Arnfjörð Bjarmason wrote:

> >> As this is pretty-much a test-only option, perhaps going longer but
> >> more descriptive would make sense?
> >>
> >> 	git rev-parse --compute-abbrev-length-for <object-count>
> >>
> >> may be an overkill, but something along those lines.
> >
> > You could even default <object-count> to the number of objects in the
> > repository. Which implies that perhaps the best spot is the command
> > where we already count the number of objects, git-count-objects.
> 
> That's documented as reporting loose objects by default, although it has
> a full report with -v.

True, though I think that's mostly for historical reasons. It _could_ be
part of the full report, like:

  $ git count-objects -v
  ...
  abbrev-len: 12

but from your test-script usage, I'd expect you'd want to be able to
feed a fake count to it, like:

  git count-objects --compute-abbrev-len=1234

or something (of course you _could_ also make a repository with N
objects, but that's a lot more expensive).

> Maybe rev-parse isn't the right place, I just picked it because it seems
> to be the general utility belt for stuff that doesn't fit elsewhere.
> 
> But putting it in git-count-objects seems like a bit more of a stretch
> given the above.

I dunno. It seems like less of a stretch to me, but it is true that
rev-parse is already a kitchen sink repository. I can live with it
either way.

-Peff
