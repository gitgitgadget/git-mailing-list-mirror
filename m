Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE9C120D0C
	for <e@80x24.org>; Wed, 14 Jun 2017 09:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbdFNJY7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:24:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:39856 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752243AbdFNJY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 05:24:57 -0400
Received: (qmail 13519 invoked by uid 109); 14 Jun 2017 09:24:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 09:24:56 +0000
Received: (qmail 9686 invoked by uid 111); 14 Jun 2017 09:24:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 05:24:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 05:24:54 -0400
Date:   Wed, 14 Jun 2017 05:24:54 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98yvind?= Holm <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix a refname trimming problem in `log --bisect`
Message-ID: <20170614092454.7mtaqnvhiho5yslx@sigill.intra.peff.net>
References: <5a3f6af6-f936-50e7-5fca-c41b3aeefdce@alum.mit.edu>
 <cover.1497430232.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1497430232.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 11:07:25AM +0200, Michael Haggerty wrote:

> Fix the problem in two orthogonal ways:
> 
> 1. Add a new function, `for_each_fullref_in_submodule()`, that doesn't
>    trim the refnames that it passes to callbacks, and us that instead.
>    I *think* that this is a strict improvement, though I don't know
>    the `git log` code well enough to be sure that it won't have bad
>    side-effects.

I think this is fine, for the reasons I gave elsewhere in the thread.

> 2. Relax the "trimming too many characters" check to allow the full
>    length of the refname to be trimmed away (though not more than
>    that).
> 
> In an ideal world the second patch shouldn't be necessary, because
> this calling pattern is questionable and it might be better that we
> learn about any other offenders. But if we'd rather be conservative
> and not break any other code that might rely on the old behavior,
> patch 2 is my suggestion for how to do it.

My preference would be to hold off on (2) if we can avoid it. It's
cleaner, and I think flushing out these kinds of bugs is useful.

-Peff
