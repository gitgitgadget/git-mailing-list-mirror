From: Jeff King <peff@peff.net>
Subject: Re: RLIMIT_NOFILE fallback
Date: Wed, 18 Dec 2013 16:40:01 -0500
Message-ID: <20131218214001.GA14354@sigill.intra.peff.net>
References: <20131218171446.GA19657@kitenet.net>
 <xmqqy53ihwe4.fsf@gitster.dls.corp.google.com>
 <20131218191702.GA9083@sigill.intra.peff.net>
 <xmqq61qmhrb3.fsf@gitster.dls.corp.google.com>
 <20131218212847.GA13685@sigill.intra.peff.net>
 <xmqqd2kthmcr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 22:40:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtOqi-000650-D4
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 22:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab3LRVkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 16:40:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:46936 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753645Ab3LRVkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 16:40:05 -0500
Received: (qmail 9231 invoked by uid 102); 18 Dec 2013 21:40:05 -0000
Received: from va-71-48-137-223.dhcp.embarqhsd.net (HELO sigill.intra.peff.net) (71.48.137.223)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Dec 2013 15:40:05 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Dec 2013 16:40:01 -0500
Content-Disposition: inline
In-Reply-To: <xmqqd2kthmcr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239491>

On Wed, Dec 18, 2013 at 01:37:24PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > According to the POSIX quote above, it sounds like we could do:
> >
> >   #if defined (_SC_OPEN_MAX)
> >   {
> >           long max;
> >           errno = 0;
> >           max = sysconf(_SC_OPEN_MAX);
> >           if (0 < max) /* got the limit */
> >                   return max;
> >           else if (!errno) /* unlimited, cast to int-max */
> >                   return max;
> >           /* otherwise, fall through */
> >   }
> >   #endif
> >
> > Obviously you could collapse the two branches of the conditional, though
> > I think it deserves at least a comment to explain what is going on.
> 
> Yes, that is locally OK, but depending on how the caller behaves, we
> might need to have an extra saved_errno dance here, which I didn't
> want to get into...

I think we are fine. The only caller is about to clobber errno by
closing packs anyway.

-Peff
