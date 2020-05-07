Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D083C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8248A20725
	for <git@archiver.kernel.org>; Thu,  7 May 2020 17:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEGRSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 13:18:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:40548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725949AbgEGRSm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 13:18:42 -0400
Received: (qmail 908 invoked by uid 109); 7 May 2020 17:18:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 17:18:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19503 invoked by uid 111); 7 May 2020 17:18:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 13:18:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 13:18:40 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: allow per-branch config for GitHub Actions
Message-ID: <20200507171840.GA3645692@coredump.intra.peff.net>
References: <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <20200507162011.GA3638906@coredump.intra.peff.net>
 <20200507170042.GC26677@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507170042.GC26677@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 11:00:42AM -0600, Taylor Blau wrote:

> >    windows-build:
> > +    needs: ci-config
> > +    if: needs.ci-config.outputs.enabled == 'yes'
> 
> One thing I wonder is whether the downstream 'windows-test' partitions.
> I think that it should be fine, since we won't run the dependent
> 'windows-build', and then 'windows-test' won't have all of its
> prerequisites filled.

Yes, I intentionally left them out for that reason. It seemed simpler to
just let the skip percolate down the dependency tree.

> > +# Sample script for enabling/disabling GitHub Actions CI runs on
> > +# particular refs. By default, CI is run for all branches pushed to
> > +# GitHub. You can override this by dropping the ".sample" from the script,
> > +# editing it, committing, and pushing the result to the "ci-config" branch of
> > +# your repository:
> > +#
> > +#   git checkout -b ci-config
> 
> Should we be recommending '--orphan' instead of '-b' here? It looks
> like when you clone this branch down that you try to get as few bytes as
> possible, so I figure it may be easier to have this be a orphaned
> branch.

No, the whole point of doing the partial clone (rather than using
actions/checkout, which doesn't support that) was so people didn't have
to deal with the orphan-branch thing.

-Peff
