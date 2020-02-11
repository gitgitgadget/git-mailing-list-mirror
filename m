Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F59FC352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3899C20578
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgBKRQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:16:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:57536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727954AbgBKRQv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 12:16:51 -0500
Received: (qmail 8591 invoked by uid 109); 11 Feb 2020 17:16:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Feb 2020 17:16:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32097 invoked by uid 111); 11 Feb 2020 17:25:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 12:25:42 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 12:16:49 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/4] some more mailinfo cleanups
Message-ID: <20200211171649.GB2118476@coredump.intra.peff.net>
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
 <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
 <CAPig+cQdJ0NJSWZN-2ckeLB7RfU9GZ7LGvVX4y+Q1daPnW8WsA@mail.gmail.com>
 <20200210234427.GA632160@coredump.intra.peff.net>
 <xmqq1rr1xfmt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rr1xfmt.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 08:17:30AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Something like the (largely untested) patch below. That would also make
> > it easy to support arbitrary amounts of whitespace after the header,
> > which I think are allowed by the standard (whereas now we'd parse
> > "Content-type:    text/plain" as "    text/plain", which is silly).
> >
> > Worth doing?
> 
> The result does look cleaner.  I do not think we've seen much
> polishing in this area of the code for quite a long time, which
> might indicate that what we have may be good enough, but at the same
> time it would mean it is quiescent time for the code and it is safe
> to clean it up.

Yeah, it feels a little like code churn. It's not like we ever add new
headers to match. But I doodled the series below while I was in a
meeting, and it does fix one tiny user-visible bug (that I don't think
anybody has ever noticed or complained about), so maybe it's worth
doing. ;)

This is on top of rs/strbuf-insertstr, since it relies on 517b60564e
(mailinfo: don't insert header prefix for handle_content_type(),
2020-02-10).

  [1/4]: mailinfo: treat header values as C strings
  [2/4]: mailinfo: simplify parsing of header values
  [3/4]: mailinfo: be more liberal with header whitespace
  [4/4]: mailinfo: factor out some repeated header handling

 mailinfo.c          | 62 +++++++++++++++++++++++++++------------------
 t/t5100-mailinfo.sh | 15 +++++++++++
 2 files changed, 52 insertions(+), 25 deletions(-)

-Peff
