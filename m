From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 00/10] Increase test coverage on Windows by removing SYMLINKS from many tests
Date: Fri,  7 Jun 2013 22:53:24 +0200
Message-ID: <cover.1370636706.git.j6t@kdbg.org>
References: <cover.1370076477.git.j6t@kdbg.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 22:54:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3fk-00075o-Sz
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285Ab3FGUyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:54:00 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:10102 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755868Ab3FGUxh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:53:37 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C136F13004B;
	Fri,  7 Jun 2013 22:53:34 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 68D7619F5E6;
	Fri,  7 Jun 2013 22:53:34 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.rc1.32.g8b61cbb
In-Reply-To: <cover.1370076477.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226715>

Many tests that involve symbolic links actually check only whether our
algorithms are correct by investigating the contents of the object
database and the index. Only some of them check the filesystem.

This series introduces a function test_ln_s_add that inserts a symbolic
link in the index even if the filesystem does not support symbolic links.
By using this function, many more tests can be run when the filesystem
does not have symblic links, aka Windows.

Changes since v1:

- Ripped out test_ln_s and corresponding conversions; they were dubious.

- There are no changes to t2100 anymore; the corresponding modernization
  patch is gone.

- Moved the t4011 change from the "trivial cases" to its own patch.
  It still contains the effects of the former test_ln_s, but open-coded
  and with a comment.

Johannes Sixt (10):
  test-chmtime: Fix exit code on Windows
  t3010: modernize style
  tests: introduce test_ln_s_add
  tests: use test_ln_s_add to remove SYMLINKS prerequisite (trivial
    cases)
  t0000: use test_ln_s_add to remove SYMLINKS prerequisite
  t3030: use test_ln_s_add to remove SYMLINKS prerequisite
  t3100: use test_ln_s_add to remove SYMLINKS prerequisite
  t3509, t4023, t4114: use test_ln_s_add to remove SYMLINKS prerequisite
  t6035: use test_ln_s_add to remove SYMLINKS prerequisite
  t4011: remove SYMLINKS prerequisite

 t/README                               |  14 ++++
 t/t0000-basic.sh                       |  39 +++--------
 t/t1004-read-tree-m-u-wf.sh            |   7 +-
 t/t2001-checkout-cache-clash.sh        |   7 +-
 t/t2004-checkout-cache-temp.sh         |   5 +-
 t/t2007-checkout-symlink.sh            |  12 ++--
 t/t2021-checkout-overwrite.sh          |  12 ++--
 t/t2200-add-update.sh                  |   5 +-
 t/t3010-ls-files-killed-modified.sh    | 118 ++++++++++++++++-----------------
 t/t3030-merge-recursive.sh             |  62 ++++++++---------
 t/t3100-ls-tree-restrict.sh            |  42 +++++-------
 t/t3509-cherry-pick-merge-df.sh        |  12 ++--
 t/t3700-add.sh                         |  15 ++---
 t/t3903-stash.sh                       |  39 ++++++++---
 t/t4008-diff-break-rewrite.sh          |  12 ++--
 t/t4011-diff-symlink.sh                |  35 +++++++---
 t/t4023-diff-rename-typechange.sh      |  28 ++++----
 t/t4030-diff-textconv.sh               |   8 +--
 t/t4114-apply-typechange.sh            |  29 ++++----
 t/t4115-apply-symlink.sh               |  10 ++-
 t/t4122-apply-symlink-inside.sh        |   8 +--
 t/t6035-merge-dir-to-symlink.sh        |  73 ++++++++++++--------
 t/t7001-mv.sh                          |  18 +++--
 t/t7607-merge-overwrite.sh             |   5 +-
 t/t8006-blame-textconv.sh              |  14 ++--
 t/t8007-cat-file-textconv.sh           |  10 ++-
 t/t9350-fast-export.sh                 |   5 +-
 t/t9500-gitweb-standalone-no-errors.sh |  15 ++---
 t/test-lib-functions.sh                |  17 +++++
 test-chmtime.c                         |   8 +--
 30 files changed, 351 insertions(+), 333 deletions(-)

-- 
1.8.3.rc1.32.g8b61cbb
