Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914DA20954
	for <e@80x24.org>; Mon,  4 Dec 2017 21:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbdLDVmY (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 16:42:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:47930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752310AbdLDVmX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 16:42:23 -0500
Received: (qmail 10172 invoked by uid 109); 4 Dec 2017 21:42:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Dec 2017 21:42:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27270 invoked by uid 111); 4 Dec 2017 21:42:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 04 Dec 2017 16:42:43 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Dec 2017 16:42:21 -0500
Date:   Mon, 4 Dec 2017 16:42:21 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171204214221.GB21552@sigill.intra.peff.net>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129143752.60553-3-lars.schneider@autodesk.com>
 <20171130205137.GC3313@sigill.intra.peff.net>
 <BB878570-F214-4BAA-AB58-4A9C0F8F80AB@gmail.com>
 <20171201182924.GB27688@sigill.intra.peff.net>
 <aacb7604-edc3-a920-da43-701b57045956@gmail.com>
 <D330CEDD-7F6B-49DB-A30E-EE0BDB80E28A@gmail.com>
 <20171204172623.GD13332@sigill.intra.peff.net>
 <07CF6EAE-815E-4846-887D-560F2459E69D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07CF6EAE-815E-4846-887D-560F2459E69D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 04, 2017 at 10:31:15PM +0100, Lars Schneider wrote:

> >> I would like to add "for your input" or "for you" to convey 
> >> that Git is not waiting for the machine but for the user.
> >> 
> >>    "hint: Launched editor. Waiting for your input..."
> >> 
> >> Would that work for you?
> > 
> > I guess "input" was the part that I found funny/confusing. The only
> > thing we know is that we're waiting on the editor process to finish, and
> > everything else is making assumptions about what's happening in the
> > editor.
> 
> I see. How about:
> 
> "hint: Launched editor. Waiting for your action..."
> (my preference)
> 
> or
> 
> "hint: Launched editor. Waiting for you..."

Better, IMHO, though I still think literally saying:

  hint: Waiting for your editor to exit...

is the most accurate, which I think makes it clear that you must _exit_
your editor, not just save and close the file.

I dunno, maybe that is being overly paranoid. Certainly I have seen
graphical programs that have a mismatch with the one-process-per-action
way that most terminal editors view the world, and would hang around
even after the user thinks they are done editing. But at the same time,
those programs are unlikely to work well as $GIT_EDITOR in the first
place, because running them from the terminal may just open a new window
in an existing session and exit immediately (which is the opposite
problem -- the editor exited before the user actually did their thing).

So I'm not sure if that would be a problem in practice or not. I'm too
mired in the vim world to have any real data. Somebody like you who is
supporting a large number of less-Unixy users probably has more
perspective there.

-Peff
