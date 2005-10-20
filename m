From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cg-fetch will now retrieve commits related to tags if missing.
Date: Wed, 19 Oct 2005 21:44:47 -0700
Message-ID: <7virvsu79c.fsf@assigned-by-dhcp.cox.net>
References: <1129769745158-git-send-email-martin@catalyst.net.nz>
	<7voe5lvv1q.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510192118s31c52fe7m73d88a9779653f4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 06:47:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESSIR-0000o9-DB
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 06:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbVJTEou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 00:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbVJTEou
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 00:44:50 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:18361 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751742AbVJTEot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 00:44:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051020044438.NES16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Oct 2005 00:44:38 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510192118s31c52fe7m73d88a9779653f4c@mail.gmail.com>
	(Martin Langhoff's message of "Thu, 20 Oct 2005 17:18:51 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10346>

Martin Langhoff <martin.langhoff@gmail.com> writes:

>>         GIT_DIR=../.. git-rev-parse --verify "$tagid^0" >/dev/null 2>&1 && continue
>
> Note however that git-rev-parse is lazy and won't check that the
> commit is there. I have to call git-cat-file and check whether it
> succeeds to know if we have the object.

Are you sure?

What "rev^0" does is:

    1. parse "rev"; make sure it can deref to commit and read
       it (otherwise give up and say the whole thing is not an
       SHA1 expression);

    2. grab the nth parent SHA1.  If N>0, it is lazy and does
       not check if the parent object exists, but still 0th
       parent is the commit object itself and if we came this
       far you know that commit is available already.

Together with --verify, it barfs if the above does not say "rev^0"
is a valid SHA1 expression.  So this should work without
cat-file.  No?

BTW, I just got a SEGV while pulling Cogito repository over
git-fetch-pack after interrupting rsync transfer (I wanted to
switch to git transfer).  I am running with Johaness patch from
today so the cause may be different from yours, but now I have
something to look at, which is better than before.

Fetching with rsync (and interrupting in the middle) is a good
way to simulate a broken repository ;-).
