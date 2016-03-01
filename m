From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 00/33] refs backend
Date: Mon, 29 Feb 2016 19:52:33 -0500
Message-ID: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:53:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZ9-0006sP-VE
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbcCAAx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 19:53:27 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33494 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbcCAAx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:26 -0500
Received: by mail-qg0-f51.google.com with SMTP id d32so74632669qgd.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqEaMKKdmGIiy+s1swkExS8nhqlaAirmS+dCWXtGg8Y=;
        b=VQiNbEe9qZMzpdQdWQDYheruA9V7SJRUtu9ibvg0EszPYuy+y5JIKEFKWlx5U8KJ0q
         kLfbcOsdTSHVGGkAuDc61pKxGqN7ZvDzGXJNjnEv4M5uYvWdWXPJS/vmBvfrPjNqwV26
         dZaiOX+vC5hWTs5qZfInxOGvZPgcMgeJAqcRV0dUrxKRN0jcYXLNijCYGWaxnlVzco9t
         j/TEeNpSAt2fMyvPxrc9s348MNcYaw7UEQxF52Sh1Mvhrcr/XOnwrBTCVtRpMQnrcvrz
         6OAgzp2gYfUutmndfoAGldlf42Atehtjl+IOvnmhARwgLHldMr/Ohtyl2GVh9EAXA4qm
         bSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqEaMKKdmGIiy+s1swkExS8nhqlaAirmS+dCWXtGg8Y=;
        b=kvClnvTBcHkyuWmrET6PDGwkVRFn6IbhwhNqv42tjfxRM2q0jlb98AWyG6voqWDWym
         2h8xAU7DsEKelTmai68trywyHK5Q/ZUVPia4ZcoqbQ3GpD4Juyj6FkzJJ5gzW4gwlljs
         bzBijHIk+DzUqMxWPxcdbrGtyr3JmvT3r3YbOo0V8+erIRB8AC0sDbMvm3MntNQSMLOy
         Z9Jp1mazHozUN+t/Z5p5nktBYNq0qcY8jX+F9b9EUOm7JSuLiJm4PqsOdRbn7F0cMX+P
         4qqumpiLAavA9IHSGrUGfVwFLEKHYS1MjFM+IVZ8IZiDs7/ljapMocszVUM7lYHQxzbS
         Gpww==
X-Gm-Message-State: AD7BkJLDcL+r22eGSyx3vsc/bOY8AFCIvvSE1Tk1Vgc9nsRyThEAgf3tn/tn5ie9xNtI1A==
X-Received: by 10.140.35.115 with SMTP id m106mr23033517qgm.13.1456793604452;
        Mon, 29 Feb 2016 16:53:24 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:23 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287949>

This one has suggestions from Peff, SZEDER G=C3=A1bor, Duy Nguyen, and
fixups from Junio.

The major changes are:

* The new patch "call setup_git_directory_gently before accessing
  refs" -- this is necessary in order to move "setup: configure ref
  storage config on startup" from config to setup.

* "setup: configure ref storage config on startup" is now much shorter.

In addition, there are some minor fixups to remove variable shadowing
in the lmdb code and to improve the design of the
set_ref_storage_backend family of functions.

David Turner (30):
  setup: call setup_git_directory_gently before accessing refs
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
  setup: configure ref storage config on startup
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
 builtin/grep.c                                 |    1 +
 builtin/init-db.c                              |   55 +-
 builtin/log.c                                  |    2 +-
 builtin/shortlog.c                             |    7 +-
 builtin/submodule--helper.c                    |    2 +-
 cache.h                                        |    2 +
 config.c                                       |    1 +
 configure.ac                                   |   33 +
 contrib/completion/git-completion.bash         |    6 +-
 contrib/workdir/git-new-workdir                |    3 +
 git-submodule.sh                               |   13 +
 git-svn.perl                                   |    6 +-
 git.c                                          |    2 +-
 path.c                                         |   30 +-
 refs.c                                         |  631 +++++++-
 refs.h                                         |   16 +
 refs/files-backend.c                           |  686 ++++-----
 refs/lmdb-backend.c                            | 1886 ++++++++++++++++=
++++++++
 refs/refs-internal.h                           |  123 +-
 setup.c                                        |   29 +
 shortlog.h                                     |    2 +-
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
 t/t7400-submodule-basic.sh                     |   22 +-
 t/t7402-submodule-rebase.sh                    |    2 +-
 t/t7405-submodule-merge.sh                     |   10 +-
 t/t9104-git-svn-follow-parent.sh               |    3 +-
 t/t9115-git-svn-dcommit-funky-renames.sh       |    2 +-
 t/t9350-fast-export.sh                         |    6 +-
 t/t9902-completion.sh                          |    4 +-
 t/t9903-bash-prompt.sh                         |    2 +-
 t/test-lib-functions.sh                        |   53 +-
 t/test-lib.sh                                  |   12 +
 test-match-trees.c                             |    2 +
 test-refs-lmdb-backend.c                       |   66 +
 test-revision-walking.c                        |    2 +
 100 files changed, 5265 insertions(+), 605 deletions(-)
 create mode 100644 Documentation/technical/refs-lmdb-backend.txt
 create mode 100644 refs/lmdb-backend.c
 create mode 100755 t/t1460-refs-lmdb-backend.sh
 create mode 100755 t/t1470-refs-lmdb-backend-reflog.sh
 create mode 100755 t/t1480-refs-lmdb-submodule.sh
 create mode 100644 test-refs-lmdb-backend.c

--=20
2.4.2.767.g62658d5-twtrsrc
