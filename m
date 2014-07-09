From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 00/32] Support multiple checkouts
Date: Wed,  9 Jul 2014 14:32:45 +0700
Message-ID: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:33:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mNg-0002mX-64
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbaGIHd2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:33:28 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:42838 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbaGIHd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:33:27 -0400
Received: by mail-pd0-f182.google.com with SMTP id y13so8607699pdi.13
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=yzw7plsfgAp2FhLXbKSy/nyi4CC41Q82R+ZnzeiySXg=;
        b=zatzCIyjvIHmO6puN2VRDwOnCzS+TqEGBUArS9J3pmd26DaQ/G/YVMkJgvyjljk/T2
         hKdJZb9JxLFDZpYbeL9uNFMTiXNGSGbizh68wTcUEjEXu1/OtAfHJAPwKo8FdR9Y2SNI
         1iN+FndHHLFJd0WsUBx+t9to/BWFtoGihOQd/moIRKIXd0g64HtdLz3h6B27pvwjhXp5
         LQT4pK1+sbPAnggKW0sEm9oN57YF6vOYCwAD8McJxO5s+D9en0Gplmox5kTPK6/Y/4iE
         zcvykLFTn8w3/pyXihowZQtLhXc9JPkOvncxhQ8CFdRhgd0+HyjNA70UzPBP6tF68O04
         ZccA==
X-Received: by 10.70.44.43 with SMTP id b11mr9939018pdm.23.1404891207271;
        Wed, 09 Jul 2014 00:33:27 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id z6sm27271434pdj.2.2014.07.09.00.33.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:33:26 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:33:23 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253075>

This is basically a reroll from what was parked on 'pu' with two
new patches at the end: one to not share info/sparse-checkout
across worktrees, and one to allow 'checkout --to` from a bare
repository.

I cherry-picked two patches from jk/xstrfmt (on next) because they
result in non-trivial conflicts. When this series is merged with
jk/xstrfmt, you still get conflicts in environment.c, but you can just
pick up my changes and drop Jeff's.

Dennis Kaarsemaker (1):
  checkout: don't require a work tree when checking out into a new one

Jeff King (2):
  setup_git_env: use git_pathdup instead of xmalloc + sprintf
  setup_git_env(): introduce git_path_from_env() helper

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (29):
  path.c: make get_pathname() return strbuf instead of static buffer
  path.c: make get_pathname() call sites return const char *
  git_snpath(): retire and replace with strbuf_git_path()
  path.c: rename vsnpath() to do_git_path()
  path.c: group git_path(), git_pathdup() and strbuf_git_path() togethe=
r
  git_path(): be aware of file relocation in $GIT_DIR
  *.sh: respect $GIT_INDEX_FILE
  reflog: avoid constructing .lock path with git_path
  fast-import: use git_path() for accessing .git dir instead of get_git=
_dir()
  commit: use SEQ_DIR instead of hardcoding "sequencer"
  $GIT_COMMON_DIR: a new environment variable
  git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
  *.sh: avoid hardcoding $GIT_DIR/hooks/...
  git-stash: avoid hardcoding $GIT_DIR/logs/....
  setup.c: convert is_git_directory() to use strbuf
  setup.c: detect $GIT_COMMON_DIR in is_git_directory()
  setup.c: convert check_repository_format_gently to use strbuf
  setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
  setup.c: support multi-checkout repo setup
  wrapper.c: wrapper to open a file, fprintf then close
  use new wrapper write_file() for simple file writing
  checkout: support checking out into a new working directory
  checkout: clean up half-prepared directories in --to mode
  checkout: detach if the branch is already checked out elsewhere
  prune: strategies for linked checkouts
  gc: style change -- no SP before closing bracket
  gc: support prune --repos
  count-objects: report unused files in $GIT_DIR/repos/...
  git_path(): keep "info/sparse-checkout" per work-tree

 Documentation/config.txt               |   9 ++
 Documentation/git-checkout.txt         |  34 +++++
 Documentation/git-prune.txt            |   3 +
 Documentation/git-rev-parse.txt        |  10 ++
 Documentation/git.txt                  |   9 ++
 Documentation/gitrepository-layout.txt |  75 ++++++++--
 builtin/branch.c                       |   4 +-
 builtin/checkout.c                     | 248 +++++++++++++++++++++++++=
+++++++-
 builtin/clone.c                        |   9 +-
 builtin/commit.c                       |   2 +-
 builtin/count-objects.c                |   4 +-
 builtin/fetch.c                        |   5 +-
 builtin/fsck.c                         |   4 +-
 builtin/gc.c                           |  21 ++-
 builtin/init-db.c                      |   7 +-
 builtin/prune.c                        |  74 ++++++++++
 builtin/receive-pack.c                 |   2 +-
 builtin/reflog.c                       |   2 +-
 builtin/remote.c                       |   2 +-
 builtin/repack.c                       |   8 +-
 builtin/rev-parse.c                    |  11 ++
 cache.h                                |  17 ++-
 daemon.c                               |  11 +-
 environment.c                          |  45 ++++--
 fast-import.c                          |   7 +-
 git-am.sh                              |  22 +--
 git-pull.sh                            |   2 +-
 git-rebase--interactive.sh             |   6 +-
 git-rebase--merge.sh                   |   6 +-
 git-rebase.sh                          |   4 +-
 git-sh-setup.sh                        |   2 +-
 git-stash.sh                           |   6 +-
 git.c                                  |   2 +-
 notes-merge.c                          |   6 +-
 path.c                                 | 234 +++++++++++++++++++++----=
------
 refs.c                                 |  86 +++++++-----
 refs.h                                 |   2 +-
 run-command.c                          |   4 +-
 run-command.h                          |   2 +-
 setup.c                                | 124 +++++++++++++----
 sha1_file.c                            |   2 +-
 submodule.c                            |   9 +-
 t/t0060-path-utils.sh                  |  35 +++++
 t/t1501-worktree.sh                    |  76 ++++++++++
 t/t1510-repo-setup.sh                  |   1 +
 t/t2025-checkout-to.sh (new +x)        |  72 ++++++++++
 templates/hooks--applypatch-msg.sample |   4 +-
 templates/hooks--pre-applypatch.sample |   4 +-
 trace.c                                |   1 +
 transport.c                            |   8 +-
 wrapper.c                              |  31 +++++
 51 files changed, 1109 insertions(+), 265 deletions(-)
 create mode 100755 t/t2025-checkout-to.sh

--=20
1.9.1.346.ga2b5940
