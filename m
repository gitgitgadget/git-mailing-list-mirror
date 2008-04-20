From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 00/10] Updated "stg reset" series
Date: Mon, 21 Apr 2008 00:10:20 +0200
Message-ID: <20080420215625.5837.82896.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:11:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnhki-0007p9-64
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 00:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbYDTWKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 18:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbYDTWKa
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:10:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3177 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbYDTWK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 18:10:29 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jnhjn-00081K-00; Sun, 20 Apr 2008 23:10:19 +0100
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79989>

The patch stack log / stg reset series has matured over the weekend.
The major highlights are

  1. When a command fails to push a patch due to conflicts, it will
     log two entries -- one for the part of the command that
     succeeded, and one just for the conflicting push. This makes it
     possible to undo just the last part, and not the whole command.

  2. I've tightened the checks so that conflicts will prevent most
     commands from working unless they actively claim to make sense in
     the face of conflicts. Basically, only commands that don't touch
     the topmost patch should be able to run when there are conflicts.

  3. stg reset now understands --hard, which makes it zonk any local
     changes, including conflicts.

(1) and (3) means that

  $ stg reset --hard <branchname>.stgit^~1

can be used instead of stg push --undo when you want to undo a
conflicting push. Now I just have to make that available as

  $ stg undo

so that it actually becomes usable ...

These patches are available at

  git://repo.or.cz/stgit/kha.git experimental

---

Karl Hasselstr=C3=B6m (10):
      Don't write a log entry if there were no changes
      Add a --hard flag to stg reset
      Log conflicts separately for all commands
      Log conflicts separately
      New command: stg reset
      Add utility function for reordering patches
      Write to a stack log when stack is modified
      Library functions for tree and blob manipulation
      Add property with a list of all patch names
      Prevent most commands from running when there are conflicts


 stgit/commands/branch.py   |   20 ++++-
 stgit/commands/clean.py    |    3 +
 stgit/commands/coalesce.py |    6 +-
 stgit/commands/commit.py   |   13 ++--
 stgit/commands/common.py   |    8 ++
 stgit/commands/delete.py   |   14 +++-
 stgit/commands/diff.py     |    2 -
 stgit/commands/edit.py     |    3 +
 stgit/commands/export.py   |    2 -
 stgit/commands/files.py    |    2 -
 stgit/commands/id.py       |    2 -
 stgit/commands/log.py      |    2 -
 stgit/commands/mail.py     |    2 -
 stgit/commands/patches.py  |    2 -
 stgit/commands/reset.py    |  118 ++++++++++++++++++++++++++++++++
 stgit/commands/series.py   |    2 -
 stgit/commands/show.py     |    2 -
 stgit/commands/status.py   |    3 +
 stgit/commands/top.py      |    2 -
 stgit/commands/uncommit.py |    5 +
 stgit/lib/git.py           |  143 +++++++++++++++++++++++++++++++++---=
---
 stgit/lib/log.py           |  161 ++++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py         |    8 ++
 stgit/lib/transaction.py   |   92 ++++++++++++++++++++-----
 stgit/main.py              |    4 +
 t/t3100-reset.sh           |  151 ++++++++++++++++++++++++++++++++++++=
+++++
 t/t3101-reset-hard.sh      |   56 +++++++++++++++
 27 files changed, 754 insertions(+), 74 deletions(-)
 create mode 100644 stgit/commands/reset.py
 create mode 100644 stgit/lib/log.py
 create mode 100755 t/t3100-reset.sh
 create mode 100755 t/t3101-reset-hard.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
