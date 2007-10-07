From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit kha experimental branch updated
Date: Mon, 8 Oct 2007 01:39:02 +0200
Message-ID: <20071007233902.GB1262@diana.vm.bytemark.co.uk>
References: <20071007232943.GA1262@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iefih-0006S5-Ci
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534AbXJGXjJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756086AbXJGXjI
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:39:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4492 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962AbXJGXjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:39:07 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IefiA-0000Wt-00; Mon, 08 Oct 2007 00:39:02 +0100
Content-Disposition: inline
In-Reply-To: <20071007232943.GA1262@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60262>

There's nothing new here; it's all just rebased on top of the updated
safe branch. In order, we have

  * David's patches that remove the "top" and "bottom" patch fields.
    These need a format version upgrade function (trivial), but are
    otherwise ready, I think.

  * David's conflict refactoring series, with some fixes by me, and
    removal of some commands that become superfluous. Almost ready,
    but it makes ugly conflict markers, and "stg resolved" should
    probably be removed.

The following changes since commit 2299c463794f214b750ecc33e24779243ddc=
5aff:
  Karl Hasselstr=F6m (1):
        Make "stg refresh" subdirectory safe

are available in the git repository at:

  git://repo.or.cz/stgit/kha.git experimental

David K=E5gedal (9):
      Check bottom and invariants
      Remove the 'bottom' field
      Remove the 'top' field
      Split git.merge into two functions
      Leave working dir and index alone after failed (conflicting) push
      Added a test case to check what happens when push finds a conflic=
t
      Simplify merge_recursive
      Use the output from merge-recursive to list conflicts
      Ask git about unmerged files

Karl Hasselstr=F6m (9):
      Better error message if merge fails
      Fix "stg resolved" to work with new conflict representation
      Refactoring: pass more than one file to resolved()
      We keep the different stages of a conflict in the index now
      Clean up the logic in "stg resolved"
      "stg status --reset" is not needed anymore
      Remove "stg add"
      Remove "stg rm"
      Remove "stg cp"

 Documentation/stg-cp.txt      |   63 --------------------------
 Documentation/tutorial.txt    |   22 +++++----
 stgit/commands/add.py         |   44 ------------------
 stgit/commands/common.py      |   25 +++-------
 stgit/commands/copy.py        |   45 ------------------
 stgit/commands/pick.py        |    2 +-
 stgit/commands/resolved.py    |   70 ++++++++++-------------------
 stgit/commands/rm.py          |   48 --------------------
 stgit/commands/status.py      |   34 +++++---------
 stgit/commands/sync.py        |    1 -
 stgit/git.py                  |   72 +++++++++++++++++------------
 stgit/gitmergeonefile.py      |   99 ++++++++++++++++++++++-----------=
-------
 stgit/main.py                 |    6 ---
 stgit/run.py                  |    3 +
 stgit/stack.py                |   65 +++++++++++----------------
 t/t0002-status.sh             |   11 +++--
 t/t1200-push-modified.sh      |    2 +-
 t/t1202-push-undo.sh          |    4 +-
 t/t1203-push-conflict.sh      |   70 +++++++++++++++++++++++++++++
 t/t1204-pop-keep.sh           |    2 +-
 t/t1205-push-subdir.sh        |    4 +-
 t/t1300-uncommit.sh           |    4 +-
 t/t1301-assimilate.sh         |    2 +-
 t/t1400-patch-history.sh      |    4 +-
 t/t1500-float.sh              |   14 +++---
 t/t1600-delete-one.sh         |   12 +++---
 t/t1601-delete-many.sh        |    2 +-
 t/t1700-goto-top.sh           |    2 +-
 t/t2000-sync.sh               |    8 ++--
 t/t2100-pull-policy-fetch.sh  |    4 +-
 t/t2101-pull-policy-pull.sh   |    4 +-
 t/t2102-pull-policy-rebase.sh |    4 +-
 t/t2300-refresh-subdir.sh     |    2 +-
 33 files changed, 295 insertions(+), 459 deletions(-)
 delete mode 100644 Documentation/stg-cp.txt
 delete mode 100644 stgit/commands/add.py
 delete mode 100644 stgit/commands/copy.py
 delete mode 100644 stgit/commands/rm.py
 create mode 100755 t/t1203-push-conflict.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
