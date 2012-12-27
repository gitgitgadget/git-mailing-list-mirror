From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 00/19] new git check-ignore sub-command
Date: Thu, 27 Dec 2012 02:32:19 +0000
Message-ID: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:34:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3IC-0006l1-AJ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864Ab2L0Ccl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:32:41 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53760 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab2L0Cck (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:40 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 34A6E2E5DB
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:39 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212184>

This v3 re-roll of my check-ignore series is a reasonably substantial
revamp over v2, and applies on top of Junio's current
nd/attr-match-optim-more branch (82dce998c202).

All feedback and patches from the v2 series has been incorporated, and
several other improvements too, including:

  - composite exclude_lists have been split up into
    exclude_list_groups each containing one exclude_list per source

  - smaller commits for easier review

  - minor memory leaks have been fixed and verified via valgrind

  - t0007-ignores.sh has been renumbered to t0008-ignores.sh to avoid
    a conflict with t0007-git-var.sh

  - improvements to documentation and comments

For reference, the v2 series was announced here:

    http://thread.gmane.org/gmane.comp.version-control.git/204661/focus=206074

All tests pass except for t91*, since there seems to be some
pre-existing breakage in 82dce998c202 relating to git-svn.

Adam Spiers (19):
  api-directory-listing.txt: update to match code
  Improve documentation and comments regarding directory traversal API
  dir.c: rename cryptic 'which' variable to more consistent name
  dir.c: rename path_excluded() to is_path_excluded()
  dir.c: rename excluded_from_list() to is_excluded_from_list()
  dir.c: rename excluded() to is_excluded()
  dir.c: refactor is_excluded_from_list()
  dir.c: refactor is_excluded()
  dir.c: refactor is_path_excluded()
  dir.c: rename free_excludes() to clear_exclude_list()
  dir.c: use a single struct exclude_list per source of excludes
  dir.c: keep track of where patterns came from
  dir.c: provide clear_directory() for reclaiming dir_struct memory
  add.c: refactor treat_gitlinks()
  add.c: remove unused argument from validate_pathspec()
  pathspec.c: move reusable code from builtin/add.c
  pathspec.c: extract new validate_path() for reuse
  setup.c: document get_pathspec()
  Add git-check-ignore sub-command

 .gitignore                                        |   1 +
 Documentation/git-check-ignore.txt                |  89 ++++
 Documentation/gitignore.txt                       |   6 +-
 Documentation/technical/api-directory-listing.txt |  35 +-
 Makefile                                          |   3 +
 attr.c                                            |   2 +-
 builtin.h                                         |   1 +
 builtin/add.c                                     |  84 +--
 builtin/check-ignore.c                            | 170 +++++++
 builtin/clean.c                                   |   3 +-
 builtin/ls-files.c                                |  11 +-
 command-list.txt                                  |   1 +
 contrib/completion/git-completion.bash            |   1 +
 dir.c                                             | 243 +++++++--
 dir.h                                             |  87 +++-
 git.c                                             |   1 +
 pathspec.c                                        | 107 ++++
 pathspec.h                                        |   6 +
 setup.c                                           |  15 +
 t/t0008-ignores.sh                                | 595 ++++++++++++++++++++++
 unpack-trees.c                                    |  14 +-
 21 files changed, 1305 insertions(+), 170 deletions(-)
 create mode 100644 Documentation/git-check-ignore.txt
 create mode 100644 builtin/check-ignore.c
 create mode 100644 pathspec.c
 create mode 100644 pathspec.h
 create mode 100755 t/t0008-ignores.sh

-- 
1.7.11.2.249.g31c7954
