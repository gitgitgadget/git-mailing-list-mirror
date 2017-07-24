Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47D56203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 18:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755895AbdGXSbG (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 14:31:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:47374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755891AbdGXSbF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 14:31:05 -0400
Received: (qmail 9753 invoked by uid 109); 24 Jul 2017 18:31:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 18:31:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11838 invoked by uid 111); 24 Jul 2017 18:31:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 14:31:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 14:31:03 -0400
Date:   Mon, 24 Jul 2017 14:31:03 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Blake <eblake@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-contacts: Add recognition of Reported-by
Message-ID: <20170724183103.b4vbr5xkijj7s7z3@sigill.intra.peff.net>
References: <20170721141530.25907-1-eblake@redhat.com>
 <xmqqbmodj1pa.fsf@gitster.mtv.corp.google.com>
 <a8b47a45-0100-dbef-0bff-fdfdb9cbccb4@redhat.com>
 <xmqqwp71hj5n.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp71hj5n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2017 at 09:03:16AM -0700, Junio C Hamano wrote:

> Eric Blake <eblake@redhat.com> writes:
> 
> > You mean, something like
> >
> > git config --add contacts.autocc Reported-by
> > git config --add contacts.autocc Suggested-by
> >
> > where contacts.autocc would be a new multi-valued config option
> > specifying additional Tag: patterns to scrape out of the commit message?
> 
> Yes, something along that line, and you are correct to point out
> that I should have mentioned the need for command-line override.
> 
> In fact, if you anticipate that the primary use of this contributed
> script is as "send-email --cccmd", then we probably are better off
> doing this without any configuration variables, but just add the
> mechanism for command-line override of the hardcoded default.
> 
> I also should have mentioned the need for a way to say "remove all
> hardcoded default and start from scratch".

There's already some prior art around trailers in the trailer.* config.
I wonder if it would make sense to claim a new key there, like:

  git config trailer.Reported-by.autocc true

If "Reported-by" is a trailer that your project uses, then there may be
some benefit to setting up other config related to it, and this would
mesh nicely. And then potentially other programs besides git-contacts
would want to respect that flag (perhaps send-email would even want to
do it itself; I think it already respects cc and s-o-b headers).

-Peff
