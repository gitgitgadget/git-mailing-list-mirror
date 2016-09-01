Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3E71F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 22:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbcIAWUW (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:20:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:36833 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752180AbcIAWUU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:20:20 -0400
Received: (qmail 2066 invoked by uid 109); 1 Sep 2016 22:20:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Sep 2016 22:20:20 +0000
Received: (qmail 19988 invoked by uid 111); 1 Sep 2016 22:20:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Sep 2016 18:20:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2016 18:20:15 -0400
Date:   Thu, 1 Sep 2016 18:20:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Jan Keromnes <janx@linux.com>, git@vger.kernel.org,
        Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: `make profile-install` fails in 2.9.3
Message-ID: <20160901222015.wqhrerudnwddbyhz@sigill.intra.peff.net>
References: <CAA6PgK7C18F1WGyZMTEUAWEVsUWqiZND5Ne_0SH-rUEm8u5dNg@mail.gmail.com>
 <20160901200700.GA8254@hank>
 <20160901215810.ez47lqwmfmahyvc7@sigill.intra.peff.net>
 <xmqqh99zuuyh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh99zuuyh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 01, 2016 at 03:16:38PM -0700, Junio C Hamano wrote:

> Which means that piggybacking this on the "run 'git diff' limited to
> the pathspec to find the paths that needs updating" logic usually
> done in "git add" can not be reused [*1*].
> 
> What was I thinking while reviewing the patch X-<.  Sigh.
> 
> 
> [Footnote]
> 
> *1* I guess we _could_, by first flipping all the regular file
>     blob's executable bit for paths that are inside the pathspec and
>     then by running "git diff" against that modified index, limited
>     to the pathspec, to find the paths that need to be added.
> 
>     It sounds ugly, but may conceptually be cleaner.  We first start
>     from an ideal end-result, and then re-hash what needs to be
>     updated to match the ideal.

Yeah, I had a similar thought, but it just feels so hacky. Is there
anything wrong with making this completely separate from the content
update. I.e., just applying the pathspec to the index as a separate step
and adding "+x" to each entry?

This really is just a more convenient interface around "update-index
--chmod", isn't it? We should be able to do the same thing it does.

-Peff
