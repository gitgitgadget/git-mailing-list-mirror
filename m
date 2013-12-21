From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 20/21] t/perf: add tests for pack bitmaps
Date: Sat, 21 Dec 2013 08:40:17 -0500
Message-ID: <20131221134017.GD10123@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
 <20131114124834.GA11612@sigill.intra.peff.net>
 <8761r0ioyo.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sat Dec 21 14:40:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuMn9-0008Hd-4O
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 14:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab3LUNkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 08:40:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:48453 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753217Ab3LUNkS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 08:40:18 -0500
Received: (qmail 5988 invoked by uid 102); 21 Dec 2013 13:40:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 07:40:18 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 08:40:17 -0500
Content-Disposition: inline
In-Reply-To: <8761r0ioyo.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239592>

On Sat, Dec 07, 2013 at 05:51:43PM +0100, Thomas Rast wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +test_perf 'simulated fetch' '
> > +	have=$(git rev-list HEAD --until=1.week.ago -1) &&
> 
> This will give you HEAD if your GIT_PERF_LARGE_REPO hasn't seen any
> activity lately.  I'd prefer something that always takes a fixed commit,
> e.g. HEAD~1000, keeping the perf test reproducible over time (not over
> changing GIT_PERF_LARGE_REPO, of course).

Good point. I just did a "git pull" on the kernel before my tests, but
of course the same test with my 3-week-stale repo would be a lot less
interesting.

I tried to figure out what is the right N for HEAD~N to represent a
week's worth of commits. It turns out the kernel is really bursty
depending on where they are in the cycle. Sometimes N is 50, and
sometimes 200. I'm picking 100. It doesn't have to be a week; the main
goal was to approximate "here's how it performs if you don't repack for
a week", so anything in the ballpark is fine.

-Peff
