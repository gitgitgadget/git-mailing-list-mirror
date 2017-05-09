Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D1421FC44
	for <e@80x24.org>; Tue,  9 May 2017 03:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdEIDUi (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 23:20:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:47840 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdEIDUi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 23:20:38 -0400
Received: (qmail 13223 invoked by uid 109); 9 May 2017 03:20:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 03:20:37 +0000
Received: (qmail 19312 invoked by uid 111); 9 May 2017 03:21:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 23:21:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 23:20:34 -0400
Date:   Mon, 8 May 2017 23:20:34 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Enabling the diff "indent" heuristic by default
Message-ID: <20170509032034.zbdeu2xsawcm32xb@sigill.intra.peff.net>
References: <xmqqlgq77pse.fsf@gitster.mtv.corp.google.com>
 <f867af6f-b601-251a-86a4-ede0bb942efb@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f867af6f-b601-251a-86a4-ede0bb942efb@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 10:54:10AM -0400, Marc Branchaud wrote:

> On 2017-05-08 03:48 AM, Junio C Hamano wrote:
> > 
> > * mb/diff-default-to-indent-heuristics (2017-05-02) 4 commits
> >   (merged to 'next' on 2017-05-08 at 158f401a92)
> 
> I think there's a general open question about this, which is whether or not
> we should just drop the diff.indentHeuristic configuration setting
> altogether.
> 
> Peff made the point [0] that if we keep the setting then t4061 should be
> rewritten.
> 
> My instinct is to keep the setting, at least until the changed default has a
> bit of time to settle in.  So I'll re-send the topic with the renovated
> t4061.

My instinct matches that, too. It gives people like Ævar, with his
patch-id database, a way to keep compatibility if he chooses. If we were
designing from the ground up, I'd say the option is probably just
clutter, but the backwards compatibility issue means we should probably
keep it around more or less forever.

And since Junio wasn't on the other thread, I'll repeat what I wrote
there:

  I do feel a bit sad about breaking this case (or at the very least
  forcing you to set an option to retain cross-version compatibility).
  But my gut says that we don't want to lock ourselves into never
  changing the diff algorithm (and I'm sure we've done it inadvertently
  a few times over the years; even the recent switch to turning on
  renames would have had that impact).

> Both Peff [1] and Ævar [2] mentioned situations where enabling the heuristic
> has a small impact on them.  If/when this graduates, it's perhaps worth
> adding a backward-compatibility note that the default patch IDs are
> changing.  Maybe something like:
> 
> The diff "indent" heuristic is now enabled by default.  This changes the
> patch IDs calculated by git-patch-id and used by git-cherry, which could
> affect patch-based workflows that rely on previously-computed patch IDs.
> The heuristic can be disabled by setting diff.indentHeuristic to false.

I think a note like this is a good idea.

-Peff
