Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1530D20C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbdFLViM (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:38:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:38548 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752619AbdFLViB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:38:01 -0400
Received: (qmail 3130 invoked by uid 109); 12 Jun 2017 21:38:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 21:38:01 +0000
Received: (qmail 16875 invoked by uid 111); 12 Jun 2017 21:38:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jun 2017 17:38:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jun 2017 17:37:59 -0400
Date:   Mon, 12 Jun 2017 17:37:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a
 parent-less branch
Message-ID: <20170612213759.f2scl3r46vboolna@sigill.intra.peff.net>
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
 <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
 <1497084241.8531.2.camel@gmail.com>
 <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net>
 <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
 <1497255003.1718.1.camel@gmail.com>
 <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
 <20170612212025.ytyukvmmthfcsejh@sigill.intra.peff.net>
 <xmqqshj4nb9u.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshj4nb9u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 02:31:25PM -0700, Junio C Hamano wrote:

> >> -	status_printf_ln(s, c, _("Changes not staged for commit:"));
> >> +	if (s->commit_template)
> >> +		status_printf_ln(s, c, _("Changes not staged for commit:"));
> >> +	else
> >> +		status_printf_ln(s, c, _("Changes not yet in the index:"));
> >
> > I think "staged for commit" still makes perfect sense even when we are
> > just asking "what's the current status" and not "what would it look like
> > if I were to commit".
> >
> > And avoiding the word "index" is worth-while here, I think. I am not in
> > general of the "let's hide the index" camp" but it is a technical term.
> > If we can say the same thing in a way that is understood both by people
> > who know what the index is and people who do not, that seems like a win.
> 
> I do not mind "Changes not staged yet:".  The point was not about
> getting rid of "stage" but about not mentioning "commit", because
> stepping back a bit, if the readers are prepared to accept these
> messages in the mindset that they are guiding them toward their next
> commit, "I find 'Initial commit' confusing" would not have been an
> issue in the first place.

I think the difference is that "Initial commit" is talking about a
_specific_ commit. If we're not working on one, it doesn't make much
sense. But "staged for commit" is not necessarily talking about a
specific commit; we are talking about the purpose of staging something
in general. You could equally well say "staged for committing" (though I
think the shorter word sounds more natural).

Likewise with "to be committed".

> If we can get rid of 'yet' and 'already' from the above two, that
> would be even better.  The point of the exercise is to be understood
> by those who do not think in terms of 'preparing for the next commit',
> so 'yet', 'already', 'to be committed' are all counter-productive
> for that goal.  Those who accept the 'description of the current
> state in the context of preparing for the next commit' are not the
> ones we are trying to help with the suggested three changes.

I agree that is the goal. My point was that the existing messages are OK
even if you aren't thinking of preparing for the next commit. Saying
"this is in the index" and "this is staged" are synonyms. Saying "this
is staged for commit" is likewise a synonym, unless there is some other
reason we stage things.

-Peff
