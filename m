Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FE3C1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 14:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeCCO1u (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 09:27:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:45880 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751863AbeCCO1t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 09:27:49 -0500
Received: (qmail 3424 invoked by uid 109); 3 Mar 2018 14:27:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 03 Mar 2018 14:27:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6535 invoked by uid 111); 3 Mar 2018 14:28:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Mar 2018 09:28:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Mar 2018 09:27:47 -0500
Date:   Sat, 3 Mar 2018 09:27:47 -0500
From:   Jeff King <peff@peff.net>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, olyatelezhnaya@gmail.com,
        christian.couder@gmail.com, Git Mailing List <git@vger.kernel.org>
Subject: Re: t006 broken under Mac OS
Message-ID: <20180303142747.GA28218@sigill.intra.peff.net>
References: <f711d7ea-b3a0-82c4-6700-5ec285c91115@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f711d7ea-b3a0-82c4-6700-5ec285c91115@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 03, 2018 at 01:52:05PM +0100, Torsten Bögershausen wrote:

> Beside that t1006 has a broken indentation (mixed spaces and TABs at
>  the beginning of the line, I get 4 errors here under Mac OS:
> 
> not ok 15 - Check %(refname) gives empty output
> not ok 36 - Check %(refname) gives empty output
> not ok 58 - Check %(refname) gives empty output
> not ok 89 - Check %(refname) gives empty output
> 
> 
> Running with debug and verbose shows that the empty files are not empty.
> The characters in the non-empty file are outside the ASCII range,
> so I copy  the stuff in here after running `od -c`  on the log file.
> And I don't have a clue, where this stuff comes from - but I get different
> "crap" with each run - seams as if there is a read behind a buffer ?

Yeah, I think the ref_array_item.refname flex-parameter is not valid.
This is the same issue Ramsay mentioned in:

  https://public-inbox.org/git/58b2bdcd-d621-fd21-ab4d-6a9478319b19@ramsayjones.plus.com/

Junio, I think it probably makes sense to eject ot/cat-batch-format from
pu for now. That series is on pause for a bit while Olga works on some
other refactoring, and it's causing problems for people who test pu
regularly.

-Peff
