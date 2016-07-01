Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DC620FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 07:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbcGAHPs (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 03:15:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:38809 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752551AbcGAHPr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 03:15:47 -0400
Received: (qmail 26874 invoked by uid 102); 1 Jul 2016 07:09:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 03:09:08 -0400
Received: (qmail 14158 invoked by uid 107); 1 Jul 2016 07:09:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 03:09:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 03:09:03 -0400
Date:	Fri, 1 Jul 2016 03:09:03 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org,
	dwwang@google.com
Subject: Re: [RFC PATCHv1 0/4] Push options in C Git
Message-ID: <20160701070902.GF5358@sigill.intra.peff.net>
References: <20160630005951.7408-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160630005951.7408-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 05:59:47PM -0700, Stefan Beller wrote:

> Allow a user to pass information along a push to the pre/post-receive hook
> on the remote.

Seems like a reasonable thing to want, and related to:

  http://thread.gmane.org/gmane.comp.version-control.git/285124

which was specifically interested in making "--quiet" and "--force"
available, but stopped short of arbitrary data. (It looks like that
topic got overlooked, and Dennis never prodded again).

> When using a remote that is more than just a plain Git host (e.g. Gerrit,
> Git{hub/lab}, etc) this may become more obvious: The (server backend specific)
> push options can instruct the server to:
> * open a pull request

I know this is just a "for example", but I don't know if we would ever
support opening a pull request directly via push, if only because a good
pull request has actual parameters that the user needs to fill out (like
the cover letter message).

So you'd probably want some client tool to help the user figure out what
to put in the PR, and of course that already exists, because GitHub has
an HTTP API that it can talk to. Shoe-horning it into Git doesn't buy
much.

I'm not sure if your other examples would be better served by just using
an HTTP API or not. I think Gerrit is funny in this regard because it
eschews branches entirely. E.g., in a GitHub PR, you push to branch
"foo", and then you open a PR using "foo" as the source. But with
Gerrit, you push to the magic refs/for/master, and you have no real way
to cross-reference that submission later.

Whereas in Dennis's patches, it was about specific information directly
related to the act of pushing.

> * When pushing to Gerrit you can already attach some of this information by
>   adding a '%' followed by the parameter to the ref, i.e. when interacting with
>   Gerrit it is possible to do things like[1]:
>     
>     git push origin HEAD:refs/for/master%draft%topic=example%cc=jon.doe@example.org
>   
>   This is not appealing to our users as it looks like hacks upon hacks to make
>   it work. It would read better if it was spelled as:

Heh. It _is_ hacks upon hacks, isn't it? ;)

-Peff
