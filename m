From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Built-in diff driver shows Index: line.
Date: Thu, 28 Apr 2005 15:09:45 -0700
Message-ID: <7vacni5z9y.fsf@assigned-by-dhcp.cox.net>
References: <7vy8b27lyf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504281236090.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 00:04:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRH7V-00009t-9Y
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 00:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVD1WJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 18:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVD1WJz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 18:09:55 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:43501 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262283AbVD1WJs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 18:09:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428220947.DCJD1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 18:09:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504281236090.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 28 Apr 2005 13:05:25 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Actually, I do dislike the Index: line, and think this is a pretty
LT> intrusive work-around for a problem with diffstat.

Alright.  Please consider the patch retracted.

LT> Oh, actually maybe the better pattern to use is the one that GNU diff 
LT> itself ends up matching:
LT> 	"*** %[^\t ]%[\t ]%d%c%d%c%d %d:%d:%d"
LT> where the "%c" has to be either '-' or '/' (ie it ends up matching as 
LT> "numeric date" + "numeric time").

LT> You can put the "mode" thing at the end, and diffstat won't care about it.

Hmph.  Timestamps do not mean anything in most of the intended
use of diff-* family, since they are meant to operate on trees,
except:

 - comparing against the working tree --- show-diff's <new> and
   diff-cache's <new>; we can take the timestamp from the
   filesystem.

 - comparing against a tree that comes from a known commit ---
   we can take the timestamp of the commit that contains the
   file.

If we want to show the timestamp of the latter, diff-tree and
diff-cache need to be taught to take notice if their
tree-or-commit parameter is actually a commit and if so needs to
pass the timestamp in the committer field down the path for the
diff driver.  There is no way for diff-tree-helper to do this
because the origin information is already stripped out when it
sees a valid SHA1.

So I'd say we'd punt this one for now, unless somebody else has
a better idea.

