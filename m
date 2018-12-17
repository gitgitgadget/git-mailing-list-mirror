Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66381F405
	for <e@80x24.org>; Mon, 17 Dec 2018 19:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbeLQTfQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 14:35:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:44032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727166AbeLQTfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 14:35:16 -0500
Received: (qmail 16354 invoked by uid 109); 17 Dec 2018 19:35:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Dec 2018 19:35:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5993 invoked by uid 111); 17 Dec 2018 19:34:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 17 Dec 2018 14:34:48 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2018 14:35:14 -0500
Date:   Mon, 17 Dec 2018 14:35:14 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Mark Kharitonov <mark.kharitonov@gmail.com>, git@vger.kernel.org
Subject: Re: Can git tell me which uncommitted files clash with the incoming
 changes?
Message-ID: <20181217193514.GB9853@sigill.intra.peff.net>
References: <CAG2YSPzmN5u1uAPVbjsqC3LzVVinFR21-_6wfrkBHdPWhOfMfQ@mail.gmail.com>
 <20181217162108.GB914@sigill.intra.peff.net>
 <877eg80z1f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877eg80z1f.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 17, 2018 at 07:49:00PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > The answer that gives will be overly broad (e.g., in a case where our
> > local branch had touched file "foo" but other side had not, we'd
> > consider "foo" as a difference the two-point diff-tree, whereas a real
> > 3-way merge would realize that we'd keep our version of "foo"). But it
> > might be good enough for your purposes.
> 
> Isn't this done more simply with just running the merge with
> git-merge-tree? Maybe I'm missing something. E.g. earlier I had a
> conflict between a WIP series of mine in next in
> parse-options-cb.c. Just using git-merge-tree and grepping for conflict
> markers gives me what conflicted:

I forgot about the existence of merge-tree (though TBH I don't have a
huge amount of faith in antique plumbing tools like that that very few
people actually run these days).

It won't look at the working tree at all, but it could be used instead
of diff-tree to find the set of touched paths, and then that can be
correlated with the diff-files output. We'd want to see all paths, not
just conflicted ones, so you'd have to be a little fancy with the
parsing.

It's also not _quite_ the same as what git-pull is doing to merge, since
merge-recursive does fancy stuff like renames. But the distinction would
probably be OK for casual use.

-Peff
