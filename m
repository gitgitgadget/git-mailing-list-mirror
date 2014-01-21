From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] performance regression in mark_edges_uninteresting
Date: Mon, 20 Jan 2014 21:24:31 -0500
Message-ID: <20140121022431.GA4614@sigill.intra.peff.net>
References: <20140120212845.GA11451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 03:24:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5R14-0007kF-8n
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 03:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbaAUCYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 21:24:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:35982 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752329AbaAUCYd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 21:24:33 -0500
Received: (qmail 29984 invoked by uid 102); 21 Jan 2014 02:24:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 20:24:33 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jan 2014 21:24:31 -0500
Content-Disposition: inline
In-Reply-To: <20140120212845.GA11451@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240739>

On Mon, Jan 20, 2014 at 04:28:45PM -0500, Jeff King wrote:

> This series fixes a rev-list performance regression in fbd4a70 (list-objects:
> mark more commits as edges in mark_edges_uninteresting, 2013-08-16).  That
> commit is a little tricky because it actually _knows_ it's trading off CPU for
> a better packfile, but I think we're performing the tradeoff in too many
> places. See the second commit for details.
> 
>   [1/2]: t/perf: time rev-list with UNINTERESTING commits
>   [2/2]: list-objects: only look at cmdline trees with edge_hint
> 
> Here's t/perf/p0001 output that shows the problem:
> 
>   0001.5: rev-list --objects $commit --not --all
>   fbd4a703^         fbd4a703                  HEAD
>   0.04(0.04+0.00)   0.28(0.27+0.00) +600.0%   0.04(0.04+0.00) +0.0%

Here's v2 that addresses the minor comments on the list (simpler test in
the first patch, and dropping the now-redundant revs->edge_hint check in
the second patch).

-Peff
