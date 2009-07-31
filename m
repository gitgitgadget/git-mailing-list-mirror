From: Johan Herland <johan@herland.net>
Subject: [RFCv2 00/12] Foreign VCS helper program for CVS repositories
Date: Fri, 31 Jul 2009 12:00:20 +0200
Message-ID: <1249034432-31437-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 12:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWov8-0007RP-1n
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbZGaKAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 06:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbZGaKAy
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:00:54 -0400
Received: from mx.getmail.no ([84.208.15.66]:55431 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751315AbZGaKAx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 06:00:53 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNN00EX755G2D60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 31 Jul 2009 12:00:52 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNN005FA55FU840@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 31 Jul 2009 12:00:52 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.7.31.94825
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124521>

Hi,

Here is a resend of the jh/vcs-cvs topic in 'pu'. This series is based on
the jh/notes topic in current 'pu', but is NOT based on the db/transport-shim
topic. As a consequence of this, the series now contains 3 more patches that
were part of the original db/foreign-scm topic.

Also, I expect that Barkalow will at some point send an updated
db/foreign-scm topic, which will invalidate parts of - or the whole of -
this patch series. I expect to rebase and resend this topic when the
updated db/foreign-scm appears, but since I am away for the next week,
I still send this series now, to reflect the current (unfinished) state.

The 7 first patches are a resend of Barkalow's original foreign-scm topic,
or at least enough of it to support the rest of this series.

Next, there are 3 patches tweaking and expanding the foreign-vcs API (with
corresponding implementations in the foreign transport code) to adjust for
the CVS helper's needs.

The final 2 patches add the git-vcs-cvs helper program that implements the
fetch/import of objects from a local or remote CVS repository, along with
selftests for verifying its correctness in some simple cases.


Changes since the last iteration:
- Added 3 more patches from the db/foreign-scm topic, caused by rebase.
- The patch with preliminary refactoring in fast-import.c is gone.
- The patch teaching fast-import to import notes has been moved to jh/notes.
- The CVS helper is updated to use the new 'notemodify' fast-import command.


Daniel Barkalow (7):
  Allow late reporting of fetched hashes
  Document details of transport function APIs
  Add option for using a foreign VCS
  Add specification of git-vcs-* helper programs
  Use a function to determine whether a remote is valid
  Allow programs to not depend on remotes having urls
  Add a transport implementation using git-vcs-* helpers

Johan Herland (5):
  Preliminary clarifications to git-vcs documentation
  Teach foreign transport code to perform the "capabilities" command
  Introduce a 'marks <filename>' feature to the foreign transport code
  First draft of CVS importer using the foreign-scm machinery
  Add simple test cases of git-vcs-cvs functionality

 Documentation/config.txt         |    4 +
 Documentation/git-vcs-cvs.txt    |   85 ++++
 Documentation/git-vcs.txt        |   88 ++++
 Makefile                         |   47 ++
 builtin-clone.c                  |    6 +-
 builtin-fetch.c                  |   19 +-
 builtin-ls-remote.c              |    6 +-
 builtin-push.c                   |   54 ++-
 configure.ac                     |    3 +
 git-vcs-cvs.py                   |  697 ++++++++++++++++++++++++++++++
 git_vcs_cvs/.gitignore           |    2 +
 git_vcs_cvs/Makefile             |   27 ++
 git_vcs_cvs/changeset.py         |  114 +++++
 git_vcs_cvs/commit_states.py     |   52 +++
 git_vcs_cvs/cvs.py               |  884 ++++++++++++++++++++++++++++++++++++++
 git_vcs_cvs/cvs_revision_map.py  |  367 ++++++++++++++++
 git_vcs_cvs/cvs_symbol_cache.py  |  283 ++++++++++++
 git_vcs_cvs/git.py               |  591 +++++++++++++++++++++++++
 git_vcs_cvs/setup.py             |   12 +
 git_vcs_cvs/util.py              |  147 +++++++
 remote.c                         |   15 +-
 remote.h                         |    2 +
 t/t9800-foreign-vcs-cvs-basic.sh |  518 ++++++++++++++++++++++
 t/t9801-foreign-vcs-cvs-fetch.sh |  291 +++++++++++++
 t/test-lib.sh                    |    1 +
 transport-foreign.c              |  271 ++++++++++++
 transport.c                      |   24 +-
 transport.h                      |   45 ++-
 28 files changed, 4609 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/git-vcs-cvs.txt
 create mode 100644 Documentation/git-vcs.txt
 create mode 100755 git-vcs-cvs.py
 create mode 100644 git_vcs_cvs/.gitignore
 create mode 100644 git_vcs_cvs/Makefile
 create mode 100644 git_vcs_cvs/__init__.py
 create mode 100644 git_vcs_cvs/changeset.py
 create mode 100644 git_vcs_cvs/commit_states.py
 create mode 100644 git_vcs_cvs/cvs.py
 create mode 100644 git_vcs_cvs/cvs_revision_map.py
 create mode 100644 git_vcs_cvs/cvs_symbol_cache.py
 create mode 100644 git_vcs_cvs/git.py
 create mode 100644 git_vcs_cvs/setup.py
 create mode 100644 git_vcs_cvs/util.py
 create mode 100755 t/t9800-foreign-vcs-cvs-basic.sh
 create mode 100755 t/t9801-foreign-vcs-cvs-fetch.sh
 create mode 100644 transport-foreign.c


Have fun! :)

...Johan
