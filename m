Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60211F404
	for <e@80x24.org>; Fri, 30 Mar 2018 17:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeC3RVD (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 13:21:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:48894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751938AbeC3RVC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 13:21:02 -0400
Received: (qmail 20800 invoked by uid 109); 30 Mar 2018 17:21:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 17:21:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29938 invoked by uid 111); 30 Mar 2018 17:22:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 13:22:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 13:21:00 -0400
Date:   Fri, 30 Mar 2018 13:21:00 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Rafael Ascensao <rafa.almas@gmail.com>
Subject: Re: [PATCH 0/8] Re: git complains packed-refs is not a directory
 when used with GIT_DIR and GIT_WORK_TREE envvars.
Message-ID: <20180330172100.GA18648@sigill.intra.peff.net>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
 <20180328181932.GB16565@sigill.intra.peff.net>
 <20180329145726.GA10253@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180329145726.GA10253@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 29, 2018 at 04:57:26PM +0200, Duy Nguyen wrote:

> On Wed, Mar 28, 2018 at 02:19:32PM -0400, Jeff King wrote:
> > 
> > > I will probably rework on top of your chdir-notify instead (and let
> > > yours to be merged earlier)
> > 
> > Thanks. I like some of the related changes you made, like including this
> > in the tracing output. That should be easy to do on top of mine, I
> > think.
> 
> Yeah. But is it possible to sneak something like this in your series
> (I assume you will reroll anyway)? I could do it separately, but it
> looks nicer if it's split out and merged in individual patches that
> add new chdir-notify call site.

Sure.

> -void chdir_notify_register(chdir_notify_callback cb, void *data)
> +void chdir_notify_register(const char *name,
> +			   chdir_notify_callback cb,
> +			   void *data)
>  {
>  	struct chdir_notify_entry *e = xmalloc(sizeof(*e));
>  	e->cb = cb;
>  	e->data = data;
> +	e->name = name;
>  	list_add_tail(&e->list, &chdir_notify_entries);
>  }

I'm tempted to make a copy of the name here (or at least document that
it must remain valid forever).

-Peff
