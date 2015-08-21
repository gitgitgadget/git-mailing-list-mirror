From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 7/9] builtin/send-pack.c: Use option parsing API
Date: Fri, 21 Aug 2015 11:06:14 -0400
Message-ID: <20150821150613.GB565@sigill.intra.peff.net>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
 <1439998007-28719-8-git-send-email-dborowitz@google.com>
 <CAGZ79kYSNAqsaj-rWvt1fSbNd+LPpeSSACcX5kHNZPe9+brLiw@mail.gmail.com>
 <CAD0k6qSp5af+N9QvjAxw1M19ytzh_n4repFA1+5Nq6v+px+fPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 17:06:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSntd-0000WV-6P
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 17:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbbHUPGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 11:06:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:48190 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752068AbbHUPGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 11:06:16 -0400
Received: (qmail 32553 invoked by uid 102); 21 Aug 2015 15:06:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 10:06:16 -0500
Received: (qmail 1925 invoked by uid 107); 21 Aug 2015 15:06:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 11:06:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Aug 2015 11:06:14 -0400
Content-Disposition: inline
In-Reply-To: <CAD0k6qSp5af+N9QvjAxw1M19ytzh_n4repFA1+5Nq6v+px+fPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276303>

On Wed, Aug 19, 2015 at 03:46:25PM -0400, Dave Borowitz wrote:

> >> +       unsigned dry_run = 0;
> >> +       unsigned send_mirror = 0;
> >> +       unsigned force_update = 0;
> >> +       unsigned quiet = 0;
> >> +       unsigned push_cert = 0;
> >> +       unsigned use_thin_pack = 0;
> >> +       unsigned atomic = 0;
> >> +       unsigned stateless_rpc = 0;
> >
> > First I thought:
> >     You could write to the args flags directly from the options. No
> > need to have (most of)
> >     the variables around here and copy over the values. You'd need to
> > use OPT_BIT instead
> >     for setting a specific bit though
> > but then I realized we do not have a direct bit field in args, which
> > would make it a bit unreadable.
> 
> Right, and &args->push_cert etc. is invalid, and I didn't know if it
> was ok to expand the args struct to be several words longer. But I'm
> not a C programmer so I'm happy to take suggestions how to make this
> more idiomatic.

I think it would be fine to expand it. The reason to use bitfields is to
save memory, and there is literally only one of these structs per
program. I'm sure we can afford the extra dozen bytes.

Making the struct members single-bits also communicates to readers that
they are true booleans, but I think a comment in the declaration of
send_pack_args could do the same.

-Peff
