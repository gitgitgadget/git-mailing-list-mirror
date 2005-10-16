From: Junio C Hamano <junkio@cox.net>
Subject: Do you use "git-apply --show-files"?
Date: Sun, 16 Oct 2005 11:41:50 -0700
Message-ID: <7vek6lxq1d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 20:43:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERDSF-0002uu-IK
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 20:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVJPSlw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Oct 2005 14:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVJPSlw
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Oct 2005 14:41:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59903 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751343AbVJPSlw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2005 14:41:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051016184141.KCOX16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 16 Oct 2005 14:41:41 -0400
To: torvalds@osdl.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10169>

As a part of "funny pathname character" updates, I was reviewing
"apply.c" and have two questions on its "--show-files" flag.

 * Unlike other informational flags like --stat and --summary,
   it does not turn off "apply".  Is it intentional? 

 * Do you (or anybody else) use it, and if so how?

The current code in the proposed updates branch decodes the same
C-style encoded pathnames GNU patch with proposed enhancements
would understand before applying patches, and when it needs to
show pathnames with --index-info, --stat, and --summary, it uses
the same encoded pathname to keep things on one line.

I think --show-files should also do the same for consistency,
but before I update it I wanted to ask the above questions.  If
nobody uses it, I can just ignore the issues and probably
remove the flag.

The plan is to backport the git-apply change to the maint branch
to do a 0.99.8e before updated git-diff-* hits the master
branch.  The only thing that would make a difference is embedded
SP.  Currently they are not quoted, but they will be, like this:

        : siamese; git diff
        diff --git "a/Read Me" "b/Read Me"
        index 3deac99..543a8f0 100644
        --- "a/Read Me"
        +++ "b/Read Me"
        ...
