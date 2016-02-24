From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 00/32] refs backend
Date: Wed, 24 Feb 2016 17:58:32 -0500
Message-ID: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 24 23:59:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiPH-0003fn-3n
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759045AbcBXW7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:16 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35841 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759034AbcBXW7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:13 -0500
Received: by mail-qg0-f43.google.com with SMTP id y9so27387340qgd.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=PxvE0BsvyYRIEFM7ZgdjFU/QpGTXnlP8Dgg3vOCx0aM=;
        b=YbZVzKWD/Kz6zShcjqfbQCglisgIU3GUXWL+kX4h3iQeeF78NBqj+pXX30x8hnat9+
         rBPL7L1T9q0wk15Ts9nn70/qZo/i3QRlzXMxkn1auVBlbBAf4F/26qS5nEa23afEqsf3
         VNUpVsbKURF1hWsg5AUzQSQyyPrD+dLcXE1slhoGpadQImOonCa2MVJlieCb4L2lLpr5
         Vh02n2C/bIPX/tWvKrWOyxQ6TF/7zL9126SMeVQJCzUF75VDRYhsPAaeQ0W0NXnGx5qj
         1utMAfaBXVhWXgsrJhIuJd3LENoPVQTMloStjbOFaHFNCsjWJRUfN/emvMFuYPHUD6uh
         dqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=PxvE0BsvyYRIEFM7ZgdjFU/QpGTXnlP8Dgg3vOCx0aM=;
        b=BvM9qo39l5O23Yj3OZ9vlhWr9Ui2pxeZBcPfv/DdIqwH8M/6smf/K/qeFyUR9P2pOo
         zD95upFWY6PYFNEKkoJbO/YsGPIc+P0NyKufVIiefgYOlJ2HCldoF4qd5QzgYFnfl8u/
         f9sdMHHquR+rMxv24prl079Ay4nVQZWTgwCuWxfMM9ZW5ytehEZPLi8LXKyL8lleAaBK
         VJmXIinzyr6GqOQEUb93JOHtor46ZXMtG9GuE435VtL3FJkxbFihSN47SFCG36tKsk3N
         h9OuqPHMKIoDpTvoWtpJkVgfXgv4zs9tUTnEtCEZT0w1F4d1tYxp90lqF6OT0FfTFnwi
         lajw==
X-Gm-Message-State: AG10YOR4TQGODoAJqknDW6jxaGBX6TV11lDV8Nf5hLp6jPfgCp9gjSxzHDv7rrNhPCGvew==
X-Received: by 10.140.240.87 with SMTP id l84mr55266942qhc.69.1456354752118;
        Wed, 24 Feb 2016 14:59:12 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:11 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287248>

This version incorporates fixes for function scope from Ramsay Jones.

It breaks patches down a bit more, to make them easier to review and
understand. Michael Haggerty had some suggestions here.

As suggested by Duy Nguyen, it replaces the resolve_ref_unsafe backend
method with read_raw_ref, moving resolve_ref_unsafe to the common
code.

It adds support for running tests under alternate ref backends.

It fixes two indentation errors, one reported by Eric Wong.

It updates the documentation to include info about a few more
limitations on the LMDB backend. It incorporates other LMDB-related
suggestions from Duy Nguyen, e.g. using MDB_NOSUBDIR.

There's a fix for non-normal ref renames, also from Duy Nguyen.

Symbolic ref splitting has a bug fix, suggested by Michael Haggerty.

There are other, more minor changes suggested by Michael Haggerty and
Duy Nguyen.


David Turner (29):
  refs: move head_ref{,_submodule} to the common code
  refs: move for_each_*ref* functions into common code
  files-backend: break out ref reading
  refs: move resolve_ref_unsafe into common code
  refs: add method for do_for_each_ref
  refs: add do_for_each_per_worktree_ref
  refs: add methods for reflog
  refs: add method for initial ref transaction commit
  refs: add method for delete_refs
  refs: add methods to init refs db
  refs: add method to rename refs
  refs: handle non-normal ref renames
  refs: make lock generic
  refs: move duplicate check to common code
  refs: allow log-only updates
  refs: don't dereference on rename
  refs: on symref reflog expire, lock symref not referrent
  refs: resolve symbolic refs first
  refs: always handle non-normal refs in files backend
  init: allow alternate ref strorage to be set for new repos
  refs: check submodules' ref storage config
  clone: allow ref storage backend to be set for clone
  svn: learn ref-storage argument
  refs: register ref storage backends
  config: read ref storage config on startup
  refs: break out resolve_ref_unsafe_submodule
  refs: add LMDB refs storage backend
  refs: tests for lmdb backend
  tests: add ref-storage argument

Ramsay Jones (1):
  refs: reduce the visibility of do_for_each_ref()

