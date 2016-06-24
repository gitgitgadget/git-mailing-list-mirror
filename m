Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77A822018A
	for <e@80x24.org>; Fri, 24 Jun 2016 19:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbcFXTKr (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 15:10:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:59891 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750876AbcFXTKq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 15:10:46 -0400
Received: (qmail 29862 invoked by uid 102); 24 Jun 2016 19:10:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:10:46 -0400
Received: (qmail 21721 invoked by uid 107); 24 Jun 2016 19:11:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 15:11:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 15:10:44 -0400
Date:	Fri, 24 Jun 2016 15:10:44 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 2/4] archive-tar: write extended headers for file
 sizes >= 8GB
Message-ID: <20160624191044.GB32118@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
 <20160623232104.GB3668@sigill.intra.peff.net>
 <xmqqwplefm2r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwplefm2r.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 12:01:16PM -0700, Junio C Hamano wrote:

> > @@ -267,7 +281,13 @@ static int write_tar_entry(struct archiver_args *args,
> >  			memcpy(header.linkname, buffer, size);
> >  	}
> >  
> > -	prepare_header(args, &header, mode, size);
> > +	size_in_header = size;
> > +	if (S_ISREG(mode) && size > 077777777777UL) {
> 
> Want a symbolic constant with a comment that says why you have
> eleven 7's?

I tried instead to make sure we only mention it once to avoid a symbolic
constant (even though the same constant appears in the next patch, too,
it would be a mistake to give them the same name; they just happen to be
the same size).

So if anything, I would put a comment here, explaining that ustar cannot
handle anything larger than this, and POSIX mandates it (but I didn't
because the commit message already goes into much more detail).

-Peff
