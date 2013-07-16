From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Tue, 16 Jul 2013 02:21:22 -0400
Message-ID: <20130716062122.GA4964@sigill.intra.peff.net>
References: <51E431F1.6050002@ramsay1.demon.co.uk>
 <51E4E0C0.3060604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jul 16 08:21:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyydf-0004Py-PZ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 08:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab3GPGV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 02:21:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:46441 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab3GPGV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 02:21:26 -0400
Received: (qmail 1355 invoked by uid 102); 16 Jul 2013 06:22:47 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Jul 2013 01:22:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jul 2013 02:21:22 -0400
Content-Disposition: inline
In-Reply-To: <51E4E0C0.3060604@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230542>

On Tue, Jul 16, 2013 at 07:57:20AM +0200, Johannes Sixt wrote:

> Am 7/15/2013 19:31, schrieb Ramsay Jones:
> > Sparse issues three "Using plain integer as NULL pointer" warnings.
> > Each warning relates to the use of an '{0}' initialiser expression
> > in the declaration of an 'struct object_info'.
> 
> I question the value of this warning. Initialization with '= {0}' is a
> well-established idiom, and sparse should know about it. Also, plain 0
> *is* a null pointer constant.

I agree with you. It's not a bug, and I think sparse is being overly
picky here; it is missing the forest for the trees in interpreting the
idiom.

Still, it may be worth tweaking in the name of eliminating compiler
noise, since it does not cost us very much to do so (and I believe we
have done so in the past, too).

We could also ask people with sparse to turn off the "use NULL instead
of 0" warning, but I think it _is_ a useful warning elsewhere (even
though it is never a bug, it violates our style guidelines and may be an
indication of a bug). It would be nice if sparse learned to ignore the
warning in this particular idiom, but I am not going to hold my breath
for that.

-Peff
