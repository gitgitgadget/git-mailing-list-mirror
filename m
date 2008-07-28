From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] make sure parsed wildcard refspec ends with slash
Date: Mon, 28 Jul 2008 01:41:51 -0400
Message-ID: <20080728054151.GB7294@sigill.intra.peff.net>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com> <1216858043-53646-1-git-send-email-lee.marlow@gmail.com> <20080725204051.GB23202@spearce.org> <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org> <20080726082405.GA10104@sigill.intra.peff.net> <7vvdysb2na.fsf@gitster.siamese.dyndns.org> <7vsktv3l9k.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 07:42:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNLVV-00086d-PJ
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 07:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbYG1Fly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 01:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbYG1Fly
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 01:41:54 -0400
Received: from peff.net ([208.65.91.99]:2512 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbYG1Flx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 01:41:53 -0400
Received: (qmail 29396 invoked by uid 111); 28 Jul 2008 05:41:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 28 Jul 2008 01:41:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2008 01:41:51 -0400
Content-Disposition: inline
In-Reply-To: <7vsktv3l9k.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90406>

On Sat, Jul 26, 2008 at 11:15:51PM -0700, Junio C Hamano wrote:

> > I have a nagging suspicion that it might be a simpler and cleaner change
> > to change parse_refspec_internal() to keep the trailing slash, instead of
> > dropping it.  Then the check you added is not needed (the trailing slash
> > guarantees that the pattern matches at the hierarchy boundary), neither
> > any of the change in this patch.
> 
> This is the other variant, and it turns out that I was right.  Among the
> 64-18 = 46 new lines, 30 are from the new test file.  Two existing
> "matching part is followed by '/'" tests are removed.

Looks like you have already applied it, but I will chime in that of the
two, I think this is the more sensible change. Stripping the '/' felt
like a loss of information to me. IIRC, when "support only /*" was
discussed, the thinking was "let's keep it tight now, and we can loosen
it later." Keeping the '/' means that the code is much more sane if
other globbing rules come in the future.

-Peff
