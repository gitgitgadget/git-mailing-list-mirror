Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40CBC1F42D
	for <e@80x24.org>; Tue, 29 May 2018 21:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967368AbeE2VdU (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 17:33:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:55818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S967361AbeE2VdT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 17:33:19 -0400
Received: (qmail 3994 invoked by uid 109); 29 May 2018 21:33:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 May 2018 21:33:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31193 invoked by uid 111); 29 May 2018 21:33:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 May 2018 17:33:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2018 17:33:17 -0400
Date:   Tue, 29 May 2018 17:33:17 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 1/3] usage: extract `prefix_suffix_lines()` from
 `advise()`
Message-ID: <20180529213317.GE7964@sigill.intra.peff.net>
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
 <cover.1527279322.git.martin.agren@gmail.com>
 <90ac0a41563f070a840076521d8935ad7c21beb9.1527279322.git.martin.agren@gmail.com>
 <CACsJy8CZQLxU5TPx=M0NV_xTR_9qyjbOWnVcdX9-Tz+BCb24VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8CZQLxU5TPx=M0NV_xTR_9qyjbOWnVcdX9-Tz+BCb24VA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 28, 2018 at 08:40:16PM +0200, Duy Nguyen wrote:

> On Fri, May 25, 2018 at 11:00 PM, Martin Ågren <martin.agren@gmail.com> wrote:
> > advice.c contains a useful code snippet which takes a multi-line string
> > and prints the lines, prefixing and suffixing each line with two
> > constant strings. This was originally added in 23cb5bf3b3 (i18n of
> > multi-line advice messages, 2011-12-22) to produce such output:
> >
> > hint: some multi-line advice
> > hint: prefixed with "hint: "
> >
> > The prefix is actually colored after 960786e761 (push: colorize errors,
> > 2018-04-21) and each line has a suffix for resetting the color.
> >
> > The next commit will teach the same "prefix all the lines"-trick to the
> > code that produces, e.g., "warning: "-messages. In preparation for that,
> > extract the code for printing the individual lines and expose it through
> > git-compat-util.h.
> >
> > Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> > ---
> > I'm open for suggestions on the naming of `prefix_suffix_lines()`...
> 
> I think the important verb, print (to FILE*), is somehow missing. This
> current name would be great if it produces another str(buf).

It can't use a strbuf, since we want vreportf() to avoid calling any
allocation functions.

-Peff
