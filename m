From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] performance regression in mark_edges_uninteresting
Date: Mon, 20 Jan 2014 17:29:36 -0500
Message-ID: <20140120222936.GA25291@sigill.intra.peff.net>
References: <20140120212845.GA11451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 23:29:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5NLi-0000Fa-Ja
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 23:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752303AbaATW3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 17:29:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:35881 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751380AbaATW3i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 17:29:38 -0500
Received: (qmail 17780 invoked by uid 102); 20 Jan 2014 22:29:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 16:29:37 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jan 2014 17:29:36 -0500
Content-Disposition: inline
In-Reply-To: <20140120212845.GA11451@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240732>

On Mon, Jan 20, 2014 at 04:28:45PM -0500, Jeff King wrote:

>   [1/2]: t/perf: time rev-list with UNINTERESTING commits
>   [2/2]: list-objects: only look at cmdline trees with edge_hint
> 
> Here's t/perf/p0001 output that shows the problem:
> 
>   0001.5: rev-list --objects $commit --not --all
>   fbd4a703^         fbd4a703                  HEAD
>   0.04(0.04+0.00)   0.28(0.27+0.00) +600.0%   0.04(0.04+0.00) +0.0%

Those numbers are on git.git. Obviously 600% is a lot, but 24ms is not.
However, the cost is a factor of the tree size times the number of refs.
For the "homebrew.git" repository stored at GitHub, which has ~28,000
refs (mostly pointing at pull-request tips in refs/pull), the numbers
are much more dramatic:

fbd4a703^         fbd4a703                   HEAD                 
0.50(0.46+0.02)   8.23(8.17+0.06) +1546.0%   0.50(0.48+0.01) +0.0%

-Peff
