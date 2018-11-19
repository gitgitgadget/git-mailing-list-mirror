Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5F91F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 12:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeKSWcz (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 17:32:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:44362 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728679AbeKSWcz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 17:32:55 -0500
Received: (qmail 4685 invoked by uid 109); 19 Nov 2018 12:09:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Nov 2018 12:09:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17494 invoked by uid 111); 19 Nov 2018 12:08:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 19 Nov 2018 07:08:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Nov 2018 07:09:27 -0500
Date:   Mon, 19 Nov 2018 07:09:27 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/5] Make :(attr) pathspec work with "git log"
Message-ID: <20181119120927.GA31660@sigill.intra.peff.net>
References: <20181118164800.32759-1-pclouds@gmail.com>
 <87d0r217vr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0r217vr.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 08:51:52PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > But this also reveals an interesting thing: even though we walk on a
> > tree, we check attributes from _worktree_ (and optionally fall back to
> > the index). This is how attributes are implemented since forever. I
> > think this is not a big deal if we communicate clearly with the user.
> > But otherwise, this series can be scraped, as reading attributes from
> > a specific tree could be a lot of work.
> 
> I'm very happy to see this implemented, and I think the behavior
> described here is the right way to go. E.g. in git.git we have diff=perl
> entries in .gitattributes. It would suck if:
> 
>     git log ':(attr:diff=perl)'
> 
> Would only list commits as far as 20460635a8 (".gitattributes: use the
> "perl" differ for Perl", 2018-04-26), since that's when we stop having
> that attribute. Ditto for wanting to run "grep" on e.g. perl files in
> 2.12.0.
> 
> I have also run into cases where I want to use a .gitattributes file
> from a specific commit. E.g. when writing pre-receive hooks where I've
> wanted the .gitattributes of the commit being pushed to configure
> something about it. But as you note this isn't supported at all.
> 
> But a concern is whether we should be making :(attr:*) behave like this
> for now. Are we going to regret it later? I don't think so, I think
> wanting to use the current working tree's / index's is the most sane
> default, and if we get the ability to read it from revisions as we
> e.g. walk the log it would make most sense to just call that
> :(treeattr:*) or something like that.

I think that ship already sailed with the fact that "git log -p" will
show diffs using the worktree attrs. I agree that it would sometimes be
nice to specify attributes from a particular tree, but at this point the
default probably needs to remain as it is.

-Peff
