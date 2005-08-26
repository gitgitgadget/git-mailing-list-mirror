From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Looking at multiple ancestors in merge
Date: Fri, 26 Aug 2005 02:29:13 -0700
Message-ID: <7vwtm9f3me.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508242249030.23242@iabervon.org>
	<Pine.LNX.4.63.0508260108290.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 11:29:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8aWU-0006Yu-Pa
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 11:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVHZJ3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 05:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVHZJ3P
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 05:29:15 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:46542 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932222AbVHZJ3P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 05:29:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826092914.HGQG16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 05:29:14 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7797>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I've started this, and have gotten as far as having read-tree accept > 3
> trees and ignore everything but the last 3. Am I correct in assuming that
> if I break read-tree in any way, some test will fail?

If some test fails you would know you broke it, but the inverse
is probably not always true.

I think the current read-tree test suite has reasonably wide
coverage of all the interesting cases.  But the definition of
"interesting" was derived from the current world order (IOW, the
test suite was designed around the way we do things right now as
a whitebox test, not a blackbox test).  I would not be surprised
if some of them did not catch breakage you may introduce during
the development.

I wonder however if extending the current way of doing things in
the cache is the right thing.  Right now we use two bits out of
the top four bits for recording stage, one bit for the update
bit, so you have only one extra bit to extend the number of
stages, which means you could hold at most 7 trees at once.

You "ignore things but the last 3", so this may not be too much
of a problem, but I am a bit puzzled what you meant by it
though.  Are you talking about reading more than 3 trees and
keeping only the 3 to be merged, discarding the rest, doing the
selection per path?
