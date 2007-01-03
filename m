From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 3 Jan 2007 05:46:20 -0500
Message-ID: <20070103104620.GA27015@coredump.intra.peff.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <87ps9xgkjo.wl%cworth@cworth.org> <7virfprquo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 11:46:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H23db-0003YY-KH
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 11:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750695AbXACKqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 05:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbXACKqY
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 05:46:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1516 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750695AbXACKqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 05:46:23 -0500
Received: (qmail 27046 invoked from network); 3 Jan 2007 05:46:30 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Jan 2007 05:46:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jan 2007 05:46:20 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virfprquo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35858>

On Tue, Jan 02, 2007 at 02:44:31PM -0800, Junio C Hamano wrote:

> necessarily a better option of the two.  We could allow commits
> and prevent the user from switching out of the detached HEAD
> state without an explicit action instead.  If we go the first

I think you should only enact this safety valve if there have actually
been commits. Otherwise, people who are just tracking and do a
"git-checkout v1.4.0; look look look; git-checkout v1.5.0" will get a
confusing message.

Personally, I like the "don't allow commit without a branch" approach,
but only if you can "git-commit -b newbranch" and "git-merge -b
newbranch" to make it convenient to create a branch. Making commits that
aren't on any branch seems like a broken state (and indeed, you have to
use special options to get out of the state); it makes more sense to me
to never enter the state in the first place.

Also, the implementation should be conceptually simple. Put
refs/tags/v1.4.0 into HEAD on checkout. Disallow commit/merge unless
HEAD points to refs/heads/*.

Just my 2 cents...

-Peff
