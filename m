From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 00/23] git notes merge
Date: Mon, 25 Oct 2010 02:08:30 +0200
Message-ID: <1287965333-5099-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 02:09:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAcr-0000Uz-0Y
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab0JYAJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 20:09:14 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59867 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492Ab0JYAJN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 20:09:13 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT005XXKFBGG40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:11 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 2D81517990AE_CC4CAA7B	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:11 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id E3D0517966AD_CC4CAA6F	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:10 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT004SRKFAVB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:10 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159901>

Hi,

This is the 5th iteration of the 'git notes merge' patch series.

In short, patch #5 has an updated commit message, patch #6 has a
minor improvement, patch #16 has renames "--reset" to "--abort",
and there are 2 new patches at the end (totally independent from
the other patches) implementing 'git merge --abort'. Feel free to
consider the two last patches separately from the rest of the series.

Changes between v4 and v5:

- (Jonathan Nieder) Improved commit messages

- (Jonathan Nieder) Improve clarity of final if-condition in
  note_tree_insert()

- (Sverre Rabbelier) Rename 'git notes merge --reset' to
  'git notes merge --abort'.

- Introduce 'git merge --abort' as a synonym of 'git reset --merge'
  (when MERGE_HEAD is present).


Some open questions (not already being discussed in other threads):

- Should we refuse to finalize a notes merge when conflict markers
  present in .git/NOTES_MERGE_WORKTREE? Since add/commit in regular
  merges does NOT do this, I have not implemented it for notes merge.


Have fun! :)

...Johan


Johan Herland (23):
  notes.c: Hexify SHA1 in die() message from init_notes()
  (trivial) notes.h: Minor documentation fixes to copy_notes()
  notes.h: Make default_notes_ref() available in notes API
  notes.c: Reorder functions in preparation for next commit
  notes.h/c: Allow combine_notes functions to remove notes
  notes.h/c: Propagate combine_notes_fn return value to add_note() and beyond
  (trivial) t3303: Indent with tabs instead of spaces for consistency
  notes.c: Use two newlines (instead of one) when concatenating notes
  builtin/notes.c: Split notes ref DWIMmery into a separate function
  git notes merge: Initial implementation handling trivial merges only
  builtin/notes.c: Refactor creation of notes commits.
  git notes merge: Handle real, non-conflicting notes merges
  git notes merge: Add automatic conflict resolvers (ours, theirs, union)
  Documentation: Preliminary docs on 'git notes merge'
  git notes merge: Manual conflict resolution, part 1/2
  git notes merge: Manual conflict resolution, part 2/2
  git notes merge: List conflicting notes in notes merge commit message
  git notes merge: --commit should fail if underlying notes ref has moved
  git notes merge: Add another auto-resolving strategy: "cat_sort_uniq"
  git notes merge: Add testcases for merging notes trees at different fanouts
  Provide 'git notes get-ref' to easily retrieve current notes ref
  cmd_merge(): Parse options before checking MERGE_HEAD
  Provide 'git merge --abort' as a synonym to 'git reset --merge'

 Documentation/git-merge.txt           |   29 ++-
 Documentation/git-notes.txt           |   85 ++++-
 Makefile                              |    2 +
 builtin.h                             |    2 +-
 builtin/merge.c                       |   47 ++-
 builtin/notes.c                       |  268 +++++++++++--
 notes-cache.c                         |    3 +-
 notes-merge.c                         |  735 +++++++++++++++++++++++++++++++++
 notes-merge.h                         |   98 +++++
 notes.c                               |  272 ++++++++----
 notes.h                               |   47 ++-
 t/t3301-notes.sh                      |   23 +
 t/t3303-notes-subtrees.sh             |   19 +-
 t/t3308-notes-merge.sh                |  368 +++++++++++++++++
 t/t3309-notes-merge-auto-resolve.sh   |  647 +++++++++++++++++++++++++++++
 t/t3310-notes-merge-manual-resolve.sh |  556 +++++++++++++++++++++++++
 t/t3311-notes-merge-fanout.sh         |  436 +++++++++++++++++++
 t/t3404-rebase-interactive.sh         |    1 +
 t/t7609-merge-abort.sh                |  273 ++++++++++++
 t/t9301-fast-import-notes.sh          |    5 +
 20 files changed, 3754 insertions(+), 162 deletions(-)
 create mode 100644 notes-merge.c
 create mode 100644 notes-merge.h
 create mode 100755 t/t3308-notes-merge.sh
 create mode 100755 t/t3309-notes-merge-auto-resolve.sh
 create mode 100755 t/t3310-notes-merge-manual-resolve.sh
 create mode 100755 t/t3311-notes-merge-fanout.sh
 create mode 100755 t/t7609-merge-abort.sh

--
1.7.3.98.g5ad7d9
