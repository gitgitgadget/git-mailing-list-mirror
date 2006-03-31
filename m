From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Fri, 31 Mar 2006 00:28:58 -0800
Message-ID: <7v1wwjvwz9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
	<Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 10:29:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPF0C-0006vj-KM
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 10:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWCaI3B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 03:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWCaI3A
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 03:29:00 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54979 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751269AbWCaI3A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 03:29:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060331082859.QEBA20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 31 Mar 2006 03:28:59 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603301652531.27203@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 30 Mar 2006 17:05:25 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18223>

Linus Torvalds <torvalds@osdl.org> writes:

> This is an absolutely huge deal for anything like "git log -- <pathname>", 
> but also for some things that we don't do yet - like the "find where 
> things changed" logic I've described elsewhere, where we want to find the 
> previous revision that changed a file.
>...
> Btw, don't even bother testing this with the git archive. git itself is so 
> small that parsing the whole revision history for it takes about a second 
> even with path limiting.

By the way, I forgot to praise you ;-).  

Even on a fast machine, the old one was not very useful, but
this one is _instantaneous_.  Very good job.

$ PAGER=cat GIT_DIR=/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
  /usr/bin/time git log -1 --pretty=short -- drivers/
commit ce362c009250340358a7221f3cdb7954cbf19c01
Merge: 064c94f... cd7a920...
Author: Linus Torvalds <torvalds@g5.osdl.org>

    Merge git://git.kernel.org/pub/scm/linux/kernel/git/kyle/parisc-2.6

15.44user 0.19system 0:25.11elapsed 62%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+18050minor)pagefaults 0swaps

$ PAGER=cat GIT_DIR=/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
  /usr/bin/time ./git.pu log -1 --pretty=short -- drivers/
commit ce362c009250340358a7221f3cdb7954cbf19c01
Merge: 064c94f... cd7a920...
Author: Linus Torvalds <torvalds@g5.osdl.org>

    Merge git://git.kernel.org/pub/scm/linux/kernel/git/kyle/parisc-2.6

0.00user 0.00system 0:00.00elapsed 50%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+388minor)pagefaults 0swaps
