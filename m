From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH 0/8] Fix git's test suite to pass when the path contains spaces
Date: Tue,  8 Apr 2008 21:29:56 -0400
Message-ID: <cover.1207702130.git.bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 03:31:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjP9h-0007g2-23
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 03:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbYDIBaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 21:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbYDIBaO
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 21:30:14 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:49003 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbYDIBaN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 21:30:13 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JjP8b-0007dN-Fg; Wed, 09 Apr 2008 01:30:09 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JjP8W-0007v1-6S; Tue, 08 Apr 2008 21:30:04 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79057>

This patch series fixes bugs in git and git's testsuite to allow all tests
to pass when the working directory contains whitespace and/or shell
metacharacters.

The first three patches in this series fix bugs in git itself that were
uncovered in the process of fixing the test suite. Each contains additional
tests and/or updates to existing tests to exercise the bug in question.

The remaining patches fix bugs in the test suite itself.

Bryan Donlan (8):
  git-rebase.sh: Fix --merge --abort failures when path contains
    whitespace
  config.c: Escape backslashes in section names properly
  git-send-email.perl: Handle shell metacharacters in $EDITOR properly
  test-lib.sh: Handle properly cases where the git checkout path
    contains whitespace
  test-lib.sh: Add a test_set_editor function to safely set $VISUAL
  lib-git-svn.sh: Handle paths with shell metacharacters correctly
  Use test_set_editor in t9001-send-email.sh
  Fix tests breaking when checkout path contains shell metacharacters

 config.c                                      |    2 +-
 git-rebase.sh                                 |    4 +-
 git-send-email.perl                           |    2 +-
 t/lib-git-svn.sh                              |   11 +++--
 t/t0000-basic.sh                              |    4 +-
 t/t0001-init.sh                               |    2 +-
 t/t1020-subdirectory.sh                       |   24 +++++-----
 t/t1303-wacky-config.sh                       |    6 +++
 t/t1501-worktree.sh                           |   14 +++---
 t/t3050-subprojects-fetch.sh                  |    2 +-
 t/t3404-rebase-interactive.sh                 |    3 +-
 t/t3407-rebase-abort.sh                       |   55 ++++++++++++++----------
 t/t5500-fetch-pack.sh                         |    2 +-
 t/t5512-ls-remote.sh                          |    2 +-
 t/t5516-fetch-push.sh                         |    8 ++--
 t/t5700-clone-reference.sh                    |    4 +-
 t/t5710-info-alternate.sh                     |    4 +-
 t/t7003-filter-branch.sh                      |    4 +-
 t/t7010-setup.sh                              |    2 +-
 t/t7300-clean.sh                              |    2 +-
 t/t7501-commit.sh                             |    8 ++--
 t/t7504-commit-msg-hook.sh                    |   20 +++++-----
 t/t7505-prepare-commit-msg-hook.sh            |   14 +++---
 t/t9001-send-email.sh                         |    5 +-
 t/t9100-git-svn-basic.sh                      |   54 ++++++++++++------------
 t/t9101-git-svn-props.sh                      |    6 +-
 t/t9102-git-svn-deep-rmdir.sh                 |    6 +-
 t/t9103-git-svn-tracked-directory-removed.sh  |   30 +++++++-------
 t/t9104-git-svn-follow-parent.sh              |   50 +++++++++++-----------
 t/t9105-git-svn-commit-diff.sh                |   12 +++---
 t/t9106-git-svn-commit-diff-clobber.sh        |   14 +++---
 t/t9106-git-svn-dcommit-clobber-series.sh     |    6 +-
 t/t9107-git-svn-migrate.sh                    |   48 +++++++++++-----------
 t/t9108-git-svn-glob.sh                       |    8 ++--
 t/t9110-git-svn-use-svm-props.sh              |    8 ++--
 t/t9111-git-svn-use-svnsync-props.sh          |    8 ++--
 t/t9112-git-svn-md5less-file.sh               |    4 +-
 t/t9113-git-svn-dcommit-new-file.sh           |    6 +-
 t/t9114-git-svn-dcommit-merge.sh              |    4 +-
 t/t9115-git-svn-dcommit-funky-renames.sh      |    4 +-
 t/t9116-git-svn-log.sh                        |    4 +-
 t/t9117-git-svn-init-clone.sh                 |   10 ++--
 t/t9118-git-svn-funky-branch-names.sh         |   12 +++---
 t/t9120-git-svn-clone-with-percent-escapes.sh |    2 +-
 t/t9500-gitweb-standalone-no-errors.sh        |   13 +++---
 t/test-lib.sh                                 |   11 +++++-
 46 files changed, 275 insertions(+), 249 deletions(-)
