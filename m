Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C124A1FC44
	for <e@80x24.org>; Tue,  9 May 2017 03:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdEIDQ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 23:16:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:47828 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdEIDQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 23:16:56 -0400
Received: (qmail 12962 invoked by uid 109); 9 May 2017 03:16:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 03:16:56 +0000
Received: (qmail 19281 invoked by uid 111); 9 May 2017 03:17:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 23:17:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 23:16:54 -0400
Date:   Mon, 8 May 2017 23:16:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] Make diff plumbing commands respect the
 indentHeuristic.
Message-ID: <20170509031653.7hc36pil3vzrobsz@sigill.intra.peff.net>
References: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
 <20170427205037.1787-1-marcnarc@xiplink.com>
 <CAGZ79kbUqVfz+6Y0XkTL7FCZfaD+2YRMZ_v0vP8-DOFhWc+ELw@mail.gmail.com>
 <20170428220450.olqitnuwhrxzg3pv@sigill.intra.peff.net>
 <CACBZZX5f81HKCjRjTDyXzNMVuef9Z_ECS+0SVk2xpbwXudgxCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5f81HKCjRjTDyXzNMVuef9Z_ECS+0SVk2xpbwXudgxCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2017 at 12:34:38PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I don't know if we would want to be extra paranoid about patch-ids.
> > There is no helping:
> >
> >   git rev-list HEAD | git diff-tree --stdin -p | git patch-id --stable
> >
> > because diff-tree doesn't know that it's trying for "--stable" output.
> > But the diffs we compute internally for patch-id could disable the
> > heuristics. I'm not sure if those matter, though. AFAIK those are used
> > only for internal comparisons within a single program. I.e., we never
> > compare them against input from the user, nor do we output them to the
> > user. So they'll change, but I don't think anybody would care.
> 
> I have a few-million row table with commit_id as one column & patch_id
> as another. I.e. a commit -> patch_id mapping.

Thanks for this data point. It's always interesting to hear about
unforeseen uses of the tools.

Out of curiosity, how do you generate the patch-ids? Is it with
something like diff-tree piped to patch-id?

I do feel a bit sad about breaking this case (or at the very least
forcing you to set an option to retain cross-version compatibility). But
my gut says that we don't want to lock ourselves into never changing the
diff algorithm (and I'm sure we've done it inadvertently a few times
over the years; even the recent switch to turning on renames would have
had that impact).

-Peff
