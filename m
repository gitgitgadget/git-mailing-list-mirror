From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Sun, 09 Apr 2006 11:46:56 -0700
Message-ID: <7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604090950590.9504@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 20:47:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSewA-0005Z8-M6
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 20:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWDISq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 14:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWDISq7
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 14:46:59 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56454 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750814AbWDISq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 14:46:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060409184658.QTRW20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Apr 2006 14:46:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18557>

Linus Torvalds <torvalds@osdl.org> writes:

> I wonder... This all looks fine, but there are actually two different 
> "diffs" that can be shown for "git log --diff <pathlimiter>":
>
>  - the whole diff for a commit
>  - the path-limited diff

Yes, exactly the same way sometimes you would want just pickaxe,
sometimes you would want it with --pickaxe-all.

Also, I might have to rethink --max-count logic -- I think it is
reasonable to skip the commit when doing limiting by diff like
"whatchanged" does, but one thing I find suboptimal with the
current whatchanged is that it does not count commits that are
actually shown (it counts what the upstream rev-list feeds
diff-tree).  With the "git log --diff" based whatchanged, it
becomes trivial to skip the revs->max_count limiting and have
the caller count the commits it actually does something
user-visible to, instead of counting the commits it pulled out
of get_revision().

BTW I think I could remove the log message generation part of
"git log" and have it use the one in log-tree (which I will
probably rewrite not to format the message into the static
this_header[] buffer when it is not shown).

Another thing that might be useful is to teach diff-* to do the
diffstat part internally.  After that is in place we could
introduce --pretty=patch to have "git log" produce format-patch
compatible output.
