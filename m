From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] remove the impression of unexpectedness when access
 is denied
Date: Tue, 7 May 2013 14:39:37 -0400
Message-ID: <20130507183937.GA5776@sigill.intra.peff.net>
References: <20120610182310.GB2427@book.hvoigt.net>
 <20120611190207.GA20889@sigill.intra.peff.net>
 <20120614071259.GA51076@book.hvoigt.net>
 <7v395xg6oh.fsf@alter.siamese.dyndns.org>
 <20120614203712.GA51783@book.hvoigt.net>
 <20120619182449.GA99957@book.hvoigt.net>
 <20130504031001.GA3734@elie.Belkin>
 <7vr4hktddq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 20:39:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZmnh-0002qi-1z
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 20:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab3EGSjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 14:39:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:50047 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602Ab3EGSjk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 14:39:40 -0400
Received: (qmail 27758 invoked by uid 102); 7 May 2013 18:40:01 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 May 2013 13:40:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2013 14:39:37 -0400
Content-Disposition: inline
In-Reply-To: <7vr4hktddq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223591>

On Mon, May 06, 2013 at 07:02:41AM -0700, Junio C Hamano wrote:

> >    Would it make sense for the server to send an "ERR" packet to give
> >    a more helpful diagnosis?
> 
> I think git-daemon does so (or at least attempts to do so);
> path_ok() uses enter_repo() to check if the given path is a
> repository, returns NULL to run_service(), whichh in turn calls
> daemon_error() that does the ERR thing.

Yeah, that went into v1.7.8. Do we have any simple way to find out which
version kernel.org is running? They should probably also turn on the
--informative-errors option, as they do not (AFAIK) have any private
repos whose information could be leaked by better error messages.

If they are running v1.7.8 and it is not producing an ERR message, then
I think there is a bug.

> >  * The error message is the same whether the server returned no
> >    response or an incomplete pkt-line.  Maybe in the latter case it
> >    should print the "hung up unexpectedly" thing.
> 
> OK.

I made a stab at this some time ago:

  http://article.gmane.org/gmane.comp.version-control.git/112189

There were some follow-up comments, and I remember trying to make
something work with processing remote stderr, but running into
complications. Alas, I don't remember any more details than that. But
maybe it helps.

-Peff
