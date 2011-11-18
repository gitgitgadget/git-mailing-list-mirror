From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] receive-pack, fetch-pack: reject bogus pack that records
 objects twice
Date: Fri, 18 Nov 2011 13:44:55 -0500
Message-ID: <20111118184455.GA13782@sigill.intra.peff.net>
References: <7v7h2znv36.fsf@alter.siamese.dyndns.org>
 <20111118103355.GA4854@sigill.intra.peff.net>
 <7vd3cpl1cw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 19:45:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRTQr-000052-Vs
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 19:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab1KRSo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 13:44:57 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47480
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046Ab1KRSo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 13:44:57 -0500
Received: (qmail 1296 invoked by uid 107); 18 Nov 2011 18:45:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Nov 2011 13:45:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Nov 2011 13:44:55 -0500
Content-Disposition: inline
In-Reply-To: <7vd3cpl1cw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185673>

On Fri, Nov 18, 2011 at 10:41:35AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If we are fixing a thin pack (which should be the case most of the
> > time), we are rewriting the packfile anyway. Shouldn't we just omit
> > the duplicate?
> 
> Excising unwanted objects from the middle of an existing packfile would
> mean you would need an equivalent of memmove() in the file, which amounts
> to really rewriting the packfile, but the thing is, we are _not_ rewriting
> in that sense in "index-pack --fix-thin"; it only appends and adjust the
> fixed-size header.

I thought we took the packfile over --stdin, and we really were
writing the entire thing to disk as we processed it. So we could just
suppress writing the second entry. But I guess there is some complexity
with deltified entries? As in, if the first entry is deltified but the
second is not, you would want to keep the second one?

I'm not complaining if it's really too hard to do in practice, or not
worth the trouble. I just still don't understand what is causing these
and when it would come up.

-Peff
