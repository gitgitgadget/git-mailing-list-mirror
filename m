From: linux@horizon.com
Subject: Why can't git-rebase back up?
Date: 17 Feb 2006 08:59:38 -0500
Message-ID: <20060217135938.7412.qmail@science.horizon.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 15:00:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA69Q-0003o1-3J
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 15:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWBQN7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 08:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWBQN7t
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 08:59:49 -0500
Received: from science.horizon.com ([192.35.100.1]:17707 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751416AbWBQN7t
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 08:59:49 -0500
Received: (qmail 7413 invoked by uid 1000); 17 Feb 2006 08:59:38 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16343>

Newbie question...  In what I assume is a usual technique, I maintain a
"build" branch off of the linux-2.6 history which is what I check out
to build a kernel.  I usually keep it at an official tagged releas,
such as v2.6.16-rc2.

[[ This is because core git won't allow the checked-out HEAD to point
to anything but a branch, and checking out something without having
HEAD point to it is fragile and delicate.  Cogito lets you do this with
cg-seek. ]]

Now, if I want to migrate to a newer base version, I can always use
git-reset --hard v2.6.16-rc3, but that's a bit dangerous.
Preferable is to use git-rebase v2.6.16-rc3, which will preserve
any local edits.

(I could also do it as a merge, but that seems like unnecessary history
clutter.  It's not like local edits are common, anyway.)

But suppose discover a nasty bug in -rc3 and want to move my build branch
back to -rc2.  "git-rebase v2.6.16-rc2" does nothing.  After a bit
of thought, I realize why, but sometime I do want to back up.

What's the best way to do that?  Should git-rebase take an optional
third argument which is the branch head we are moving away from?
E.g. what I want to do would be

	git-rebase v2.6.16-rc2 build v2.6.16-rc3

Or is there some other tool already suited to the job?

(Yes, I'm aware the operations cannot be exact inverses, because if
I applied a local patch that was also included in -rc3, git-rebase
will delete the redundant copy from the build branch, and the backing
up will have no way to know to put it back.  If I wanted to do that,
I would use a merge.)


On a completely unrelated note, how do I find out what git thinks of a
particular file, such as linux-2.6/.config?  It isn't listed in the
output of git-status or git-ls-files, but git-ls-files -i produces an error.
Very confusingly,
git-ls-files -i --exclude-per-directory=.gitignore -X .git/info/exclude .config
also produces no output, even though .* is listed in .gitignore.
