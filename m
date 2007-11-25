From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 00/10] Infrastructure rewrite series
Date: Sun, 25 Nov 2007 21:50:47 +0100
Message-ID: <20071125203717.7823.70046.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:51:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwORp-0003Y8-Qr
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225AbXKYUvG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756462AbXKYUvF
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:51:05 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4104 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222AbXKYUvE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:51:04 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwORI-0007Z1-00; Sun, 25 Nov 2007 20:50:53 +0000
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65993>

I've expanded on the infrastructure rewrite series. As of now, clean,
applied, unapplied, goto, uncommit, and the new command coalesce have
been converted.

The main new development is support for index and worktree operations,
so that it can do conflicting merges. This made it possible to convert
"stg goto", but the main practical attraction is the vastly improved
"stg coalesce", which can now take an arbitrary list of patches and
reorder them so that they can be joined to one big patch. It will do
so entirely automatically if the merges resolve automatically, and if
they don't it will pretend to have done a series of pops, pushes, and
deletes, and leave the user to manually resolve the first conflicting
push.

The implementation of coalesce -- particularly the ability to fail
gracefully on conflicts at any intermediate step -- is helped a lot by
some new cool transaction stuff.

Available from

  git://repo.or.cz/stgit/kha.git experimental

---

Karl Hasselstr=C3=B6m (10):
      Convert "stg uncommit" to the new infrastructure
      Let "stg goto" use the new infrastructure
      Let "stg clean" use the new transaction primitives
      Teach the new infrastructure about the index and worktree
      Let "stg applied" and "stg unapplied" use the new infrastructure
      Add "stg coalesce"
      Let "stg clean" use the new infrastructure
      Upgrade older stacks to newest version
      Write metadata files used by the old infrastructure
      New StGit core infrastructure: repository operations


 contrib/stgit-completion.bash |    2=20
 setup.py                      |    2=20
 stgit/commands/applied.py     |   27 +--
 stgit/commands/clean.py       |   49 ++---
 stgit/commands/coalesce.py    |  109 ++++++++++++
 stgit/commands/common.py      |   10 +
 stgit/commands/goto.py        |   52 ++----
 stgit/commands/unapplied.py   |   23 +-
 stgit/commands/uncommit.py    |   79 ++++----
 stgit/lib/__init__.py         |   18 ++
 stgit/lib/git.py              |  383 +++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py            |  168 ++++++++++++++++++
 stgit/lib/stackupgrade.py     |   96 ++++++++++
 stgit/lib/transaction.py      |  194 +++++++++++++++++++++
 stgit/main.py                 |    2=20
 stgit/stack.py                |  100 +----------
 stgit/utils.py                |   24 +++
 t/t2600-coalesce.sh           |   31 +++
 18 files changed, 1136 insertions(+), 233 deletions(-)
 create mode 100644 stgit/commands/coalesce.py
 create mode 100644 stgit/lib/__init__.py
 create mode 100644 stgit/lib/git.py
 create mode 100644 stgit/lib/stack.py
 create mode 100644 stgit/lib/stackupgrade.py
 create mode 100644 stgit/lib/transaction.py
 create mode 100755 t/t2600-coalesce.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
