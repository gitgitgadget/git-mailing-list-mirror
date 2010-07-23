From: Johan Herland <johan@herland.net>
Subject: [WIP/RFC 00/13] git notes merge
Date: Fri, 23 Jul 2010 12:14:51 +0200
Message-ID: <1279880104-29796-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 12:15:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcFHk-0000nW-Vj
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 12:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab0GWKPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 06:15:13 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43952 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450Ab0GWKPL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 06:15:11 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6000G959T9M390@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:09 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8C4041EA54CD_C496BADB	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:09 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 6944A1EA369A_C496BADF	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:09 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L60005R49T9TN00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:09 +0200 (MEST)
X-Mailer: git-send-email 1.7.2.220.gea1d3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151513>

Hi,

Here are some rough patches implementing most of the 'git notes merge'
functionality. There are still missing pieces in the area of manual
conflict resolution, but what's here should be enough to start
experimenting with automatic notes merge resolution.

Patches #1 - #8 + #10 are a combination of general cleanup and
preparations for 'git notes merge'. Patch #9 implements handling
of trivial notes merges ("already up-to-date" and "fast-forward").
Patch #11 implements object-level merging of notes, using regular
three-way rules. Patch #12 adds a few automatic conflict resolvers
that can be used instead of manual conflict resolution (which has
yet to be implemented). Patch #13 adds some preliminary docs.

For now, this is probably only ready for those with a special
interest in notes.


Have fun! :)

...Johan


Johan Herland (13):
  (trivial) notes.h: Minor documentation fixes to copy_notes()
  notes.h: Make default_notes_ref() available in notes API
  notes.h/c: Clarify the handling of notes objects that are == null_sha1
  notes.h/c: Propagate combine_notes_fn return value to add_note() and beyond
  (trivial) t3303: Indent with tabs instead of spaces for consistency
  notes.c: Use two newlines (instead of one) when concatenating notes
  (trivial) git notes prune: Accept --verbose in addition to -v
  builtin/notes.c: Split notes ref DWIMmery into a separate function
  git notes merge: Initial implementation handling trivial merges only
  builtin/notes.c: Refactor creation of notes commits.
  git notes merge: Handle real, non-conflicting notes merges
  git notes merge: Add automatic conflict resolvers (ours, theirs, union)
  Documentation: Preliminary docs on 'git notes merge'

 Documentation/git-notes.txt         |   30 ++-
 Makefile                            |    2 +
 builtin.h                           |    2 +-
 builtin/notes.c                     |  130 ++++++--
 notes-cache.c                       |    3 +-
 notes-merge.c                       |  474 +++++++++++++++++++++++++
 notes-merge.h                       |   59 +++
 notes.c                             |  196 ++++++-----
 notes.h                             |   46 +++-
 t/t3301-notes.sh                    |    4 +
 t/t3303-notes-subtrees.sh           |   19 +-
 t/t3308-notes-merge.sh              |  669 +++++++++++++++++++++++++++++++++++
 t/t3309-notes-merge-auto-resolve.sh |  512 +++++++++++++++++++++++++++
 t/t3404-rebase-interactive.sh       |    1 +
 t/t9301-fast-import-notes.sh        |    5 +
 15 files changed, 2014 insertions(+), 138 deletions(-)
 create mode 100644 notes-merge.c
 create mode 100644 notes-merge.h
 create mode 100755 t/t3308-notes-merge.sh
 create mode 100755 t/t3309-notes-merge-auto-resolve.sh

--
1.7.2.220.gea1d3
