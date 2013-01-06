From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v4 00/11] new git check-ignore sub-command
Date: Sun,  6 Jan 2013 16:58:02 +0000
Message-ID: <1357491493-11619-1-git-send-email-git@adamspiers.org>
References: <20130106161758.GC2396@pacific.linksys.moosehall>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:58:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtYY-0007mE-0r
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078Ab3AFQ6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:58:18 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45593 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067Ab3AFQ6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:58:17 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 3FEC42E5D3
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 16:58:14 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.7.33.gb8feba5
In-Reply-To: <20130106161758.GC2396@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212814>

This is the v4 re-roll of the check-ignore series, which is based on
Junio's as/dir-c-cleanup topic branch f6198812 (dir.c: rename
free_excludes() to clear_exclude_list(), 2012-12-27).  As previously
discussed, the earlier parts of the v3 series seem to be complete and
are progressing to 'next'.

Since v3, I addressed the issue of newly public functions with
unacceptably vague or generic names via the following steps:

  - eliminated extraction from add.c to pathspec.c of two functions
    which did not need to be public (validate_pathspec() and
    treat_gitlinks())

  - edited the series history to create separate commits for
    extraction of reusable code from treat_gitlinks() and
    validate_pathspec() into more carefully named public functions

This should make reviewing easier.

I will summarise the changes in the revised patches since v3 in
between the "---" divider and the diffstat of each individual patch.

This series is also available via the check-ignore-v4 tag in:

    git://github.com/aspiers/git.git

Adam Spiers (11):
  dir.c: use a single struct exclude_list per source of excludes
  dir.c: keep track of where patterns came from
  dir.c: provide clear_directory() for reclaiming dir_struct memory
  dir.c: improve docs for match_pathspec() and match_pathspec_depth()
  add.c: remove unused argument from validate_pathspec()
  add.c: move pathspec matchers into new pathspec.c for reuse
  pathspec.c: rename newly public functions for clarity
  add.c: extract check_path_for_gitlink() from treat_gitlinks() for
    reuse
  add.c: extract new die_if_path_beyond_symlink() for reuse
  setup.c: document get_pathspec()
  add git-check-ignore sub-command

 .gitignore                                        |   1 +
 Documentation/git-check-ignore.txt                |  89 +++
 Documentation/gitignore.txt                       |   6 +-
 Documentation/technical/api-directory-listing.txt |  14 +-
 Makefile                                          |   3 +
 builtin.h                                         |   1 +
 builtin/add.c                                     |  78 +--
 builtin/check-ignore.c                            | 173 ++++++
 builtin/clean.c                                   |   3 +-
 builtin/ls-files.c                                |   9 +-
 command-list.txt                                  |   1 +
 contrib/completion/git-completion.bash            |   1 +
 dir.c                                             | 152 ++++--
 dir.h                                             |  62 ++-
 git.c                                             |   1 +
 pathspec.c                                        | 101 ++++
 pathspec.h                                        |   9 +
 setup.c                                           |  19 +
 t/t0008-ignores.sh                                | 632 ++++++++++++++++++++++
 unpack-trees.c                                    |   2 +-
 20 files changed, 1240 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/git-check-ignore.txt
 create mode 100644 builtin/check-ignore.c
 create mode 100644 pathspec.c
 create mode 100644 pathspec.h
 create mode 100755 t/t0008-ignores.sh

-- 
1.7.11.7.33.gb8feba5
