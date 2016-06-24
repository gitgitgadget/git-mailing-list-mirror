Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916C82018A
	for <e@80x24.org>; Fri, 24 Jun 2016 13:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbcFXNNa (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 09:13:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:59646 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751315AbcFXNNa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 09:13:30 -0400
Received: (qmail 14631 invoked by uid 102); 24 Jun 2016 13:13:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 09:13:29 -0400
Received: (qmail 19158 invoked by uid 107); 24 Jun 2016 13:13:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 09:13:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 09:13:25 -0400
Date:	Fri, 24 Jun 2016 09:13:25 -0400
From:	Jeff King <peff@peff.net>
To:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 4/4] archive-tar: drop return value
Message-ID: <20160624131325.GA28941@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
 <20160623232158.GD3668@sigill.intra.peff.net>
 <1865881092.716701.1466768964884.JavaMail.zimbra@ensimag.grenoble-inp.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1865881092.716701.1466768964884.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 01:49:24PM +0200, Remi Galan Alfonso wrote:

> Hi Peff,
> 
> Jeff King <peff@peff.net> writes:
> > @@ -413,7 +411,7 @@ static int write_tar_archive(const struct archiver *ar,
> >  {
> >          int err = 0;
> >  
> > -        err = write_global_extended_header(args);
> > +        write_global_extended_header(args);
> >          if (!err)
> >                  err = write_archive_entries(args, write_tar_entry);
> 
> If we drop the error code from 'write_global_extended_header' then the
> above 'if (!err)' becomes useless (always evaluates to 'true' since
> 'err' is set to '0').

Thanks, you're right.

I wondered if we could drop "err" entirely, but write_archive_entries()
does indeed have some error code paths (everybody uses write_or_die, but
we return an error for things like unknown file types).

-Peff
