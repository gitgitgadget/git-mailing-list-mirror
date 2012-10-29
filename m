From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] replace: parse revision argument for -d
Date: Mon, 29 Oct 2012 05:04:19 -0400
Message-ID: <20121029090419.GA29464@sigill.intra.peff.net>
References: <807340e40adb1fc97cd97161fe1fabd292bc79c3.1351258394.git.git@drmicha.warpmail.net>
 <20121029065836.GC5102@sigill.intra.peff.net>
 <508E4637.2060903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 10:04:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSlGw-000250-5t
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 10:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758528Ab2J2JE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 05:04:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41960 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758246Ab2J2JEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 05:04:23 -0400
Received: (qmail 17274 invoked by uid 107); 29 Oct 2012 09:05:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 05:05:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 05:04:19 -0400
Content-Disposition: inline
In-Reply-To: <508E4637.2060903@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208606>

On Mon, Oct 29, 2012 at 10:02:47AM +0100, Michael J Gruber wrote:

> Jeff King venit, vidit, dixit 29.10.2012 07:58:
> > On Fri, Oct 26, 2012 at 03:33:27PM +0200, Michael J Gruber wrote:
> > 
> >>  	for (p = argv; *p; p++) {
> >> -		if (snprintf(ref, sizeof(ref), "refs/replace/%s", *p)
> >> +		q = *p;
> >> +		if (get_sha1(q, sha1))
> >> +			warning("Failed to resolve '%s' as a valid ref; taking it literally.", q);
> >> +		else
> >> +			q = sha1_to_hex(sha1);
> > 
> > Doesn't get_sha1 already handle this for 40-byte sha1s (and for anything
> > else, it would not work anyway)?
> 
> What is "this"???
> 
> So far, "git replace -d <rev>" only accepts a full sha1, because it uses
> it literally as a ref name "resf/replace/<rev>" without resolving anything.
> 
> The patch makes it so that <rev> gets resolved to a sha1 even if it is
> abbreviated, and then it gets used.
> 
> Or do you mean the warning?

Sorry, yeah, I meant the warning and fallback.

If I understand correctly, the fallback will never work unless we are
fed a 40-byte sha1. But get_sha1 should always return a 40-byte sha1
without doing any further processing.

-Peff
