Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EA351F4B6
	for <e@80x24.org>; Wed,  3 Jul 2019 17:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfGCRkG (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 13:40:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:58670 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726736AbfGCRkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 13:40:06 -0400
Received: (qmail 19820 invoked by uid 109); 3 Jul 2019 17:40:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Jul 2019 17:40:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26134 invoked by uid 111); 3 Jul 2019 17:40:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Jul 2019 13:40:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2019 13:40:04 -0400
Date:   Wed, 3 Jul 2019 13:40:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Janos Farkas <chexum@gmail.com>,
        git@vger.kernel.org
Subject: Re: 2.22.0 repack -a duplicating pack contents
Message-ID: <20190703174004.GB29348@sigill.intra.peff.net>
References: <CAEXt3sqno7RAtuwQ_OpD3aLkEORLaf6aNeNKGQL0BKezD+wWTw@mail.gmail.com>
 <875zow8i85.fsf@evledraar.gmail.com>
 <20190623180226.GA1100@sigill.intra.peff.net>
 <20190623180825.3ospajjgat3clwiu@dcvr>
 <20190623224244.GB1100@sigill.intra.peff.net>
 <874l4f8h4c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874l4f8h4c.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 11:30:59AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I can't think of some great solution for this case, some thoughts:
> 
>  a. Perhaps we should split the *.keep flag into two things or
>     more.
> 
>     We're using it for all of "I want this *.pack forever"
>     (e.g. debugging) and "I want only this *.pack to contain the data
>     found in it" (I/O & CPU optimization, what Janos wants) and "I'm
>     git.git code avoiding a race with myself" (what you describe in #3).
> 
>     So maybe for the last of those we could also use and understand
>     *.tmp-keep, at which point we wouldn't have this race described in
>     #3. The 1st of those is a *.noprune and the 2nd is *.highlander (but
>     whether it's worth splitting all that out v.s. just having
>     *.tmp-keep is another matter).

Yeah, this is exactly the crux of the problem. We have two very
different things that are not distinguished by the reader. I left some
thoughts elsewhere in the thread:

  https://public-inbox.org/git/20190703173814.GA29348@sigill.intra.peff.net/

-Peff
