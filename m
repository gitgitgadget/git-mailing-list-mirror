From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/3] Auto-generate man pages and command list
Date: Mon, 08 Sep 2008 23:07:52 +0200
Message-ID: <20080908210302.1957.44280.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 23:09:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcnyx-0008QS-42
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 23:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbYIHVIB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2008 17:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbYIHVIA
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 17:08:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1919 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612AbYIHVIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 17:08:00 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KcoJE-0003bs-00; Mon, 08 Sep 2008 22:30:08 +0100
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95302>

The first patch auto-generates man pages for all StGit commands. We
still have to write the actual text by hand (bummer!), but we get all
the flags for free. Now we just have to take all those man pages and
make them good ...

The third patch gets rid of the manual list of all commands in main.py
and stg.txt, and instead generates it automatically. (There's still
one list in the bash completion script; it is my next target.)

---

Karl Hasselstr=C3=B6m (3):
      Generate command lists automatically
      asciidoc.conf: Steal updates from git
      Auto-generate man pages for all StGit commands


 Documentation/.gitignore           |    4 -
 Documentation/COMMAND-TEMPLATE.txt |   42 ---------
 Documentation/Makefile             |   15 +++
 Documentation/asciidoc.conf        |  100 +++++++++++++++-----
 Documentation/stg-branch.txt       |  114 -----------------------
 Documentation/stg-clone.txt        |   32 -------
 Documentation/stg-init.txt         |   29 ------
 Documentation/stg-new.txt          |  115 ------------------------
 Documentation/stg-sink.txt         |   49 ----------
 Documentation/stg.txt              |  138 ----------------------------
 Makefile                           |   18 +++-
 stg-build                          |   37 ++++++++
 stgit/argparse.py                  |  176 ++++++++++++++++++++++++++++=
--------
 stgit/commands/.gitignore          |    1=20
 stgit/commands/__init__.py         |   78 ++++++++++++++++
 stgit/commands/branch.py           |  123 ++++++++++++++++---------
 stgit/commands/clean.py            |   22 ++---
 stgit/commands/clone.py            |   20 +++-
 stgit/commands/coalesce.py         |   14 ++-
 stgit/commands/commit.py           |   22 +++--
 stgit/commands/delete.py           |   16 ++-
 stgit/commands/diff.py             |   27 +++---
 stgit/commands/edit.py             |   24 ++---
 stgit/commands/export.py           |   48 +++++-----
 stgit/commands/files.py            |   24 ++---
 stgit/commands/float.py            |   18 ++--
 stgit/commands/fold.py             |   23 ++---
 stgit/commands/goto.py             |   11 +-
 stgit/commands/hide.py             |   17 ++-
 stgit/commands/id.py               |   12 +-
 stgit/commands/imprt.py            |   93 +++++++++----------
 stgit/commands/init.py             |   14 ++-
 stgit/commands/log.py              |   34 +++----
 stgit/commands/mail.py             |  116 +++++++++++-------------
 stgit/commands/new.py              |   34 ++++---
 stgit/commands/patches.py          |   22 ++---
 stgit/commands/pick.py             |   50 +++++-----
 stgit/commands/pop.py              |   28 +++---
 stgit/commands/pull.py             |   23 ++---
 stgit/commands/push.py             |   38 +++-----
 stgit/commands/rebase.py           |   23 ++---
 stgit/commands/refresh.py          |   45 ++++-----
 stgit/commands/rename.py           |   20 ++--
 stgit/commands/repair.py           |   11 +-
 stgit/commands/resolved.py         |   27 +++---
 stgit/commands/series.py           |   78 +++++++---------
 stgit/commands/show.py             |   31 +++---
 stgit/commands/sink.py             |   44 ++++++---
 stgit/commands/status.py           |   53 +++++------
 stgit/commands/sync.py             |   31 +++---
 stgit/commands/top.py              |   16 ++-
 stgit/commands/uncommit.py         |   25 +++--
 stgit/commands/unhide.py           |   19 ++--
 stgit/main.py                      |  138 ++--------------------------
 54 files changed, 1024 insertions(+), 1358 deletions(-)
 delete mode 100644 Documentation/COMMAND-TEMPLATE.txt
 delete mode 100644 Documentation/stg-branch.txt
 delete mode 100644 Documentation/stg-clone.txt
 delete mode 100644 Documentation/stg-init.txt
 delete mode 100644 Documentation/stg-new.txt
 delete mode 100644 Documentation/stg-sink.txt
 create mode 100755 stg-build
 create mode 100644 stgit/commands/.gitignore

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
