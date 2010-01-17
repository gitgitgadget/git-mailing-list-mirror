From: Johan Herland <johan@herland.net>
Subject: [PATCHv11 00/20] git notes
Date: Sun, 17 Jan 2010 22:04:17 +0100
Message-ID: <1263762277-31419-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 17 22:05:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcJ4-00072C-4I
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab0AQVFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641Ab0AQVFA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:05:00 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62433 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753463Ab0AQVE7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jan 2010 16:04:59 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE002BGT870RE0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:04:56 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWE00CILT85S310@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 17 Jan 2010 22:04:55 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.17.205416
X-Mailer: git-send-email 1.6.6.rc1.321.g0496e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137322>

Hi,

Here is the 11th iteration of the git-notes series. Changes in this
iteration are as follows:

Changes to existing patches:

- Rebased onto a8b59ef... (Add more testcases to test fast-import of notes)
  which has now been merged to 'next', which now incorporates the initial 3
  of the 11 patches from the previous iteration.

- Patch #1 (was #4) has received minor additional non-functional fixes.

- Patch #4 (was #6) has received two fixes to init_notes():
  - Fail loudly if get_tree_entry() fails on the latest notes commit.
  - Don't ignore the core.notesRef config variable.

- Patch #8 (was #9) revamps for_each_note():
  - Add a 'flags' parameter for adjusting the notes tree traversal.
  - Make sure too-deep fanout levels are consolidated.
  - Minor change to calculation of optimal fanout.

- Patch #10 (was #10) is adjusted to handle the addition of remove_note()
  and write_notes_tree() (patches #6 and #9).

- Patch #11 (was #11) has received some fixes:
  - Use blob_type from blob.h instead of "blob".


New patches:

- Patch #3 adds tests to make sure $GIT_NOTES_REF and core.notesRef
  are handled correctly.

- Patch #6 adds remove_note() for removing notes from notes tree.

- Patch #9 adds write_notes_tree() for saving the notes tree to tree
  objects on disk.

- Patch #12 is the builtin-ification of the "git notes" command.

- Patches #13 and #14 adds tests for aspects of the notes code that was
  not easily testable before the builtin-ification of "git notes".

- Patch #15 teaches the notes code to properly preserve non-note entries
  in the notes tree across a read/update/write-cycle.

- Patches #16 - #18 handles deletion of notes from the notes tree,
  including a test for verifying that repeatedly removing notes
  eventually consolidates the notes tree structure.

- Patches #19 and #20 adds gc_notes() for garbage-collecting notes that
  annotate non-existing commits, and teaches the "--notes" option to
  "git gc".


TODO:
- Handle note objects that are not blobs, but trees
(- Rewrite fast-import notes code to use new notes API with non-note support)


Have fun! :)

...Johan


Johan Herland (20):
  Minor non-functional fixes to notes.c
  Notes API: get_commit_notes() -> format_note() + remove the commit restriction
  Add tests for checking correct handling of $GIT_NOTES_REF and core.notesRef
  Notes API: init_notes(): Initialize the notes tree from the given notes ref
  Notes API: add_note(): Add note objects to the internal notes tree structure
  Notes API: remove_note(): Remove note objects from the notes tree structure
  Notes API: get_note(): Return the note annotating the given object
  Notes API: for_each_note(): Traverse the entire notes tree with a callback
  Notes API: write_notes_tree(): Store the notes tree in the database
  Notes API: Allow multiple concurrent notes trees with new struct notes_tree
  Refactor notes concatenation into a flexible interface for combining notes
  Builtin-ify git-notes
  t3301: Verify successful annotation of non-commits
  t3305: Verify that adding many notes with git-notes triggers increased fanout
  Teach notes code to properly preserve non-notes in the notes tree
  Teach builtin-notes to remove empty notes
  builtin-notes: Teach -d option for deleting existing notes
  t3305: Verify that removing notes triggers automatic fanout consolidation
  Notes API: gc_notes(): Prune notes that belong to non-existing objects
  builtin-gc: Teach the new --notes option to garbage-collect notes

 Documentation/git-gc.txt                      |    5 +-
 Documentation/git-notes.txt                   |   19 +-
 Makefile                                      |    2 +-
 builtin-gc.c                                  |   13 +
 builtin-notes.c                               |  251 ++++++++
 builtin.h                                     |    3 +
 git-notes.sh => contrib/examples/git-notes.sh |    0
 git.c                                         |    1 +
 notes.c                                       |  841 +++++++++++++++++++++----
 notes.h                                       |  192 ++++++-
 pretty.c                                      |    9 +-
 t/t3301-notes.sh                              |  189 +++++-
 t/t3303-notes-subtrees.sh                     |   28 +-
 t/t3304-notes-mixed.sh                        |   36 +-
 t/t3305-notes-fanout.sh                       |   95 +++
 t/t3306-notes-gc.sh                           |  106 ++++
 16 files changed, 1622 insertions(+), 168 deletions(-)
 create mode 100644 builtin-notes.c
 rename git-notes.sh => contrib/examples/git-notes.sh (100%)
 create mode 100755 t/t3305-notes-fanout.sh
 create mode 100755 t/t3306-notes-gc.sh
