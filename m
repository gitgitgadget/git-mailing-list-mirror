Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95EC71F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 20:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfJIUbH (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 16:31:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:43796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729535AbfJIUbH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 16:31:07 -0400
Received: (qmail 26898 invoked by uid 109); 9 Oct 2019 20:31:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Oct 2019 20:31:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17187 invoked by uid 111); 9 Oct 2019 20:33:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Oct 2019 16:33:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Oct 2019 16:31:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
        Zeger-Jan van de Weg <git@zjvandeweg.nl>
Subject: Re: [PATCH 1/1] commit: add support to provide --coauthor
Message-ID: <20191009203105.GA7007@sigill.intra.peff.net>
References: <20191008074935.10972-1-toon@iotcl.com>
 <20191009014039.GA10802@szeder.dev>
 <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr23mlkxo.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 09, 2019 at 11:19:47AM +0900, Junio C Hamano wrote:

> > I wonder how we are supposed to use this trailer in the Git project,
> > in particular in combination with Signed-off-by.  Should all
> > (co)authors sign off as well?  Or will Co-authored-by imply
> > Signed-off-by?
> 
> I think we have been happy with (1) a comment at the end of the log
> message that says X worked together with Y and Z to produce this
> patch, and (2) the trailer block that has S-o-b: from X, Y and Z,
> without any need for Co-authored-by: trailer so far, and I do not
> see any reason to change it in this project.

One advantage to making a machine-readable version is that tools on the
reading side can then count contributions, etc. For instance:

  https://github.com/git/git/commit/69f272b922df153c86db520bf9b6018a9808c2a6

shows all of the co-author avatars, and you can click through to their
pages.

> If other projects wants to use such a footer, that's their choice,
> but I am fairly negative to the idea to open the gate to unbounded
> number of new options for new trailer lines.  We do not even have
> such options like --acked=<acker>, --reported=<reporter>, for the
> trailers that are actively used already (and to make sure nobody
> misunderstands, I do not think it is a good idea to add such
> individual options).

Yeah, I'd agree that we should start first with a generic trailer line.
There might be some advantage to building trailer-specific intelligence
on top of that (for instance, it would be nice for coauthor trailers to
expand names the way --author does). But that can come after, and might
not even be in the form of specific command-line options. E.g., if the
coauthor trailer could be marked in config as "this is an ident", then
we we would know to expand it. And the same could apply to acked,
reported, etc.

-Peff
