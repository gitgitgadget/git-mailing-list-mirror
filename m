Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE99820986
	for <e@80x24.org>; Tue,  4 Oct 2016 12:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbcJDMLP (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 08:11:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:51885 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbcJDMLO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 08:11:14 -0400
Received: (qmail 15362 invoked by uid 109); 4 Oct 2016 12:11:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 12:11:13 +0000
Received: (qmail 3728 invoked by uid 111); 4 Oct 2016 12:11:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 08:11:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 08:11:11 -0400
Date:   Tue, 4 Oct 2016 08:11:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v8 00/11] Git filter protocol
Message-ID: <20161004121111.gqilov3colsgzdft@sigill.intra.peff.net>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
 <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
 <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
 <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
 <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
 <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com>
 <C53500E8-7352-4AAC-9F53-40CCFA7F1418@gmail.com>
 <xmqqvax974dl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvax974dl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 10:02:14AM -0700, Junio C Hamano wrote:

> The timeout would be good for you to give a message "filter process
> running the script '%s' is not exiting; I am waiting for it".  The
> user is still left with a hung Git, and can then see if that process
> is hanging around.  If it is, then we found a buggy filter.  Or we
> found a buggy Git.  Either needs to be fixed.  I do not think it
> would help anybody by doing a kill(2) to sweep possible bugs under
> the rug.

I would argue that we should not even bother with such a timeout. This
is an exceptional, buggy condition, and hanging is not at all restricted
to this particular case. If git is hanging, then the right tools are
"ps" or "strace" to figure out what is going on. I know that not all
users are comfortable with those tools, but enough are in practice that
the bugs get ironed out, without git having to carry a bunch of extra
timing code that is essentially never exercised.

-Peff
