Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A57191F453
	for <e@80x24.org>; Wed,  1 May 2019 18:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfEASJj (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 14:09:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:46010 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725973AbfEASJj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 14:09:39 -0400
Received: (qmail 23206 invoked by uid 109); 1 May 2019 18:09:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 18:09:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20708 invoked by uid 111); 1 May 2019 18:10:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 14:10:13 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 14:09:37 -0400
Date:   Wed, 1 May 2019 14:09:37 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with
 write_block_or_die()
Message-ID: <20190501180936.GB4109@sigill.intra.peff.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com>
 <20190413013451.GB2040@sigill.intra.peff.net>
 <xmqqzhouwizg.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1904261028220.45@tvgsbejvaqbjf.bet>
 <xmqqd0l8tjph.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1904291732370.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1904291732370.45@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 29, 2019 at 05:32:50PM -0400, Johannes Schindelin wrote:

> > Another is that I am not sure how your "fixed format" argument
> > meshes with the "-b blocksize" parameter to affect the tar/pax
> > output.  The format may be fixed, but it is parameterized.  If
> > we ever need to grow the ability to take "-b", having the knowledge
> > that our current code is limited to the fixed BLOCKSIZE in a single
> > function (i.e. the caller of this function , not the callee) would
> > be less error prone.
> 
> This argument would hold a lot more water if the following lines were not
> part of archive-tar.c:
> 
> 	#define RECORDSIZE      (512)
> 	#define BLOCKSIZE       (RECORDSIZE * 20)
> 
> 	static char block[BLOCKSIZE];
> 
> If you can tell me how the `-b` (run-time) parameter can affect the
> (compile-time) `BLOCKSIZE` constant, maybe I can start to understand your
> concern.

FWIW, I agree with you here. These patches are not making anything worse
(and may even make them better, since we'd probably need to swap out the
BLOCKSIZE constant for a run-time "blocksize" variable in fewer places).

-Peff
