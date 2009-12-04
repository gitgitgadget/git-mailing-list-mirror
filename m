From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Fri,  4 Dec 2009 15:36:27 +0100
Message-ID: <cover.1259934977.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 04 15:37:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGZHH-0005g2-Mt
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 15:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbZLDOgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 09:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752832AbZLDOgk
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 09:36:40 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45766 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbZLDOgj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 09:36:39 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (ssh.berlin.jpk.com [212.222.128.135])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id nB4EafCd020736;
	Fri, 4 Dec 2009 15:36:41 +0100
X-Mailer: git-send-email 1.6.5.4
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134510>

This patch series adds "fix" to the commands that can be used within
the "rebase --interactive" patch editor.  "fix" is like "squash"
except that it discards the log message of the corresponding commit.

Why I would like this feature:

One of my favorite aliases is

    fix = commit --amend -C HEAD

which I use in those all-too-frequent head-slapping "I just committed
something with a minor typo" moments.  It amends the last commit with
whatever is staged, reusing the same commit message.  It can also be
used with the "-a" option, a list of filenames, etc.

But sometimes I don't have my head-slapping moments until a few
commits later.  In this case, my usual practice is to commit the
trivial typo change on top of the current branch, then "rebase
--interactive" to move the typo fix on top of the erroneous commit and
squash it:

pick 05d3b81 Commit with typo
pick c29114a Good commit 1
pick 250b013 Good commit 2
pick 5eb3299 Fix for typo

        |
        V

pick 05d3b81 Commit with typo
squash 5eb3299 Fix for typo
pick c29114a Good commit 1
pick 250b013 Good commit 2

But then it is necessary to go into the commit message editor, move
the cursor down past the first commit message, delete the "Fix for
typo" commit message, save, and quit.

This patch implements a "fix" command, similar to "squash", except
that the corresponding log message is not included in the log message
suggested for the combined commit.  (In fact, it includes the log
message, but commented out.)  It therefore saves the editor chores.

"fix" and "squash" can be used in the same group, in which case the
"squash" commit messages are preserved and the "fix" commit messages
are skipped.

If the idea of a "fix" command is acceptable, then I would like to
implement a further convenience: if a group of commits to be folded
together includes *only* "fix" commits, then the first log message
should be used without even opening an editor.  But I would like to
get a reaction to the "fix" command in general before doing so.

Michael Haggerty (3):
  Better document the original repository layout.
  Set a couple more tags in the original repository.
  Add a command "fix" to rebase --interactive.

 Documentation/git-rebase.txt  |   13 ++++++++-----
 git-rebase--interactive.sh    |   39 +++++++++++++++++++++++++++++----------
 t/lib-rebase.sh               |    7 ++++---
 t/t3404-rebase-interactive.sh |   41 +++++++++++++++++++++++++++++++++++++----
 4 files changed, 78 insertions(+), 22 deletions(-)
