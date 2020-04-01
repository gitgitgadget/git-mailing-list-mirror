Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040D3C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61BA20714
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 12:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbgDAMSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:18:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:58198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732169AbgDAMSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 08:18:47 -0400
Received: (qmail 1722 invoked by uid 109); 1 Apr 2020 12:18:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Apr 2020 12:18:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7725 invoked by uid 111); 1 Apr 2020 12:28:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2020 08:28:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Apr 2020 08:18:46 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Konstantin Tokarev <annulen@yandex.ru>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Inefficiency of partial shallow clone vs shallow clone +
 "old-style" sparse checkout
Message-ID: <20200401121846.GB1916590@coredump.intra.peff.net>
References: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
 <20200328144023.GB1198080@coredump.intra.peff.net>
 <decf87bb-dffc-e44e-912e-fe51bc2514c3@gmail.com>
 <20200331214653.GA95875@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200331214653.GA95875@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 03:46:53PM -0600, Taylor Blau wrote:

> On Sat, Mar 28, 2020 at 12:58:41PM -0400, Derrick Stolee wrote:
>
> > This is a good find, and I expect we will find more "opportunities"
> > to insert OBJECT_INFO_SKIP_FETCH_OBJECT like this.

The worst part is that we _did_ find this in git-fetch, and fixed it in
3e96c66805 (partial-clone: avoid fetching when looking for objects,
2020-02-21). But as usual git-clone has its own kind-of-the-same
implementation of the same feature.

> Should we turn this into a proper patch and have it reviewed? It seems
> to be helping the situation, and after thinking about it (only briefly,
> but more than not ;-)), this seems like the right direction.

Yes, I wanted to simplify the test and double-check the addition of
QUICK. See the patch I just posted in:

  https://lore.kernel.org/git/20200401121537.GA1916590@coredump.intra.peff.net/

-Peff
