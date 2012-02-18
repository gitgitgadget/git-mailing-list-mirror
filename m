From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/3]
Date: Fri, 17 Feb 2012 19:51:48 -0500
Message-ID: <20120218005148.GA1940@sigill.intra.peff.net>
References: <7v7gzmxw78.fsf@alter.siamese.dyndns.org>
 <cover.1329472405.git.trast@student.ethz.ch>
 <7v62f5v1d1.fsf@alter.siamese.dyndns.org>
 <7vk43lqbt8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, Jehan Bing <jehan@orb.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 18 01:52:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyYXI-0006P7-3L
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 01:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab2BRAvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 19:51:51 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41291
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab2BRAvu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 19:51:50 -0500
Received: (qmail 13742 invoked by uid 107); 18 Feb 2012 00:51:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 17 Feb 2012 19:51:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2012 19:51:48 -0500
Content-Disposition: inline
In-Reply-To: <7vk43lqbt8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190990>

On Fri, Feb 17, 2012 at 03:28:51PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Thomas Rast <trast@student.ethz.ch> writes:
> > ...
> > I seem to be getting intermittent test failures, and every time the
> > failing tests are different, when these three are queued to 'pu'. I didn't
> > look for what goes wrong and how.
> 
> False alarm. I suspect that it is jb/required-filter topic that is causing
> intermittent failures from convert.c depending on the timing of how fast
> filter subprocess dies vs how fast we consume its result or something.
> 
> Repeatedly running t0021 like this:
> 
>     $ cd t
>     $ while sh t0021-conversion.sh ; do :; done
> 
> under load seems to make it fail every once in a while.
> 
> test_must_fail: died by signal: git add test.fc
> 
> Are we dying on SIGPIPE or something?

I would be unsurprised if that is the case. Joey Hess mentioned similar
issues with hooks a month or two ago. And I have been seeing
intermittent failures of t5541 under load that I traced back to SIGPIPE.
I've been meaning to dig further and come up with a good solution.
Here's some previous discussion:

  http://article.gmane.org/gmane.comp.version-control.git/186291

I'd be happy if we just ignored SIGPIPE everywhere, but turned it on for
the log family.

-Peff
