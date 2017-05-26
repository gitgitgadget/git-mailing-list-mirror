Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409B31FA14
	for <e@80x24.org>; Fri, 26 May 2017 19:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758379AbdEZTG0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:06:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:58597 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757985AbdEZTGV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:06:21 -0400
Received: (qmail 21550 invoked by uid 109); 26 May 2017 19:06:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 19:06:09 +0000
Received: (qmail 32094 invoked by uid 111); 26 May 2017 19:06:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 15:06:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 May 2017 15:06:07 -0400
Date:   Fri, 26 May 2017 15:06:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 0/6] make "^:foo" work without disambiguating "--"
Message-ID: <20170526190607.jr44oygs6mzm3q6e@sigill.intra.peff.net>
References: <20170525152739.t63dbsq2dojy2y2h@sigill.intra.peff.net>
 <xmqq4lw8cql8.fsf@gitster.mtv.corp.google.com>
 <20170526132432.zcoml5vphrzd557t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170526132432.zcoml5vphrzd557t@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 09:24:32AM -0400, Jeff King wrote:

> The middle ground would be to replicate a simple subset of the rules in
> verify_filename(). If we assume that all arguments with ":(" are
> pathspecs (which seem rather unlikely to have false positives), then
> that leaves only a few short-magic patterns: :/, :!, and :^.
> 
> We already specially handle :/ here. So it would really just be adding
> the other two (which are just aliases of each other). It's not that much
> code. The dirty thing is just that we're replicating some of the
> pathspec logic, and any new magic would have to be updated here, too.
> 
> I'll see if I can work up a patch.

So here's what I came up with. TBH, I could live without patch 5. What I
care most about is making the ":^" work. But I don't really see a
downside to it.

  [1/6]: t4208: add check for ":/" without matching file
  [2/6]: check_filename(): refactor ":/" handling
  [3/6]: check_filename(): use skip_prefix
  [4/6]: check_filename(): handle ":^" path magic
  [5/6]: verify_filename(): treat ":(magic)" as a pathspec
  [6/6]: verify_filename(): flip order of checks

 setup.c                       | 42 ++++++++++++++++++++++++++++++++----------
 t/t4208-log-magic-pathspec.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 10 deletions(-)

-Peff
