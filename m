Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50B371F461
	for <e@80x24.org>; Fri, 28 Jun 2019 23:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfF1Xzf (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 19:55:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:54678 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726643AbfF1Xzf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 19:55:35 -0400
Received: (qmail 15979 invoked by uid 109); 28 Jun 2019 23:55:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jun 2019 23:55:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21963 invoked by uid 111); 28 Jun 2019 23:56:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 19:56:26 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 19:55:33 -0400
Date:   Fri, 28 Jun 2019 19:55:33 -0400
From:   Jeff King <peff@peff.net>
To:     "Vanak, Ibrahim" <ibrahim.vanak@hpe.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: GIT issue while cloning (fatal: pack is corrupted (SHA1
 mismatch)) !!!
Message-ID: <20190628235532.GA2625@sigill.intra.peff.net>
References: <20190528093728.GA15106@sigill.intra.peff.net>
 <TU4PR8401MB1216A7B920D40B5063123A94E11E0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190528213004.GF24650@sigill.intra.peff.net>
 <TU4PR8401MB12166DBE2156683ADF28E9A4E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <TU4PR8401MB1216339F1E7A378C45DF9B36E11F0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <20190530115742.GC31607@sigill.intra.peff.net>
 <TU4PR8401MB12163C00148C39F0083C732DE1ED0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <TU4PR8401MB1216962E3F135E850E81E407E1EA0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
 <6e78d3b7-07f2-f635-1dac-c4d98961b8eb@jeffhostetler.com>
 <TU4PR8401MB1216FC788B6A421F8FD82B2EE1FC0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TU4PR8401MB1216FC788B6A421F8FD82B2EE1FC0@TU4PR8401MB1216.NAMPRD84.PROD.OUTLOOK.COM>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 04:18:37PM +0000, Vanak, Ibrahim wrote:

> But HPUX Dev team have seen one significance difference, when they
> were triaging this issue, the ways GIT operations handled by 2 OSs: On
> linux, around 40 processes are spawned for handling a GIT operation
> whereas on HPUX only one process manages the operation. Is there
> something special being written for linux on GIT code ?

On Linux (and any platform that supports pthreads), Git will do the
lstat() operations to refresh the index in parallel. See the
core.preloadIndex option (which I think defaults to true).

If you have a very high-latency lstat() and your build does not have
pthread support, that could be a significant difference.

That might be worth exploring.

-Peff
