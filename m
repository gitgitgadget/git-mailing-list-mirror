From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cherry-pick -x: add newline before pick note
Date: Tue, 16 Nov 2010 14:30:18 -0500
Message-ID: <20101116193018.GA31036@sigill.intra.peff.net>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Martin Svensson <martin.k.svensson@netinsight.se>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 16 20:30:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIREd-0000dQ-2l
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 20:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757313Ab0KPTaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 14:30:21 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59859 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756304Ab0KPTaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 14:30:20 -0500
Received: (qmail 31324 invoked by uid 111); 16 Nov 2010 19:30:19 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 16 Nov 2010 19:30:19 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Nov 2010 14:30:18 -0500
Content-Disposition: inline
In-Reply-To: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161580>

On Tue, Nov 16, 2010 at 04:11:17PM +0100, Michael J Gruber wrote:

> Currently, cherry-pick -x sticks the pick note immediately after the
> existing commit message. This
> 
> * is bad for commits with 1 line subject (it makes a 2 line subject)
> * is different from git-svn, e.g., which leaves an empty line before.
> 
> Make cherry-pick always insert an empty line before the pick note.

Hmm. Should this respect pseudo-header blocks at the end? E.g., if I
have:

  message subject

  Message body.

  Signed-off-by: Jeff King <peff@peff.net>

shouldn't it result in:

  message subject

  Message body.

  (cherry picked from commit ...)

  Signed-off-by: Jeff King <peff@peff.net>

?

Even better, I wonder if it should actually be:

  message subject

  Message body.

  Signed-off-by: Jeff King <peff@peff.net>
  Cherry-picked-from: ...

And then you could actually sign off the cherry-pick separately, too, if
you wanted, by adding a line _below_ the cherry-picked-from. I have no
idea if people are trying to grep for "cherry picked from commit...",
which my proposal would break.

Note that none of this is introduced by your patch. The current output
for this case is terribly ugly. But I thought I would mention it, as my
third version means we _do_ want the current behavior in some cases
(i.e., when there is already a pseudo-header block).

-Peff
