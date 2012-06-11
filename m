From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lessen the impression of unexpectedness on remote hangup
Date: Mon, 11 Jun 2012 15:02:07 -0400
Message-ID: <20120611190207.GA20889@sigill.intra.peff.net>
References: <20120610182310.GB2427@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:02:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9sZ-0003T8-6N
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab2FKTCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 15:02:12 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50272
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab2FKTCK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:02:10 -0400
Received: (qmail 7695 invoked by uid 107); 11 Jun 2012 19:02:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 15:02:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 15:02:07 -0400
Content-Disposition: inline
In-Reply-To: <20120610182310.GB2427@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199702>

On Sun, Jun 10, 2012 at 08:23:10PM +0200, Heiko Voigt wrote:

> If a server accessed through ssh is denying access git will currently
> issue the message
> 
> 	"fatal: The remote end hung up unexpectedly"
> 
> as the last line. This sounds as if something really ugly just happened.
> Since this is a quite typical situation in which users regularly get
> lets just say:
> 
> 	"fatal: The remote end hung up"
> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
> We just got this bug report in msysgit
> 
> https://github.com/msysgit/msysgit/issues/28
> 
> and IIRC there have been more people questioning that line.

This does not seem like it would lessen the surprise all that much. I
wonder if we could use some context about where we are in the protocol
to tell more. For example, if the remote end hangs up before advertising
its refs, it is probably an authentication error or a missing
repository. And we should say that. If it happens during ref negotiation
or during the pack file, then it really is unexpected; the other end has
broken protocol, and it probably makes sense to say so.

-Peff
