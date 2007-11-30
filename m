From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: StGit kha/experimental branch updated
Date: Fri, 30 Nov 2007 07:49:38 +0100
Message-ID: <20071130064938.GA19892@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 07:50:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxzhO-0001dN-9o
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 07:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054AbXK3Gtr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Nov 2007 01:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756683AbXK3Gtq
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 01:49:46 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1356 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbXK3Gtq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 01:49:46 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ixzgw-0005E2-00; Fri, 30 Nov 2007 06:49:38 +0000
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66619>

I've fixed a handful of minor problems in the "new infrastructure"
series, and added one new patch at the end of David's series that
might be a tad controversial: the removal of "stg resolved".

The reason for removing it are simply that "git add" and "git
mergetool" can do the same job, and I think it's a bad idea to make
StGit's command set any bigger than necessary. If it ain't about
patches, we should leave the job to git (and if we feel that git does
a suboptimal job, we should fix git).

                                 -+-

The following changes since commit 8d2b87ac26d01c7110d911aefea8988ca5a9=
b183:
  Karl Hasselstr=F6m (1):
        Make "stg repair" help text more helpful

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

Karl Hasselstr=F6m (20):
      Better error message if merge fails
      Fix "stg resolved" to work with new conflict representation
      Refactoring: pass more than one file to resolved()
      We keep the different stages of a conflict in the index now
      "stg status --reset" is not needed anymore
      Remove "stg add"
      Remove "stg rm"
      Remove "stg cp"
      Remove "stg resolved"
      New StGit core infrastructure: repository operations
      Write metadata files used by the old infrastructure
      Upgrade older stacks to newest version
      Let "stg clean" use the new infrastructure
      Add "stg coalesce"
      Let "stg applied" and "stg unapplied" use the new infrastructure
      Teach the new infrastructure about the index and worktree
      Let "stg clean" use the new transaction primitives
      Let "stg goto" use the new infrastructure
      Convert "stg uncommit" to the new infrastructure
      New infrastructure: Make sure that the branch is initialized

 Documentation/stg-cp.txt      |   63 -------
 Documentation/stg.txt         |    2 -
 Documentation/tutorial.txt    |   31 ++--
 contrib/stgit-completion.bash |    4 +-
 examples/gitconfig            |   19 +--
 setup.py                      |    2 +-
 stgit/commands/add.py         |   44 -----
 stgit/commands/applied.py     |   27 ++--
 stgit/commands/clean.py       |   49 ++----
 stgit/commands/coalesce.py    |  112 ++++++++++++
 stgit/commands/common.py      |   35 ++--
 stgit/commands/copy.py        |   45 -----
 stgit/commands/goto.py        |   52 ++----
 stgit/commands/pick.py        |    2 +-
 stgit/commands/resolved.py    |   94 ----------
 stgit/commands/rm.py          |   48 -----
 stgit/commands/status.py      |   31 ++--
 stgit/commands/sync.py        |    1 -
 stgit/commands/unapplied.py   |   23 ++--
 stgit/commands/uncommit.py    |   79 ++++-----
 stgit/config.py               |    1 -
 stgit/git.py                  |   72 +++++----
 stgit/gitmergeonefile.py      |   97 +----------
 stgit/lib/__init__.py         |   18 ++
 stgit/lib/git.py              |  383 +++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py            |  171 ++++++++++++++++++
 stgit/lib/stackupgrade.py     |   98 +++++++++++
 stgit/lib/transaction.py      |  195 +++++++++++++++++++++
 stgit/main.py                 |   10 +-
 stgit/run.py                  |    3 +
 stgit/stack.py                |  151 +++-------------
 stgit/utils.py                |   24 +++
 t/t0002-status.sh             |   13 +-
 t/t1200-push-modified.sh      |    2 +-
 t/t1202-push-undo.sh          |    4 +-
 t/t1203-push-conflict.sh      |   70 ++++++++
 t/t1204-pop-keep.sh           |    2 +-
 t/t1205-push-subdir.sh        |    8 +-
 t/t1300-uncommit.sh           |    4 +-
 t/t1301-repair.sh             |    2 +-
 t/t1400-patch-history.sh      |    4 +-
 t/t1500-float.sh              |   14 +-
 t/t1600-delete-one.sh         |   12 +-
 t/t1601-delete-many.sh        |    2 +-
 t/t1700-goto-top.sh           |    2 +-
 t/t2000-sync.sh               |   12 +-
 t/t2100-pull-policy-fetch.sh  |    4 +-
 t/t2101-pull-policy-pull.sh   |    4 +-
 t/t2102-pull-policy-rebase.sh |    4 +-
 t/t2300-refresh-subdir.sh     |    2 +-
 t/t2600-coalesce.sh           |   31 ++++
 51 files changed, 1373 insertions(+), 809 deletions(-)
 delete mode 100644 Documentation/stg-cp.txt
 delete mode 100644 stgit/commands/add.py
 create mode 100644 stgit/commands/coalesce.py
 delete mode 100644 stgit/commands/copy.py
 delete mode 100644 stgit/commands/resolved.py
 delete mode 100644 stgit/commands/rm.py
 create mode 100644 stgit/lib/__init__.py
 create mode 100644 stgit/lib/git.py
 create mode 100644 stgit/lib/stack.py
 create mode 100644 stgit/lib/stackupgrade.py
 create mode 100644 stgit/lib/transaction.py
 create mode 100755 t/t1203-push-conflict.sh
 create mode 100755 t/t2600-coalesce.sh

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
