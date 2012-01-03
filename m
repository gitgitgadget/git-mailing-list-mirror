From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] expanded hook api with stdio support
Date: Tue, 3 Jan 2012 15:06:42 -0500
Message-ID: <20120103200642.GH20926@sigill.intra.peff.net>
References: <1325207240-22622-1-git-send-email-joey@kitenet.net>
 <1325207240-22622-2-git-send-email-joey@kitenet.net>
 <4EFD88CB.3050403@kdbg.org>
 <7vsjjwtvf1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Joey Hess <joey@kitenet.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 21:06:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiAdF-0002NA-TL
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 21:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab2ACUGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 15:06:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55549
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731Ab2ACUGp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 15:06:45 -0500
Received: (qmail 9606 invoked by uid 107); 3 Jan 2012 20:13:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jan 2012 15:13:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2012 15:06:42 -0500
Content-Disposition: inline
In-Reply-To: <7vsjjwtvf1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187887>

On Tue, Jan 03, 2012 at 11:53:22AM -0800, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > IMO, as the first step, the user of this infrastructure should only be
> > required to construct the hook input as a strbuf, and receive the hook
> > output, if needed, also as a strbuf.
> 
> Now you brought it up, I think I would agree. The only reason I suggested
> a callback feeder approach was because I somehow was hoping that it may be
> possible to share more code with the codepath for textconv that may not
> want to hold too much buffer in core when we know the data is only used
> sequencially and I wanted to see more things to go through streaming API
> in the future.

Even if we don't make the input streaming, it would be nice to factor
the concept of "feed input to program and read its output without
deadlocking" into something independent of hooks.

The credential helper code could potentially have the same deadlock.
Possibly also clean/smudge filters.

Maybe it could even be part of the run-command interface?

-Peff
