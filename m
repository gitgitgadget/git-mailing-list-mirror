From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Wed, 05 Oct 2005 17:03:27 -0700
Message-ID: <7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510042155090.31407@g5.osdl.org>
	<7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510050725510.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 02:05:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENJEj-0000qW-IG
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 02:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbVJFAD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 20:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbVJFAD3
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 20:03:29 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34044 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030451AbVJFAD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 20:03:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051006000323.RLHX9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 20:03:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9751>

Linus Torvalds <torvalds@osdl.org> writes:

> ... Although I would actually prefer to be able to try against
> a specific named release (not "all named tags" first).

That makes sense, given that you know better than the tool can
possibly guess, especially from the performance point of view.

What's interesting is that from the correctness point of view,
it should not make that much of a difference which base tree
happens to be picked -- if the base tree is wildly different
from your current HEAD, most of that wild difference will be
carried over intact to the result of patch application for paths
and parts of the files the patch does not touch.  Three-way
merge notices that and your "changes" from the base tree win.

> Quite often, the reason it doesn't apply is that I already have that patch 
> through a git merge (or because I applied that patch earlier through 
> another person), in which case I don't even try to merge it, I just delete 
> that email too, and just do "git-applymbox" again.

Thanks.  So in short, you do not even need '-c' option, but just
trim the mbox you feed to applymbox and re-run it.

While I was experimenting with the git-am (only in 'pu' branch,
and still marked as "do not use"), I noticed that it does the
right thing on an already applied patch.  It fails to apply,
finds an appropriate base and then notices the result of the
patch application is already contained in the HEAD ;-).
