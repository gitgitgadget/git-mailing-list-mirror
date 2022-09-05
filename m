Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10431C6FA86
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbiIEI1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbiIEI0y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:26:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDEF1CD
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:26:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e13so10304165wrm.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=RP4Zh/NonLPqPUHAciGcZ8ICDFnbEMbuc00Z+dNoViE=;
        b=JeR9NxQLbYPrfbgRORj3W3+2cjkt4zPIX82NJkBl0Pnawi9qg/bt2OD1ycpgGkElqM
         6csxYffKZzSjGA7w/X/pXzjoflYLYcqUZ/PeRJsCIRK/CX9rjA4ZW9sxtpup7hG73WS0
         dbKlLByhw9zXMxcpWnNS20FUAVU0z9YQcnejx3Mcs92FUB+rbRhXaQMcNRpdkv2Ic77M
         A6Ei5HCUoQGwrLQoEKQLbHOjdaH3lFXj6MESm5Me9NuUwNDv1fXo5VyhjyGnZxVxsPDo
         7GrnSZmjKoOHtQVLqA2SN4bKzWSUd3D9PsfaZnrXlWEBun/NkcyaIuOCU5AQKr0XGuGv
         D8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RP4Zh/NonLPqPUHAciGcZ8ICDFnbEMbuc00Z+dNoViE=;
        b=kSyi0DwVPB8GizgqFuHo0E3MdpyTStI139sOFIklFLT3JN6TEfm9dA39YTKJIFukIF
         cs5SzK8uZd4kcB/xzs1Syt8W9cs/xGJgKpI59hHN82x0BYr4sKA7hzW/zeunhpZY8d2f
         bWc1S84dMV0rz+7Y3xfPLhQSlCvC1SWrjXg9RFr3FGvZnpg0SRTEHsQfwrL1EjWvP0Xr
         gL0hwV9HxeLX74CZyHZfYfREGnoR9yOq/lS0aLl+/xXvyYfEv3wCIYVL7MNGi7jTwsZ6
         0yeqY+F0QURBuj7Dxu/nLT++4MsPbw9WCC7PAjS5PnNB/R1ubvDZzHi9ofEsN1I1bqMm
         ZxeA==
X-Gm-Message-State: ACgBeo0MkGOkDRuQbgufbghciY2wDQ097uojZgygYnMq5Q0S/Ps+8NbN
        2VAaMoUUO2HBxgSTVY+O+t9V1RQFJ+4=
X-Google-Smtp-Source: AA6agR4Y50S4DodM3xzKPtroslHh9Fk1BpEx+exAwQ14LH4Iu4uvE63xII2ty35wHwLmQeSlFxR/mg==
X-Received: by 2002:a05:6000:381:b0:221:7540:b1ee with SMTP id u1-20020a056000038100b002217540b1eemr22984716wrf.307.1662366410678;
        Mon, 05 Sep 2022 01:26:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:26:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/34] doc/UX: make txt & -h output more consistent
Date:   Mon,  5 Sep 2022 10:26:11 +0200
Message-Id: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are currently wildly inconsistent in whether the SYNOPSIS in the
manual page matches the first line of the -h output, and as we add new
options we routinely forget to add them to one or the other (or both).

Without a more complex approach it's hard to do something about the
"or both" case. But we can rather easily test whether the -h output
matches the *.txt version, and report differences.

As this series shows that allows us to fix a lot of issues we've
effectively already "fixed", we just fixed them in one version, but
not the other.

We now have a test that checks that these are the same for all
built-ins. Out of 141 built-in commands we still have 58 cases that
differ at the end of this series, but that's a lot better than before.

This series is 34 patches, but it's been structured in a way that
reviewers should be able to mostly trust the "doc txt & -h
consistency" commits already. In all of those cases we already have
the post-image in-tree, it's just in either the *.txt or -h version,
not both. All of the "doc txt & -h consistency" commits merely make
those consistent together.

All of the commands and documentation altered by the "doc txt & -h
consistency" commits are then tested in 34/34, i.e. there are no
"loose ends" where we partially "fix" something, but fail to fully
test it at the end (unless I missed something).

Junio: This series merges cleanly with "seen", and I've intentionally
left out any changes that might conflict. If we get newlry queued
patches that make things inconsistent the new test will fail. Perhaps
we should make them all "TODO" and flip the switch later, but we are
going to have to test this for real at some point if we're going to
stem the tide of these routinely drifting apart.

