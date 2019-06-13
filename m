Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652B01F462
	for <e@80x24.org>; Thu, 13 Jun 2019 19:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfFMTCc (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 15:02:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:54258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727307AbfFMTCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 15:02:32 -0400
Received: (qmail 3980 invoked by uid 109); 13 Jun 2019 19:02:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jun 2019 19:02:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21088 invoked by uid 111); 13 Jun 2019 19:03:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Jun 2019 15:03:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2019 15:02:30 -0400
Date:   Thu, 13 Jun 2019 15:02:30 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] t: add t0016-oidmap.sh
Message-ID: <20190613190229.GB27217@sigill.intra.peff.net>
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
 <20190609044907.32477-3-chriscool@tuxfamily.org>
 <20190609092259.GB24208@szeder.dev>
 <20190613171913.GA14055@sigill.intra.peff.net>
 <20190613175236.GF31952@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190613175236.GF31952@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 13, 2019 at 07:52:36PM +0200, SZEDER Gábor wrote:

> > At the point where we are normalizing byte order of the hashes, I have
> > to wonder: why do we care about testing the hash value in the first
> > place? We care that oidmap can store and retrieve values, and that it
> > performs well. But as long as it does those things, I don't think
> > anybody cares if it uses the first 4 bytes of the sha1 or the last 4.
> > 
> > I know there are testing philosophies that go to this level of
> > white-box testing, but I don't think we usually do in Git. A unit
> > test of oidmap's externally visible behavior seems like the right
> > level to me.
> 
> That's a good point...  but then why does 't0011-hashmap.sh' do it in
> the first place?  As far as I understood this t0016 mainly follows
> suit of t0011.

I'd make the same argument against t0011. :)

I think there it at least made a little more sense because we truly are
hashing ourselves, rather than just copying out some sha1 bytes. But I
think I'd still argue that if I updated strhash() to use a different
hash, I should not have to be updating t0011 to change out the hashes.

-Peff
