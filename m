From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why is it bad to rewind a branch that has already been pushed out?
Date: Sat, 03 Feb 2007 01:04:54 -0800
Message-ID: <7vzm7v7gsp.fsf@assigned-by-dhcp.cox.net>
References: <20070203084247.13894.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Feb 03 10:05:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDGpb-0004Dn-UT
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 10:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946404AbXBCJFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 04:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946410AbXBCJE7
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 04:04:59 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:45361 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946404AbXBCJE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 04:04:57 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070203090455.QPBR1349.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 3 Feb 2007 04:04:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Jx4v1W0041kojtg0000000; Sat, 03 Feb 2007 04:04:56 -0500
In-Reply-To: <20070203084247.13894.qmail@science.horizon.com>
	(linux@horizon.com's message of "3 Feb 2007 03:42:47 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38555>

linux@horizon.com writes:

> The basic problem is that, if you rewind your series from j to j^,
> and Alice has already fetched it, she'll get an error when she tries to
> fetch it again and git notices that j -> h is not a fast-forward.

Well, if you do a pull without tracking branch, like Linus seems
to do, there is no non-fast-forward error.  Also, repositories
prepared with git-clone from 1.5.0 by default will have tracking
branches of forcing kind.  I.e. the fetch configuration will
specify tracking with '+' in front:

	[remote "origin"]
		fetch = +refs/heads/*:refs/remotes/origin/*

so non-fast-forward check will not trigger in general.

> It won't confuse git, but might confuse Alice.

I think I should have made it more obvious, but the emphasis of
my proposed rewording is not about removing the word "git gets
confused" in order to defend git.

It is very likely to confuse Alice (especially if she did not
have any 'a' commits), having to do the merge.  But I think the
confusion is just a symptom, and the real disease lies
elsewhere.  The real disease is that it is wrong for me to force
the merge on Alice, from the workflow perspective, and that is
true even if we were lucky and Alice did not get confused about
the merge (e.g. 'j' and 'h' series did not have anything
related, and/or 'a' really fixed up 'j').  In any case, Alice
should not to have to worry about what happened between 'j' and
'h' forks, and I think the document should emphasize that point.
