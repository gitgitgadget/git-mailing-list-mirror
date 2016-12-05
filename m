Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189811FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 07:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbcLEHSZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 02:18:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:51579 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbcLEHSY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 02:18:24 -0500
Received: (qmail 32733 invoked by uid 109); 5 Dec 2016 07:18:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 07:18:23 +0000
Received: (qmail 2232 invoked by uid 111); 5 Dec 2016 07:19:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 05 Dec 2016 02:19:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2016 02:18:22 -0500
Date:   Mon, 5 Dec 2016 02:18:22 -0500
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Git v2.11.0 breaks max depth nested alternates
Message-ID: <20161205071822.ndeswelgj5epej5k@sigill.intra.peff.net>
References: <fe33de5b5f0b3da68b249cc4a49a6d7@3c843fe6ba8f3c586a21345a2783aa0>
 <49DE271A91214D6DADBD4DE667A1659B@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49DE271A91214D6DADBD4DE667A1659B@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 04, 2016 at 11:22:52AM -0000, Philip Oakley wrote:

> > Ever since 722ff7f876 (receive-pack: quarantine objects until
> > pre-receive accepts, 2016-10-03, v2.11.0), Git has been quarantining
> > objects and packs received during an incoming push into a separate
> > objects directory and using the alternates mechanism to make them
> > available until they are either accepted and moved into the main
> > objects directory or rejected and discarded.
> 
> Is there a step here that after the accepted/rejected stage, it should then
> decrement the limit back to its original value. The problem description
> suggests that might be the case.

No. I thought that at first, too, but this increment happens in the
sub-process which is using the extra level of alternates for its entire
lifetime. So it "resets" it by exiting, and the parent process never
increments its internal value at all.

-Peff
