Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71AE920A21
	for <e@80x24.org>; Fri, 15 Sep 2017 00:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbdIOAno (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 20:43:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:39402 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751599AbdIOAnn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 20:43:43 -0400
Received: (qmail 17034 invoked by uid 109); 15 Sep 2017 00:43:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Sep 2017 00:43:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1500 invoked by uid 111); 15 Sep 2017 00:44:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 20:44:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Sep 2017 20:43:41 -0400
Date:   Thu, 14 Sep 2017 20:43:41 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 6/7] notes-merge: use ssize_t for write_in_full() return
 value
Message-ID: <20170915004341.zwmpkvcvjgifn5zn@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171744.32cmtjkdcp7yf7pt@sigill.intra.peff.net>
 <20170913212035.GN27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913212035.GN27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 02:20:35PM -0700, Jonathan Nieder wrote:

> > --- a/notes-merge.c
> > +++ b/notes-merge.c
> > @@ -302,7 +302,7 @@ static void write_buf_to_worktree(const struct object_id *obj,
> >  	fd = xopen(path, O_WRONLY | O_EXCL | O_CREAT, 0666);
> >  
> >  	while (size > 0) {
> > -		long ret = write_in_full(fd, buf, size);
> > +		ssize_t ret = write_in_full(fd, buf, size);
> >  		if (ret < 0) {
> >  			/* Ignore epipe */
> >  			if (errno == EPIPE)
> > 				break;
> > 			die_errno("notes-merge");
> > 		} else if (!ret) {
> > 			die("notes-merge: disk full?");
> > 		}
> 
> These three lines are dead code.  How about the following, e.g. for
> squashing in?

Thanks, I didn't notice that.

I'd actually prefer it as a separate patch, since it needs explained
separately.

-Peff
