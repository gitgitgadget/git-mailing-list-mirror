Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC78A20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 08:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeLNIUw (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 03:20:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:41698 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726520AbeLNIUw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 03:20:52 -0500
Received: (qmail 21165 invoked by uid 109); 14 Dec 2018 08:20:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Dec 2018 08:20:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1328 invoked by uid 111); 14 Dec 2018 08:20:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 14 Dec 2018 03:20:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2018 03:20:50 -0500
Date:   Fri, 14 Dec 2018 03:20:50 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/3] serve: pass "config context" through to individual
 commands
Message-ID: <20181214082050.GA11777@sigill.intra.peff.net>
References: <20181211104236.GA6899@sigill.intra.peff.net>
 <20181211104342.GA7233@sigill.intra.peff.net>
 <xmqqo99oeu4u.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo99oeu4u.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 11:09:53AM +0900, Junio C Hamano wrote:

> > diff --git a/ls-refs.h b/ls-refs.h
> > index b62877e8da..da26fc9824 100644
> > --- a/ls-refs.h
> > +++ b/ls-refs.h
> > @@ -4,7 +4,8 @@
> >  struct repository;
> >  struct argv_array;
> >  struct packet_reader;
> > -extern int ls_refs(struct repository *r, struct argv_array *keys,
> > +extern int ls_refs(struct repository *r, const char *config_context,
> > +		   struct argv_array *keys,
> >  		   struct packet_reader *request);
> 
> One thing I wonder is if we want to pass the whole *_opt thing,
> instead of only one field out of it.

I actually started by doing that, but "struct serve_options" is not
currently known by ls-refs.c, upload-pack.c, etc. So they'd have to
start including "serve.h". I don't think that's the end of the world,
but it felt like a funny mutual circular to me (my mental model now is
that ls-refs, upload-pack, etc are low-level commands, tied together by
the "serve" stuff).

-Peff
