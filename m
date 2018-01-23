Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7052F1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbeAWAPD (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:15:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:53930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751128AbeAWAPD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:15:03 -0500
Received: (qmail 12037 invoked by uid 109); 23 Jan 2018 00:15:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 00:15:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12724 invoked by uid 111); 23 Jan 2018 00:15:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Jan 2018 19:15:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jan 2018 19:15:00 -0500
Date:   Mon, 22 Jan 2018 19:15:00 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Gargi Sharma <gs051095@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v5] mru: Replace mru.[ch] with list.h implementation
Message-ID: <20180123001500.GD26357@sigill.intra.peff.net>
References: <1516497964-6041-1-git-send-email-gs051095@gmail.com>
 <20180122073701.h7fh7xrkmnzndzj7@untitled>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180122073701.h7fh7xrkmnzndzj7@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 07:37:01AM +0000, Eric Wong wrote:

> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -859,9 +859,8 @@ static void prepare_packed_git_mru(void)
> >  {
> >  	struct packed_git *p;
> >  
> > -	mru_clear(&packed_git_mru);
> 
> But the removed mru_clear needs to be replaced with:
> 
> +	INIT_LIST_HEAD(&packed_git_mru);
> 
> Otherwise, t3050 never finishes for me.

Good catch. One alternative is to just add any new packs to the end (or
beginning) of the mru list, instead of "resetting" it here. We can do
that because we know that prepare_packed_git() never drops list entries,
but only adds new ones.

I'm OK with it either way, though.

-Peff
