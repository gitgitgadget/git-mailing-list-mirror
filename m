From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 00/23] git notes merge
Date: Tue, 09 Nov 2010 22:49:36 +0100
Message-ID: <1289339399-4733-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 22:50:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFw5G-0000PX-CF
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 22:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab0KIVuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 16:50:12 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61168 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708Ab0KIVuL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 16:50:11 -0500
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN005VS0NMCV30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:10 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 4BBB91799CD9_CD9C212B	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:10 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 110941799C80_CD9C212F	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:10 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN00HVN0NLS730@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:10 +0100 (MET)
X-Mailer: git-send-email 1.7.3.2.173.gab1c9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161080>

Hi,

This is the 6th iteration of the 'git notes merge' patch series.

Changes between v5 and v6:

- (in v5.1) Clarify 'git merge --abort' documentation with help from
  Jonathan Nieder

- (in v5.1) Rewrite t7609 to more clearly (and correctly) demonstrate
  (and verify) the different scenarios in which 'git merge --abort' can
  be run. Again, thanks to Jonathan Nieder for help with this.

- (Junio C Hamano) t3311: Portability fix

- (Junio C Hamano) fixup minor style issues


Some open questions (not already being discussed in other threads):

- Should we refuse to finalize a notes merge when conflict markers are
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

 Documentation/git-merge.txt           |   27 ++-
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
 t/t7609-merge-abort.sh                |  313 ++++++++++++++
 t/t9301-fast-import-notes.sh          |    5 +
 20 files changed, 3792 insertions(+), 162 deletions(-)
 create mode 100644 notes-merge.c
 create mode 100644 notes-merge.h
 create mode 100755 t/t3308-notes-merge.sh
 create mode 100755 t/t3309-notes-merge-auto-resolve.sh
 create mode 100755 t/t3310-notes-merge-manual-resolve.sh
 create mode 100755 t/t3311-notes-merge-fanout.sh
 create mode 100755 t/t7609-merge-abort.sh

--
1.7.3.2.173.gab1c9.dirty
