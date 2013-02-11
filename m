From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Include xmlparse.h instead of expat.h on QNX
Date: Mon, 11 Feb 2013 13:24:11 -0800
Message-ID: <20130211212411.GA19113@ftbfs.org>
References: <1360616395-18912-1-git-send-email-kraai@ftbfs.org>
 <20130211210621.GC32740@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:24:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U50rd-000551-7t
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 22:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635Ab3BKVYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 16:24:13 -0500
Received: from kvm.ftbfs.org ([46.22.115.26]:57397 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932605Ab3BKVYN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 16:24:13 -0500
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1U50rD-0004zb-IZ; Mon, 11 Feb 2013 13:24:11 -0800
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
Content-Disposition: inline
In-Reply-To: <20130211210621.GC32740@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216092>

On Mon, Feb 11, 2013 at 04:06:21PM -0500, Jeff King wrote:
> On Mon, Feb 11, 2013 at 12:59:55PM -0800, Matt Kraai wrote:
> 
> > From: Matt Kraai <matt.kraai@amo.abbott.com>
> > 
> > QNX 6.3.2 through 6.5.0 include Expat 1.1, which provides xmlparse.h
> > instead of expat.h, so include the former on QNX systems.
> 
> So it is not just QNX, but rather older versions of expat?

Yes, Expat 1.1 and 1.2 provide xmlparse.h, whereas 1.95.0 and later
provide expat.h.

> > diff --git a/http-push.c b/http-push.c
> > index 9923441..55c575e 100644
> > --- a/http-push.c
> > +++ b/http-push.c
> > @@ -11,7 +11,11 @@
> >  #include "list-objects.h"
> >  #include "sigchain.h"
> >  
> > +#ifndef __QNX__
> >  #include <expat.h>
> > +#else
> > +#include <xmlparse.h>
> > +#endif
> 
> If that is the case, should this #ifdef look for EXPAT_NEEDS_XMLPARSE_H,
> and that macro triggered externally? Either in the QNX section of the
> Makefile, or potentially by an autoconf macro?

I'll submit another patch shortly that does so, defining the variable
in the QNX section of config.mak.uname.
