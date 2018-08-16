Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F751F404
	for <e@80x24.org>; Thu, 16 Aug 2018 16:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392165AbeHPTFE (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 15:05:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:57672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392162AbeHPTFE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 15:05:04 -0400
Received: (qmail 6993 invoked by uid 109); 16 Aug 2018 16:05:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Aug 2018 16:05:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16765 invoked by uid 111); 16 Aug 2018 16:05:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 12:05:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 12:05:40 -0400
Date:   Thu, 16 Aug 2018 12:05:40 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ulrich.Windl@rz.uni-regensburg.de,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: non-smooth progress indication for git fsck and git gc
Message-ID: <20180816160539.GB22739@sigill.intra.peff.net>
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de>
 <CACsJy8Dukjw_PKQXMTxwd_C3juA_0cqZSjb=1L2wKqtJoC3rkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Dukjw_PKQXMTxwd_C3juA_0cqZSjb=1L2wKqtJoC3rkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 05:18:51PM +0200, Duy Nguyen wrote:

> > During "git gc" the writing objects phase did not update for some
> > seconds, but then the percentage counter jumped like from 15% to
> > 42%.
> [...]
> 
> Is it possible to make this repository public? You can also use "git
> fast-export --anonymize" to make a repo with same structure but no
> real content (but read the man page about that option first)

Try this:

-- >8 --
git init repo
cd repo

# one big blob
dd if=/dev/urandom of=big bs=1M count=100
git add big
git commit -m big

# several small blobs
for i in $(seq 10); do
  echo $i >file
  git add file
  git commit -m $i
done

git gc
-- >8 --

It "stalls" at 33%, and then jumps straight to 100%.

-Peff
