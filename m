From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Thu, 4 Feb 2016 06:45:06 -0500
Message-ID: <20160204114506.GA1710@sigill.intra.peff.net>
References: <56B32953.2010908@gmail.com>
 <20160204111307.GA30495@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602041216240.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	szeder@ira.uka.de, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 12:45:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRIM8-0006OO-3w
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 12:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933789AbcBDLpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 06:45:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:37433 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932994AbcBDLpK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 06:45:10 -0500
Received: (qmail 28728 invoked by uid 102); 4 Feb 2016 11:45:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 06:45:10 -0500
Received: (qmail 2468 invoked by uid 107); 4 Feb 2016 11:45:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 06:45:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Feb 2016 06:45:06 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1602041216240.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 04, 2016 at 12:26:19PM +0100, Johannes Schindelin wrote:

> > Hmm. I feel like this case (HEAD points to a branch, then `fetch
> > --prune` deletes it) came up recently and we discussed quieting that
> > warning. But now I cannot seem to find it.
> 
> I am pretty certain that it came up in my patch series:
> 
> 	http://thread.gmane.org/gmane.comp.version-control.git/278538

Good, I'm not going crazy! But my search skills are apparently
atrophying. :)

It looks like we just addressed the git-gc issue there. for-each-ref
uses the "rawref" interface, so it gets fed broken things and warns
about them.

I'm tempted to say that it should just silently ignore broken symrefs,
as they're kind-of a normal thing. But I also think Sebastian's patch to
squelch stderr during completion is quite reasonable, too.

> This is funny: after reading the commit message at
> https://github.com/git/git/commit/0571979b it eludes me why strip=2 should
> be so much faster than short...

:short is slow because it checks for ambiguity. So it has to walk the
dwim_ref() rules backwards, checking if each possibility is an existing
ref.

Whereas strip=2 is literally just skipping past the early bits of the
refname string.

-Peff
