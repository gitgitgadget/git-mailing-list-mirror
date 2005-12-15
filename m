From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to clone-pack the HEAD?
Date: Wed, 14 Dec 2005 17:20:28 -0800
Message-ID: <7vfyovtaub.fsf@assigned-by-dhcp.cox.net>
References: <20051215004440.GM22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 02:21:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmhnR-0007Rj-Lm
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 02:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVLOBUa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 20:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVLOBUa
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 20:20:30 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:59088 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964965AbVLOBUa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 20:20:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215011905.MXAF17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 20:19:05 -0500
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20051215004440.GM22159@pasky.or.cz> (Petr Baudis's message of
	"Thu, 15 Dec 2005 01:44:40 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13668>

Petr Baudis <pasky@ucw.cz> writes:

>   (i) git-clone-pack url HEAD doesn't work

"clone-pack url branchname" might work, but the thing is, nobody
uses clone-pack with explicit heads arguments so if HEAD does
not work I am not surprised at all.

>   (ii) git-clone-pack has hardcoded assumptions about refs/heads/master

I've read that part of the code twice in the past, but my
recollection is it tries hard to "guess" where HEAD points at
(because the remote side does not tell us, other than which
commit object HEAD points at).  When more than two branch heads
point at the same commit as HEAD records, it gives preference to
"master" branch while guessing, but otherwise there is nothing
special about the "master" branch.

The problem is, clone-pack is about cloning and not fetching.  I
am not claiming it is the right design decision --- after all,
it was the oldest of the git native protocol driver suite ---
but just stating where it stands with all the history behind its
(and git-fetch-pack's) evolution.

I think extending git-fetch-pack to optionally keep things
packed would be somewhat painful but the right approach.  Less
painful and readily doable would be to run clone-pack as is, and
reorganize the result of "copy of the remote" yourself.  That
would be a straightforward thing to do if you are using it for
the initial cloning.
