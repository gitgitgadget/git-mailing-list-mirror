From: Jeff King <peff@peff.net>
Subject: Re: [RFH] git cherry vs. git rev-list --cherry, or: Why does "..."
 suck?
Date: Wed, 23 Mar 2011 13:19:12 -0400
Message-ID: <20110323171912.GD30337@sigill.intra.peff.net>
References: <4D889119.3020009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 18:19:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2RiL-0005ee-6I
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 18:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab1CWRTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 13:19:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40310
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754442Ab1CWRTO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 13:19:14 -0400
Received: (qmail 6893 invoked by uid 107); 23 Mar 2011 17:19:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Mar 2011 13:19:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2011 13:19:12 -0400
Content-Disposition: inline
In-Reply-To: <4D889119.3020009@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169858>

On Tue, Mar 22, 2011 at 01:07:53PM +0100, Michael J Gruber wrote:

> I don't get this:
> 
> git cherry A B: 0.4s
> git rev-list --cherry A...B: 1.7s
> (more details below)
> 
> This makes "rev-list --cherry" almost unacceptable as a replacement. But
> I'd like to understand this difference (and maybe do something about
> it). I'm lost with gprof, but here are more details on the timing:

I don't have much to say on the problem at hand, but have you tried
using the "perf" tool from the kernel to measure? These days it ships in
linux-tools-2.6.x in Debian unstable; I don't know about other distros.

You can do this:

  perf record git cherry $A $B >/dev/null
  perf record git rev-list --cherry $A...$B >/dev/null
  perf diff

to get a list of the hot-spots with the time differences between the two
runs (along with "perf report" and "perf annotate" to get more
information).

Disclaimer: I am very new to perf, so I may be misleading you about how
useful the "diff" would be. In particular, it seems to be based on a
percentages of time spent between two runs. Which is great for two runs
of the same program calling very similar functions. But for two programs
calling _mostly_ the same functions, I don't know how misleading it is.

-Peff
