Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759401F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbeIVEEK (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:04:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:55546 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725775AbeIVEEK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:04:10 -0400
Received: (qmail 4888 invoked by uid 109); 21 Sep 2018 22:13:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Sep 2018 22:13:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9077 invoked by uid 111); 21 Sep 2018 22:13:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Sep 2018 18:13:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2018 18:13:18 -0400
Date:   Fri, 21 Sep 2018 18:13:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180921221317.GB11177@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
 <xmqqfty2v9qj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfty2v9qj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 02:09:08PM -0700, Junio C Hamano wrote:

> > +test_expect_success 'setup' '
> > +	test_commit one &&
> > +	git update-ref refs/heads/a HEAD &&
> > +	test_commit two &&
> > +	git update-ref refs/heads/b HEAD &&
> > +	test_commit three &&
> > +	git update-ref refs/heads/c HEAD &&
> > +	git clone --bare . fork &&
> > +	git clone fork pusher &&
> > +	(
> > +		cd fork &&
> > +		git config receive.advertisealternates true &&
> 
> Hmph.  Do we have code to support this configuration variable?

Sorry, I should have caught that. Our existing solution is to disable
alternates in the advertisement entirely (since the optimization
backfires for us). So this line is a leftover from testing it against
our fork, and should be dropped.

If anybody is interested, we can share those patches, though they're
unsurprisingly trivial. I suspect we may end up discarding them if this
custom-command thing works, but it's possible we'll still need to be
able to shut them off completely for some truly pathological cases.

> > +		cat <<-EOF | git update-ref --stdin &&
> 
> Style: writing "<<-\EOF" instead would allow readers' eyes to
> coast over without having to look for $variable_references in
> the here-doc.

Also, useless-use-of-cat in the original, which could be:

  git update-ref --stdin <<-\EOF

> [...]

Yeah, I second all the other bits you mentioned.

-Peff
