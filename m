From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/4] Clean up subprocess calling
Date: Sun, 26 Aug 2007 22:33:21 +0200
Message-ID: <20070826202724.16265.85821.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:33:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOo1-00083X-EU
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938AbXHZUdb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752418AbXHZUda
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:33:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4753 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbXHZUda (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:33:30 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOnS-0005vJ-00; Sun, 26 Aug 2007 21:33:22 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56719>

We had nearly ten separate functions implementing about five different
ways of calling a subprocess. This series cleans it up. The aggregate
diffstat looks scary, but that's mostly because these functions were
called in a bajillion different places.

If you choose to pull from my repository (which I highly recommend!),
note that this series is built on top of the misc fixes, so you get
those as well.

The following changes since commit 216a1524c4acbd9952ffaeec054e30cf14dd=
e5fc:
  Karl Hasselstr=C3=B6m (1):
        Compile regexp just once

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git run

Karl Hasselstr=C3=B6m (4):
      Refactor output handling to break circular dependency
      Refactor subprocess creation
      Assert that the argument to Run is a sequence of strings
      Add optional logging of subprocess execution

 stgit/basedir.py             |   13 +-
 stgit/commands/applied.py    |    1 +
 stgit/commands/assimilate.py |    1 +
 stgit/commands/branch.py     |    1 +
 stgit/commands/clean.py      |    1 +
 stgit/commands/commit.py     |    1 +
 stgit/commands/common.py     |    1 +
 stgit/commands/delete.py     |    1 +
 stgit/commands/diff.py       |    1 +
 stgit/commands/export.py     |   10 +-
 stgit/commands/files.py      |    1 +
 stgit/commands/fold.py       |    1 +
 stgit/commands/hide.py       |    1 +
 stgit/commands/id.py         |    1 +
 stgit/commands/imprt.py      |    1 +
 stgit/commands/log.py        |    1 +
 stgit/commands/mail.py       |    1 +
 stgit/commands/patches.py    |    1 +
 stgit/commands/pick.py       |    1 +
 stgit/commands/pull.py       |    1 +
 stgit/commands/push.py       |    1 +
 stgit/commands/refresh.py    |    1 +
 stgit/commands/rename.py     |    1 +
 stgit/commands/series.py     |    1 +
 stgit/commands/sync.py       |    1 +
 stgit/commands/top.py        |    1 +
 stgit/commands/unapplied.py  |    1 +
 stgit/commands/uncommit.py   |    1 +
 stgit/commands/unhide.py     |    1 +
 stgit/config.py              |   56 ++-----
 stgit/git.py                 |  331 +++++++++++++++++-----------------=
--------
 stgit/gitmergeonefile.py     |   21 +--
 stgit/main.py                |    2 +-
 stgit/out.py                 |  100 +++++++++++++
 stgit/run.py                 |  141 ++++++++++++++++++
 stgit/stack.py               |    1 +
 stgit/utils.py               |   81 +----------
 37 files changed, 436 insertions(+), 347 deletions(-)
 create mode 100644 stgit/out.py
 create mode 100644 stgit/run.py

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
