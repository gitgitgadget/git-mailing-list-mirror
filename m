Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0881FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 19:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbdFSTnS (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 15:43:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:44900 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751024AbdFSTnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 15:43:16 -0400
Received: (qmail 22146 invoked by uid 109); 19 Jun 2017 19:37:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Jun 2017 19:37:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31019 invoked by uid 111); 19 Jun 2017 19:43:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jun 2017 15:43:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jun 2017 15:43:15 -0400
Date:   Mon, 19 Jun 2017 15:43:15 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/28] Create a reference backend for packed refs
Message-ID: <20170619194315.tzdmo7xel2dztoju@sigill.intra.peff.net>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
 <xmqqzid3stdw.fsf@gitster.mtv.corp.google.com>
 <xmqqvanrsru4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvanrsru4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 12:25:07PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Is the iterator over packed-refs correctly skipping over what are
> > covered by loose refs?  The entries in the packed-refs file that are
> > superseded by loose refs should be allowed to point at an already
> > expired object.
> 
> Here it is in a test form for easier diagnosis.

Thanks, I was just starting to do that myself. The problem is in
ca6b06eb7 (packed_ref_store: support iteration, 2017-05-15) and is
pretty obvious: the packed_ref iterator checks whether the entry
resolves.

I think that _neither_ of the loose and packed iterators should be
checking this. It's only the merged result (where loose trumps packed)
that should bother checking.

-Peff
