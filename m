From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Tue, 14 Feb 2012 15:38:01 -0500
Message-ID: <20120214203801.GB23291@sigill.intra.peff.net>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
 <201202131944.50886.jnareb@gmail.com>
 <20120213220917.4cf14eb1@gmail.com>
 <201202141831.59699.jnareb@gmail.com>
 <20120214192340.2d473866@gmail.com>
 <20120214185233.GA12072@sigill.intra.peff.net>
 <20120214210453.16c6bd2e@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:38:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxP8s-0002Tm-1v
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760898Ab2BNUiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 15:38:08 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35876
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757213Ab2BNUiG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:38:06 -0500
Received: (qmail 11183 invoked by uid 107); 14 Feb 2012 20:45:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 15:45:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 15:38:01 -0500
Content-Disposition: inline
In-Reply-To: <20120214210453.16c6bd2e@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190756>

On Tue, Feb 14, 2012 at 09:04:53PM +0100, Micha=C5=82 Kiedrowicz wrote:

> Sure, now it's a simple algorithm, but if we add more code, we will
> have problems with making it consistent in both gitweb and
> diff-highlight (which is nice-to-have IMO).

True. I was thinking they would stay simple enough that porting feature=
s
wouldn't be too painful. But that might be overly optimistic.

> Note that my patches to gitweb already support combined diffs (in
> obvious cases) while diff-highlight will fail on them badly (see for
> example 09bb4eb4f14c).  I haven't done it in diff-highlight because I
> noticed that problem while working on patches for gitweb.

Hmm. 09bb4eb4f14c looks fine to me, because all of the combined lines
are from the left-hand side. A better example is 4802997, where the
first hunk properly highlights, but the second does not (because we
interpret the lines as context lines).

Even worse is "git show 5de89d3 -- notes-cache.c", where we match a "- =
"
line with a "++" line, and erroneously think the changes begin in the
second character (even though it is simply a combined-diff marker).

These are reasonably rare, so I don't consider them critical bugs, but
yeah, it would be nice to fix.

-Peff
