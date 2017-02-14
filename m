Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFCAD1FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 06:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbdBNGAZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 01:00:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:54866 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751393AbdBNGAY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 01:00:24 -0500
Received: (qmail 11278 invoked by uid 109); 14 Feb 2017 06:00:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 06:00:24 +0000
Received: (qmail 626 invoked by uid 111); 14 Feb 2017 06:00:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 01:00:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 01:00:21 -0500
Date:   Tue, 14 Feb 2017 01:00:21 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 0/7] grep rev/path parsing fixes
Message-ID: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
References: <20170214001159.19079-1-jonathantanmy@google.com>
 <20170214012037.u2eg2n7mvteullcx@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214012037.u2eg2n7mvteullcx@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 08:20:37PM -0500, Jeff King wrote:

> > If there is a repo and "foo" is a rev, the "--no-index or --untracked
> > cannot be used with revs." error would occur. If there is a repo and
> > "foo" is not a rev, this command would proceed as usual. If there is no
> > repo, the "setup_git_env called without repository" error would occur.
> > (This is my understanding from reading the code - I haven't tested it
> > out.)
> 
> Yes, it's easy to see that "git grep --no-index foo bar" outside of a
> repo generates the same BUG. I suspect that "--no-index" should just
> disable looking up revs entirely, even if we are actually in a
> repository directory.

I've fixed that, along with a few other bugs and cleanups. The complete
series is below. Patch 2 is your (untouched) patch. My suggestions for
your test are in patch 3, which can either remain on its own or be
squashed in.

  [1/7]: grep: move thread initialization a little lower
  [2/7]: grep: do not unnecessarily query repo for "--"
  [3/7]: t7810: make "--no-index --" test more robust
  [4/7]: grep: re-order rev-parsing loop
  [5/7]: grep: fix "--" rev/pathspec disambiguation
  [6/7]: grep: avoid resolving revision names in --no-index case
  [7/7]: grep: do not diagnose misspelt revs with --no-index

 builtin/grep.c  | 78 +++++++++++++++++++++++++++++++++++++++------------------
 t/t7810-grep.sh | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+), 25 deletions(-)

-Peff