Ævar Arnfjörð Bjarmason (34):
  CodingGuidelines: update and clarify command-line conventions
  builtin/bundle.c: use \t, not fix indentation 2-SP indentation
  bundle: define subcommand -h in terms of command -h
  blame: use a more detailed usage_msg_optf() error on bad -L
  doc SYNOPSIS: don't use ' for subcommands
  doc SYNOPSIS: consistently use ' for commands
  doc SYNOPSIS & -h: fix incorrect alternates syntax
  built-ins: consistently add "\n" between "usage" and options
  doc txt & -h consistency: word-wrap
  doc txt & -h consistency: fix incorrect alternates syntax
  doc txt & -h consistency: add "-z" to cat-file "-h"
  doc txt & -h consistency: add missing "]" to bugreport "-h"
  doc txt & -h consistency: correct padding around "[]()"
  stash doc SYNOPSIS & -h: correct padding around "[]()"
  doc txt & -h consistency: use "<options>", not "<options>..."
  t/helper/test-proc-receive.c: use "<options>", not "<options>..."
  doc txt & -h consistency: fix mismatching labels
  doc txt & -h consistency: add or fix optional "--" syntax
  doc txt & -h consistency: make output order consistent
  doc txt & -h consistency: add missing options and labels
  doc txt & -h consistency: make "rerere" consistent
  doc txt & -h consistency: make "read-tree" consistent
  doc txt & -h consistency: make "bundle" consistent
  doc txt & -h consistency: use "git foo" form, not "git-foo"
  doc txt & -h consistency: add missing options
  doc txt & -h consistency: make "stash" consistent
  doc txt & -h consistency: make "annotate" consistent
  doc txt & -h consistency: use "[<label>...]" for "zero or more"
  doc txt & -h consistency: make "diff-tree" consistent
  doc txt & -h consistency: make "commit" consistent
  reflog doc: list real subcommands up-front
  worktree: define subcommand -h in terms of command -h
  doc txt & -h consistency: make "worktree" consistent
  tests: start asserting that *.txt SYNOPSIS matches -h output

 Documentation/CodingGuidelines                |  17 +-
 Documentation/git-annotate.txt                |   2 +-
 Documentation/git-clean.txt                   |   6 +-
 Documentation/git-commit-graph.txt            |   5 +-
 .../git-credential-cache--daemon.txt          |   2 +-
 Documentation/git-diff-files.txt              |   2 +-
 Documentation/git-fast-export.txt             |   2 +-
 Documentation/git-hash-object.txt             |   3 +-
 Documentation/git-interpret-trailers.txt      |   5 +-
 Documentation/git-merge-base.txt              |   4 +-
 Documentation/git-mv.txt                      |   2 +-
 Documentation/git-pack-redundant.txt          |   2 +-
 Documentation/git-prune-packed.txt            |   2 +-
 Documentation/git-read-tree.txt               |   2 +-
 Documentation/git-receive-pack.txt            |   2 +-
 Documentation/git-reflog.txt                  |  17 +-
 Documentation/git-rerere.txt                  |   2 +-
 Documentation/git-send-pack.txt               |   3 +-
 Documentation/git-show-branch.txt             |   4 +-
 Documentation/git-show-ref.txt                |   4 +-
 Documentation/git-sparse-checkout.txt         |   2 +-
 Documentation/git-stash.txt                   |  17 +-
 Documentation/git-status.txt                  |   2 +-
 Documentation/git-tag.txt                     |   2 +-
 Documentation/git-update-server-info.txt      |   8 +-
 Documentation/git-upload-archive.txt          |   4 +-
 Documentation/git-var.txt                     |   2 +-
 Documentation/git-verify-commit.txt           |   2 +-
 Documentation/git-verify-pack.txt             |   2 +-
 Documentation/git-verify-tag.txt              |   2 +-
 Documentation/git-worktree.txt                |   3 +-
 builtin/blame.c                               |  26 ++-
 builtin/bugreport.c                           |   3 +-
 builtin/bundle.c                              |  38 ++--
 builtin/cat-file.c                            |   2 +-
 builtin/clean.c                               |   2 +-
 builtin/commit-graph.c                        |  10 +-
 builtin/commit-tree.c                         |   5 +-
 builtin/commit.c                              |  11 +-
 builtin/credential-cache--daemon.c            |   4 +-
 builtin/describe.c                            |   5 +-
 builtin/diagnose.c                            |   3 +-
 builtin/diff-files.c                          |   1 +
 builtin/diff-index.c                          |   3 +-
 builtin/diff-tree.c                           |   6 +-
 builtin/diff.c                                |   3 +-
 builtin/for-each-repo.c                       |   2 +-
 builtin/fsck.c                                |   5 +-
 builtin/hash-object.c                         |   5 +-
 builtin/help.c                                |   2 +-
 builtin/init-db.c                             |   5 +-
 builtin/interpret-trailers.c                  |   4 +-
 builtin/ls-remote.c                           |   2 +-
 builtin/merge-base.c                          |   2 +-
 builtin/pack-objects.c                        |   4 +-
 builtin/pack-redundant.c                      |   2 +-
 builtin/pack-refs.c                           |   2 +-
 builtin/read-tree.c                           |   4 +-
 builtin/rerere.c                              |   2 +-
 builtin/rev-list.c                            |   3 +-
 builtin/revert.c                              |   9 +-
 builtin/rm.c                                  |   4 +-
 builtin/send-pack.c                           |   1 +
 builtin/show-branch.c                         |   3 +-
 builtin/show-ref.c                            |   4 +-
 builtin/sparse-checkout.c                     |   2 +-
 builtin/stash.c                               |  73 ++++---
 builtin/symbolic-ref.c                        |   5 +-
 builtin/tag.c                                 |  10 +-
 builtin/unpack-file.c                         |   2 +-
 builtin/update-server-info.c                  |   2 +-
 builtin/upload-archive.c                      |   2 +-
 builtin/upload-pack.c                         |   3 +-
 builtin/verify-pack.c                         |   2 +-
 builtin/worktree.c                            | 110 ++++++++---
 help.c                                        |   2 +-
 t/helper/test-proc-receive.c                  |   2 +-
 t/t0450-txt-doc-vs-help.sh                    | 179 ++++++++++++++++++
 78 files changed, 530 insertions(+), 185 deletions(-)
 create mode 100755 t/t0450-txt-doc-vs-help.sh

-- 
2.37.3.1425.g73df845bcb2

