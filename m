From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 00/45] Massive improvents to rebase and cherry-pick
Date: Sun,  9 Jun 2013 11:40:12 -0500
Message-ID: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulihs-0006Gd-C6
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822Ab3FIQmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:42:52 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42907 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab3FIQmv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:42:51 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so9046562obc.31
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+Z5+ij8Y1akjSDUIv9S4Wj5y00aXNw/oZyL2dCYvtUM=;
        b=Qi1snIYMe4hRgR/7BOuYUlu0CJ5nK4MsAglo1YJFR5r8+kf8aekzgrX5V00Fwa/ad1
         +j6ViKMmJrLE4uLPc0KlbC6ca0G5biQFm4mK1rjShWPGMt9CGyu4WWlbbL2GZlZH3jjb
         6IkSOJyMOpro2HdGekb3vLmGgNSus5t+47kZ67+M9CDMUCHp5Oh5jmcfzGSzH0/nvJa6
         MUS3SGMkc8/MvhmfSV1PvDkpmqd4+zDcjLDi0gvztbbofRkH2i1C1Ivf64rb3Qd1qyDe
         qCP/eFUIrFAEB5E2rNPZpx46NRfmBCl1j5BS+DdTEok2amCCgelWtO0DOYCfuLIwF2x1
         LrGw==
X-Received: by 10.60.58.33 with SMTP id n1mr5341892oeq.3.1370796170603;
        Sun, 09 Jun 2013 09:42:50 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d5sm15206447oex.0.2013.06.09.09.42.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:42:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226972>

Hi,

These are improvements to 'git rebase' by using a much improved 'git
cherry-pick'. I already sent some of these, but they have been revamped.

These changes require reorganization of the code in order to have a
builtin/lib.a library.

A new builtin/rewrite.c helper is added, and builtin/commit updated to use
that.

A new git-rebase--cherypick mode is added, and it replaces git-rebase--am and
git-rebase--merge.

I also added the new rebase tests by Martin von Zweigbergk to make sure
everything works, and in fact, it works better than before, since now all the
rebase modes are consistent with each other.

I don't have any hopes of these getting merged, because people have no interest
in fixing the ./*.o ./builin/*.o divide problem, only interested in arguing
that libgit.a is not a real library, and it should never be. So my obviously
cleanup is rejected.

Felipe Contreras (38):
  build: generate and clean test scripts
  build: do not install git-remote-testgit
  build: trivial cleanup
  build: add builtin lib
  log-tree: remove dependency from sequencer
  Move sequencer to builtin
  unpack-trees: plug a memory leak
  read-cache: plug a few leaks
  sequencer: remove useless indentation
  sequencer: trivial fix
  cherry-pick: don't barf when there's nothing to do
  cherry-pick: add --skip-empty option
  revert/cherry-pick: add --quiet option
  revert/cherry-pick: add --skip option
  builtin: add rewrite helper
  cherry-pick: store rewritten commits
  cherry-pick: don't store skipped commit
  builtin: move run_rewrite_hook() to rewrite.c
  builtin: add copy_rewrite_notes()
  cherry-pick: copy notes and run hooks
  cherry-pick: add --action-name option
  cherry-pick: remember rerere-autoupdate
  rebase: split the cherry-pick stuff
  rebase: cherry-pick: fix mode storage
  rebase: cherry-pick: fix sequence continuation
  rebase: cherry-pick: fix abort of cherry mode
  rebase: cherry-pick: fix command invocations
  rebase: cherry-pick: fix status messages
  rebase: cherry-pick: automatically commit stage
  rebase: cherry-pick: set correct action-name
  rebase: trivial cleanup
  rebase: use 'cherrypick' mode instead of 'am'
  rebase: cherry-pick: fix for shell prompt
  rebase: cherry-pick: add merge options
  rebase: remove merge mode
  rebase: cherry-pick: add copyright
  tests: fix autostash
  tests: update topology tests

Martin von Zweigbergk (7):
  add simple tests of consistency across rebase types
  add tests for rebasing with patch-equivalence present
  add tests for rebasing of empty commits
  add tests for rebasing root
  add tests for rebasing merged history
  t3406: modernize style
  tests: move test for rebase messages from t3400 to t3406

 .gitignore                             |   1 +
 Documentation/git-cherry-pick.txt      |  10 +-
 Documentation/git-revert.txt           |   7 +-
 Documentation/sequencer.txt            |   3 +
 Makefile                               |  31 +--
 builtin/commit.c                       |  46 +----
 builtin/revert.c                       |  17 ++
 builtin/rewrite.c                      | 124 ++++++++++++
 builtin/rewrite.h                      |  20 ++
 sequencer.c => builtin/sequencer.c     | 263 ++++++++++---------------
 sequencer.h => builtin/sequencer.h     |  12 +-
 contrib/completion/git-prompt.sh       |   4 +-
 git-rebase--am.sh                      |  12 +-
 git-rebase--cherrypick.sh              |  72 +++++++
 git-rebase--interactive.sh             |   4 +-
 git-rebase--merge.sh                   | 151 --------------
 git-rebase.sh                          |  16 +-
 log-tree.c                             | 161 ++++++++++++++-
 log-tree.h                             |   3 +
 read-cache.c                           |   4 +
 t/lib-rebase.sh                        |  33 ++++
 t/t3400-rebase.sh                      |  53 +----
 t/t3401-rebase-partial.sh              |  69 -------
 t/t3404-rebase-interactive.sh          |  10 +-
 t/t3406-rebase-message.sh              |  56 +++---
 t/t3407-rebase-abort.sh                |   2 +-
 t/t3409-rebase-preserve-merges.sh      |  53 -----
 t/t3420-rebase-autostash.sh            |   5 +-
 t/t3421-rebase-topology-linear.sh      | 350 +++++++++++++++++++++++++++++++++
 t/t3425-rebase-topology-merges.sh      | 255 ++++++++++++++++++++++++
 t/t3508-cherry-pick-many-commits.sh    |  13 ++
 t/t3510-cherry-pick-sequence.sh        |  14 +-
 t/t5520-pull.sh                        |   2 +-
 t/t9106-git-svn-commit-diff-clobber.sh |   2 +-
 t/t9903-bash-prompt.sh                 |   2 +-
 unpack-trees.c                         |   4 +-
 36 files changed, 1268 insertions(+), 616 deletions(-)
 create mode 100644 builtin/rewrite.c
 create mode 100644 builtin/rewrite.h
 rename sequencer.c => builtin/sequencer.c (86%)
 rename sequencer.h => builtin/sequencer.h (86%)
 create mode 100644 git-rebase--cherrypick.sh
 delete mode 100644 git-rebase--merge.sh
 delete mode 100755 t/t3401-rebase-partial.sh
 create mode 100755 t/t3421-rebase-topology-linear.sh
 create mode 100755 t/t3425-rebase-topology-merges.sh

-- 
1.8.3.698.g079b096
