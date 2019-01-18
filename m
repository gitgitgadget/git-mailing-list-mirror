Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7891F454
	for <e@80x24.org>; Fri, 18 Jan 2019 21:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfARVaV (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 16:30:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:41548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729598AbfARVaV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 16:30:21 -0500
Received: (qmail 25242 invoked by uid 109); 18 Jan 2019 21:30:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Jan 2019 21:30:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15242 invoked by uid 111); 18 Jan 2019 21:30:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 Jan 2019 16:30:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2019 16:30:19 -0500
Date:   Fri, 18 Jan 2019 16:30:19 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Barret Rhoden <brho@google.com>, git@vger.kernel.org,
        David Kastrup <dak@gnu.org>, Jeff Smith <whydoubt@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 1/3] Move init_skiplist() outside of fsck
Message-ID: <20190118213018.GA28808@sigill.intra.peff.net>
References: <20190107213013.231514-1-brho@google.com>
 <20190117202919.157326-1-brho@google.com>
 <20190117202919.157326-2-brho@google.com>
 <87k1j247ui.fsf@evledraar.gmail.com>
 <xmqqzhrxlvfj.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1901182155020.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1901182155020.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 09:59:21PM +0100, Johannes Schindelin wrote:

> By that reasoning all the preparatory work for switching to SHA-256 and
> making the references in the Git code base less tied to SHA-1 would be
> irrelevant now, "because we can cross that bridge when we reach it".
> 
> You are suggesting to incur technical debt here. Let's be smarter about
> this. We do not *have* to incur said technical debt. Nothing (except
> mental laziness) makes use do that.
> 
> Instead, we can make our load "when we reach that bridge" a lot lighter
> by already doing the right thing.
> 
> BTW I totally disagree that the skip list is bound to be SHA-1. It is
> bound to be a list of object names, that's what its purpose is, and just
> because we happen to not yet support other hash algorithms but SHA-1 does
> not mean that the skip list is fixed to SHA-1. It'll always be whatever
> hash algorithm is used in the current repository.

Yeah, I agree with this. In particular, the code has already been
modified to use "struct object_id" and parse_oid_hex(). So it is not
even like somebody will have to come through later and fix the
implementation here, and while they're at it change the "SHA-1" in the
message. It has literally already been fixed, and is just waiting on
parse_oid_hex() to learn about the new hashes behind the scenes.

IMHO the conversion to object_id probably would have been the time to
fix that message so we would not even have to be revisiting the
discussion now. But that conversion was such a monumental pain it is
hard to fault the authors for not picking up every scrap at that moment. ;)

That is no excuse not to do it now, though.

-Peff