Ronnie Sahlberg (2):
  refs: add a backend method structure with transaction functions
  refs: add methods for misc ref operations

 .gitignore                                     |    1 +
 Documentation/config.txt                       |    9 +
 Documentation/git-clone.txt                    |    6 +
 Documentation/git-init-db.txt                  |    2 +-
 Documentation/git-init.txt                     |    8 +-
 Documentation/technical/refs-lmdb-backend.txt  |   61 +
 Documentation/technical/repository-version.txt |    7 +
 Makefile                                       |   12 +
 builtin/clone.c                                |    5 +
 builtin/init-db.c                              |   55 +-
 builtin/submodule--helper.c                    |    2 +-
 cache.h                                        |    2 +
 config.c                                       |   24 +
 configure.ac                                   |   33 +
 contrib/completion/git-completion.bash         |    6 +-
 contrib/workdir/git-new-workdir                |    3 +
 git-submodule.sh                               |   13 +
 git-svn.perl                                   |    6 +-
 path.c                                         |   30 +-
 refs.c                                         |  632 +++++++-
 refs.h                                         |   16 +
 refs/files-backend.c                           |  686 ++++-----
 refs/lmdb-backend.c                            | 1886 ++++++++++++++++++++++++
 refs/refs-internal.h                           |  123 +-
 setup.c                                        |   12 +
 t/README                                       |    6 +
 t/lib-submodule-update.sh                      |   15 +-
 t/lib-t6000.sh                                 |    7 +-
 t/t0001-init.sh                                |   25 +
 t/t0008-ignores.sh                             |    2 +-
 t/t0062-revision-walking.sh                    |    6 +
 t/t1021-rerere-in-workdir.sh                   |    6 +
 t/t1200-tutorial.sh                            |    8 +-
 t/t1302-repo-version.sh                        |    6 +
 t/t1305-config-include.sh                      |   17 +-
 t/t1400-update-ref.sh                          |    6 +
 t/t1401-symbolic-ref.sh                        |   17 +-
 t/t1404-update-ref-df-conflicts.sh             |    8 +-
 t/t1410-reflog.sh                              |   16 +
 t/t1430-bad-ref-name.sh                        |    6 +
 t/t1450-fsck.sh                                |   12 +-
 t/t1460-refs-lmdb-backend.sh                   | 1109 ++++++++++++++
 t/t1470-refs-lmdb-backend-reflog.sh            |  359 +++++
 t/t1480-refs-lmdb-submodule.sh                 |   85 ++
 t/t1506-rev-parse-diagnosis.sh                 |    4 +-
 t/t2013-checkout-submodule.sh                  |    2 +-
 t/t2105-update-index-gitfile.sh                |    4 +-
 t/t2107-update-index-basic.sh                  |    6 +-
 t/t2201-add-update-typechange.sh               |    4 +-
 t/t3001-ls-files-others-exclude.sh             |    2 +-
 t/t3010-ls-files-killed-modified.sh            |    4 +-
 t/t3040-subprojects-basic.sh                   |    4 +-
 t/t3050-subprojects-fetch.sh                   |    2 +-
 t/t3200-branch.sh                              |   84 +-
 t/t3210-pack-refs.sh                           |    7 +
 t/t3211-peel-ref.sh                            |    6 +
 t/t3308-notes-merge.sh                         |    2 +-
 t/t3404-rebase-interactive.sh                  |    2 +-
 t/t3600-rm.sh                                  |    2 +-
 t/t3800-mktag.sh                               |    4 +-
 t/t3903-stash.sh                               |    2 +-
 t/t4010-diff-pathspec.sh                       |    2 +-
 t/t4020-diff-external.sh                       |    2 +-
 t/t4027-diff-submodule.sh                      |    2 +-
 t/t4035-diff-quiet.sh                          |    2 +-
 t/t4255-am-submodule.sh                        |    2 +-
 t/t5000-tar-tree.sh                            |    3 +-
 t/t5304-prune.sh                               |    2 +-
 t/t5312-prune-corruption.sh                    |   11 +-
 t/t5500-fetch-pack.sh                          |   10 +-
 t/t5510-fetch.sh                               |   30 +-
 t/t5526-fetch-submodules.sh                    |    4 +-
 t/t5527-fetch-odd-refs.sh                      |    7 +
 t/t5537-fetch-shallow.sh                       |    7 +
 t/t5700-clone-reference.sh                     |   42 +-
 t/t6001-rev-list-graft.sh                      |    3 +-
 t/t6010-merge-base.sh                          |    2 +-
 t/t6050-replace.sh                             |    4 +-
 t/t6120-describe.sh                            |    6 +-
 t/t6301-for-each-ref-errors.sh                 |   12 +-
 t/t7201-co.sh                                  |    2 +-
 t/t7300-clean.sh                               |   25 +-
 t/t7400-submodule-basic.sh                     |   18 +-
 t/t7402-submodule-rebase.sh                    |    2 +-
 t/t7405-submodule-merge.sh                     |   10 +-
 t/t9104-git-svn-follow-parent.sh               |    3 +-
 t/t9115-git-svn-dcommit-funky-renames.sh       |    2 +-
 t/t9350-fast-export.sh                         |    6 +-
 t/t9902-completion.sh                          |    3 +-
 t/t9903-bash-prompt.sh                         |    1 +
 t/test-lib-functions.sh                        |   53 +-
 t/test-lib.sh                                  |   12 +
 test-refs-lmdb-backend.c                       |   65 +
 93 files changed, 5257 insertions(+), 595 deletions(-)
 create mode 100644 Documentation/technical/refs-lmdb-backend.txt
 create mode 100644 refs/lmdb-backend.c
 create mode 100755 t/t1460-refs-lmdb-backend.sh
 create mode 100755 t/t1470-refs-lmdb-backend-reflog.sh
 create mode 100755 t/t1480-refs-lmdb-submodule.sh
 create mode 100644 test-refs-lmdb-backend.c

-- 
2.4.2.767.g62658d5-twtrsrc
