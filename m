From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 00/27] refs backends
Date: Thu, 18 Feb 2016 00:17:23 -0500
Message-ID: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:18:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGz0-0000ze-BE
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbcBRFS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:26 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36121 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbcBRFSY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:24 -0500
Received: by mail-qg0-f48.google.com with SMTP id y9so29814082qgd.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Yw1r98KyJAq9QgAm25ev5qVCLHsTFKAWy4quakLj8X0=;
        b=qQ+3KsXVecnBTfuUOKaMDQCWxam2c9DfcX/y+G7OPIabcTcJIAbgla7jFy3kdmWr8p
         HqFAbqU2muXipxYdSzOpt+RwkcEtkoPNlWtfjuOoSff1FRFgn604uW9HQQC2pkUGZXi4
         RQGAq2tjru5znvBfn0C7KP3uVzblJlPzwXYbMlMDAT1sGyzBpse8lE5b+ZH3N8vqUZ88
         I2r9Cp8H0idYYaZErGtxwCOzx2/u+Pm4xjDZfF1c7A5ALQIfrcOPZ7P5VhWruP808eUc
         gyA9JAPrBgSXhZWjYT/ry9f7mBs88FWnOtOeNLX/hqV7LNAkd7HaD+T8H2bP1/qUiHxl
         xoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=Yw1r98KyJAq9QgAm25ev5qVCLHsTFKAWy4quakLj8X0=;
        b=iDofi+uZ9s0YUf+oWqujLqBLGZ8N+LqRnZzrp6QcUR3jKoiq1+s0YtoL6gKBwXpMUr
         AVQyJ4WHmMxJw8FDe0uKpL5mdhE19jV++1i8ItHAOeuzv1VcUneP4TutpDGkFL3rbcOa
         cvxEL+HZGvfC1ZooWiDZhOaoAbuk+R/R8WGlpD1XliiUuN9WKB3/ruZAHuiboTq5KI+D
         5rntYfHiw8M1DVYqeWN7Qcy/7ABMtrZqFw0wiVDBUYgVNvIg9jA/HEY3+4nlrjhU6K3x
         /HjVIz1rUjXmQb/C/9Nb8WbhQqzNm5hc8kbZKsTu/6Q9r3fTQwQvmonJGoKppwvyVtjj
         impw==
X-Gm-Message-State: AG10YORLNDjH2envda65PSsbg3tZL9vonKXnh1VHoZrcDPRRpQQpUqeI5gmqhXJdUU1dtA==
X-Received: by 10.140.105.97 with SMTP id b88mr6580101qgf.74.1455772703931;
        Wed, 17 Feb 2016 21:18:23 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:23 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286572>

This version incorporates numerous changes suggested by Michael
Haggerty.  Also a few by Duy Nguyen.

Of particular note are a few new patches:

refs: Move head_ref{,_submodule} to the common code. Michael pointed
out that these didn't directly use backend-specific functions.

refs: add method for do_for_each_ref.  This was originally separate
methods for each flavor of do_for_each_ref, and has now been simplified
to use a single common method.

refs: forbid cross-backend ref renames.  Later, we could go back and make
these work.

refs: don't dereference on rename and refs: on symref reflog expire,
lock symref not referrent.  These are broken out of "resolve symbolic
refs first", which was overlong, and now come with tests.  Also, I applied
Michael's insight on ref_noderef to the lmdb backend (so that it passes
the new tests).

tests: add ref-storage argument: this allows everyone to run the tests
under lmdb easily.


David Turner (25):
  refs: Move head_ref{,_submodule} to the common code
  refs: move for_each_*ref* functions into common code
  refs: add method for do_for_each_ref
  refs: add do_for_each_per_worktree_ref
  refs: add methods for reflog
  refs: add method for initial ref transaction commit
  refs: add method for delete_refs
  refs: add methods to init refs db
  refs: add method to rename refs
  refs: forbid cross-backend ref renames
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
  refs: add register_ref_storage_backends()
  refs: add LMDB refs storage backend
  refs: tests for lmdb backend
  tests: add ref-storage argument

Ronnie Sahlberg (2):
  refs: add a backend method structure with transaction functions
  refs: add methods for misc ref operations

 .gitignore                                     |    1 +
 Documentation/config.txt                       |    9 +
 Documentation/git-clone.txt                    |    6 +
 Documentation/git-init-db.txt                  |    2 +-
 Documentation/git-init.txt                     |    8 +-
 Documentation/technical/refs-lmdb-backend.txt  |   52 +
 Documentation/technical/repository-version.txt |    5 +
 Makefile                                       |   12 +
 builtin/clone.c                                |    5 +
 builtin/init-db.c                              |   55 +-
 builtin/submodule--helper.c                    |    2 +-
 cache.h                                        |    2 +
 config.c                                       |   25 +
 configure.ac                                   |   33 +
 contrib/completion/git-completion.bash         |    6 +-
 contrib/workdir/git-new-workdir                |    3 +
 git-submodule.sh                               |   13 +
 git-svn.perl                                   |    6 +-
 path.c                                         |   30 +-
 refs.c                                         |  512 ++++++-
 refs.h                                         |   21 +
 refs/files-backend.c                           |  464 +++---
 refs/lmdb-backend.c                            | 1921 ++++++++++++++++++++++++
 refs/refs-internal.h                           |  114 +-
 setup.c                                        |   23 +-
 t/lib-submodule-update.sh                      |   15 +-
 t/lib-t6000.sh                                 |    5 +-
 t/t0001-init.sh                                |   25 +
 t/t0008-ignores.sh                             |    2 +-
 t/t0062-revision-walking.sh                    |    6 +
 t/t1021-rerere-in-workdir.sh                   |    6 +
 t/t1200-tutorial.sh                            |    8 +-
 t/t1302-repo-version.sh                        |    6 +
 t/t1305-config-include.sh                      |   17 +-
 t/t1400-update-ref.sh                          |    6 +
 t/t1401-symbolic-ref.sh                        |   18 +-
 t/t1410-reflog.sh                              |   26 +-
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
 t/t3200-branch.sh                              |   74 +-
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
 t/test-lib.sh                                  |    7 +
 test-refs-lmdb-backend.c                       |   64 +
 transport.c                                    |    7 +-
 92 files changed, 5071 insertions(+), 457 deletions(-)
 create mode 100644 Documentation/technical/refs-lmdb-backend.txt
 create mode 100644 refs/lmdb-backend.c
 create mode 100755 t/t1460-refs-lmdb-backend.sh
 create mode 100755 t/t1470-refs-lmdb-backend-reflog.sh
 create mode 100755 t/t1480-refs-lmdb-submodule.sh
 create mode 100644 test-refs-lmdb-backend.c

-- 
2.4.2.767.g62658d5-twtrsrc
