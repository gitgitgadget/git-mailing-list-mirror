From: Jeff King <peff@peff.net>
Subject: Re: change symlink
Date: Wed, 31 Oct 2012 09:44:32 -0400
Message-ID: <20121031134432.GA24518@sigill.intra.peff.net>
References: <m2mwz3odys.fsf@igel.home>
 <CAH_OBidWxkhG3o4C4OPP4OxyQQfw_fF_h4C9KR9AnoOZ27=9TQ@mail.gmail.com>
 <m2fw4vod81.fsf@igel.home>
 <CAH_OBifch3uuXYHQ1R9vS6xFu8LuY3mUfiPsHcs3F=HMvnBzyg@mail.gmail.com>
 <m27gq7ochp.fsf@igel.home>
 <CAH_OBif=Zr-3GO3CE4D6O3wJJZysB6=vvmA37K6ujTHTr-un7w@mail.gmail.com>
 <m2390vobnh.fsf@igel.home>
 <CAH_OBidmrJsmw1QQ2WONieA1EQmS_Y4WJ8Mu2Mh90tEPU0uWgw@mail.gmail.com>
 <20121031120505.GD30879@sigill.intra.peff.net>
 <20121031123057.GE30879@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 14:44:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTYbB-000831-NH
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 14:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422789Ab2JaNog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 09:44:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45110 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422754Ab2JaNog (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 09:44:36 -0400
Received: (qmail 14246 invoked by uid 107); 31 Oct 2012 13:45:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Oct 2012 09:45:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2012 09:44:32 -0400
Content-Disposition: inline
In-Reply-To: <20121031123057.GE30879@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208818>

On Wed, Oct 31, 2012 at 08:30:57AM -0400, Jeff King wrote:

> Something like this seems to fix it for me, but I am not sure if that
> would affect other callers.
> [...]
> +		return !is_dir || !S_ISGITLINK(istate->cache[pos]->ce_mode);

That's completely wrong, of course. It should be:

  return is_dir && !S_ISGITLINK(...);

(we found an index entry, so if it isn't a directory, then we know that
it is not untracked, and should return 0).

With that, we at least pass the test suite.

-Peff
