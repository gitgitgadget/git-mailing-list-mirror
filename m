From: Johan Herland <johan@herland.net>
Subject: [PATCHv12 00/23] git notes
Date: Wed, 27 Jan 2010 12:51:37 +0100
Message-ID: <1264593120-4428-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 27 12:54:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na6Si-0000gj-Hr
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898Ab0A0LwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871Ab0A0LwT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:52:19 -0500
Received: from smtp.getmail.no ([84.208.15.66]:52693 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752667Ab0A0LwR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:52:17 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00JBBMB22M00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:14 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00EZ7MAZN340@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:52:14 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.113919
X-Mailer: git-send-email 1.6.6.405.g80ed6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138150>

Hi,

Here is the 12th iteration of the git-notes series. Changes in this
iteration are as follows:

- Rebased onto 67bc740... (Merge branch 'jc/maint-limit-note-output') to adjust
  for the fixes limiting the eagerness of log and friends to show notes.

- Patches #2, #3, #10, #12, #17 and #20 resolved conflicts while rebasing.

- Patch #12 has been changed to call die() instead of fprintf(stderr, ...)
  followed by exit(1). Thanks to Stephen Boyd for the suggestion.

- Patches #17 and #18 have been changed to add a new "git notes remove"
  subcommand instead of a "git notes edit -d" option.

- Patch #19 has renamed gc_notes() to prune_notes().

- Patch #20 (which added "git gc --notes") has been replaced by a patch adding
  the equivalent "git notes prune" subcommand.

- Patch #21 is a new patch revamping the git-notes documentation to talk about
  'object' notes instead of 'commit' notes.

- Patch #22 is a new patch adding the "git notes list" command for listing
  notes and the objects they annotate.

- Patch #23 is a new patch adding the "git notes add" command for appending
  contents to notes (instead of editing/replacing).


STILL TODO:

- Suggestion by Matthieu Moy and Sverre Rabbelier:
  Add notes support to git-format-patch, where note contents in
  refs/notes/format-patch are added to the "comments section"
  (i.e. following the '---' separator) of generated patches.

- Better integration with rebase/amend/cherry-pick. Optionally bring
  notes across a commit rewrite. Controlled by command-line options
  and/or config variables. Add "git notes move" and "git notes copy"
  to suit. Junio says:
    I used to fix minor issues (styles, decl-after-stmt, etc.) using
    rebase-i long after running "am" in bulk, but these days I find
    myself going back to my "inbox" and fix them in MUA; this is
    only because I know these notes do not propagate across rebases
    and amends -- adjusting the workflow to the tool's limitation is
    not very good.

- Junio says:
  The interface to tell tools to use which notes ref to use should be
  able to say "these refs", not just "this ref" i.e. GIT_NOTES_REF=a:b
  just like PATH=a:b:c...); I am fairly certain that we would want to
  store different kind of information in separate notes trees and
  aggregate them, as we gain experience with notes.

- Junio says:
  There should be an interface to tell tools to use which notes refs via
  command line options; "!alias" does not TAB-complete, and "git lgm"
  above doesn't, either. "git log --notes=notes/amlog --notes=notes/other"
  would probably be the way to go.

- Add a "git notes grep" subcommand: Junio says:
  While reviewing the "inbox", I sometimes wonder if I applied a message
  to somewhere already, but there is no obvious way to grep in the notes
  tree and get the object name that a note is attached to.  Of course I
  know I can "git grep -c johan@herland.net notes/amlog" and it will give
  me something like:

    notes/amlog:65807ee697a28cb30b8ad38ebb8b84cebd3f255d:1
    notes/amlog:c789176020d6a008821e01af8b65f28abc138d4b:1

  but this won't scale and needs scripting to mechanize, once we start
  rebalancing the notes tree with different fan-outs.  The end user (me
  in this case) is interested in "set of objects that match this grep
  criteria", not "the pathnames the notes tree's implementation happens
  to use to store notes for them in the hierarchy".

- Handle note objects that are not blobs, but trees

(- Rewrite fast-import notes code to use new notes API with non-note support)


Have fun! :)

...Johan


Johan Herland (23):
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
  builtin-notes: Add "remove" subcommand for removing existing notes
  t3305: Verify that removing notes triggers automatic fanout consolidation
  Notes API: prune_notes(): Prune notes that belong to non-existing objects
  builtin-notes: Add "prune" subcommand for removing notes for missing objects
  Documentation: Generalize git-notes docs to 'objects' instead of 'commits'
  builtin-notes: Add "list" subcommand for listing note objects
  builtin-notes: Add "add" subcommand for appending to note objects

 Documentation/git-notes.txt                   |   60 ++-
 Makefile                                      |    2 +-
 builtin-notes.c                               |  301 +++++++++
 builtin.h                                     |    3 +
 git-notes.sh => contrib/examples/git-notes.sh |    0
 git.c                                         |    1 +
 notes.c                                       |  843 +++++++++++++++++++++----
 notes.h                                       |  192 ++++++-
 pretty.c                                      |    9 +-
 t/t3301-notes.sh                              |  262 +++++++-
 t/t3303-notes-subtrees.sh                     |   28 +-
 t/t3304-notes-mixed.sh                        |   36 +-
 t/t3305-notes-fanout.sh                       |   95 +++
 t/t3306-notes-prune.sh                        |   94 +++
 14 files changed, 1737 insertions(+), 189 deletions(-)
 create mode 100644 builtin-notes.c
 rename git-notes.sh => contrib/examples/git-notes.sh (100%)
 create mode 100755 t/t3305-notes-fanout.sh
 create mode 100755 t/t3306-notes-prune.sh
