Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB9BA1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 21:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389214AbfHAVgl (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 17:36:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:59458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729085AbfHAVgk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 17:36:40 -0400
Received: (qmail 32533 invoked by uid 109); 1 Aug 2019 21:36:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Aug 2019 21:36:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31562 invoked by uid 111); 1 Aug 2019 21:38:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2019 17:38:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Aug 2019 17:36:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Ariadne Conill <ariadne@dereferenced.org>
Subject: Re: Git for Windows v2.23.0-rc0, was Re: [ANNOUNCE] Git v2.23.0-rc0
Message-ID: <20190801213638.GA30522@sigill.intra.peff.net>
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1907311440130.21907@tvgsbejvaqbjf.bet>
 <20190731231848.GC1933@sigill.intra.peff.net>
 <20190801002125.GA176307@google.com>
 <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfwcopn1.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 01, 2019 at 08:45:54AM -0700, Junio C Hamano wrote:

> While I think "revert to hardcoded default" may be a good idea, I do
> not think the hardcoded default you implemented that changes the
> behaviour based on the output destination makes much sense.  If I
> want to eradicate junkio@cox.net from my paged/interactive output, I
> want to eradicate it also in the output piped to the script I use
> for authorship stats.  
> 
> I suspect that you may have misread the "is interactive" bit in the
> original; that was used only to decide if we are going to warn.

Yeah, I wondered about the same misreading when I read the response in:

  https://public-inbox.org/git/20190801011448.GB176307@google.com/

> Anyway, how about this much simplified version?

Yes, this is what I was thinking of in my earlier responses, but...

> @@ -214,12 +204,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>  	memset(&w, 0, sizeof(w));
>  	userformat_find_requirements(NULL, &w);
>  
> -	if (mailmap < 0) {
> -		if (session_is_interactive() && !rev->pretty_given)
> -			warning("%s\n", _(warn_unspecified_mailmap_msg));
> -
> +	if (mailmap < 0)
>  		mailmap = 0;
> -	}

This should be "mailmap = 1" to match the commit message, no? (Which
also implies we may want a new test).

I'd also be OK with leaving it at "0" for now, making a note of the
upcoming change in the release notes, and flipping it _next_ time. But
IMHO we don't need to be that conservative (and I share your pessimism
that enough people actually read the release notes to merit that kind of
advance notice).

-Peff
