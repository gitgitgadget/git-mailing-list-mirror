Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A37620986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbcJDVcp (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:32:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:52423 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753107AbcJDVco (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:32:44 -0400
Received: (qmail 21598 invoked by uid 109); 4 Oct 2016 21:32:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 21:32:44 +0000
Received: (qmail 10827 invoked by uid 111); 4 Oct 2016 21:33:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 17:33:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 17:32:41 -0400
Date:   Tue, 4 Oct 2016 17:32:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 12/18] alternates: use a separate scratch space
Message-ID: <20161004213241.ihzkl7cohliavydg@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203551.tmqp5rll6nqkewxz@sigill.intra.peff.net>
 <xmqqk2dnssz9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk2dnssz9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 02:29:46PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >  extern struct alternate_object_database {
> >  	struct alternate_object_database *next;
> > +
> >  	char *name;
> > -	char base[FLEX_ARRAY]; /* more */
> > +	char *scratch;
> > +
> > +	char path[FLEX_ARRAY];
> >  } *alt_odb_list;
> 
> It is not wrong per-se, but I am a bit surprised to see that the
> code keeps FLEX_ARRAY _and_ uses a separate malloc'ed area pointed
> at by the scratch pointer.

Yeah, there's really no reason "path" could not become a non-flex
buffer. I mostly left it there out of inertia. If you have a preference,
I'm happy to change it.

-Peff
