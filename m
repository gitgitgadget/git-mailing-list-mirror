Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD0E203C1
	for <e@80x24.org>; Fri, 15 Jul 2016 09:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbcGOJmI (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 05:42:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:45274 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932220AbcGOJmG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 05:42:06 -0400
Received: (qmail 15871 invoked by uid 102); 15 Jul 2016 09:42:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 05:42:07 -0400
Received: (qmail 13898 invoked by uid 107); 15 Jul 2016 09:42:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 05:42:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 05:42:01 -0400
Date:	Fri, 15 Jul 2016 05:42:01 -0400
From:	Jeff King <peff@peff.net>
To:	"Morten W. J." <morten@winkler.dk>
Cc:	git@vger.kernel.org
Subject: Re: Two consecutive clones of a remote produces different files
Message-ID: <20160715094200.GA17917@sigill.intra.peff.net>
References: <2183637.OVprKRVBmt@t430>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2183637.OVprKRVBmt@t430>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 10:45:47AM +0200, Morten W. J. wrote:

> I have a repository hosted on a GitLab server on my LAN and when I clone that 
> repository to a linux box and a windows box I get different files!
> 
> It is very hard to explain in words, so I have recorded my desktop while 
> reproducing it, which I can do consistently:
> 
> https://dl.dropboxusercontent.com/u/5234017/git-clone-produces-different-results.ogv
> 
> I have no ideas what is wrong or why it behaves the way it does, but I am 
> actually pretty scared now. The repository has been updated from as a subtree 
> from another repository, but that should not create such behavior?

Just a blind guess, but might you have two files with names that differ
only in case, and on Windows one is overwriting the other because you
have a case-insensitive filesystem?

Try:

  git ls-files -s | grep -i src/LogEventSubscriber.h

to see what is in the index (which is case-sensitive, and is the source
from which git checks the files out into the working tree).

-Peff
