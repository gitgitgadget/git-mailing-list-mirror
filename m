From: Junio C Hamano <junkio@cox.net>
Subject: Re: Joining Repositories
Date: Thu, 19 Jan 2006 10:24:39 -0800
Message-ID: <7vlkxcdqjc.fsf@assigned-by-dhcp.cox.net>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
	<20060118125158.GN28365@pasky.or.cz>
	<20060118125857.GO28365@pasky.or.cz>
	<200601181501.38791.Mathias.Waack@rantzau.de>
	<20060118141442.GP28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mathias Waack <Mathias.Waack@rantzau.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 19:28:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzeSo-0001iM-H9
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 19:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWASSYm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 13:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWASSYm
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 13:24:42 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:49029 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030285AbWASSYl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 13:24:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119182227.GBUL26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 13:22:27 -0500
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14921>

Petr Baudis <pasky@suse.cz> writes:

>   oops, it seems this is only in the latest pu branch of git. If you are
> not brave enough for that, you will need to use the prefix facility of
> checkout-index instead, and it'll take much longer:
>...
>   Note that I'm not sure when which feature was introduced. Your best
> bet is to just use the latest stable GIT/Cogito versions.

The "read-tree --prefix" and friends were only talked about
during the "bind" commit discussion, and with some experimental
code in "pu".  Here is my thought on their readiness:

 - "read-tree --prefix=<prefix>/" may independently be useful
   even if we choose not to go "bind" commit approach.  However
   what it does when the index already has something at
   <prefix>/ has room for improvement.  I think it should have
   an option to do an equivalent of either one-way merge or
   two-way merge for that part of subtree.  Currently it always
   rejects if the current index has anything there.

 - "write-tree --prefix=<prefix>/" is redundant for the purpose
   of "bind" commit, because we would write the whole tree to be
   recorded in the enclosing project and it is easy to pick the
   subproject part with ls-tree from such a tree.  So it needs
   an independent advocate / rationale before graduating from
   "pu".

 - "write-tree --bound=<prefix>/ --bound=<prefix>/ ..." cannot
   be emulated by any other way and may be independently useful
   outside "bind" commit context.  Maybe the option should be
   renamed to --exclude=<prefix>/ or somesuch before going to
   "master".

 - "commit-tree --bind" should stay in "pu" until other pieces
   to correctly deal with commit objects with "bind" lines are
   ready, including fsck-objects and rev-list.  It _might_ be
   safer to bump the core.repositoryformatversion automatically
   once you have such a commit object in your repo.
