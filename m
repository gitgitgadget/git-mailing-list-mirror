From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] performance regression in mark_edges_uninteresting
Date: Mon, 20 Jan 2014 16:28:45 -0500
Message-ID: <20140120212845.GA11451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 22:28:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5MOq-00042u-DI
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 22:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbaATV2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 16:28:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:35843 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750823AbaATV2r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 16:28:47 -0500
Received: (qmail 14135 invoked by uid 102); 20 Jan 2014 21:28:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 15:28:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jan 2014 16:28:45 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240726>

This series fixes a rev-list performance regression in fbd4a70 (list-objects:
mark more commits as edges in mark_edges_uninteresting, 2013-08-16).  That
commit is a little tricky because it actually _knows_ it's trading off CPU for
a better packfile, but I think we're performing the tradeoff in too many
places. See the second commit for details.

  [1/2]: t/perf: time rev-list with UNINTERESTING commits
  [2/2]: list-objects: only look at cmdline trees with edge_hint

Here's t/perf/p0001 output that shows the problem:

  0001.5: rev-list --objects $commit --not --all
  fbd4a703^         fbd4a703                  HEAD
  0.04(0.04+0.00)   0.28(0.27+0.00) +600.0%   0.04(0.04+0.00) +0.0%

-Peff

PS If you are wondering about the output format above, I had to munge it
manually to avoid giant 115-character lines. We should maybe teach the
perf suite an alternate output format. :)
