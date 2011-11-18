From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] receive-pack, fetch-pack: reject bogus pack that records
 objects twice
Date: Fri, 18 Nov 2011 16:08:25 -0500
Message-ID: <20111118210825.GA14710@sigill.intra.peff.net>
References: <7v7h2znv36.fsf@alter.siamese.dyndns.org>
 <20111118103355.GA4854@sigill.intra.peff.net>
 <7vd3cpl1cw.fsf@alter.siamese.dyndns.org>
 <20111118184455.GA13782@sigill.intra.peff.net>
 <7v62ihkzhb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 22:08:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRVfk-0000BC-OC
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 22:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab1KRVI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 16:08:27 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47512
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752Ab1KRVI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 16:08:27 -0500
Received: (qmail 2314 invoked by uid 107); 18 Nov 2011 21:08:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Nov 2011 16:08:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Nov 2011 16:08:25 -0500
Content-Disposition: inline
In-Reply-To: <7v62ihkzhb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185679>

On Fri, Nov 18, 2011 at 11:22:08AM -0800, Junio C Hamano wrote:

> >> > If we are fixing a thin pack (which should be the case most of the
> >> > time), we are rewriting the packfile anyway. Shouldn't we just omit
> >> > the duplicate?
> >> ...
> > ... But I guess there is some complexity
> > with deltified entries? As in, if the first entry is deltified but the
> > second is not, you would want to keep the second one?
> 
> I think you answered your own question here; it is not "some complexity"
> but is exactly the "you need to memmove() in the output file" situation in
> the message you are responding to.
> 
> Upon seeing a delta, you would not know if the same object as this delta
> represents appears later in the pack stream, which means until you read to
> the end you wouldn't know.  You obviously would not want to hold onto all
> deltas in-core to "just omit the duplicate".

OK, that makes sense to me. It's nice to hear it confirmed from somebody
who obviously thought more about it.

-Peff
