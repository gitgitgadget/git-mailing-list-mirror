From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Thu, 3 Jul 2008 15:59:15 -0400
Message-ID: <20080703195915.GA18532@sigill.intra.peff.net>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com> <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com> <20080702032155.GA13581@sigill.intra.peff.net> <200807021144.46423.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Brewster <adambrewster@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 22:00:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEUyW-0007km-S6
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 22:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753945AbYGCT7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 15:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754128AbYGCT7S
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 15:59:18 -0400
Received: from peff.net ([208.65.91.99]:1757 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753647AbYGCT7S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 15:59:18 -0400
Received: (qmail 3586 invoked by uid 111); 3 Jul 2008 19:59:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 03 Jul 2008 15:59:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jul 2008 15:59:15 -0400
Content-Disposition: inline
In-Reply-To: <200807021144.46423.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87311>

On Wed, Jul 02, 2008 at 11:44:45AM +0200, Jakub Narebski wrote:

> Well, there is one situation where either separate git-bases program
> (which is a good start; it can be named git-bundle--bases; there are
> some precedents for that ;-)), or allowing to create 'bases' file
> without creating bundle would be good to have.  Namely situation
> where two computers are _sometimes off-line (disconnected)_.  If you
> want to transfer new commits from machine B to machine A, you would
> generate 'bases' file on machine A, then transfer this file using some
> off-line medium, then generate bundle on machine B using those bases,
> etc.

Yes, certainly it is more flexible to have them split. I find Adam's
argument the most compelling, though. Think about moving commits as a
multi-step protocol:

  1. Local -> Remote: Here are some new commits, basis..current
  2. Remote -> Local: OK, I am now at current.
  3. Local: update basis to current

git-push has the luxury of asking for "basis" each time, so we know it
is correct. But with bundles, we can't do that. And failing to update
"basis" means we will send some extra commits next time. But updating
"basis" when we shouldn't means that the next bundle will be broken.

So I think even if people _do_ want to update "basis" when they create
the bundle (because it is more convenient, and they are willing to
accept the possibility of losing sync), it is trivial to create that
workflow on top of the separate components. But I can see why somebody
might prefer the separate components, and it is hard to create them if
the feature is lumped into "git-bundle" (meaning in such a way that you
cannot perform the steps separately; obviously git-bundle --basis would
be equivalent).

But I am not a bundle user, so that is just my outsider perspective.

-Peff
