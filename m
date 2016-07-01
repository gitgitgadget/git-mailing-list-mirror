Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2251FE4E
	for <e@80x24.org>; Fri,  1 Jul 2016 06:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbcGAGJp (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 02:09:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:38747 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750924AbcGAGJo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 02:09:44 -0400
Received: (qmail 24350 invoked by uid 102); 1 Jul 2016 06:09:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:09:45 -0400
Received: (qmail 13692 invoked by uid 107); 1 Jul 2016 06:10:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 02:10:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 02:09:40 -0400
Date:	Fri, 1 Jul 2016 02:09:40 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v4 0/5] Better ref summary alignment in "git fetch"
Message-ID: <20160701060940.GA5341@sigill.intra.peff.net>
References: <20160605031141.23513-1-pclouds@gmail.com>
 <20160626055810.26960-1-pclouds@gmail.com>
 <20160627184354.GA9594@sigill.intra.peff.net>
 <CACsJy8DS3n=7sRGztqe16igrsVaKt3Qa-GRVJBMoZvtEJmdmQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DS3n=7sRGztqe16igrsVaKt3Qa-GRVJBMoZvtEJmdmQA@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 30, 2016 at 06:16:09PM +0200, Duy Nguyen wrote:

> > I've shrunk it a bit to fit in the email; my actual "long" name was much
> > larger. And the average length for the shorter ones is, too, but the
> > overall effect is the same; almost every line has a huge run of
> > whitespace. And some lines wrap that would not have even under the
> > normal, duplicated scheme.
> 
> I was about to resend with s/\$/*/g and ignored this issue (with a
> note) then it occurred to me we can simply ignore these long lines
> from column width calculation. Yeah such a line may still be wrapped
> around, but it will not push every other line to the far right. We
> already have code for that in adjust_refcol_width()
> 
>         max    = term_columns();
>         ...
>         /*
>         * rough estimation to see if the output line is too long and
>         * should not be counted (we can't do precise calculation
>         * anyway because we don't know if the error explanation part
>         * will be printed in update_local_ref)
>         */
>         if (21 /* flag and summary */ + rlen + 4 /* -> */ + llen >= max)
>                 return;
>         ...
> 
> we can limit max to, like, term_columns() / 2 (or 2/3 of
> term_columns). There's no perfect number, some people will still find
> the output ugly _often_. But hopefully the majority won't. What do you
> think?

Without having seen the output, my gut feeling is "meh". It will
hopefully avoid the wrapping, and it will reduce the size of the huge
whitespace gap, but not eliminate it. So I think it will still be
somewhat ugly.

-Peff
