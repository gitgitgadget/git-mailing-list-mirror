From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/12] Fix some reference-related races
Date: Wed, 12 Jun 2013 08:52:35 -0400
Message-ID: <20130612125235.GA28876@sigill.intra.peff.net>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 12 14:52:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmkXb-0000F1-DE
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 14:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380Ab3FLMwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 08:52:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:36615 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527Ab3FLMwj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 08:52:39 -0400
Received: (qmail 21543 invoked by uid 102); 12 Jun 2013 12:53:31 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Jun 2013 07:53:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jun 2013 08:52:35 -0400
Content-Disposition: inline
In-Reply-To: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227611>

On Tue, Jun 11, 2013 at 11:48:20PM +0200, Michael Haggerty wrote:

> *This patch series must be built on top of mh/reflife.*

Applying on top of what Junio has in mh/reflife seems to create
conflicts at the first patch. I didn't look into it, though, but just
read the patches and looked at the packed-refs-transactions branch at
git://github.com/mhagger/git.git.

> The other problem was that the for_each_ref() functions will die if
> the ref cache that they are iterating over is freed out from under
> them.  This problem is solved by using reference counts to avoid
> freeing the old packed ref cache (even if it is no longer valid) until
> all users are done with it.

I was worried that the reference-counting would end up invasive and
ugly, but it turned out quite nice.

Overall, I think the series goes in the right direction, and I didn't
see any implementation flaws. The core of the race-handling is the same
as in mine, but your "hyperactive repository" patch shows how badly mine
can break under load.

I sent a few comments to specific patches, but I'd be fine with applying
it as-is. Thanks for working on it.

-Peff
