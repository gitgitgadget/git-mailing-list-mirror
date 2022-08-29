Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE586ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 20:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiH2UyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH2UyU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 16:54:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A681B20
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v16so8926191wrm.8
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=BxzF2Jup09RVoasVjP+mX8RujNhrjkf/U+PkXSUWSvE=;
        b=H2HdaZ0rxkkajBNdNjaN02B0CBPzjKhGCyCjWwkqYNnjitgHgdQaQ4pvDdpcMQ8R15
         neG4lxqkGonDuoaHm70a+LnWpnK+DYbGkSfOClldIaSXTSiK3TjDCBrQENJxzM38TnO5
         Au5GbG5Iwbe/Gb9vpNJjF+ty/hZDOSlsk5W+JgLDE0EZAaM0yj0/M9hbsnRL6qIoK9M0
         C2n2ZKEOyvuEEMcleO+MUCa9RAEO/lvJi4omqCmuL8K+z8fm4FPrNTHXSus7xJDKnUnX
         ksIULy3ijzqO8Scg9sbYTSIC7tweoM4/hjSAD092vygGgP1Dj8II2QWbX2yRgh2bPBD7
         B+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=BxzF2Jup09RVoasVjP+mX8RujNhrjkf/U+PkXSUWSvE=;
        b=RZVod4oEoEy3HXhpHCxgbOes+7llM3Qz8aQdXkjSlwkqwA9+0ZFYkwugsTvgSsjqy+
         ePNz+LuewWW7CJHIEJeeKgtYaKnLaUXnImGTbh0KOtfPTGoBKsUxr49l96Zn1BQI8Xjl
         cXpgw2AF1H1cZ47JjZMREmp4uoqYfDOCOHmx1SllKdo/0SMg2C5LE422H5FkUquSrpuQ
         7IFGRZY/1nhYkVF+aRglQ+NgmQG0Fh3JSkKr/NpGuaxAKFPiWFQFlE/Hd4gyxoBUv7Mr
         ykrmF7j++F0tcfo/c7PEXiuiHgMEUNPBNEsvuMtJDhPKB8SZHT2wSU+ALSdv01MXo0A4
         eZbQ==
X-Gm-Message-State: ACgBeo1W7OcWdC5HpAuBLgrvs8XdnrC7dCq3Zhp/ZWqbwKGHmWQ7gGcr
        LLyww9kLBbCKtKeqoca4qqindACE18o=
X-Google-Smtp-Source: AA6agR6liCzHqNcxJ15YyHFbQ+5bVC2zUcqdeQ2/hHL1XQZNZNC3ptpw2koshtAdkvTj7m8xRBZ1wA==
X-Received: by 2002:adf:ed81:0:b0:226:a509:14b6 with SMTP id c1-20020adfed81000000b00226a50914b6mr7166542wro.150.1661806457990;
        Mon, 29 Aug 2022 13:54:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c359100b003a5c1e916c8sm250902wmq.1.2022.08.29.13.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:54:17 -0700 (PDT)
Message-Id: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 20:54:10 +0000
Subject: [PATCH 0/6] clone, submodule update: check out submodule branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

= Description

This series teaches "git clone --recurse-submodules" and "git submodule
update" to understand "submodule.propagateBranches" (see Further Reading for
context), i.e. if the superproject has a branch checked out and a submodule
is cloned, the submodule will have the same branch checked out.

To do this, "git submodule update" checks if "submodule.propagateBranches"
is true, and if so, gets the current superproject branch and updates the
submodule by running "git checkout -b my-superproject-branch". Since "git
clone --recurse-submodules" is implemented using "git submodule update", it
also learns this trick.

The main challenges with this approach are:

 * If the remote HEAD points to a branch, "git clone" always creates that
   branch in the clone. But with "submodule.propagateBranches", we want
   submodules to use the branch names of their superproject, not their
   upstream.
   
   This is solved by adding a new flag to "git clone", "--detach", which
   detaches the clone's HEAD at the branch and does not create it.

 * When "git submodule update" recurses into submodules, the parent process
   has to propagate the value of "submodule.propagateBranches" to child
   processes, otherwise the behavior will be inconsistent if the submodule
   has the config unset.
   
   This is solved by adding an internal GIT_* environment variable and
   passing it down via prepare_submodule_repo_env(). This is cleaner than
   passing "-c submodule.propagateBranches=true", but an even cleaner
   solution would be for submodules to read "submodule.propagateBranches"
   from their superproject config. This would also be useful for
   "submodule.alternateLocation" and "submodule.alternateErrorStrategy", as
   we wouldn't have to set those values in newly-cloned submodules. This
   requires teaching Git to treat submodules differently, which was the
   subject of some WIP in [1]. That topic has stalled, but I don't mind
   restarting it if others prefer that.

[1]
https://lore.kernel.org/git/20220310004423.2627181-1-emilyshaffer@google.com/

= Patch organization

 * Patch 1/6 adds "--detach" to "git clone"
 * Patch 2/6 creates the environment variable and repository setting for
   "submodule.propagateBranches"
 * Patches 3-5/6 are prep work, and 6/6 adds the actual
   "submodule.propagateBranches" behavior

= Future work

 * Patch 4, which refactors resolve_gitlink_ref(), notes that a better
   interface would be to return the refname instead of using an "out"
   parameter, but we use an "out" parameter so that any new callers trying
   to use the old function signature will get stopped by the compiler. The
   refactor can be finished at a later time.

= Further reading

Submodule branching RFC:
https://lore.kernel.org/git/kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com/

Original Submodule UX RFC/Discussion:
https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/

Contributor Summit submodules Notes:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211148060.56@tvgsbejvaqbjf.bet/

Submodule UX overhaul updates:
https://lore.kernel.org/git/?q=Submodule+UX+overhaul+update

"git branch --recurse-submodules":
https://lore.kernel.org/git/20220129000446.99261-1-chooglen@google.com/

Glen Choo (6):
  clone: teach --detach option
  repo-settings: add submodule_propagate_branches
  t5617: drop references to remote-tracking branches
  submodule: return target of submodule symref
  submodule--helper: refactor up-to-date criterion
  clone, submodule update: check out branches

 Documentation/git-clone.txt                   |  7 +++-
 builtin/branch.c                              | 11 ++----
 builtin/clone.c                               | 12 ++++--
 builtin/submodule--helper.c                   | 37 +++++++++++++++++--
 builtin/update-index.c                        |  4 +-
 cache.h                                       |  1 +
 combine-diff.c                                |  3 +-
 diff-lib.c                                    |  2 +-
 dir.c                                         |  2 +-
 object-file.c                                 |  2 +-
 read-cache.c                                  |  4 +-
 refs.c                                        | 10 +++--
 refs.h                                        |  5 ++-
 repo-settings.c                               | 11 +++---
 repository.h                                  |  1 +
 submodule.c                                   |  2 +
 t/t5601-clone.sh                              | 22 +++++++++++
 ...es-remote.sh => t5617-clone-submodules.sh} | 36 +++++++++++++++++-
 t/t7406-submodule-update.sh                   | 22 +++++++++++
 unpack-trees.c                                |  3 +-
 20 files changed, 161 insertions(+), 36 deletions(-)
 rename t/{t5617-clone-submodules-remote.sh => t5617-clone-submodules.sh} (72%)


base-commit: 9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1321%2Fchooglen%2Fsubmodule%2Fclone-recursive-with-branch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1321/chooglen/submodule/clone-recursive-with-branch-v1
Pull-Request: https://github.com/git/git/pull/1321
-- 
gitgitgadget
