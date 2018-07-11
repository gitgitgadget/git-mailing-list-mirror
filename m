Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4BA1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 16:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389691AbeGKQpw (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 12:45:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:55592 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387947AbeGKQpw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 12:45:52 -0400
Received: (qmail 15873 invoked by uid 109); 11 Jul 2018 16:40:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 16:40:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9451 invoked by uid 111); 11 Jul 2018 16:40:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 12:40:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 12:40:41 -0400
Date:   Wed, 11 Jul 2018 12:40:41 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     wchargin@gmail.com, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] sha1-name.c: for ":/", find detached HEAD commits
Message-ID: <20180711164041.GB20988@sigill.intra.peff.net>
References: <20180710154106.5356-1-wchargin@gmail.com>
 <CACsJy8CBJvpKAAtVjrdcuO06WossxcMmqwmSRL9Shr7g+qVySA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CBJvpKAAtVjrdcuO06WossxcMmqwmSRL9Shr7g+qVySA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 05:45:09PM +0200, Duy Nguyen wrote:

> > diff --git a/sha1-name.c b/sha1-name.c
> > index 60d9ef3c7..641ca12f9 100644
> > --- a/sha1-name.c
> > +++ b/sha1-name.c
> > @@ -1650,6 +1650,7 @@ static int get_oid_with_context_1(const char *name,
> >                         struct commit_list *list = NULL;
> >
> >                         for_each_ref(handle_one_ref, &list);
> > +                       head_ref(handle_one_ref, &list);
> 
> When multiple worktrees are used, should we consider all HEADs or just
> current worktree's HEAD?
> 
> This is the latter case, if we should go with the former (I don't
> know, it's a genuine question) then you need one more call:
> other_head_refs().

Oof, I didn't even think about other worktrees. I'd probably say "yes",
as we consider them reachable (and really the intent of this feature
seems to be "find it in any reachable commit").

-Peff
