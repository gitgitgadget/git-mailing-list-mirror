From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 0/13] credential helpers
Date: Fri, 9 Dec 2011 18:39:58 -0500
Message-ID: <20111209233957.GC10560@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <7v7h29fkfy.fsf@alter.siamese.dyndns.org>
 <20111207064231.GA499@sigill.intra.peff.net>
 <7vmxb2hhne.fsf@alter.siamese.dyndns.org>
 <20111209022913.GA2600@sigill.intra.peff.net>
 <7vzkf1fwvn.fsf@alter.siamese.dyndns.org>
 <20111209231800.GA14376@sigill.intra.peff.net>
 <7vehwdcob3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 00:40:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZA2x-00042X-Rb
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528Ab1LIXkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:40:02 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45445
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab1LIXkB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:40:01 -0500
Received: (qmail 9907 invoked by uid 107); 9 Dec 2011 23:46:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Dec 2011 18:46:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Dec 2011 18:39:58 -0500
Content-Disposition: inline
In-Reply-To: <7vehwdcob3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186704>

On Fri, Dec 09, 2011 at 03:34:08PM -0800, Junio C Hamano wrote:

> > We _could_ modify credential_match() to automatically reject such a
> > pattern at that level,...
> 
> I do not think that is such a good idea to modify "match()" function
> either, as I agree match with empty has its uses, but that does not stop
> "rewrite_credential_file()" from being safe by default, no? After all, the
> one that makes the decision to drop things that match the pattern is that
> function (it chooses to give NULL to match_cb).

Yeah, you could move it down to that level, but there isn't much point.
rewrite_credential_file is unique to credential-store, and the only two
callers are store_credential (which has its own, stricter rules already)
and remove_credential, which we are modifying here.

Note that I didn't bother with the same safety valve for
credential-cache. It is, after all, a cache that will go away eventually
anyway, so safety is less interesting.

Third-party helpers will have to do their own checks anyway, as in
general I don't plan on them linking directly against git code.

Speaking of which, I hackishly ported Jay's osxkeychain helper to the
new format last night. I'll try to clean that up and post it tonight.

-Peff
