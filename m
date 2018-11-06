Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610F51F453
	for <e@80x24.org>; Tue,  6 Nov 2018 19:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbeKGEfe (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 23:35:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:42588 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387884AbeKGEfd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 23:35:33 -0500
Received: (qmail 10988 invoked by uid 109); 6 Nov 2018 19:08:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 19:08:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2898 invoked by uid 111); 6 Nov 2018 19:08:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 14:08:12 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 14:08:52 -0500
Date:   Tue, 6 Nov 2018 14:08:52 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 12/16] parse-options: replace opterror() with optname()
Message-ID: <20181106190852.GA7499@sigill.intra.peff.net>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
 <20181105192059.20303-13-pclouds@gmail.com>
 <xmqqpnvjexzf.fsf@gitster-ct.c.googlers.com>
 <d29c4fcc-0591-fc45-5a5d-65d2874d98a7@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d29c4fcc-0591-fc45-5a5d-65d2874d98a7@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 06, 2018 at 02:02:42PM +0000, Ramsay Jones wrote:

> Also, this patch does not replace opterror() calls outside of
> the 'parse-options.c' file with optname(). This tickles my
> static-check.pl script, since optname() is an external function
> which is only called from 'parse-options.c'.
> 
> So, at present, optname() could be marked as a local 'static'
> symbol. However, I could also imagine it being used by new callers
> outside of 'parse-options.c' in the future. (maybe) Your call. ;-)

One potential caller is the BUG() cases I added in:

  https://public-inbox.org/git/20181105064542.GM25864@sigill.intra.peff.net/

I actually thought about factoring out an optname() there, but saw that
it involved memory ownership issues and punted (since those messages are
just BUG()s anyway, and unlikely to be triggered). But if we have it, we
could use it.

-Peff
