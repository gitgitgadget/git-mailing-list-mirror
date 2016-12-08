Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA551FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 01:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933226AbcLHBqm (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 20:46:42 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33240 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbcLHBql (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 20:46:41 -0500
Received: by mail-pg0-f44.google.com with SMTP id 3so168145486pgd.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 17:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VbOeLWxfpY8/xaUsx3vOgp9tLZiJ3oARVqX6Ft0q4B4=;
        b=cQ8BCbV40YrGp7LFuom75Nmq8etqsnSMCcU5wMcjLPj/pUgb3a2VntncespXN6aSxJ
         5mtSNhjpC3CdD7EH+71ZhEIMXC/TFBYevyYRC2i+x2rC7NnzxJSG2+TQQfxSA4CE/DyX
         POvCeViYWL/jqp1gWXXNuprAL7lw/4b5jX8sZQnpe+qlZFct10UEm/Q2m0Y9bsbUnByt
         wng77rOx7ZSzNFmq+DbaLgTBt0bqL1lEj2xj+iaLOYvI0+CI1/X/WJ+TfY/+qiQO7TTi
         mTVLUCmEB4AfvryM+XYOfCEcXa34Dh/hNiD/ScnVPXCrL2/cso/TF3Xfb5QB+tmc1Xos
         2zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VbOeLWxfpY8/xaUsx3vOgp9tLZiJ3oARVqX6Ft0q4B4=;
        b=ja5pX1e3vEspaSvlSasCMVEhSQvoTvie1XUO/ObNou//2MMZRsmEt2ymragPf2Vspc
         8Nvf5Bl5g5qh5+F39jEj/hnp4WPMbCVsi/PQ7vLqO+nry1vsOv5M1G5YtMsiC/6Z3ZzR
         p9ZsH8L1tOTBoH0UYH79q4krMGrnMXKZQC7VxihbQM4r18hcn7GENizFkgWXQFAQzfS/
         G7bwCinBhSfq39i6ECmZ2C77mQNukFPTM72wgNom8FqD4lJHjuHtAQLIxNDJTxBc8bW4
         fjdSKxnhCo6XmETFDUUPcShBmmCCj5YfnsGj8MOvPvEI9J0tIloKdNsooG2Jxq7AC/Un
         I4QQ==
X-Gm-Message-State: AKaTC01zWRD9wdNeHhnJ0+7kJLtryXwDHOyezT1x6qgqrATIykS5pRSQUxm1TsJa6uJo60Ln
X-Received: by 10.98.32.151 with SMTP id m23mr72985142pfj.127.1481161600586;
        Wed, 07 Dec 2016 17:46:40 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id q12sm45406362pfj.18.2016.12.07.17.46.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 17:46:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 0/7] submodule embedgitdirs
Date:   Wed,  7 Dec 2016 17:46:16 -0800
Message-Id: <20161208014623.7588-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.gc512cbd.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6:
 * renamed embedgitdirs to absorbgitdirs embedding may be interpreted as
   embedding the git dir into the working directory, whereas absorbing sounds
   more like the submodule is absorbed by the superproject, making the
   submodule less independent
 * Worktrees API offer uses_worktrees(void) and submodule_uses_worktree(path).
 * moved the printing to stderr and one layer up (out of the pure
   relocate_git_dir function).
 * connect_... is in dir.h now.

v5:
* Add another layer of abstraction, i.e. the relocate_git_dir is only about
  moving a git dir of one repository. The submodule specific stuff (e.g.
  recursion into nested submodules) is in submodule.{c,h}

  This was motivated by reviews on the series of checkout aware of submodules
  building on top of this series, as we want to directly call the embed-git-dirs
  function without the overhead of spawning a child process.

v4:
* rebuilt on top of nd/worktree-list-fixup
* fix and test behavior for un-init submodules (don't crash, rather do nothing)
* incorporated a "static" as pointed out by Ramsay
* use internal functions instead of duplicating code in worktree.c
  (use get_common_dir_noenv for the submodule to actually get the common dir)
* fixed a memory leak in relocate_gitdir

v3:
* have a slightly more generic function "relocate_gitdir".
  The recursion is strictly related to submodules, though.
* bail out if a submodule is using worktrees.
  This also lays the groundwork for later doing the proper thing,
  as worktree.h offers a function `get_submodule_worktrees(path)`
* nit by duy: use git_path instead of git_common_dir

v2:
* fixed commit message for patch:
 "submodule: use absolute path for computing relative path connecting"
* a new patch "submodule helper: support super prefix"
* redid the final patch with more tests and fixing bugs along the way
* "test-lib-functions.sh: teach test_commit -C <dir>" unchanged

v1:
The discussion of the submodule checkout series revealed to me that a command
is needed to move the git directory from the submodules working tree to be
embedded into the superprojects git directory.

So I wrote the code to intern the submodules git dir into the superproject,
but whilst writing the code I realized this could be valueable for our use
in testing too. So I exposed it via the submodule--helper. But as the
submodule helper ought to be just an internal API, we could also
offer it via the proper submodule command.

The command as it is has little value to the end user for now, but
breaking it out of the submodule checkout series hopefully makes review easier.

Thanks,
Stefan

Stefan Beller (7):
  submodule: use absolute path for computing relative path connecting
  submodule helper: support super prefix
  test-lib-functions.sh: teach test_commit -C <dir>
  worktree: get worktrees from submodules
  worktree: add function to check if worktrees are in use
  move connect_work_tree_and_git_dir to dir.h
  submodule: add absorb-git-dir function

 Documentation/git-submodule.txt    |  15 +++++
 builtin/submodule--helper.c        |  69 ++++++++++++++++----
 dir.c                              |  38 +++++++++++
 dir.h                              |   4 ++
 git-submodule.sh                   |   7 +-
 git.c                              |   2 +-
 submodule.c                        | 127 ++++++++++++++++++++++++++++++-------
 submodule.h                        |   5 +-
 t/t7412-submodule-absorbgitdirs.sh | 101 +++++++++++++++++++++++++++++
 t/test-lib-functions.sh            |  20 ++++--
 worktree.c                         |  70 +++++++++++++++++---
 worktree.h                         |  13 ++++
 12 files changed, 418 insertions(+), 53 deletions(-)
 create mode 100755 t/t7412-submodule-absorbgitdirs.sh

-- 
2.11.0.rc2.30.gc512cbd.dirty

