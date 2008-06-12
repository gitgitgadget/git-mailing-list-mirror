From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 00/14] Undo series
Date: Thu, 12 Jun 2008 07:34:04 +0200
Message-ID: <20080612052913.23549.69687.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:35:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fSy-0004qz-AS
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYFLFeZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 01:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbYFLFeZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:34:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2151 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbYFLFeY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:34:24 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K6fRl-00013O-00; Thu, 12 Jun 2008 06:34:05 +0100
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84703>

Now with API documentation added all over the place! Especially in
2/14 and 3/14.

The only two things missing before I'll ask for this to be included
are

  1. Conversion of stg refresh to the new infrastructure, so that it
     can write two separate steps to the stack log (which will allow
     undo et.al. to handle it nicely).

  2. Log writing optimization: Right now, we always write all the
     patches to the log, without trying to reuse the entries for the
     ones that haven't changed since last time.

---

Karl Hasselstr=C3=B6m (14):
      Make "stg log" show stack log instead of patch log
      Log and undo external modifications
      New command: stg redo
      New command: stg undo
      Move stack reset function to a shared location
      Don't write a log entry if there were no changes
      Add a --hard flag to stg reset
      Log conflicts separately for all commands
      Log conflicts separately
      New command: stg reset
      Add utility function for reordering patches
      Write to a stack log when stack is modified
      Library functions for tree and blob manipulation
      Fix typo


 stgit/commands/branch.py     |   19 +-
 stgit/commands/common.py     |    9 +
 stgit/commands/diff.py       |    2=20
 stgit/commands/files.py      |    2=20
 stgit/commands/id.py         |    2=20
 stgit/commands/log.py        |  169 +++++------------
 stgit/commands/mail.py       |    2=20
 stgit/commands/patches.py    |    2=20
 stgit/commands/redo.py       |   52 +++++
 stgit/commands/reset.py      |   56 +++++
 stgit/commands/show.py       |    2=20
 stgit/commands/status.py     |    3=20
 stgit/commands/undo.py       |   49 +++++
 stgit/lib/git.py             |  197 +++++++++++++++++--
 stgit/lib/log.py             |  429 ++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py           |   16 ++
 stgit/lib/transaction.py     |  121 +++++++++---
 stgit/main.py                |    8 +
 t/t1400-patch-history.sh     |  103 ----------
 t/t3100-reset.sh             |  151 +++++++++++++++
 t/t3101-reset-hard.sh        |   56 +++++
 t/t3102-undo.sh              |   86 ++++++++
 t/t3103-undo-hard.sh         |   56 +++++
 t/t3104-redo.sh              |  122 ++++++++++++
 t/t3105-undo-external-mod.sh |   68 +++++++
 25 files changed, 1491 insertions(+), 291 deletions(-)
 create mode 100644 stgit/commands/redo.py
 create mode 100644 stgit/commands/reset.py
 create mode 100644 stgit/commands/undo.py
 create mode 100644 stgit/lib/log.py
 delete mode 100755 t/t1400-patch-history.sh
 create mode 100755 t/t3100-reset.sh
 create mode 100755 t/t3101-reset-hard.sh
 create mode 100755 t/t3102-undo.sh
 create mode 100755 t/t3103-undo-hard.sh
 create mode 100755 t/t3104-redo.sh
 create mode 100755 t/t3105-undo-external-mod.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
