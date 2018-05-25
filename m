Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B6AE1F42D
	for <e@80x24.org>; Fri, 25 May 2018 17:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967305AbeEYRKx (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 13:10:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:52926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S936185AbeEYRKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 13:10:53 -0400
Received: (qmail 25532 invoked by uid 109); 25 May 2018 17:10:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 May 2018 17:10:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4994 invoked by uid 111); 25 May 2018 17:11:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 25 May 2018 13:11:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 May 2018 13:10:51 -0400
Date:   Fri, 25 May 2018 13:10:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
Message-ID: <20180525171050.GC10461@sigill.intra.peff.net>
References: <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
 <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com>
 <20180524192214.GA21535@sigill.intra.peff.net>
 <20180524193105.GB21535@sigill.intra.peff.net>
 <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
 <20180525024002.GA1998@sigill.intra.peff.net>
 <xmqqd0xknmf1.fsf@gitster-ct.c.googlers.com>
 <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 06:14:16PM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> -		warning("the '-l' alias for '--create-reflog' is deprecated;");
> >> -		warning("it will be removed in a future version of Git");
> >> +		if (list) {
> >> +			warning("the '-l' option is an alias for '--create-reflog' and");
> >> +			warning("has no effect in list mode. This option will soon be");
> >> +			warning("removed and you should omit it (or use '--list' instead).");
> >> +		} else {
> >> +			warning("the '-l' alias for '--create-reflog' is deprecated;");
> >> +			warning("it will be removed in a future version of Git");
> >> +		}
> 
> By the way, this is one of these times when I feel that we should
> have a better multi-line message support in die/error/warning/info
> functions.  Ideally, I should be able to write
> 
> 	warning(_("the '-l' option is an alias for '--create-reflog' and\n"
> 		  "has no effect in list mode, This option will soon be\n"
> 		  "removed and you should omit it (or use '--list' instead)."));
> 
> and warning() would:
> 
>  - do the sprintf formatting thing as necessary to prepare a long multi-line
>    message;
> 
>  - chomp that into lines at '\n' boundary; and
> 
>  - give each of these lines with _("warning: ") prefixed.
> 
> That way, translators can choose to make the resulting message to
> different number of lines from the original easily.

Yep, I totally agree. In past discussions I was thinking mostly of
the pain of writing these multi-line messages. But I imagine it is
absolute hell for translators, and we should fix it for that reason.

(Also, I guess this message probably ought to be marked for
translation).

-Peff
