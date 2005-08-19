From: Junio C Hamano <junkio@cox.net>
Subject: Re: git commit (or git-commit-script) question
Date: Fri, 19 Aug 2005 12:52:01 -0700
Message-ID: <7vd5o9yaam.fsf@assigned-by-dhcp.cox.net>
References: <4306119C.8000600@jstenback.com>
	<Pine.LNX.4.58.0508191028190.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 21:53:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6CuO-0005nq-Gw
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 21:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVHSTwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 15:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbVHSTwE
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 15:52:04 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:17561 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965016AbVHSTwC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 15:52:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819195202.XWDD550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 Aug 2005 15:52:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508191028190.3412@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 19 Aug 2005 10:36:35 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> However, one thing to look out for is that if you've marked any files for 
> update (with git-update-cache) those will always be committed regardless 
> of what arguments you give to "git commit".

Another thing to look out for is that the files you told it
about with "git add" will be included and does not show up in
"git diff", because there currently is no way to record "intent
to add" (rather, "Mr GIT, please keep an eye on this file")
without actually adding a path to the index file for inclusion
in the next commit.

I have a couple of updates to git-commit-script in the proposed
updates branch, and one of the changes is that git-update-cache
in git-commit-script, used when either the --all flag or
explicit paths are given, has a --remove flag there.  The reason
it does not need --add flag there as well is a direct
consequence of this asymmetry.

Although I do not think this asymmetry a major source of
confusion, I suspect that we could "fix" it by treating an index
entry with all-zero mode and sha1 as "keep-an-eye-on" entry with
a new flag "git-update-cache --watch <path>" or something like
that.  "git-diff-files" would then treat that special entry as a
nonexistent path and would compare it with whatever happens to
be (or lack of it) in the working tree, and "git diff" would
show a diff that creates the file.  This needs a tweak or two in
the diffcore machinery as well.
