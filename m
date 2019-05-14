Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A32061F4B6
	for <e@80x24.org>; Tue, 14 May 2019 12:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfENM37 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:29:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:56900 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726130AbfENM37 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:29:59 -0400
Received: (qmail 4429 invoked by uid 109); 14 May 2019 12:29:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 May 2019 12:29:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12573 invoked by uid 111); 14 May 2019 12:30:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 May 2019 08:30:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 May 2019 08:29:57 -0400
Date:   Tue, 14 May 2019 08:29:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
Message-ID: <20190514122957.GC27276@sigill.intra.peff.net>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
 <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
 <20190514115047.oncvfq24fhnp64re@dcvr>
 <87ftphw7mv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftphw7mv.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 02:19:36PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Aside from this change, I wonder if making "fetch" optionally "exit 1"
> if no refs were updated would be useful, as in the below WIP. Of course
> it would be better to distinguish errors from "no refs to update".

That seems very sensible to me, as long as it's an optional flag as you
have it here.

> @@ -133,6 +135,8 @@ static struct option builtin_fetch_options[] = {
>  	{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
>  		    N_("control recursive fetching of submodules"),
>  		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules },
> +	OPT_BOOL(0, "exit-code", &exit_code,
> +		 N_("exit successfully if refs are updated")),

I think it makes sense to flip this explanation: "exit non-zero if no
refs are updated" or "treat it as an error if no refs are updated".
Since the default behavior is already to exit successfully in this case. :)

We may also want to advertise a particular result code so callers can
distinguish it from regular die() errors.

-Peff
