Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9882D20248
	for <e@80x24.org>; Thu, 14 Mar 2019 00:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfCNAG3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 20:06:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:49960 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726618AbfCNAG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 20:06:29 -0400
Received: (qmail 30406 invoked by uid 109); 14 Mar 2019 00:06:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 00:06:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17597 invoked by uid 111); 14 Mar 2019 00:05:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 20:05:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 20:05:12 -0400
Date:   Wed, 13 Mar 2019 20:05:12 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache bug
Message-ID: <20190314000511.GA31968@sigill.intra.peff.net>
References: <pull.161.git.gitgitgadget@gmail.com>
 <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com>
 <87k1h2bvpb.fsf@evledraar.gmail.com>
 <20190313163516.GA26045@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903132322420.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903132322420.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 11:27:02PM +0100, Johannes Schindelin wrote:

> > We have get_oid_commit() and get_oid_committish() already. Should rebase
> > just be using those? (I think we probably want "commit()", because we do
> > not expect a "pick" line to have a tag, for example.
> 
> I did think about this while developing this patch series, and decided
> against conflating concerns.

Yeah, I'd definitely agree it is a separate topic.

> And I was totally right to do so! Because I do have an internal ticket
> that talks about allowing `reset v2.20.1`, which is a tag, not a commit.

Thanks for that example. I agree it's plausible for somebody to be using
a tag there, so committish() is probably the better option.

(It also doesn't really hurt disambiguation much; in any given repo,
commits tend to be dwarfed by trees and blobs by an order of magnitude,
and tags are even an order of magnitude smaller than commits).

-Peff
