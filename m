From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Eliminate one user of extra_refs
Date: Fri, 6 Jan 2012 09:53:56 -0500
Message-ID: <20120106145356.GB4525@sigill.intra.peff.net>
References: <1325859153-31016-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jan 06 15:54:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjBBF-0006qh-96
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 15:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758747Ab2AFOyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 09:54:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58719
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754075Ab2AFOx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 09:53:59 -0500
Received: (qmail 5874 invoked by uid 107); 6 Jan 2012 15:00:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Jan 2012 10:00:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Jan 2012 09:53:56 -0500
Content-Disposition: inline
In-Reply-To: <1325859153-31016-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188031>

On Fri, Jan 06, 2012 at 03:12:30PM +0100, mhagger@alum.mit.edu wrote:

> Receive pack currently uses "extra refs" to keep track of ".have"
> references, which in turn are used to tell the source the SHA1s of
> references that are already known to the repository via alternates.
> 
> But the code already creates an array holding the alternate SHA1s.  So
> just read the SHA1s out of this array rather then round-tripping them
> through the extra_refs mechanism.
> 
> This is one step towards hopefully abolishing extra_refs altogether.
> I still have to examine the other user.

Thanks, this is a nice simplification. The patches look good to me, and
they produce the same output for a simple test (I happened to be fiddling
with receive-pack and alternates yesterday, so I had a nice test case
right at hand :) ).

>   receive-pack: move more work into write_head_info()

BTW, I have a patch to make sending ".have" refs configurable[1] (it
adds a receive.advertiseAlternates config variable), which this patch
conflicts with. I don't think that is your problem, but I thought I
would mention it since you are working in the area. Is that something we
want in git?

-Peff

[1] We are using it at GitHub because our alternates repos are so huge
    that the overhead of advertising the refs outweighs the minor
    benefits you get from avoiding object transfer.
