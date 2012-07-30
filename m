From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] null sha1 in trees
Date: Mon, 30 Jul 2012 11:42:14 -0400
Message-ID: <20120730154214.GA16701@sigill.intra.peff.net>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <7v8ve2uscw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 17:42:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svs71-0006Pd-4P
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 17:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab2G3PmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 11:42:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41422 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909Ab2G3PmV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 11:42:21 -0400
Received: (qmail 16688 invoked by uid 107); 30 Jul 2012 15:42:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jul 2012 11:42:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jul 2012 11:42:14 -0400
Content-Disposition: inline
In-Reply-To: <7v8ve2uscw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202566>

On Sun, Jul 29, 2012 at 03:15:11PM -0700, Junio C Hamano wrote:

> All looked reasonable, even though I'd want to read the
> surrounding codepath over for 2/3 a few more times.
> 
> Will queue; thanks.

Yeah, 2/3 is the one that gives me the most pause. I originally assumed
we would never want to put a null-sha1 entry into the in-core index, but
that turned out to be very wrong. So I softened my assumption to "we
would never want to put a null-sha1 entry on disk". Which seems like the
right thing to me and passes the test suite, but there might be an
unexercised code path in there.

In an ideal world, I would trace each code path that inserts a cache
entry all the way back to its original sha1, but when I tried it turned
out too complex. The educated-guess-and-see-if-it-passes-tests approach
to coding does not make me happy, but I don't see a good alternative.

Patch 1 is a pure bug-fix, and it would be nice for it to make it onto a
maint- track or into 1.7.12 (though I can't guarantee that I got it 100%
right, I am confident that it is at least trying to do the right thing,
and any fixes would be incremental on top).  The other two should be
fine to cook longer and go in post-1.7.12.

-Peff
