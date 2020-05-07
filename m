Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649DEC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43DA32186A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGUq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 16:46:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:40942 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726367AbgEGUq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 16:46:26 -0400
Received: (qmail 2665 invoked by uid 109); 7 May 2020 20:46:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 20:46:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21902 invoked by uid 111); 7 May 2020 20:46:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 16:46:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 16:46:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci: allow per-branch config for GitHub Actions
Message-ID: <20200507204626.GG29683@coredump.intra.peff.net>
References: <20200504162311.GE12842@coredump.intra.peff.net>
 <20200504215824.GC45250@syl.local>
 <20200504233634.GB39798@coredump.intra.peff.net>
 <20200505002055.GC64230@syl.local>
 <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <20200507162011.GA3638906@coredump.intra.peff.net>
 <xmqqwo5n34ka.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo5n34ka.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 12:53:09PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +        - id: check-ref
> > +          name: check whether CI is enabled for ref
> > +          run: |
> > +            enabled=yes
> > +            if test -x config-repo/ci/config/allow-ref &&
> > +               ! config-repo/ci/config/allow-ref '${{ github.ref }}'
> 
> Is it deliberate that the output from the script is not redirected
> to >/dev/null, which would mean they are allowed to do something
> that looks like:
> 
> 		echo "::set-output name=enabled::frotz"
> 
> or emit other random ::string-that-affects-github-actions to its
> standard output stream?

It was deliberate in the sense that I would allow them to write useful
messages to the Actions log. If they want to do nonsense like
"::set-output", then it's their foot and their gun.

I don't know if Actions distinguishes between stdout and stderr here
(i.e., if we redirected the script's stdout to stderr, would that
prevent this case or not?).

-Peff
