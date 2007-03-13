From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 13 Mar 2007 12:48:52 -0700
Message-ID: <7vd53cj55n.fsf@assigned-by-dhcp.cox.net>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
	<7v8xep8dfk.fsf@assigned-by-dhcp.cox.net>
	<7v7itx5mep.fsf@assigned-by-dhcp.cox.net>
	<7vps7dle8j.fsf@assigned-by-dhcp.cox.net>
	<20070313174304.GA2540@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 20:49:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRCzT-00036G-OL
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 20:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbXCMTsy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 15:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbXCMTsx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 15:48:53 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:41450 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbXCMTsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 15:48:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070313194852.OZPG2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Mar 2007 15:48:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aKos1W00J1kojtg0000000; Tue, 13 Mar 2007 15:48:52 -0400
In-Reply-To: <20070313174304.GA2540@moooo.ath.cx> (Matthias Lederhofer's
	message of "Tue, 13 Mar 2007 18:43:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42146>

Matthias Lederhofer <matled@gmx.net> writes:

> Here is what I thought about:
>
> check that --work-dir overrides $GIT_WORK_DIR and both override
> $GIT_DIR/workdir.
>
> use a correct and an invalid path for:
>     $GIT_DIR/workdir:
>         file containing a relative and an absolute path
>         symlink pointing to an invalid path, a directory, a file
>         test a symlink to something else (e.g. device, fifo, ..) too?
>         directory
>     $GIT_WORK_DIR: relative and absolute path
>     and test what git does with git-rev-parse
>             --is-bare-repository
>             --show-prefix
>             --show-cdup
>
> test git rev-parse --is-inside-git-dir

... and do the rev-parse test with *and* *without* $GIT_WORK_DIR
or $GIT_DIR/workdir to make sure there won't be any regressions.

> A symlink pointing to an invalid path is currently handled as if there
> is no $GIT_DIR/workdir at all because stat returns ENOENT.  Is this ok
> or should git complain like it does for an invalid path when
> $GIT_DIR/workdir is a file?  We could also decide to ignore all
> invalid workdir settings and handle this the same as being outside the
> workdir.

Silently ignoring would leave the user who misconfigured it by
mistake.

By the way, why should it be $GIT_DIR/workdir when it appears
everybody is putting things in $GIT_DIR/config?  Shouldn't it be
something like:

	[core]
        	worktree = "/path/to/the/working/tree"

And more importantly, why nobody mentioned the above so far?
Maybe it is a sign that nobody is interested in this new
feature?
