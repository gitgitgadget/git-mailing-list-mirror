Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6657C203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 08:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbcLJI75 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 03:59:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:54577 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751639AbcLJI75 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 03:59:57 -0500
Received: (qmail 1647 invoked by uid 109); 10 Dec 2016 08:59:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 08:59:41 +0000
Received: (qmail 25177 invoked by uid 111); 10 Dec 2016 09:00:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 04:00:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2016 03:59:39 -0500
Date:   Sat, 10 Dec 2016 03:59:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
Subject: Re: Any interest in 'git merge --continue' as a command
Message-ID: <20161210085938.rfbkuwpvyhnhuzhn@sigill.intra.peff.net>
References: <CAFOYHZDs5rBt5+4D_ViMYfV04foq3h_UrsSMA3FfyMzLh9QdwA@mail.gmail.com>
 <20161209091127.sxxczhfslrqsqs3m@sigill.intra.peff.net>
 <xmqqshpwrjyz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshpwrjyz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2016 at 11:16:52AM -0800, Junio C Hamano wrote:

> > It seems like that would be in line with 35d2fffdb (Provide 'git merge
> > --abort' as a synonym to 'git reset --merge', 2010-11-09), whose stated
> > goal was providing consistency with other multi-command operations.
> >
> > I assume it would _just_ run a vanilla "git commit", and not try to do
> > any trickery with updating the index (which could be disastrous).
> 
> If we were to have "merge --continue", I agree that it would be the
> logical implementation.
> 
> There is nothing to "continue" in a stopped merge where Git asked
> for help from the user, and because of that, I view the final "git
> commit" as "concluding the merge", not "continuing".  "continue"
> makes quite a lot of sense with rebase and cherry-pick A..B that
> stopped; it concludes the current step and let it continue to
> process the remainder.  So from that point of view, it somewhat
> feels strange to call it "merge --continue", but it probably is just
> me.

No, I think your reasoning makes sense. But I also think we've already
choosen to have "--continue" mean "conclude the current, and continue if
there is anything left" in other contexts (e.g., a single-item
cherry-pick). It's more vague, but I think it keeps the user's mental
model simpler if we provide a standard set of options for multi-step
commands (e.g., always "--continue/--abort/--skip", though there are
some like merge that omit "--skip" if it does not make sense).

-Peff
