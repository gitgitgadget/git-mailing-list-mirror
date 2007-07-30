From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 01:24:43 -0700
Message-ID: <7vhcnml2no.fsf@assigned-by-dhcp.cox.net>
References: <241612.78983.qm@web51007.mail.re2.yahoo.com>
	<alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org>
	<6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de>
	<7vbqdumlo1.fsf@assigned-by-dhcp.cox.net>
	<E49A2B0B-DAA3-4A03-925D-D3D113F907F1@zib.de>
	<20070730074937.GT20052@spearce.org>
	<577C7529-4C3C-40D4-B86A-8B3CE888C997@zib.de>
	<20070730081439.GA907@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 10:24:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFQYd-0004AV-8u
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 10:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758142AbXG3IYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 04:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757972AbXG3IYq
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 04:24:46 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42345 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757937AbXG3IYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 04:24:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070730082444.RBCP1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Jul 2007 04:24:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VkQj1X00C1kojtg0000000; Mon, 30 Jul 2007 04:24:44 -0400
In-Reply-To: <20070730081439.GA907@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 30 Jul 2007 04:14:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54204>

Jeff King <peff@peff.net> writes:

> But I think making a "fake" commit to force non-fast-forward is the
> wrong thing. You really want to make your "extra" commit be the merge
> that wouldn't have happened (which unfortunately is not as simple as
> just creating a commit by hand, since you have to actually _do_ the
> merge to get the tree).

I do agree that if you really want to create a commit instead of
allowing a fast forward, you really should create a proper merge
commit.

But it is not hard.  If it is a fast forward in reality but you
are marking it as a real merge by creating a merge commit, then:

 - The tree is obviously the merged branch that is a fast
   forward of your old HEAD;

 - The first parent of the resulting merge is your old HEAD; and

 - The second parent of the resulting merge is the merged
   branch.

So:

	git merge --no-fast-forward other

when other is a fast forward of HEAD would do:

	git commit-tree other^{tree} -p HEAD -p other
