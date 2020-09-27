Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629C9C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1BB23977
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgI0IG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:06:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:42318 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgI0IG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:06:28 -0400
Received: (qmail 28593 invoked by uid 109); 27 Sep 2020 08:06:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:06:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3800 invoked by uid 111); 27 Sep 2020 08:06:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:06:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:06:26 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] shortlog: allow multiple groups to be specified
Message-ID: <20200927080626.GC1286220@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
 <20200925070550.GH62741@coredump.intra.peff.net>
 <CAPig+cS96Y8nMQgazZE-HP4Un2LpgfPF3-63vt8=WJf0c5EuRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cS96Y8nMQgazZE-HP4Un2LpgfPF3-63vt8=WJf0c5EuRg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 04:23:39PM -0400, Eric Sunshine wrote:

> > diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> > @@ -69,6 +69,11 @@ Shortlog will attempt to parse each trailer value as a `name <email>`
> >  identity. If successful, the mailmap is applied and the email is omitted
> >  unless the `--email` option is specified. If the value cannot be parsed
> >  as an identity, it will be taken literally and completely.
> > ++
> > +If `--group` is specified multiple times, commits are counted under each
> > +value (but again, only once per unique value in that commit). For
> > +example, `git shortlog --group=author --group=trailer:co-authored-by`
> > +counts both authors and co-authors.
> 
> Intuitively, I understand (or hope) that the first use of --group
> overrides what is otherwise collected by default (authors), however,
> would there be value in stating this explicitly?

Yes. Maybe my "if no --group is specified" suggestion from the other
part of the thread _is_ worth doing then.

> At this point, the documentation for --committer still says:
> 
>     --committer::
>         Collect and show committer identities instead of authors.
>         This is an alias for `--group=committer`.
> 
> which stops feeling accurate now that --group can be specified more
> than once. The "instead of authors" bit is particularly jarring. I
> wonder if the first sentence can simply be dropped.

Hmm, yeah. I actually kept --committer different at first, having it
override any other --group options. But that seemed confusing, too
(since it's now _almost_ an alias for --group=committer). I think your
suggestion works to just explicitly mark it as an alias and nothing.

-Peff
