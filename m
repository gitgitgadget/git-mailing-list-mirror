From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] diff --cc: relax path filtering
Date: Thu, 2 Apr 2015 17:13:10 -0400
Message-ID: <20150402211310.GA22988@peff.net>
References: <1428006853-21212-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 23:13:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdmQY-0007Ws-4E
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 23:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbbDBVNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 17:13:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:41587 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752646AbbDBVNN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 17:13:13 -0400
Received: (qmail 24418 invoked by uid 102); 2 Apr 2015 21:13:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 16:13:13 -0500
Received: (qmail 15801 invoked by uid 107); 2 Apr 2015 21:13:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Apr 2015 17:13:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Apr 2015 17:13:10 -0400
Content-Disposition: inline
In-Reply-To: <1428006853-21212-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266678>

On Thu, Apr 02, 2015 at 11:34:09PM +0300, Max Kirillov wrote:

> For diff --cc, paths fitering used to select only paths which have
> changed in all parents, while diffing itself output hunks which are
> changed in as few as 2 parents.

I'm confused about "used to" here. Is this a regression due to the
combine-diff rewriting that happened in 2.0, or do you just mean "before
this patch series, we used to do this other thing".

> Fix intersect_paths() to add paths which have at least 2 changed
> parents.

I'd worry a little that this is increasing the cost to do "log --cc", as
it means we will have to open and look at extra files, and we may find
in many cases that there aren't any interesting hunks. Which would imply
we might want to put it behind a flag, rather than as the default
("--cc-me-harder").

But if I'm understanding the issue correctly, this should only matter
for octopus merges.  That is, the old rule for looking at a path was "is
there at least one parent whose content we took verbatim", but the new
one is "are there are at least 2 parents whose content we did not take
verbatim". With only two parents, those would be the same thing, I
think.

-Peff
