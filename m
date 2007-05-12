From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Fri, 11 May 2007 17:32:43 -0700
Message-ID: <7vps569904.fsf@assigned-by-dhcp.cox.net>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>
	<46413565.3090503@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sat May 12 02:32:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmfXW-0002qS-26
	for gcvg-git@gmane.org; Sat, 12 May 2007 02:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969AbXELAcp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 20:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756496AbXELAcp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 20:32:45 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:40963 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969AbXELAco (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 20:32:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512003244.CRKY2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 20:32:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id y0Yj1W00S1kojtg0000000; Fri, 11 May 2007 20:32:44 -0400
In-Reply-To: <46413565.3090503@zytor.com> (H. Peter Anvin's message of "Tue,
	08 May 2007 19:43:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47001>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Mine stops already at the directory -> symlink checkin (the above is the
> symlink -> directory one), but your trick of using "git checkout" as a
> trick to resolve things helped for both... eventually :-/

I've tried to redo your rebase using:

	apply: do not get confused by symlinks in the middle

patch on top of 'master'.  It successfully run through the end.
After rebasing f1bb07af ("rebase-1" in your repository) on to
a989705 (near the tip of Linus), I did

	git diff --stat --summary a989705...f1bb07af
        git diff --stat --summary a989705...HEAD

(that is, "show me the change since the merge base") and the
results from these two diffs match exactly.

So I think I can declare victory for now ;-).

However.

I usually have "[apply] whitespace = strip" in my ~/.gitconfig,
but during this verification run, I disabled it to keep rebase
from falling back to 3-way merge using merge-recursive.  If I
turn it on, rebase still fails and I strongly suspect "rebase
-m" would fail the same way, although I haven't tried it (it
takes too much time).

I'll be somewhat busy this weekend, so I would welcome anybody
else beating me to fixing the problem in merge-recursive.
