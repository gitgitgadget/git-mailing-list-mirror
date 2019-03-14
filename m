Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A03F220248
	for <e@80x24.org>; Thu, 14 Mar 2019 00:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfCNA0r (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 20:26:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:50054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726218AbfCNA0r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 20:26:47 -0400
Received: (qmail 31155 invoked by uid 109); 14 Mar 2019 00:26:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 00:26:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17728 invoked by uid 111); 14 Mar 2019 00:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 20:25:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 20:25:30 -0400
Date:   Wed, 13 Mar 2019 20:25:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] gc: remove redundant check for gc_auto_threshold
Message-ID: <20190314002530.GF31968@sigill.intra.peff.net>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
 <20190313235439.30439-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313235439.30439-2-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 12:54:35AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Checking gc_auto_threshold in too_many_loose_objects() was added in
> 17815501a8 ("git-gc --auto: run "repack -A -d -l" as necessary.",
> 2007-09-17) when need_to_gc() itself was also reliant on
> gc_auto_pack_limit before its early return:
> 
>     gc_auto_threshold <= 0 && gc_auto_pack_limit <= 0
> 
> When that check was simplified to just checking "gc_auto_threshold <=
> 0" in b14d255ba8 ("builtin-gc.c: allow disabling all auto-gc'ing by
> assigning 0 to gc.auto", 2008-03-19) this unreachable code should have
> been removed. We only call too_many_loose_objects() from within
> need_to_gc() itself, which will return if this condition holds, and in
> cmd_gc() which will return before ever getting to "auto_gc &&
> too_many_loose_objects()" if "auto_gc && !need_to_gc()" is true
> earlier in the function.

Yep, this is an obvious good cleanup.

-Peff
