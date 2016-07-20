Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6064D1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 20:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbcGTUwN (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 16:52:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:47773 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754964AbcGTUwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 16:52:12 -0400
Received: (qmail 28826 invoked by uid 102); 20 Jul 2016 20:52:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 16:52:12 -0400
Received: (qmail 24689 invoked by uid 107); 20 Jul 2016 20:52:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 16:52:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 14:52:07 -0600
Date:	Wed, 20 Jul 2016 14:52:07 -0600
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Richard Soderberg <rsoderberg@gmail.com>, git@vger.kernel.org
Subject: Re: git-prompt.sh incompatible with non-basic global grep.patternType
Message-ID: <20160720205207.GA578@sigill.intra.peff.net>
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
 <20160720134211.GA19359@sigill.intra.peff.net>
 <xmqqwpkgcbp9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpkgcbp9.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 01:10:42PM -0700, Junio C Hamano wrote:

> This may fix it.  I think the root cause is that logic to smear
> "pattern type" into various broken-down fields in grep_opt for the
> short-hands like --basic-regexp option needs to leave "I am setting
> this short-hand" mark to allow the grep_commit_pattern_type() that
> is done as the final step of the set-up sequence before we call
> compile_grep_patterns() can take notice.  The calls currently made
> to grep_set_pattern_type_option() when we parse "--basic-regexp" and
> friends forgets to override the "source of truth" field and only
> updates the broken-down fields.
> 
> An alternative may be to update places that parse "--basic-regexp"
> and friends to just write to .pattern_type_option without calling
> grep_set_pattern_type_option(); that might be a cleaner, but I am
> not feeling well today so I won't be able to do a deeper analysis
> right now.

I gave a very cursory look when I wrote the other email, and your
alternative solution is what looked like the most elegant fix to me.

I suspect this bug has been there quite a while, so no rush. :)

-Peff
