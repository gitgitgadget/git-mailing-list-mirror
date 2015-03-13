From: Jeff King <peff@peff.net>
Subject: [PATCH 0/7] fix transfer.hiderefs with smart http
Date: Fri, 13 Mar 2015 00:41:01 -0400
Message-ID: <20150313044101.GA18476@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 05:41:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWHPK-00086x-Sx
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 05:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbbCMElG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 00:41:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:60806 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbbCMElF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 00:41:05 -0400
Received: (qmail 30363 invoked by uid 102); 13 Mar 2015 04:41:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 23:41:05 -0500
Received: (qmail 9449 invoked by uid 107); 13 Mar 2015 04:41:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Mar 2015 00:41:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2015 00:41:01 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265391>

I'm experimenting with using transfer.hiderefs on a server, and it's
rather easy to cause a git client to hang when fetching from such a repo
over smart http. Details are in the first patch.

There are 7 patches here, but the entirety of the fix is contained in
the first one. The rest are cleanups and test enhancements I found along
the way. I moved the fix to the front of the series as we probably want
it to go to "maint", but the others can wait (being mostly test
modifications, they should not cause regressions, but they'd possibly
want more cooking time in case I broke the test suite for somebody).

The patches are:

  [1/7]: upload-pack: fix transfer.hiderefs over smart-http

    The fix.

  [2/7]: upload-pack: do not check NULL return of lookup_unknown_object

    A nearby cleanup.

  [3/7]: t: translate SIGINT to an exit
  [4/7]: t: redirect stderr GIT_TRACE to descriptor 4
  [5/7]: t: pass GIT_TRACE through Apache

    These all solve irritations I had when trying to debug the test.

  [6/7]: t5541: move run_with_cmdline_limit to test-lib.sh
  [7/7]: t5551: make EXPENSIVE test cheaper

    I had thought at first that the problem was related to large http
    fetches, but it turned out not to be. But I think these cleanups
    are a good thing, as they increase the default test coverage.

-Peff
