Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EDDC433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 13:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D64860F45
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 13:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhIENIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 09:08:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:39736 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhIENIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 09:08:25 -0400
Received: (qmail 8689 invoked by uid 109); 5 Sep 2021 13:07:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 05 Sep 2021 13:07:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22751 invoked by uid 111); 5 Sep 2021 13:07:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Sep 2021 09:07:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 5 Sep 2021 09:07:21 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: implement "quick" formats
Message-ID: <YTTBCWlsC1cBZMio@coredump.intra.peff.net>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
 <YTNps0YBOaRNvPzk@coredump.intra.peff.net>
 <CAOLTT8QYe3PBPxSH8CYY+FatSfT7C5m6nccR2xMZ1yxSDFh5OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8QYe3PBPxSH8CYY+FatSfT7C5m6nccR2xMZ1yxSDFh5OQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 05, 2021 at 04:20:07PM +0800, ZheNing Hu wrote:

> > +       case REF_FORMAT_QUICK_OBJECTNAME_REFNAME:
> > +               printf("%s %s\n", oid_to_hex(oid), refname);
> > +               return 0;
> > +       }
> > +       BUG("unknown ref_format_quick value: %d", format->quick);
> > +}
> > +
> 
> So as a fast path, we actually avoided format_ref_array_item() when we are using
> %(objectname) and %(refname). But the problem is that it’s not very elegant
> (using string compare), and it is no optimization for other atoms that
> require in-depth
> parsing. I remember the "fast path" used by Ævar last time, and it
> seems that Junio doesn't
> like them. [1][2]

Yes, I did say it was "pretty horrible". :)

It was mostly meant as a proof-of-concept to see where the time was
going, and what was possible. It _could_ be used as a stop-gap while
improving the general performance, but it's gross enough that it's
probably not a good idea (it's increased maintenance, but also it
dis-incentivizes fixing the real problems).

-Peff
