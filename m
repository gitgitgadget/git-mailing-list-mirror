From: Junio C Hamano <junkio@cox.net>
Subject: Re: someone changed the contents of my HEAD.
Date: Mon, 27 Feb 2006 21:22:18 -0800
Message-ID: <7vlkvwt5v9.fsf@assigned-by-dhcp.cox.net>
References: <20060228030446.GA23490@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 06:22:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDxJY-0002ra-Tf
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 06:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWB1FWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 00:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWB1FWW
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 00:22:22 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8886 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751805AbWB1FWV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 00:22:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060228052108.UUWB3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Feb 2006 00:21:08 -0500
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060228030446.GA23490@redhat.com> (Dave Jones's message of
	"Mon, 27 Feb 2006 22:04:46 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16916>

Dave Jones <davej@redhat.com> writes:

> When checking in changes previously, I used this..
>
> #!/bin/sh
> export GIT_AUTHOR_NAME="$1"
> export GIT_AUTHOR_EMAIL="$2"
> tree=$(git-write-tree) || exit 1
> commit=$(git-commit-tree $tree -p HEAD) || exit 1
> echo $commit > .git/HEAD

This has been deprecated for a looong time, but perhaps I should
have been louder.  "git commit --author" should be fine -- I do
not think you do not even need such a wrapper.

> For my newly created repos, this isn't a problem, as I can fudge my
> commit-as script to write to .git/refs/heads/master instead, but
> my concern now is the unpulled changes in the existing repos
> I have on master.  Will Linus be able to pull those into his tree
> with git 1.2.3, or will I have to recreate those repos with the
> new-style .git/HEAD ?

A .git/HEAD symlink pointing at refs/heads/master _is_ still
(and will be) supported, so either symlink or symref is fine.
Bare SHA1 object name in HEAD is not -- git would not know which
branch you are on, so "checkin" would not work after that.

Your refs/heads/master might be stale (one rev or more older
than what you replaced .git/HEAD with) but still should be a
proper ancestor.  After making sure your refs/heads/master has
the right commit (you may have it there already if you have been
updating them using "git-push"), running "git-symbolic-ref HEAD
refs/heads/master" would fix things.
