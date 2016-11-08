Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F242022A
	for <e@80x24.org>; Tue,  8 Nov 2016 00:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbcKHAkm (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 19:40:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:40007 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbcKHAkl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 19:40:41 -0500
Received: (qmail 22086 invoked by uid 109); 8 Nov 2016 00:40:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 00:40:41 +0000
Received: (qmail 17701 invoked by uid 111); 8 Nov 2016 00:41:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 19:41:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2016 19:40:38 -0500
Date:   Mon, 7 Nov 2016 19:40:38 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
Message-ID: <20161108004038.a7gyoe6wpucxjmvz@sigill.intra.peff.net>
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 06, 2016 at 06:32:05PM -0800, Junio C Hamano wrote:

> I regret to report that I won't be able to tag 2.11-rc1 as scheduled
> in tinyurl.com/gitCal (I am feverish and my brain is not keeping
> track of things correctly) any time soon.  I'll report back an
> updated schedule when able.

Take your time. Even if we end up bumping the release by a whole week, I
don't think it's a big deal (which seems likely given the holiday in the
middle, unless you really want to release on Thanksgiving).

> found on the list.  I am aware of only two right now ("cast enum to
> int to work around compiler warning", in Dscho's prepare sequencer
> series, and "wc -l may give leading whitespace" fix J6t pointed out
> in Lars's filter process series), but it is more than likely that I
> am missing a few more.

In addition to J6t's fix in t0021, we need mine that you queued in
jk/filter-process-fix.

I think we also need to make a final decision on the indent/compaction
heuristic naming. After reading Michael's [0], and the claim by you and
Stefan that the "compaction" name was declared sufficiently experimental
that we could later take it away, I'm inclined to follow this plan:

  1. Ship v2.11 with what is in master; i.e., both compaction and indent
     heuristics, triggerable by config or command line.

  2. Post-v2.11, retire the compaction heuristic as a failed experiment.
     Keeping it in v2.11 doesn't hurt anything (it was already
     released), and lets us take our time coming up with and cooking the
     patch.

  3. Post-v2.11, flip the default for diff.indentHeuristic to "true".
     Keep at least the command line option around indefinitely for
     experimenting (i.e., "this diff looks funny; I wonder if
     --no-indent-heuristic makes it look better").

     Config option can either stay or go at that point. I have no
     preference.

The nice thing about that plan is it punts on merging any new code to
post-v2.11. :)

Another possible regression came up today in [1]. I haven't worked up a
patch yet, but I'll do so in the next day or so.

I think that's where we're at now. I'll keep collecting and can give you
the full list when you're back in action.

Get well.

[0] http://public-inbox.org/git/8dbbd28b-af60-5e66-ae27-d7cddca233dc@alum.mit.edu/

[1] http://public-inbox.org/git/20161108003034.apydvv3bav3s7ehq@sigill.intra.peff.net/
