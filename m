Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652C61F404
	for <e@80x24.org>; Wed,  4 Apr 2018 21:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeDDVOt (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 17:14:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:53748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751749AbeDDVOs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 17:14:48 -0400
Received: (qmail 26108 invoked by uid 109); 4 Apr 2018 21:14:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Apr 2018 21:14:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8430 invoked by uid 111); 4 Apr 2018 21:15:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 04 Apr 2018 17:15:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2018 17:14:46 -0400
Date:   Wed, 4 Apr 2018 17:14:46 -0400
From:   Jeff King <peff@peff.net>
To:     Michal Nazarewicz <mina86@mina86.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Michael Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] send-email: fix docs regarding storing password with git
 credential
Message-ID: <20180404211446.GC15402@sigill.intra.peff.net>
References: <xmqqk1tpxo0g.fsf@gitster-ct.c.googlers.com>
 <20180402232348.20293-1-mina86@mina86.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180402232348.20293-1-mina86@mina86.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 03, 2018 at 12:23:48AM +0100, Michal Nazarewicz wrote:

> First of all, ‘git credential fill’ does not store credentials
> but is used to *read* them.  The command which adds credentials
> to the helper’s store is ‘git credential approve’.

Yep, makes sense (I wish we had just called these consistently "get",
"store", and "erase" as they are in the git<->helper interface).

> Second of all, git-send-email will include port number in host
> parameter when getting the password so it has to be set when
> storing the password as well.
> 
> Apply the two above to fix the Gmail example in git-send-email
> documentation.

Makes sense. This is an interesting counter-example to my earlier "well,
it usually works out in the long run" statement. Because usually you're
relying on some part of Git to issue the "fill" and the "approve", so
whatever it uses, it will be the same. But here we're trying to
pre-seed, so we have to match what the tool will do.

On the other hand, I'm not sure why we need to pre-seed here. Wouldn't
it be sufficient to just issue a "git send-email", which would then
prompt for the password? And then you'd input your generated token,
which would get saved via the approve mechanism?

-Peff
