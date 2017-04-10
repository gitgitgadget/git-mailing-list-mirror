Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18EEA20960
	for <e@80x24.org>; Mon, 10 Apr 2017 22:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbdDJWLD (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 18:11:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:59481 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752151AbdDJWLC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 18:11:02 -0400
Received: (qmail 29587 invoked by uid 109); 10 Apr 2017 22:11:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 22:11:01 +0000
Received: (qmail 29340 invoked by uid 111); 10 Apr 2017 22:11:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 18:11:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 18:10:58 -0400
Date:   Mon, 10 Apr 2017 18:10:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/3] quarantine-push loose ends
Message-ID: <20170410221058.2ao64wedg2pa6uc2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 05:14:24PM -0400, Jeff King wrote:

> > Also, I think this whole thing could really do with some documentation
> > in githooks(5). E.g. what hooks does it apply for? The test is just
> > for pre-receive but the patch changes run_update_hook(), does it also
> > take effect for update? Ditto the caveat about update-ref.
> 
> My thinking was that the cases where the effects were user-visible were
> sufficiently insane that nobody would need to know or care when the
> feature was in use.

I guess it can't hurt to write about it, though. Here's that, plus a
cleanup on the stray tmp_objdir_env() call you noticed. The final patch
provides some safety for the ref-update case. My assumption all along
has been that nobody would want to update random refs from inside the
pre-receive hook. This doubles down on that by making it forbidden. I
don't think that's a big loss, because doing so now is extremely
dangerous. If that assumption is wrong, the correct path forward is to
make the quarantining configurable.

  [1/3]: receive-pack: drop tmp_objdir_env from run_update_hook
  [2/3]: receive-pack: document user-visible quarantine effects
  [3/3]: refs: reject ref updates while GIT_QUARANTINE_PATH is set

 Documentation/git-receive-pack.txt | 29 +++++++++++++++++++++++++++++
 Documentation/githooks.txt         |  3 +++
 builtin/receive-pack.c             |  1 -
 refs.c                             |  6 ++++++
 t/t5547-push-quarantine.sh         | 11 +++++++++++
 5 files changed, 49 insertions(+), 1 deletion(-)

