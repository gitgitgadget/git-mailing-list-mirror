From: Junio C Hamano <junkio@cox.net>
Subject: Re: Split up tree diff functions into tree-diff.c library
Date: Thu, 20 Oct 2005 23:16:21 -0700
Message-ID: <7v64rr2y4q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510202058030.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 08:17:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESqCb-0000nF-LJ
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 08:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVJUGQX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 02:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVJUGQX
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 02:16:23 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15593 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964883AbVJUGQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 02:16:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051021061610.TYHR16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 21 Oct 2005 02:16:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510202058030.10477@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 20 Oct 2005 21:05:05 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10424>

I have not closely studied the user of this change, rev-list,
but I have a hunch that you might be better off, if you define a
new diff "format", DIFF_FORMAT_CALLBACK, and hook into
diff_flush(), instead of hooking into diff_addremove() and
diff_change().  Instead of calling diff_flush_raw() or
diff_flush_name(), or diff_flush_patch(), your callback function
would be called with each filepair.

Right now, you are only making the parallel tree traversing and
comparing part from diff-tree available in the library form
(which is fine), but that way leaves the door open for it to
also use the rest of the diffcore machinery.

By doing things this way, later round of rev-list that culls
uninteresting commits could be taught to also follow renames.

Am I grossly off the mark?
