Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845D6C63699
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252E620825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLWPWUNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgKLWog (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgKLWoS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:18 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA957C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:02 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 10so6589100wml.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=JkHfg2QPcN3U6m/VAXTXwb0RN86OQYjPuaGEbSViZ3M=;
        b=lLWPWUNbsGiQcQZUL7LJ/K19bYAHj8mbF9o18lVAYagAAxY8APx6tZbbscBdnnBMQw
         +aMwPJnpvyUpwSylJXdwm6LR/YIJWrHSHan5w9+ZhuaGHUEtV4mHv2nSruvVXnUps+8k
         v7LN8W6BJFKGfA0akngb9f7tHmMeHF+t+CMSX7CRP8iq5RLMPSkHz7lHQt42ee9D/+Rd
         dLMzsNLnHsxYlZhtL6J67h0nUvgtwX05YxnLI2Mo83iyOzQM8H9zvUNYecB9mWhDu4Z4
         tY8nla4tjvDcGoxhtUqGV/j2Go59Vbdo8tiPnUhcSl2qYOXvnxipe9BjfB20o9u1NtWm
         wL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JkHfg2QPcN3U6m/VAXTXwb0RN86OQYjPuaGEbSViZ3M=;
        b=e1cE9x3QQwpH2B1EdwbiA6tI4OjYQJv+PjZeQKOn/olfdDT4rJOofMDSuFrZFHrfyR
         e1ArX3unduFfLgqnyF9I+K/cpgyg3bTNG2sJOmMzTE/QiJUPIL7SNLbohotx3K+IB7vy
         B3kSgUoaVZYDcM4gEbJDU4kv+azZcc4SEYg6Io8YN9WFED9+8G8+7Cj0EK8QmMD5rbt/
         xKGCBVNt5pzE/eHL5gNvWljyvTTsqoEteAFSyqUBXuUDPtnYb143M5H5ImbCSfpn4vXD
         2TnKlOPnqpFOlO9AkPlITfFM6sWSCtCl0Xw46WD07n/AnaEa8nSLAovDsE0ahwchB/IQ
         p7gw==
X-Gm-Message-State: AOAM531KO5PKWE7O6QDJX2VZkNweZq21qbyfc0D9OmH52IrMIrOd61jx
        UnTu3SJxRW1+HUuQw0UbPFOLJK3qQBc=
X-Google-Smtp-Source: ABdhPJxjTTsWvVCuIBxd5rod+/YtGariRgeMZKUCD1gUGchpV42D9AfY927GhjrRYSmaAAg2qWS9UQ==
X-Received: by 2002:a1c:790b:: with SMTP id l11mr52345wme.53.1605221041067;
        Thu, 12 Nov 2020 14:44:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9sm8426215wrr.49.2020.11.12.14.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:00 -0800 (PST)
Message-Id: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:30 +0000
Subject: [PATCH 00/28] Use main as default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the big one. This changes the default of init.defaultBranch to main,
reflecting what many open source projects already did (which was followed by
GitHub, Azure Repos and others).

Instead of one huge patch that reflects essentially a search-and-replace in
the test suite, this patch series splits the changes up into chunks that are
intended to be smaller than 100kB so that they are not rejected by the Git
mailing list. Interspersed between those changes are adjustments e.g. in
alignment, to make it easier to review (or recreate) the search-and-replace
patches.

Note that this branch is based on next, mostly because it would otherwise
conflict with en/merge-tests, jk/diff-release-filespec-fix and 
ds/maintenance-part-3.

The semantic conflict with pk/subsub-fetch-fix consists of just a single
line in t/t5526-fetch-submodules.sh needing s/master/main/g.

To avoid even more conflicts with topics that did not even make it to seen 
yet, this patch series specifically excludes t3404, t4013, t5310, t6300,
t7064, t7817, t9902: in those test scripts, we will still use master for the
time being. Once the topics in question have settled, I will send the
appropriate follow-up patches to adjust them to use main instead.

Don Goodman-Wilson (1):
  Change the default branch name to `main`

Johannes Schindelin (27):
  t0060: preemptively adjust alignment
  t[01]*: adjust the references to the default branch name "main"
  t2*: adjust the references to the default branch name "main"
  t3[0-3]*: adjust the references to the default branch name "main"
  t3416: preemptively adjust alignment in a comment
  t34*: adjust the references to the default branch name "main"
  t3[5-9]*: adjust the references to the default branch name "main"
  t4*: adjust the references to the default branch name "main"
  t5323: prepare centered comment for `master` -> `main`
  t5[0-4]*: adjust the references to the default branch name "main"
  t5503: prepare aligned comment for replacing `master` with `main`
  t550*: adjust the references to the default branch name "main"
  t551*: adjust the references to the default branch name "main"
  t55[23]*: adjust the references to the default branch name "main"
  t55[4-9]*: adjust the references to the default branch name "main"
  t5[6-9]*: adjust the references to the default branch name "main"
  t6[0-3]*: adjust the references to the default branch name "main"
  t64*: preemptively adjust alignment to prepare for `master` -> `main`
  t6[4-9]*: adjust the references to the default branch name "main"
  t7[0-4]*: adjust the references to the default branch name "main"
  t7[5-9]*: adjust the references to the default branch name "main"
  t8*: adjust the references to the default branch name "main"
  t9[0-4]*: adjust the references to the default branch name "main"
  t9[5-7]*: adjust the references to the default branch name "main"
  tests(git-p4): transition to the default branch name `main`
  t99*: adjust the references to the default branch name "main"
  tests: drop prereq `PREPARE_FOR_MAIN_BRANCH` where no longer needed

 refs.c                                        |   2 +-
 t/annotate-tests.sh                           |   8 +-
 t/lib-cvs.sh                                  |   2 +-
 t/lib-submodule-update.sh                     |   2 +-
 t/t0002-gitfile.sh                            |   6 +-
 t/t0020-crlf.sh                               |   8 +-
 t/t0021-conversion.sh                         |  40 +-
 t/t0027-auto-crlf.sh                          |   4 +-
 t/t0028-working-tree-encoding.sh              |   4 +-
 t/t0041-usage.sh                              |  10 +-
 t/t0050-filesystem.sh                         |   6 +-
 t/t0060-path-utils.sh                         |   4 +-
 t/t0100-previous.sh                           |  18 +-
 t/t1004-read-tree-m-u-wf.sh                   |  40 +-
 t/t1008-read-tree-overlay.sh                  |   2 +-
 t/t1009-read-tree-new-index.sh                |   4 +-
 t/t1011-read-tree-sparse-checkout.sh          |   2 +-
 t/t1021-rerere-in-workdir.sh                  |   2 +-
 t/t1090-sparse-checkout-scope.sh              |  10 +-
 t/t1091-sparse-checkout-builtin.sh            |   2 +-
 t/t1300-config.sh                             |   8 +-
 t/t1301-shared-repo.sh                        |   4 +-
 t/t1305-config-include.sh                     |   2 +-
 t/t1309-early-config.sh                       |   4 +-
 t/t1400-update-ref.sh                         |  72 +--
 t/t1402-check-ref-format.sh                   |  28 +-
 t/t1403-show-ref.sh                           |  18 +-
 t/t1405-main-ref-store.sh                     |  42 +-
 t/t1406-submodule-ref-store.sh                |  30 +-
 t/t1407-worktree-ref-store.sh                 |  32 +-
 t/t1408-packed-refs.sh                        |  12 +-
 t/t1410-reflog.sh                             |  56 +-
 t/t1411-reflog-show.sh                        |   2 +-
 t/t1413-reflog-detach.sh                      |  24 +-
 t/t1414-reflog-walk.sh                        |  12 +-
 t/t1416-ref-transaction-hooks.sh              |  10 +-
 t/t1430-bad-ref-name.sh                       |  52 +-
 t/t1450-fsck.sh                               |   2 +-
 t/t1500-rev-parse.sh                          |   4 +-
 t/t1503-rev-parse-verify.sh                   |  28 +-
 t/t1505-rev-parse-last.sh                     |   8 +-
 t/t1506-rev-parse-diagnosis.sh                |   4 +-
 t/t1507-rev-parse-upstream.sh                 |  40 +-
 t/t1508-at-combinations.sh                    |  10 +-
 t/t1511-rev-parse-caret.sh                    |  26 +-
 t/t1512-rev-parse-disambiguation.sh           |   2 +-
 t/t1513-rev-parse-prefix.sh                   |   4 +-
 t/t1514-rev-parse-push.sh                     |  16 +-
 t/t1700-split-index.sh                        |   2 +-
 t/t2007-checkout-symlink.sh                   |  10 +-
 t/t2009-checkout-statinfo.sh                  |   8 +-
 t/t2010-checkout-ambiguous.sh                 |   4 +-
 t/t2011-checkout-invalid-head.sh              |  16 +-
 t/t2012-checkout-last.sh                      |  48 +-
 t/t2015-checkout-unborn.sh                    |   2 +-
 t/t2017-checkout-orphan.sh                    |  44 +-
 t/t2020-checkout-detach.sh                    |  28 +-
 t/t2022-checkout-paths.sh                     |  22 +-
 t/t2023-checkout-m.sh                         |  10 +-
 t/t2024-checkout-dwim.sh                      |  70 +--
 t/t2027-checkout-track.sh                     |   6 +-
 t/t2030-unresolve-info.sh                     |   6 +-
 t/t2060-switch.sh                             |  30 +-
 t/t2070-restore.sh                            |   4 +-
 t/t2106-update-index-assume-unchanged.sh      |   2 +-
 t/t2400-worktree-add.sh                       |  66 +--
 t/t2401-worktree-prune.sh                     |   2 +-
 t/t2402-worktree-list.sh                      |  20 +-
 t/t2405-worktree-submodule.sh                 |   6 +-
 t/t3040-subprojects-basic.sh                  |   2 +-
 t/t3200-branch.sh                             | 248 ++++-----
 t/t3201-branch-contains.sh                    |  82 +--
 t/t3202-show-branch-octopus.sh                |   2 +-
 t/t3203-branch-output.sh                      |  40 +-
 t/t3204-branch-name-interpretation.sh         |   6 +-
 t/t3205-branch-color.sh                       |   8 +-
 t/t3206-range-diff.sh                         |  40 +-
 t/t3206/history.export                        |   2 +-
 t/t3210-pack-refs.sh                          |   4 +-
 t/t3211-peel-ref.sh                           |   4 +-
 t/t3301-notes.sh                              |   6 +-
 t/t3302-notes-index-expensive.sh              |   2 +-
 t/t3303-notes-subtrees.sh                     |   8 +-
 t/t3304-notes-mixed.sh                        |   8 +-
 t/t3308-notes-merge.sh                        |   2 +-
 t/t3320-notes-merge-worktrees.sh              |   4 +-
 t/t3400-rebase.sh                             |  60 +--
 t/t3402-rebase-merge.sh                       |  44 +-
 t/t3403-rebase-skip.sh                        |   6 +-
 t/t3405-rebase-malformed.sh                   |   8 +-
 t/t3406-rebase-message.sh                     |  24 +-
 t/t3407-rebase-abort.sh                       |  18 +-
 t/t3408-rebase-multi-line.sh                  |   2 +-
 t/t3409-rebase-preserve-merges.sh             |  10 +-
 t/t3412-rebase-root.sh                        |  28 +-
 t/t3413-rebase-hook.sh                        |  42 +-
 t/t3415-rebase-autosquash.sh                  |   2 +-
 t/t3416-rebase-onto-threedots.sh              |  54 +-
 t/t3418-rebase-continue.sh                    |  24 +-
 t/t3419-rebase-patch-id.sh                    |  12 +-
 t/t3420-rebase-autostash.sh                   |   8 +-
 t/t3423-rebase-reword.sh                      |   6 +-
 t/t3427-rebase-subtree.sh                     |  20 +-
 t/t3430-rebase-merges.sh                      |  16 +-
 t/t3431-rebase-fork-point.sh                  |  32 +-
 t/t3432-rebase-fast-forward.sh                |  34 +-
 t/t3434-rebase-i18n.sh                        |   8 +-
 t/t3435-rebase-gpg-sign.sh                    |   4 +-
 t/t3436-rebase-more-options.sh                |   2 +-
 t/t3500-cherry.sh                             |  12 +-
 t/t3501-revert-cherry-pick.sh                 |   4 +-
 t/t3502-cherry-pick-merge.sh                  |   2 +-
 t/t3503-cherry-pick-root.sh                   |  10 +-
 t/t3504-cherry-pick-rerere.sh                 |  24 +-
 t/t3505-cherry-pick-empty.sh                  |  24 +-
 t/t3506-cherry-pick-ff.sh                     |   8 +-
 t/t3507-cherry-pick-conflict.sh               |   2 +-
 t/t3508-cherry-pick-many-commits.sh           |  38 +-
 t/t3509-cherry-pick-merge-df.sh               |   2 +-
 t/t3512-cherry-pick-submodule.sh              |   2 +-
 t/t3600-rm.sh                                 |  10 +-
 t/t3701-add-interactive.sh                    |   4 +-
 t/t3901-i18n-patch.sh                         |  40 +-
 t/t3903-stash.sh                              |  32 +-
 t/t3910-mac-os-precompose.sh                  |   6 +-
 t/t4014-format-patch.sh                       | 176 +++---
 t/t4015-diff-whitespace.sh                    |   2 +-
 t/t4017-diff-retval.sh                        |   2 +-
 t/t4038-diff-combined.sh                      |  14 +-
 t/t4041-diff-submodule-option.sh              |   2 +-
 t/t4048-diff-combined-binary.sh               |  10 +-
 t/t4052-stat-output.sh                        |   4 +-
 t/t4056-diff-order.sh                         |   2 +-
 t/t4057-diff-combined-paths.sh                |  20 +-
 t/t4061-diff-indent.sh                        |  24 +-
 t/t4066-diff-emit-delay.sh                    |   2 +-
 t/t4068-diff-symmetric-merge-base.sh          |  48 +-
 t/t4103-apply-binary.sh                       |  36 +-
 t/t4108-apply-threeway.sh                     |  14 +-
 t/t4121-apply-diffs.sh                        |   2 +-
 t/t4122-apply-symlink-inside.sh               |   6 +-
 t/t4150-am.sh                                 |  26 +-
 t/t4200-rerere.sh                             |  20 +-
 t/t4201-shortlog.sh                           |   2 +-
 t/t4202-log.sh                                | 106 ++--
 t/t4203-mailmap.sh                            |   2 +-
 t/t4204-patch-id.sh                           |  26 +-
 t/t4207-log-decoration-colors.sh              |   6 +-
 t/t4208-log-magic-pathspec.sh                 |   4 +-
 t/t4211/history.export                        |   2 +-
 t/t4214-log-graph-octopus.sh                  |   2 +-
 t/t4216-log-bloom.sh                          |   4 +-
 t/t4253-am-keep-cr-dos.sh                     |  20 +-
 t/t4257-am-interactive.sh                     |   2 +-
 t/t5150-request-pull.sh                       |  34 +-
 t/t5304-prune.sh                              |   2 +-
 t/t5305-include-tag.sh                        |   2 +-
 t/t5312-prune-corruption.sh                   |  16 +-
 t/t5317-pack-objects-filter-objects.sh        |   2 +-
 t/t5322-pack-objects-sparse.sh                |   2 +-
 t/t5323-pack-redundant.sh                     |  66 +--
 t/t5400-send-pack.sh                          |  60 +--
 t/t5401-update-hooks.sh                       |  24 +-
 t/t5402-post-merge-hook.sh                    |   2 +-
 t/t5403-post-checkout-hook.sh                 |   6 +-
 t/t5404-tracking-branches.sh                  |   8 +-
 t/t5405-send-pack-rewind.sh                   |   6 +-
 t/t5407-post-rewrite-hook.sh                  |   2 +-
 t/t5410-receive-pack-alternates.sh            |   4 +-
 t/t5500-fetch-pack.sh                         |  28 +-
 t/t5501-fetch-push-alternates.sh              |   4 +-
 t/t5502-quickfetch.sh                         |   6 +-
 t/t5503-tagfollow.sh                          |  12 +-
 t/t5504-fetch-receive-strict.sh               |  20 +-
 t/t5505-remote.sh                             | 148 +++---
 t/t5506-remote-groups.sh                      |   4 +-
 t/t5509-fetch-push-namespaces.sh              |  30 +-
 t/t5510-fetch.sh                              | 162 +++---
 t/t5511-refspec.sh                            |  12 +-
 t/t5512-ls-remote.sh                          |  26 +-
 t/t5514-fetch-multiple.sh                     |  30 +-
 t/t5516-fetch-push.sh                         | 500 +++++++++---------
 t/t5517-push-mirror.sh                        | 124 ++---
 t/t5518-fetch-exit-status.sh                  |   6 +-
 t/t5519-push-alternates.sh                    |  12 +-
 t/t5520-pull.sh                               |  30 +-
 t/t5521-pull-options.sh                       |  16 +-
 t/t5523-push-upstream.sh                      |  30 +-
 t/t5526-fetch-submodules.sh                   |  48 +-
 t/t5527-fetch-odd-refs.sh                     |  14 +-
 t/t5528-push-default.sh                       |  98 ++--
 t/t5529-push-errors.sh                        |   2 +-
 t/t5530-upload-pack-error.sh                  |   2 +-
 t/t5531-deep-submodule-push.sh                | 188 +++----
 t/t5533-push-cas.sh                           | 142 ++---
 t/t5534-push-signed.sh                        |   4 +-
 t/t5537-fetch-shallow.sh                      |  30 +-
 t/t5538-push-shallow.sh                       |  22 +-
 t/t5539-fetch-http-shallow.sh                 |  14 +-
 t/t5540-http-push-webdav.sh                   |   8 +-
 t/t5541-http-push-smart.sh                    |  40 +-
 t/t5542-push-http-shallow.sh                  |   8 +-
 t/t5543-atomic-push.sh                        |  80 +--
 t/t5545-push-options.sh                       |  62 +--
 t/t5548-push-porcelain.sh                     |  64 +--
 t/t5550-http-fetch-dumb.sh                    |  20 +-
 t/t5551-http-fetch-smart.sh                   |  20 +-
 t/t5552-skipping-fetch-negotiator.sh          |   2 +-
 t/t5553-set-upstream.sh                       |  82 +--
 t/t5561-http-backend.sh                       |   4 +-
 t/t556x_common                                |   8 +-
 t/t5570-git-daemon.sh                         |  16 +-
 t/t5571-pre-push-hook.sh                      |   4 +-
 t/t5572-pull-submodule.sh                     |   4 +-
 t/t5580-unc-paths.sh                          |   2 +-
 t/t5581-http-curl-verbose.sh                  |   2 +-
 t/t5582-fetch-negative-refspec.sh             |  22 +-
 t/t5601-clone.sh                              |   4 +-
 t/t5604-clone-reference.sh                    |  12 +-
 t/t5605-clone-local.sh                        |  10 +-
 t/t5606-clone-options.sh                      |   8 +-
 t/t5607-clone-bundle.sh                       |  14 +-
 t/t5608-clone-2gb.sh                          |   2 +-
 t/t5609-clone-branch.sh                       |   6 +-
 t/t5610-clone-detached.sh                     |   4 +-
 t/t5611-clone-config.sh                       |  16 +-
 t/t5612-clone-refspec.sh                      |  42 +-
 t/t5614-clone-submodules-shallow.sh           |   2 +-
 t/t5616-partial-clone.sh                      |  50 +-
 t/t5617-clone-submodules-remote.sh            |   6 +-
 t/t5700-protocol-v1.sh                        |  16 +-
 t/t5701-git-serve.sh                          |  16 +-
 t/t5702-protocol-v2.sh                        |  50 +-
 t/t5703-upload-pack-ref-in-want.sh            |  60 +--
 t/t5801-remote-helpers.sh                     |  24 +-
 t/t6000-rev-list-misc.sh                      |   2 +-
 t/t6001-rev-list-graft.sh                     |   2 +-
 t/t6004-rev-list-path-optim.sh                |  14 +-
 t/t6006-rev-list-format.sh                    |  14 +-
 t/t6007-rev-list-cherry-pick-file.sh          |   4 +-
 t/t6008-rev-list-submodule.sh                 |   2 +-
 t/t6009-rev-list-parent.sh                    |   6 +-
 t/t6012-rev-list-simplify.sh                  |   8 +-
 t/t6013-rev-list-reverse-parents.sh           |  10 +-
 t/t6016-rev-list-graph-simplify-history.sh    |   2 +-
 t/t6017-rev-list-stdin.sh                     |   8 +-
 t/t6018-rev-list-glob.sh                      |  50 +-
 t/t6019-rev-list-ancestry-path.sh             |   6 +-
 t/t6030-bisect-porcelain.sh                   |  10 +-
 t/t6040-tracking-info.sh                      |  54 +-
 t/t6050-replace.sh                            |  10 +-
 t/t6101-rev-parse-parents.sh                  |   2 +-
 t/t6110-rev-list-sparse.sh                    |   2 +-
 t/t6111-rev-list-treesame.sh                  |   6 +-
 t/t6112-rev-list-filters-objects.sh           |  14 +-
 t/t6120-describe.sh                           |  20 +-
 t/t6200-fmt-merge-msg.sh                      |  50 +-
 t/t6302-for-each-ref-filter.sh                |  58 +-
 t/t6400-merge-df.sh                           |   6 +-
 t/t6402-merge-rename.sh                       |  46 +-
 t/t6404-recursive-merge.sh                    |   4 +-
 t/t6405-merge-symlinks.sh                     |  14 +-
 t/t6406-merge-attr.sh                         |  24 +-
 t/t6407-merge-binary.sh                       |   6 +-
 t/t6409-merge-subtree.sh                      |  16 +-
 t/t6411-merge-filemode.sh                     |  10 +-
 t/t6412-merge-large-rename.sh                 |   6 +-
 t/t6413-merge-crlf.sh                         |   2 +-
 t/t6414-merge-rename-nocruft.sh               |   2 +-
 t/t6415-merge-dir-to-symlink.sh               |  22 +-
 t/t6416-recursive-corner-cases.sh             |  28 +-
 t/t6417-merge-ours-theirs.sh                  |  28 +-
 t/t6418-merge-text-auto.sh                    |  12 +-
 t/t6419-merge-ignorecase.sh                   |  10 +-
 t/t6422-merge-rename-corner-cases.sh          |  12 +-
 t/t6425-merge-rename-delete.sh                |   2 +-
 t/t6427-diff3-conflict-markers.sh             |  14 +-
 t/t6430-merge-recursive.sh                    |  18 +-
 t/t6432-merge-recursive-space-options.sh      |   6 +-
 t/t6433-merge-toplevel.sh                     |   8 +-
 t/t6434-merge-recursive-rename-options.sh     |   6 +-
 t/t6436-merge-overwrite.sh                    |   2 +-
 t/t6437-submodule-merge.sh                    |  14 +-
 t/t6439-merge-co-error-msgs.sh                |   6 +-
 t/t6501-freshen-objects.sh                    |   2 +-
 t/t7003-filter-branch.sh                      |  40 +-
 t/t7004-tag.sh                                |   8 +-
 t/t7030-verify-tag.sh                         |   2 +-
 t/t7060-wtstatus.sh                           |  26 +-
 t/t7063-status-untracked-cache.sh             |  14 +-
 t/t7102-reset.sh                              |   6 +-
 t/t7113-post-index-change-hook.sh             |   2 +-
 t/t7201-co.sh                                 | 110 ++--
 t/t7400-submodule-basic.sh                    |  20 +-
 t/t7403-submodule-sync.sh                     |  10 +-
 t/t7406-submodule-update.sh                   |  38 +-
 t/t7407-submodule-foreach.sh                  |  24 +-
 t/t7409-submodule-detached-work-tree.sh       |   8 +-
 t/t7417-submodule-path-url.sh                 |   2 +-
 t/t7501-commit-basic-functionality.sh         |   2 +-
 t/t7502-commit-porcelain.sh                   |  12 +-
 ...3-pre-commit-and-pre-merge-commit-hooks.sh |  42 +-
 t/t7504-commit-msg-hook.sh                    |  24 +-
 t/t7505-prepare-commit-msg-hook.sh            |  20 +-
 t/t7508-status.sh                             |  58 +-
 t/t7510-signed-commit.sh                      |   2 +-
 t/t7512-status-help.sh                        |  40 +-
 t/t7517-per-repo-email.sh                     |  12 +-
 t/t7600-merge.sh                              |  44 +-
 t/t7606-merge-custom.sh                       |   2 +-
 t/t7608-merge-messages.sh                     |  36 +-
 t/t7610-mergetool.sh                          | 174 +++---
 t/t7611-merge-abort.sh                        |   4 +-
 t/t7612-merge-verify-signatures.sh            |   2 +-
 t/t7614-merge-signoff.sh                      |  24 +-
 t/t7701-repack-unpack-unreachable.sh          |   2 +-
 t/t7800-difftool.sh                           |  38 +-
 t/t7810-grep.sh                               |  28 +-
 t/t8001-annotate.sh                           |   2 +-
 t/t8003-blame-corner-cases.sh                 |   4 +-
 t/t8004-blame-with-conflicts.sh               |  14 +-
 t/t9001-send-email.sh                         |  28 +-
 t/t9100-git-svn-basic.sh                      |   2 +-
 t/t9145-git-svn-master-branch.sh              |   6 +-
 t/t9151-svn-mergeinfo.sh                      |   2 +-
 t/t9155-git-svn-fetch-deleted-tag.sh          |   2 +-
 t/t9156-git-svn-fetch-deleted-tag-2.sh        |   6 +-
 t/t9163-git-svn-reset-clears-caches.sh        |   2 +-
 t/t9169-git-svn-dcommit-crlf.sh               |   2 +-
 t/t9300-fast-import.sh                        |  82 +--
 t/t9301-fast-import-notes.sh                  |  14 +-
 t/t9302-fast-import-unpack-limit.sh           |  16 +-
 t/t9350-fast-export.sh                        |  86 +--
 t/t9351-fast-export-anonymize.sh              |   4 +-
 t/t9400-git-cvsserver-server.sh               |  32 +-
 t/t9401-git-cvsserver-crlf.sh                 |  16 +-
 t/t9402-git-cvsserver-refs.sh                 |   8 +-
 t/t9500-gitweb-standalone-no-errors.sh        |  20 +-
 t/t9501-gitweb-standalone-http-status.sh      |  14 +-
 t/t9502-gitweb-standalone-parse-output.sh     |  16 +-
 t/t9600-cvsimport.sh                          |   2 +-
 t/t9601-cvsimport-vendor-branch.sh            |  16 +-
 t/t9602-cvsimport-branches-tags.sh            |   4 +-
 t/t9603-cvsimport-patchsets.sh                |   8 +-
 t/t9800-git-p4-basic.sh                       |   2 +-
 t/t9801-git-p4-branch.sh                      |  16 +-
 t/t9806-git-p4-options.sh                     |  18 +-
 t/t9807-git-p4-submit.sh                      |   2 +-
 t/t9811-git-p4-label-import.sh                |   2 +-
 t/t9903-bash-prompt.sh                        | 114 ++--
 t/test-lib.sh                                 |  13 +
 351 files changed, 3903 insertions(+), 3890 deletions(-)


base-commit: aff20da3a209088e7f8f3632077fa11b86453d67
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-762%2Fdscho%2Fuse-main-as-default-branch-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-762/dscho/use-main-as-default-branch-name-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/762
-- 
gitgitgadget
