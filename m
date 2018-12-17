Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D961F405
	for <e@80x24.org>; Mon, 17 Dec 2018 20:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeLQUYJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 15:24:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:44118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726653AbeLQUYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 15:24:09 -0500
Received: (qmail 19538 invoked by uid 109); 17 Dec 2018 20:24:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Dec 2018 20:24:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6314 invoked by uid 111); 17 Dec 2018 20:23:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 17 Dec 2018 15:23:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2018 15:24:07 -0500
Date:   Mon, 17 Dec 2018 15:24:07 -0500
From:   Jeff King <peff@peff.net>
To:     John Passaro <john.a.passaro@gmail.com>
Cc:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH 0/4] Expose gpgsig in pretty-print
Message-ID: <20181217202406.GA12122@sigill.intra.peff.net>
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
 <1544760713.970.1.camel@gentoo.org>
 <CAJdN7KjExd6T+H4-wEupO2dg_mMWzeA22oYaskkfhz+GuFbfRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJdN7KjExd6T+H4-wEupO2dg_mMWzeA22oYaskkfhz+GuFbfRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 11:07:03AM -0500, John Passaro wrote:

> Then I might rename the other new placeholders too:
> 
> %Gs: signed commit signature (blank when unsigned)
> %Gp: signed commit payload (i.e. in practice minus the gpgsig header;
> also blank when unsigned as well)

One complication: the pretty-printing code sees the commit data in the
i18n.logOutputEncoding charset (utf8 by default). But the signature will
be over the raw commit data. That's also utf8 by default, but there may
be an encoding header indicating that it's something else. In that case,
you couldn't actually verify the signature from the "%Gs%Gp" pair.

I don't think that's insurmountable in the code. You'll have to jump
through a few hoops to make sure you have the _original_ payload, but we
obviously do have that data. However, it does feel a little weird to
include content from a different encoding in the middle of the log
output stream which claims to be i18n.logOutputEncoding.

-Peff
