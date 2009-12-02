From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv9 00/11] git notes
Date: Wed, 02 Dec 2009 03:09:32 +0100
Message-ID: <1259719783-4674-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, johan@herland.net, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 03:10:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFefS-0005TP-1l
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 03:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbZLBCJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 21:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754443AbZLBCJ6
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 21:09:58 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61613 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754383AbZLBCJ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 21:09:57 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU0004FW60RPL70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:03 +0100 (MET)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KU000JVB60NVI30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 02 Dec 2009 03:10:03 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.2.15716
X-Mailer: git-send-email 1.6.5.3.433.g11067
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134282>

Hi,

Here is the 9th iteration of the git-notes series. Changes in this
iteration are as follows:

Changes to existing patches:

- Rebased back onto the early part of the jh/notes series, as
  suggested by Junio.

- Minor style fixes to some of the patches.

- The git-fast-import patch has been heavily rewritten after
  suggestions from Shawn. The new patch is much less intrusive,
  by way of NOT interfacing with the notes API, but doing the
  fanout strategy directly in fast-import.c instead.

- The new fast-import patch no longer depends on changes in the
  notes API. The fast-import-related patches are therefore moved
  to the head of the patch series, and the notes API changes that
  are no longer necessary (but still worthwhile, IMHO) are moved
  to the tail.

If Shawn is OK with the fast-import patch, I believe that at least
patches #1 - #3 (and possibly #4 - #5) are ready for 'next'.

Patches #6 - #11 drastically extend the notes API. Since there are
currently no users of that API, and it has not been discussed much
on the list (although these patches have already been present in a
couple of iterations), I would still consider them RFC quality.


TODO:
- Builtin-ify git-notes shell script to take advantage of notes API
- Garbage collect notes whose referenced object is unreachable (gc_notes())
- Handle note objects that are not blobs, but trees


Have fun! :)

...Johan


Johan Herland (11):
  fast-import: Proper notes tree manipulation
  Rename t9301 to t9350, to make room for more fast-import tests
  Add more testcases to test fast-import of notes
  Minor style fixes to notes.c
  Notes API: get_commit_notes() -> format_note() + remove the commit restriction
  Notes API: init_notes(): Initialize the notes tree from the given notes ref
  Notes API: add_note(): Add note objects to the internal notes tree structure
  Notes API: get_note(): Return the note annotating the given object
  Notes API: for_each_note(): Traverse the entire notes tree with a callback
  Notes API: Allow multiple concurrent notes trees with new struct notes_tree
  Refactor notes concatenation into a flexible interface for combining notes

 fast-import.c                                    |  141 +++++-
 notes.c                                          |  345 ++++++++++----
 notes.h                                          |  114 ++++-
 pretty.c                                         |    9 +-
 t/t9300-fast-import.sh                           |  156 ++++++-
 t/t9301-fast-import-notes.sh                     |  578 ++++++++++++++++++++++
 t/{t9301-fast-export.sh => t9350-fast-export.sh} |    0
 7 files changed, 1218 insertions(+), 125 deletions(-)
 create mode 100755 t/t9301-fast-import-notes.sh
 rename t/{t9301-fast-export.sh => t9350-fast-export.sh} (100%)
