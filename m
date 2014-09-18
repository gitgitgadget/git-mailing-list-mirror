From: Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2] Documentation/git-rebase.txt: discuss --fork-point assumption
 of vanilla "git rebase" in DESCRIPTION.
Date: Thu, 18 Sep 2014 23:03:25 +0400
Message-ID: <87k34mn0ht.fsf@osv.gnss.ru>
References: <87r3z72wiu.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 13:13:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYYtL-0000tx-7d
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 13:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbaI2LNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 07:13:06 -0400
Received: from mail.javad.com ([54.86.164.124]:54720 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbaI2LNF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 07:13:05 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 59EC661861;
	Mon, 29 Sep 2014 11:13:04 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XYYt4-0004vZ-J0; Mon, 29 Sep 2014 15:13:02 +0400
In-Reply-To: <87r3z72wiu.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257622>

Vanilla "git rebase" defaults to --fork-point that in some cases
makes behavior very different from "git rebase <upstream>",
where --no-fork-point is assumed. This fact was not mentioned in
the DESCRIPTION section of the manual page, even though the case of
omitted <upstream> was otherwise discussed. That in turn made actual
behavior of vanilla "git rebase" hardly discoverable.

While we are at it, clarify the --fork-point description itself as well.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
As asked by Junio C Hamano <gitster@pobox.com>, the newly introduced
'fork_point' term has been described.


 Documentation/git-rebase.txt | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 4138554..2e6f125 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -21,15 +21,17 @@ If <branch> is specified, 'git rebase' will perform an automatic
 it remains on the current branch.
 
 If <upstream> is not specified, the upstream configured in
-branch.<name>.remote and branch.<name>.merge options will be used; see
-linkgit:git-config[1] for details.  If you are currently not on any
-branch or if the current branch does not have a configured upstream,
-the rebase will abort.
+branch.<name>.remote and branch.<name>.merge options will be used (see
+linkgit:git-config[1] for details) and the `--fork-point` option is
+assumed.  If you are currently not on any branch or if the current
+branch does not have a configured upstream, the rebase will abort.
 
 All changes made by commits in the current branch but that are not
 in <upstream> are saved to a temporary area.  This is the same set
-of commits that would be shown by `git log <upstream>..HEAD` (or
-`git log HEAD`, if --root is specified).
+of commits that would be shown by `git log <upstream>..HEAD`; or by
+`git log 'fork_point'..HEAD`, if --fork-point is either specified or
+assumed (see --fork-point description below); or by `git log HEAD`, if
+--root is specified.
 
 The current branch is reset to <upstream>, or <newbase> if the
 --onto option was supplied.  This has the exact same effect as
@@ -327,13 +329,18 @@ link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details)
 
 --fork-point::
 --no-fork-point::
-	Use 'git merge-base --fork-point' to find a better common ancestor
-	between `upstream` and `branch` when calculating which commits have
-	have been introduced by `branch` (see linkgit:git-merge-base[1]).
+	Use reflog to find a better common ancestor between <upstream>
+	and <branch> when calculating which commits have been
+	introduced by <branch>. 
 +
-If no non-option arguments are given on the command line, then the default is
-`--fork-point @{u}` otherwise the `upstream` argument is interpreted literally
-unless the `--fork-point` option is specified.
+When --fork-point is active, 'fork_point' will be used instead of
+<upstream> to calculate the set of commits to rebase, where
+'fork_point' is the result of `git merge-base --fork-point <upstream>
+<branch>` command (see linkgit:git-merge-base[1]).  If 'fork_point'
+ends up being empty, the <upstream> will be used instead.
++
+If either <upstream> or --root is given on the command line, then the
+default is `--no-fork-point`, otherwise the default is `--fork-point`.
 
 --ignore-whitespace::
 --whitespace=<option>::
-- 
1.9.3
