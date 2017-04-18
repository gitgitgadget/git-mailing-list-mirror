Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78BFD1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 03:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754453AbdDRDzN (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 23:55:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:35069 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754400AbdDRDzM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 23:55:12 -0400
Received: (qmail 9482 invoked by uid 109); 18 Apr 2017 03:55:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Apr 2017 03:55:12 +0000
Received: (qmail 8459 invoked by uid 111); 18 Apr 2017 03:55:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Apr 2017 23:55:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Apr 2017 23:55:10 -0400
Date:   Mon, 17 Apr 2017 23:55:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, bert.wesarg@googlemail.com
Subject: Re: [PATCH v2 1/3] config: prepare to pass more info in
 git_config_with_options()
Message-ID: <20170418035509.6zd4kxtfggei5yaj@sigill.intra.peff.net>
References: <CACsJy8D-=3qPbEO-dq2+Mr-WZ+5RrivkSw9NX7_FhEJFy+59zA@mail.gmail.com>
 <20170417101002.18272-1-pclouds@gmail.com>
 <xmqqd1cah2m3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1cah2m3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 07:27:16PM -0700, Junio C Hamano wrote:

> > @@ -81,7 +82,7 @@ static struct option builtin_config_options[] = {
> >  	OPT_GROUP(N_("Other")),
> >  	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
> >  	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
> > -	OPT_BOOL(0, "includes", &respect_includes, N_("respect include directives on lookup")),
> > +	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
> 
> It would be more in line with what the log message advertised if you
> did
> 
> 	static struct config_options config_options = {
> 		-1, /* .respect_includes: unspecified */
> 	};
> 
> 	OPT_BOOL(0, "includes", &config_options.respect_includes, N_("...")),
> 
> no?

I think I like the split between the option-value here and the "final"
value that goes into config_options.respect_includes. Because we
actually munge it later based on the given-config value anyway.

So I agree this makes the diff larger than it might need to be, but I
think the end result is a bit nicer.

-Peff
