Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E37320958
	for <e@80x24.org>; Tue, 21 Mar 2017 02:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756072AbdCUCCA (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 22:02:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:48368 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755279AbdCUCCA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 22:02:00 -0400
Received: (qmail 13328 invoked by uid 109); 21 Mar 2017 02:01:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 02:01:59 +0000
Received: (qmail 10214 invoked by uid 111); 21 Mar 2017 02:02:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 22:02:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 22:01:55 -0400
Date:   Mon, 20 Mar 2017 22:01:55 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] t1400: modernize style
Message-ID: <20170321020155.dx5juulntg5k6fpr@sigill.intra.peff.net>
References: <20170321005616.31324-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321005616.31324-1-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 08:56:11PM -0400, Kyle Meyer wrote:

> These patches follow up on Peff's suggestion to modernize the style in
> t1400-update-ref.sh.
> 
>     20170217082253.kxjezkxfqkfxjhzr@sigill.intra.peff.net
> 
> The first two commits aren't concerned with "modernizing" the tests,
> but instead address issues that I noticed while looking more closely
> at t1400.

Looks good overall to me. Thanks for following up.

> I also considered
> 
>   * making the quoting/spacing/breaks around the test descriptions and
>     bodies more consistent, but I think this leads to too much code
>     churn.

I wouldn't mind the churn if you wanted to do it on top, but it's
definitely not necessary. There's nothing in 'pu' right now that touches
the file.

>   * moving the here-documents for log creation into the following
>     tests, but I don't think it's worth it because it makes already
>     long lines even longer.

Yeah, they're quite long. Probably something like:

  # arguments: <from> <to> <time> <msg>
  reflog () {
	printf '%s %s %s <%s> %s +0000\t%s' \
		"$1" "$2" \
		"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
		"$3" "$4"
  }

  test_expect_success 'verify $m log' '
	{
		reflog $Z $A 1117150200 "Initial Creation" &&
		reflog $A $B 1117150260 "Switch" &&
		reflog $B $A 1117150860 &&
	} >expect &&
	test_cmp expect .git/logs/$m
  '

wouldn't be too bad. Or maybe it's worse, because the actual format is
all tangled up in that printf statement. ;)

I'm OK with it either way.

-Peff
