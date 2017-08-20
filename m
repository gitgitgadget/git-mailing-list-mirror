Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD1D4208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 09:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbdHTJkM (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 05:40:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:43970 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751729AbdHTJkL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 05:40:11 -0400
Received: (qmail 27285 invoked by uid 109); 20 Aug 2017 09:40:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 09:40:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12951 invoked by uid 111); 20 Aug 2017 09:40:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 05:40:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 05:40:09 -0400
Date:   Sun, 20 Aug 2017 05:40:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #04; Fri, 18)
Message-ID: <20170820094009.z23wclpku35txflg@sigill.intra.peff.net>
References: <xmqq60dkbma1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60dkbma1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 02:26:14PM -0700, Junio C Hamano wrote:

> * jk/trailers-parse (2017-08-15) 8 commits
>  - pretty: support normalization options for %(trailers)
>  - t4205: refactor %(trailers) tests
>  - pretty: move trailer formatting to trailer.c
>  - interpret-trailers: add --parse convenience option
>  - interpret-trailers: add an option to unfold values
>  - interpret-trailers: add an option to show only existing trailers
>  - interpret-trailers: add an option to show only the trailers
>  - trailer: put process_trailers() options into a struct
> 
>  "git interpret-trailers" has been taught a "--parse" and a few
>  other options to make it easier for scripts to grab existing
>  trailer lines from a commit log message.
> 
>  Will merge to 'next'.

I saw that this was merged and ended up with a few conflicts related to
the other interpret-trailers series (sorry). Your resolution looks good
to me.

There are a few leftover bits I think we could do on top:

  - we disallow "--trailer" with "--only-input", because the former is
    quietly ignored. After the two series are merged, I think "--where",
    etc should probably get the same treatment (the behavior without it
    isn't horrible, but it's nice to warn the user that what they asked
    for is bogus).

  - Martin pointed out a typo in the new documentation

  - I just noticed that ref-filter understands "%(trailer)", too
    (courtesy of Jacob's original series from last year; I didn't think
    to even check for it). It probably should learn to support the
    additional options, too. I didn't look, but it probably could just
    reuse the new trailer.c formatting function I added.

There's a patch for the second one below.

None for the other two right now, as I'm just trying to clear out
backlog before going offline for a few days (but I'd be happy if anybody
wanted to take a crack at them in the meantime).

-Peff

-- >8 --
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH] doc/interpret-trailers: fix "the this" typo

Signed-off-by: Jeff King <peff@peff.net>
---
I put Martin as the author since he noticed the bug, but I think we are
OK without a signoff for this trivial change (normally I'd have just
squashed, but the topic is in 'next' now).

 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 1df8aabf51..2e22210734 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -21,7 +21,7 @@ This command reads some patches or commit messages from either the
 <file> arguments or the standard input if no <file> is specified. If
 `--parse` is specified, the output consists of the parsed trailers.
 
-Otherwise, the this command applies the arguments passed using the
+Otherwise, this command applies the arguments passed using the
 `--trailer` option, if any, to the commit message part of each input
 file. The result is emitted on the standard output.
 
-- 
2.14.1.495.ged40d10435

