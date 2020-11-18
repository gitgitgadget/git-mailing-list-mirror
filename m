Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788B9C63697
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB8A246BC
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qeaf6Ayj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgKRXo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgKRXoy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:44:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D195CC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d12so4247873wrr.13
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=VFXzLvv0Oo10FO+YxlJRaZ9NIcsGHKlQlxrcxLklZ14=;
        b=Qeaf6AyjvYKkvBbjjCY3LjizXK0l5ead9S8Zwp0ncXtuIJVG9gFe7ZrfM71v9YsfCC
         KkMt5Zu9KZ6DmUonLKZAjOIfZ/7S5idg9P1lwgHg+hFP2ktprYRg50zoiZLC4vLe2HrP
         nhJx4IF0x/icDFx+v8sD+iX+fXfZ5dWLLxJj/Fz3TqGFrAev+93eL36xrPMwDD1FVkJ3
         dzu0CH/idF7Xp7vssjI7SWz2OfGwemQ6JnxNu4dzc50kKviznlBYcmGhM8XPpxkUDdrg
         MvllL5tKr+COlxd5gz9gaoZblRytMdlOgvDwSRC+k1HKEMy+IX87qbk4iJuL75B2fjZ8
         TUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=VFXzLvv0Oo10FO+YxlJRaZ9NIcsGHKlQlxrcxLklZ14=;
        b=tI28tlXQA2xxggl1YyDvtaCiTTYt6intsO2dCnYbr0R6bT2d/69WIQlaTEqnOFCheJ
         3khfqIimybcwNY7jfhn7EtV1kNcRr7nin2yybeR1vcj5noeleJ1aGmF7ZttMdPF0OQ8n
         rqA6W470IHtda/wJ/gYzpqV+cNzfdlQJpNessY4YkEfF/wcI2x8FcYCdgWF5no27DnNL
         TpmQXGr2SqxYz0ICaNijFx30oFv+Hru9Pba+UhQo7RVjVxwdJhFbC5okoQw6+KL50ukf
         9SByrzKwIQC0CuMI07tBL1tfKVYhe8jAL1Z6mtIfdc08tnYGAJQEtONRdu/9p8OO1BL1
         9edA==
X-Gm-Message-State: AOAM531O0uAii6wQ07H+3TdoVMAvmSdVcFGdTlvCewJDsLfX54TdWuA8
        40J90IdvxtEqok+24tgDctwS9xhaWqY=
X-Google-Smtp-Source: ABdhPJwJQVpOe2cJ/M5OceVXGD7xh+hjbjUpaBabeEylB88rY7JkZZObUXIF4Sjt/GBD/GqmZedx5g==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr7296445wrn.208.1605743090021;
        Wed, 18 Nov 2020 15:44:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h20sm5979178wmb.29.2020.11.18.15.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:49 -0800 (PST)
Message-Id: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:18 +0000
Subject: [PATCH v3 00/28] tests: use main as default branch name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This (big) patch series (almost) concludes the transition of Git's test
suite to use init.defaultBranch=main that was started in 
js/default-branch-name-part-4-minus-1, continued in 
js/default-branch-name-adjust-t5411 and in 
js/default-branch-name-adjust-t5515. This transition prepares for changing
the fall-back value of init.defaultBranch accordingly (which will be done in
a different set of patch series, with an appropriate deprecation period),
reflecting what many open source projects already did followed by GitHub,
Azure Repos and others.

Before doing anything else, the series starts out with a patch that marks
all the test scripts that expect a specific default branch name and won't
pass with any other name.

Instead of one huge patch that reflects essentially a search-and-replace in
the test suite, this patch series then splits the changes up into chunks
that are intended to be smaller than 100kB so that they are not rejected by
the Git mailing list. Interspersed between those changes are adjustments
e.g. in alignment, to make it easier to review (or recreate) the
search-and-replace patches.

Note that this branch is based on next, mostly because it would otherwise
conflict with en/merge-tests, jk/diff-release-filespec-fix and 
ds/maintenance-part-3.

To avoid even more conflicts with topics that did not even make it to seen 
yet, this patch series specifically excludes t1309, t2106, t3040, t3404,
t4013, t4015, t5310, t5526, t6300, t7064, t7817, t9902: in those test
scripts, we will still use master for the time being. Once the topics in
question have settled, I will send the appropriate follow-up patches to
adjust them to use main instead.

Note that even after this patch series, master is still found in t/, even
outside of the tests we excluded specifically to avoid conflicts with other
patch series that are currently in flight: t/perf/, the git p4 tests
(because git p4 still uses p4/master to refer to the remote main branch),
and some comments still refer to this name. I intend to address at least
some of those, in patch series separate from the current one.

Changes since v2:

 * The case statement setting the default branch name for each test script
   was replaced by an initial patch that sets the default branch name in
   those test scripts that need it (and only in those). This patch also
   modifies the linux-gcc job to verify that the test suite runs with
   overridden default branch name (which the now-marked test scripts
   over-override).
 * Four more test scripts were excluded from this patch series: t1309,
   t2106, t3040 and t4015. These are handled in four separate patch series,
   where I try to remove the requirement to hard-code the default branch
   name in the first place.

Changes since v1:

 * Dropped the commit changing the default initial branch name for git init.
 * Adjusted the patch for t1402 to also replace naster by nain.
 * Excluded t5526 from the patches for now, to avoid clashing with 
   pk/subsub-fetch-fix.

Johannes Schindelin (28):
  tests: mark tests relying on the current default for
    `init.defaultBranch`
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

 ci/run-build-and-tests.sh                     |   2 +
 t/annotate-tests.sh                           |   8 +-
 t/lib-cvs.sh                                  |   2 +-
 t/t0002-gitfile.sh                            |   9 +-
 t/t0020-crlf.sh                               |  11 +-
 t/t0021-conversion.sh                         |  43 +-
 t/t0027-auto-crlf.sh                          |   4 +-
 t/t0028-working-tree-encoding.sh              |   7 +-
 t/t0041-usage.sh                              |  13 +-
 t/t0050-filesystem.sh                         |   9 +-
 t/t0060-path-utils.sh                         |   4 +-
 t/t0100-previous.sh                           |  21 +-
 t/t1004-read-tree-m-u-wf.sh                   |  43 +-
 t/t1008-read-tree-overlay.sh                  |   5 +-
 t/t1009-read-tree-new-index.sh                |   7 +-
 t/t1011-read-tree-sparse-checkout.sh          |   2 +-
 t/t1021-rerere-in-workdir.sh                  |   5 +-
 t/t1090-sparse-checkout-scope.sh              |  13 +-
 t/t1091-sparse-checkout-builtin.sh            |   5 +-
 t/t1300-config.sh                             |  11 +-
 t/t1301-shared-repo.sh                        |   7 +-
 t/t1305-config-include.sh                     |   2 +-
 t/t1400-update-ref.sh                         |  75 +--
 t/t1402-check-ref-format.sh                   |  32 +-
 t/t1403-show-ref.sh                           |  21 +-
 t/t1405-main-ref-store.sh                     |  45 +-
 t/t1406-submodule-ref-store.sh                |  33 +-
 t/t1407-worktree-ref-store.sh                 |  35 +-
 t/t1408-packed-refs.sh                        |  15 +-
 t/t1410-reflog.sh                             |  59 +-
 t/t1411-reflog-show.sh                        |   5 +-
 t/t1413-reflog-detach.sh                      |  27 +-
 t/t1414-reflog-walk.sh                        |  15 +-
 t/t1416-ref-transaction-hooks.sh              |  13 +-
 t/t1430-bad-ref-name.sh                       |  55 +-
 t/t1450-fsck.sh                               |   2 +-
 t/t1500-rev-parse.sh                          |   7 +-
 t/t1503-rev-parse-verify.sh                   |  31 +-
 t/t1505-rev-parse-last.sh                     |  11 +-
 t/t1506-rev-parse-diagnosis.sh                |   7 +-
 t/t1507-rev-parse-upstream.sh                 |  43 +-
 t/t1508-at-combinations.sh                    |  13 +-
 t/t1511-rev-parse-caret.sh                    |  29 +-
 t/t1512-rev-parse-disambiguation.sh           |   5 +-
 t/t1513-rev-parse-prefix.sh                   |   7 +-
 t/t1514-rev-parse-push.sh                     |  19 +-
 t/t1700-split-index.sh                        |   5 +-
 t/t2007-checkout-symlink.sh                   |  13 +-
 t/t2009-checkout-statinfo.sh                  |  11 +-
 t/t2010-checkout-ambiguous.sh                 |   7 +-
 t/t2011-checkout-invalid-head.sh              |  19 +-
 t/t2012-checkout-last.sh                      |  51 +-
 t/t2015-checkout-unborn.sh                    |   5 +-
 t/t2017-checkout-orphan.sh                    |  47 +-
 t/t2020-checkout-detach.sh                    |  31 +-
 t/t2022-checkout-paths.sh                     |  25 +-
 t/t2023-checkout-m.sh                         |  13 +-
 t/t2024-checkout-dwim.sh                      |  70 +--
 t/t2027-checkout-track.sh                     |   9 +-
 t/t2030-unresolve-info.sh                     |   9 +-
 t/t2060-switch.sh                             |  33 +-
 t/t2070-restore.sh                            |   7 +-
 t/t2400-worktree-add.sh                       |  69 +--
 t/t2401-worktree-prune.sh                     |   5 +-
 t/t2402-worktree-list.sh                      |  23 +-
 t/t2405-worktree-submodule.sh                 |   9 +-
 t/t3200-branch.sh                             | 251 ++++-----
 t/t3201-branch-contains.sh                    |  85 +--
 t/t3202-show-branch-octopus.sh                |   5 +-
 t/t3203-branch-output.sh                      |  43 +-
 t/t3204-branch-name-interpretation.sh         |   9 +-
 t/t3205-branch-color.sh                       |  11 +-
 t/t3206-range-diff.sh                         |  43 +-
 t/t3206/history.export                        |   2 +-
 t/t3210-pack-refs.sh                          |   7 +-
 t/t3211-peel-ref.sh                           |   7 +-
 t/t3301-notes.sh                              |   6 +-
 t/t3302-notes-index-expensive.sh              |   5 +-
 t/t3303-notes-subtrees.sh                     |  11 +-
 t/t3304-notes-mixed.sh                        |  11 +-
 t/t3308-notes-merge.sh                        |   2 +-
 t/t3320-notes-merge-worktrees.sh              |   7 +-
 t/t3400-rebase.sh                             |  63 +--
 t/t3402-rebase-merge.sh                       |  47 +-
 t/t3403-rebase-skip.sh                        |   9 +-
 t/t3404-rebase-interactive.sh                 |   3 +
 t/t3405-rebase-malformed.sh                   |  11 +-
 t/t3406-rebase-message.sh                     |  27 +-
 t/t3407-rebase-abort.sh                       |  21 +-
 t/t3408-rebase-multi-line.sh                  |   5 +-
 t/t3409-rebase-preserve-merges.sh             |  13 +-
 t/t3412-rebase-root.sh                        |  31 +-
 t/t3413-rebase-hook.sh                        |  45 +-
 t/t3415-rebase-autosquash.sh                  |   5 +-
 t/t3416-rebase-onto-threedots.sh              |  57 +-
 t/t3418-rebase-continue.sh                    |  27 +-
 t/t3419-rebase-patch-id.sh                    |  15 +-
 t/t3420-rebase-autostash.sh                   |  11 +-
 t/t3423-rebase-reword.sh                      |   6 +-
 t/t3427-rebase-subtree.sh                     |  23 +-
 t/t3430-rebase-merges.sh                      |  19 +-
 t/t3431-rebase-fork-point.sh                  |  35 +-
 t/t3432-rebase-fast-forward.sh                |  37 +-
 t/t3434-rebase-i18n.sh                        |  11 +-
 t/t3435-rebase-gpg-sign.sh                    |   7 +-
 t/t3436-rebase-more-options.sh                |   2 +-
 t/t3500-cherry.sh                             |  15 +-
 t/t3501-revert-cherry-pick.sh                 |   7 +-
 t/t3502-cherry-pick-merge.sh                  |   5 +-
 t/t3503-cherry-pick-root.sh                   |  13 +-
 t/t3504-cherry-pick-rerere.sh                 |  27 +-
 t/t3505-cherry-pick-empty.sh                  |  27 +-
 t/t3506-cherry-pick-ff.sh                     |  11 +-
 t/t3507-cherry-pick-conflict.sh               |   5 +-
 t/t3508-cherry-pick-many-commits.sh           |  41 +-
 t/t3509-cherry-pick-merge-df.sh               |   5 +-
 t/t3512-cherry-pick-submodule.sh              |   5 +-
 t/t3600-rm.sh                                 |  13 +-
 t/t3701-add-interactive.sh                    |   7 +-
 t/t3901-i18n-patch.sh                         |  43 +-
 t/t3903-stash.sh                              |  35 +-
 t/t3910-mac-os-precompose.sh                  |   9 +-
 t/t4013-diff-various.sh                       |   3 +
 t/t4014-format-patch.sh                       | 179 ++++---
 t/t4017-diff-retval.sh                        |   5 +-
 t/t4038-diff-combined.sh                      |  17 +-
 t/t4041-diff-submodule-option.sh              |   5 +-
 t/t4048-diff-combined-binary.sh               |  13 +-
 t/t4052-stat-output.sh                        |   7 +-
 t/t4056-diff-order.sh                         |   5 +-
 t/t4057-diff-combined-paths.sh                |  23 +-
 t/t4061-diff-indent.sh                        |  27 +-
 t/t4066-diff-emit-delay.sh                    |   5 +-
 t/t4068-diff-symmetric-merge-base.sh          |  51 +-
 t/t4103-apply-binary.sh                       |  39 +-
 t/t4108-apply-threeway.sh                     |  17 +-
 t/t4121-apply-diffs.sh                        |   5 +-
 t/t4122-apply-symlink-inside.sh               |   9 +-
 t/t4150-am.sh                                 |  29 +-
 t/t4200-rerere.sh                             |  23 +-
 t/t4201-shortlog.sh                           |   5 +-
 t/t4202-log.sh                                | 109 ++--
 t/t4203-mailmap.sh                            |   5 +-
 t/t4204-patch-id.sh                           |  29 +-
 t/t4207-log-decoration-colors.sh              |   9 +-
 t/t4208-log-magic-pathspec.sh                 |   7 +-
 t/t4211-line-log.sh                           |   3 +
 t/t4211/history.export                        |   2 +-
 t/t4214-log-graph-octopus.sh                  |   5 +-
 t/t4216-log-bloom.sh                          |   7 +-
 t/t4253-am-keep-cr-dos.sh                     |  23 +-
 t/t4257-am-interactive.sh                     |   2 +-
 t/t5150-request-pull.sh                       |  37 +-
 t/t5304-prune.sh                              |   5 +-
 t/t5305-include-tag.sh                        |   5 +-
 t/t5310-pack-bitmaps.sh                       |   3 +
 t/t5312-prune-corruption.sh                   |  19 +-
 t/t5317-pack-objects-filter-objects.sh        |   5 +-
 t/t5322-pack-objects-sparse.sh                |   5 +-
 t/t5323-pack-redundant.sh                     |  66 +--
 t/t5400-send-pack.sh                          |  63 +--
 t/t5401-update-hooks.sh                       |  24 +-
 t/t5402-post-merge-hook.sh                    |   5 +-
 t/t5403-post-checkout-hook.sh                 |   9 +-
 t/t5404-tracking-branches.sh                  |  11 +-
 t/t5405-send-pack-rewind.sh                   |   9 +-
 t/t5407-post-rewrite-hook.sh                  |   5 +-
 t/t5410-receive-pack-alternates.sh            |   7 +-
 t/t5500-fetch-pack.sh                         |  31 +-
 t/t5501-fetch-push-alternates.sh              |   7 +-
 t/t5502-quickfetch.sh                         |   9 +-
 t/t5503-tagfollow.sh                          |  15 +-
 t/t5504-fetch-receive-strict.sh               |  23 +-
 t/t5505-remote.sh                             | 151 +++---
 t/t5506-remote-groups.sh                      |   7 +-
 t/t5509-fetch-push-namespaces.sh              |  33 +-
 t/t5510-fetch.sh                              | 165 +++---
 t/t5511-refspec.sh                            |  12 +-
 t/t5512-ls-remote.sh                          |  29 +-
 t/t5514-fetch-multiple.sh                     |  33 +-
 t/t5516-fetch-push.sh                         | 503 +++++++++---------
 t/t5517-push-mirror.sh                        | 127 ++---
 t/t5518-fetch-exit-status.sh                  |   9 +-
 t/t5519-push-alternates.sh                    |  15 +-
 t/t5520-pull.sh                               |  33 +-
 t/t5521-pull-options.sh                       |  19 +-
 t/t5523-push-upstream.sh                      |  33 +-
 t/t5526-fetch-submodules.sh                   |   3 +
 t/t5527-fetch-odd-refs.sh                     |  17 +-
 t/t5528-push-default.sh                       | 101 ++--
 t/t5529-push-errors.sh                        |   2 +-
 t/t5530-upload-pack-error.sh                  |   2 +-
 t/t5531-deep-submodule-push.sh                | 191 +++----
 t/t5533-push-cas.sh                           | 145 ++---
 t/t5534-push-signed.sh                        |   7 +-
 t/t5537-fetch-shallow.sh                      |  33 +-
 t/t5538-push-shallow.sh                       |  25 +-
 t/t5539-fetch-http-shallow.sh                 |  17 +-
 t/t5540-http-push-webdav.sh                   |  11 +-
 t/t5541-http-push-smart.sh                    |  43 +-
 t/t5542-push-http-shallow.sh                  |  11 +-
 t/t5543-atomic-push.sh                        |  83 +--
 t/t5545-push-options.sh                       |  65 +--
 t/t5548-push-porcelain.sh                     |  64 +--
 t/t5550-http-fetch-dumb.sh                    |  23 +-
 t/t5551-http-fetch-smart.sh                   |  23 +-
 t/t5552-skipping-fetch-negotiator.sh          |   2 +-
 t/t5553-set-upstream.sh                       |  85 +--
 t/t5560-http-backend-noserver.sh              |   3 +
 t/t5561-http-backend.sh                       |   7 +-
 t/t556x_common                                |   8 +-
 t/t5570-git-daemon.sh                         |  19 +-
 t/t5571-pre-push-hook.sh                      |   7 +-
 t/t5572-pull-submodule.sh                     |   4 +-
 t/t5580-unc-paths.sh                          |   5 +-
 t/t5581-http-curl-verbose.sh                  |   5 +-
 t/t5582-fetch-negative-refspec.sh             |  25 +-
 t/t5601-clone.sh                              |   7 +-
 t/t5604-clone-reference.sh                    |  15 +-
 t/t5605-clone-local.sh                        |  13 +-
 t/t5606-clone-options.sh                      |  11 +-
 t/t5607-clone-bundle.sh                       |  17 +-
 t/t5608-clone-2gb.sh                          |   2 +-
 t/t5609-clone-branch.sh                       |   9 +-
 t/t5610-clone-detached.sh                     |   7 +-
 t/t5611-clone-config.sh                       |  19 +-
 t/t5612-clone-refspec.sh                      |  45 +-
 t/t5614-clone-submodules-shallow.sh           |   2 +-
 t/t5616-partial-clone.sh                      |  53 +-
 t/t5617-clone-submodules-remote.sh            |   9 +-
 t/t5700-protocol-v1.sh                        |  19 +-
 t/t5701-git-serve.sh                          |  19 +-
 t/t5702-protocol-v2.sh                        |  53 +-
 t/t5703-upload-pack-ref-in-want.sh            |  63 +--
 t/t5801-remote-helpers.sh                     |  27 +-
 t/t6000-rev-list-misc.sh                      |   5 +-
 t/t6001-rev-list-graft.sh                     |   5 +-
 t/t6004-rev-list-path-optim.sh                |  17 +-
 t/t6006-rev-list-format.sh                    |  17 +-
 t/t6007-rev-list-cherry-pick-file.sh          |   7 +-
 t/t6008-rev-list-submodule.sh                 |   5 +-
 t/t6009-rev-list-parent.sh                    |   9 +-
 t/t6012-rev-list-simplify.sh                  |  11 +-
 t/t6013-rev-list-reverse-parents.sh           |  13 +-
 t/t6016-rev-list-graph-simplify-history.sh    |   5 +-
 t/t6017-rev-list-stdin.sh                     |  11 +-
 t/t6018-rev-list-glob.sh                      |  53 +-
 t/t6019-rev-list-ancestry-path.sh             |   9 +-
 t/t6030-bisect-porcelain.sh                   |  13 +-
 t/t6040-tracking-info.sh                      |  57 +-
 t/t6050-replace.sh                            |  13 +-
 t/t6101-rev-parse-parents.sh                  |   5 +-
 t/t6110-rev-list-sparse.sh                    |   5 +-
 t/t6111-rev-list-treesame.sh                  |   9 +-
 t/t6112-rev-list-filters-objects.sh           |  17 +-
 t/t6120-describe.sh                           |  23 +-
 t/t6200-fmt-merge-msg.sh                      |  53 +-
 t/t6300-for-each-ref.sh                       |   3 +
 t/t6302-for-each-ref-filter.sh                |  61 ++-
 t/t6400-merge-df.sh                           |   9 +-
 t/t6402-merge-rename.sh                       |  49 +-
 t/t6404-recursive-merge.sh                    |   7 +-
 t/t6405-merge-symlinks.sh                     |  17 +-
 t/t6406-merge-attr.sh                         |  27 +-
 t/t6407-merge-binary.sh                       |   9 +-
 t/t6409-merge-subtree.sh                      |  19 +-
 t/t6411-merge-filemode.sh                     |  13 +-
 t/t6412-merge-large-rename.sh                 |   9 +-
 t/t6413-merge-crlf.sh                         |   5 +-
 t/t6414-merge-rename-nocruft.sh               |   5 +-
 t/t6415-merge-dir-to-symlink.sh               |  25 +-
 t/t6416-recursive-corner-cases.sh             |  31 +-
 t/t6417-merge-ours-theirs.sh                  |  31 +-
 t/t6418-merge-text-auto.sh                    |  15 +-
 t/t6419-merge-ignorecase.sh                   |  13 +-
 t/t6422-merge-rename-corner-cases.sh          |  15 +-
 t/t6425-merge-rename-delete.sh                |   5 +-
 t/t6427-diff3-conflict-markers.sh             |  17 +-
 t/t6430-merge-recursive.sh                    |  21 +-
 t/t6432-merge-recursive-space-options.sh      |   9 +-
 t/t6433-merge-toplevel.sh                     |  11 +-
 t/t6434-merge-recursive-rename-options.sh     |   9 +-
 t/t6436-merge-overwrite.sh                    |   5 +-
 t/t6437-submodule-merge.sh                    |  17 +-
 t/t6439-merge-co-error-msgs.sh                |   9 +-
 t/t6501-freshen-objects.sh                    |   5 +-
 t/t7003-filter-branch.sh                      |  43 +-
 t/t7004-tag.sh                                |  11 +-
 t/t7030-verify-tag.sh                         |   5 +-
 t/t7060-wtstatus.sh                           |  29 +-
 t/t7063-status-untracked-cache.sh             |  17 +-
 t/t7064-wtstatus-pv2.sh                       |   3 +
 t/t7102-reset.sh                              |   9 +-
 t/t7113-post-index-change-hook.sh             |   5 +-
 t/t7201-co.sh                                 | 113 ++--
 t/t7400-submodule-basic.sh                    |  23 +-
 t/t7403-submodule-sync.sh                     |  13 +-
 t/t7406-submodule-update.sh                   |  41 +-
 t/t7407-submodule-foreach.sh                  |  27 +-
 t/t7409-submodule-detached-work-tree.sh       |  11 +-
 t/t7417-submodule-path-url.sh                 |   5 +-
 t/t7501-commit-basic-functionality.sh         |   5 +-
 t/t7502-commit-porcelain.sh                   |  15 +-
 ...3-pre-commit-and-pre-merge-commit-hooks.sh |  45 +-
 t/t7504-commit-msg-hook.sh                    |  27 +-
 t/t7505-prepare-commit-msg-hook.sh            |  23 +-
 t/t7508-status.sh                             |  58 +-
 t/t7510-signed-commit.sh                      |   5 +-
 t/t7512-status-help.sh                        |  43 +-
 t/t7517-per-repo-email.sh                     |  15 +-
 t/t7600-merge.sh                              |  47 +-
 t/t7606-merge-custom.sh                       |   2 +-
 t/t7608-merge-messages.sh                     |  39 +-
 t/t7610-mergetool.sh                          | 177 +++---
 t/t7611-merge-abort.sh                        |   7 +-
 t/t7612-merge-verify-signatures.sh            |   5 +-
 t/t7614-merge-signoff.sh                      |  27 +-
 t/t7701-repack-unpack-unreachable.sh          |   5 +-
 t/t7800-difftool.sh                           |  41 +-
 t/t7810-grep.sh                               |  31 +-
 t/t8001-annotate.sh                           |   5 +-
 t/t8002-blame.sh                              |   3 +
 t/t8003-blame-corner-cases.sh                 |   7 +-
 t/t8004-blame-with-conflicts.sh               |  17 +-
 t/t8012-blame-colors.sh                       |   3 +
 t/t9001-send-email.sh                         |  31 +-
 t/t9100-git-svn-basic.sh                      |   5 +-
 t/t9145-git-svn-master-branch.sh              |   9 +-
 t/t9151-svn-mergeinfo.sh                      |   5 +-
 t/t9155-git-svn-fetch-deleted-tag.sh          |   5 +-
 t/t9156-git-svn-fetch-deleted-tag-2.sh        |   9 +-
 t/t9163-git-svn-reset-clears-caches.sh        |   5 +-
 t/t9169-git-svn-dcommit-crlf.sh               |   5 +-
 t/t9300-fast-import.sh                        |  85 +--
 t/t9301-fast-import-notes.sh                  |  17 +-
 t/t9302-fast-import-unpack-limit.sh           |  16 +-
 t/t9350-fast-export.sh                        |  89 ++--
 t/t9351-fast-export-anonymize.sh              |   7 +-
 t/t9400-git-cvsserver-server.sh               |  35 +-
 t/t9401-git-cvsserver-crlf.sh                 |  19 +-
 t/t9402-git-cvsserver-refs.sh                 |  11 +-
 t/t9500-gitweb-standalone-no-errors.sh        |  23 +-
 t/t9501-gitweb-standalone-http-status.sh      |  17 +-
 t/t9502-gitweb-standalone-parse-output.sh     |  19 +-
 t/t9600-cvsimport.sh                          |   5 +-
 t/t9601-cvsimport-vendor-branch.sh            |  19 +-
 t/t9602-cvsimport-branches-tags.sh            |   7 +-
 t/t9603-cvsimport-patchsets.sh                |  11 +-
 t/t9800-git-p4-basic.sh                       |   5 +-
 t/t9801-git-p4-branch.sh                      |  19 +-
 t/t9806-git-p4-options.sh                     |  21 +-
 t/t9807-git-p4-submit.sh                      |   5 +-
 t/t9811-git-p4-label-import.sh                |   5 +-
 t/t9902-completion.sh                         |   3 +
 t/t9903-bash-prompt.sh                        | 117 ++--
 355 files changed, 4835 insertions(+), 3861 deletions(-)


base-commit: aff20da3a209088e7f8f3632077fa11b86453d67
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-762%2Fdscho%2Fuse-main-as-default-branch-name-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-762/dscho/use-main-as-default-branch-name-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/762

Range-diff vs v2:

  -:  ---------- >  1:  e9ee22525a tests: mark tests relying on the current default for `init.defaultBranch`
  1:  0a05d319c0 =  2:  8c2e158c8f t0060: preemptively adjust alignment
  2:  b8fa037791 !  3:  9b7749dcde t[01]*: adjust the references to the default branch name "main"
     @@ Metadata
       ## Commit message ##
          t[01]*: adjust the references to the default branch name "main"
      
     -    This trick was performed via
     +    Carefully excluding t1309, which sees independent development elsewhere
     +    at the time of writing, we transition above-mentioned tests to the
     +    default branch name `main`. This trick was performed via
      
                  $ (cd t &&
                     sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
     -                    -e 's/Master/Main/g' -e 's/naster/nain/g' -- t[01]*.sh)
     +                    -e 's/Master/Main/g' -e 's/naster/nain/g' -- t[01]*.sh &&
     +               git checkout HEAD -- t1309\*)
      
          Note that t5533 contains a variation of the name `master` (`naster`)
          that we rename here, too.
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t0002-gitfile.sh ##
     +@@ t/t0002-gitfile.sh: test_description='.git file
     + 
     + Verify that plumbing commands work when .git is a file
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t0002-gitfile.sh: test_expect_success 'enter_repo non-strict mode' '
       	git ls-remote enter_repo >actual &&
       	cat >expected <<-EOF &&
     @@ t/t0002-gitfile.sh: test_expect_success 'enter_repo strict mode' '
       	test_cmp expected actual
      
       ## t/t0020-crlf.sh ##
     +@@
     + 
     + test_description='CRLF conversion'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t0020-crlf.sh: test_expect_success 'checkout with existing .gitattributes' '
       	git add .gitattributes .file &&
       	git commit -m second &&
     @@ t/t0020-crlf.sh: test_expect_success 'checkout when deleting .gitattributes' '
       '
      
       ## t/t0021-conversion.sh ##
     +@@
     + 
     + test_description='blob conversion via gitattributes'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t0021-conversion.sh: test_expect_success PERL 'required process filter should filter data' '
       		test_cmp_count expected.log debug.log &&
       
     @@ t/t0027-auto-crlf.sh: test_expect_success 'ls-files --eol -o Text/Binary' '
       	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nLINETWO\nLINETHREE"     >LF &&
      
       ## t/t0028-working-tree-encoding.sh ##
     +@@
     + 
     + test_description='working-tree-encoding conversion via gitattributes'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t0028-working-tree-encoding.sh: test_expect_success 'error if encoding round trip is not the same during refresh
       	TEST_HASH=$(git hash-object --no-filters -w nonsense.utf16le) &&
       	git update-index --add --cacheinfo 100644 $TEST_HASH nonsense.utf16le &&
     @@ t/t0028-working-tree-encoding.sh: test_expect_success 'error if encoding garbage
       	test_i18ngrep "error: BOM is required" err.out
      
       ## t/t0041-usage.sh ##
     +@@
     + 
     + test_description='Test commands behavior when given invalid argument value'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t0041-usage.sh: test_expect_success 'tag usage error' '
       '
       
     @@ t/t0041-usage.sh: test_expect_success 'for-each-ref --contains <inexistent_objec
       '
      
       ## t/t0050-filesystem.sh ##
     +@@
     + 
     + test_description='Various filesystem issues'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t0050-filesystem.sh: test_expect_success "setup case tests" '
       	git mv camelcase tmp &&
       	git mv tmp CamelCase &&
     @@ t/t0060-path-utils.sh: test_git_path GIT_COMMON_DIR=bar info/sparse-checkout
       test_git_path GIT_COMMON_DIR=bar config                   bar/config
      
       ## t/t0100-previous.sh ##
     +@@
     + 
     + test_description='previous branch syntax @{-n}'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t0100-previous.sh: test_expect_success 'branch -d @{-1}' '
       	test_commit A &&
       	git checkout -b junk &&
     @@ t/t0100-previous.sh: test_expect_success 'merge @{-1}~1' '
       
      
       ## t/t1004-read-tree-m-u-wf.sh ##
     +@@
     + 
     + test_description='read-tree -m -u checks working tree files'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1004-read-tree-m-u-wf.sh: test_expect_success 'two-way setup' '
       	git branch side &&
       	git tag -f branch-point &&
     @@ t/t1004-read-tree-m-u-wf.sh: test_expect_success 'three-way not complaining on a
       test_expect_success '3-way not overwriting local changes (setup)' '
      
       ## t/t1008-read-tree-overlay.sh ##
     +@@
     + 
     + test_description='test multi-tree read-tree without merging'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1008-read-tree-overlay.sh: test_expect_success setup '
       '
       
     @@ t/t1008-read-tree-overlay.sh: test_expect_success setup '
       	test_cmp expect actual
      
       ## t/t1009-read-tree-new-index.sh ##
     +@@
     + 
     + test_description='test read-tree into a fresh index file'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1009-read-tree-new-index.sh: test_expect_success setup '
       
       test_expect_success 'non-existent index file' '
     @@ t/t1011-read-tree-sparse-checkout.sh
       | M	init.t
      
       ## t/t1021-rerere-in-workdir.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='rerere run in a workdir'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1021-rerere-in-workdir.sh: test_expect_success SYMLINKS setup '
       	test_tick &&
       	git commit -a -m goodbye &&
     @@ t/t1021-rerere-in-workdir.sh: test_expect_success SYMLINKS setup '
       test_expect_success SYMLINKS 'rerere in workdir' '
      
       ## t/t1090-sparse-checkout-scope.sh ##
     +@@
     + 
     + test_description='sparse checkout scope tests'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1090-sparse-checkout-scope.sh: test_expect_success 'create feature branch' '
       	git commit -m "modification"
       '
     @@ t/t1090-sparse-checkout-scope.sh: test_expect_success 'merge feature branch into
       	test_path_is_file c &&
      
       ## t/t1091-sparse-checkout-builtin.sh ##
     +@@
     + 
     + test_description='sparse checkout builtin tests'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'interaction with clone --no-checkout (unborn index)' '
       	test_path_is_missing clone_no_checkout/.git/index &&
       
     @@ t/t1091-sparse-checkout-builtin.sh: test_expect_success 'interaction with clone
       '
      
       ## t/t1300-config.sh ##
     +@@
     + 
     + test_description='Test git config in different settings'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1300-config.sh: test_expect_success 'check split_cmdline return' "
       	echo foo > foo &&
       	git add foo &&
     @@ t/t1300-config.sh: test_expect_success '--show-origin blob' '
       
      
       ## t/t1301-shared-repo.sh ##
     +@@
     + 
     + test_description='Test shared repository initialization'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1301-shared-repo.sh: test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
       	umask 077 &&
       	git config core.sharedRepository group &&
     @@ t/t1305-config-include.sh: test_expect_success SYMLINKS 'conditional include, gi
       	git checkout -b foo-branch &&
       	echo 9 >expect &&
      
     - ## t/t1309-early-config.sh ##
     -@@ t/t1309-early-config.sh: test_expect_failure 'ignore .git/ with invalid config' '
     - 
     - test_expect_success 'early config and onbranch' '
     - 	echo "[broken" >broken &&
     --	test_with_config "[includeif \"onbranch:master\"]path=../broken"
     -+	test_with_config "[includeif \"onbranch:main\"]path=../broken"
     - '
     + ## t/t1400-update-ref.sh ##
     +@@
     + #
       
     - test_expect_success 'onbranch config outside of git repo' '
     --	test_config_global includeIf.onbranch:master.path non-existent &&
     -+	test_config_global includeIf.onbranch:main.path non-existent &&
     - 	nongit git help
     - '
     + test_description='Test git update-ref and basic ref logging'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       
     -
     - ## t/t1400-update-ref.sh ##
     -@@ t/t1400-update-ref.sh: test_description='Test git update-ref and basic ref logging'
     + . ./test-lib.sh
       
       Z=$ZERO_OID
       
     @@ t/t1402-check-ref-format.sh: test_expect_success 'check-ref-format --branch @{-1
       
      
       ## t/t1403-show-ref.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='show-ref'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1403-show-ref.sh: test_expect_success setup '
       	git checkout -b side &&
       	test_commit B &&
     @@ t/t1403-show-ref.sh: test_expect_success 'show-ref -d' '
       	done >expect.heads &&
      
       ## t/t1405-main-ref-store.sh ##
     +@@
     + 
     + test_description='test main ref store api'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1405-main-ref-store.sh: test_expect_success 'peel_ref(new-tag)' '
       	test_cmp expected actual
       '
     @@ t/t1405-main-ref-store.sh: test_expect_success 'for_each_reflog()' '
       
      
       ## t/t1406-submodule-ref-store.sh ##
     +@@
     + 
     + test_description='test submodule ref store api'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1406-submodule-ref-store.sh: test_expect_success 'setup' '
       	(
       		cd sub &&
     @@ t/t1406-submodule-ref-store.sh: test_expect_success 'for_each_reflog()' '
       
      
       ## t/t1407-worktree-ref-store.sh ##
     +@@
     + 
     + test_description='test worktree ref store api'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1407-worktree-ref-store.sh: RMAIN="test-tool ref-store worktree:main"
       
       test_expect_success 'setup' '
     @@ t/t1407-worktree-ref-store.sh: test_expect_success 'for_each_reflog()' '
       '
      
       ## t/t1408-packed-refs.sh ##
     +@@
     + 
     + test_description='packed-refs entries are covered by loose refs'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1408-packed-refs.sh: test_expect_success setup '
       	git commit --allow-empty -m one &&
       	one=$(git rev-parse HEAD) &&
     @@ t/t1408-packed-refs.sh: test_expect_success setup '
       '
      
       ## t/t1410-reflog.sh ##
     +@@
     + #
     + 
     + test_description='Test prune and reflog expiration'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1410-reflog.sh: test_expect_success setup '
       
       	check_fsck &&
     @@ t/t1410-reflog.sh: test_expect_success 'stale dirs do not cause d/f conflicts (r
       '
      
       ## t/t1411-reflog-show.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='Test reflog display routines'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1411-reflog-show.sh: test_expect_success 'git log -g -p shows diffs vs. parents' '
       '
       
     @@ t/t1411-reflog-show.sh: test_expect_success 'git log -g -p shows diffs vs. paren
       
      
       ## t/t1413-reflog-detach.sh ##
     -@@ t/t1413-reflog-detach.sh: test_description='Test reflog interaction with detached HEAD'
     +@@
     + #!/bin/sh
     + 
     + test_description='Test reflog interaction with detached HEAD'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
       . ./test-lib.sh
       
       reset_state () {
     @@ t/t1413-reflog-detach.sh: test_expect_success 'switch to branch' '
       	test_cmp expect actual
      
       ## t/t1414-reflog-walk.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='various tests of reflog walk (log -g) behavior'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1414-reflog-walk.sh: test_expect_success 'set up some reflog entries' '
       	test_commit two &&
       	git checkout -b side HEAD^ &&
     @@ t/t1414-reflog-walk.sh: test_expect_success 'walking multiple reflogs shows all'
       
      
       ## t/t1416-ref-transaction-hooks.sh ##
     +@@
     + 
     + test_description='reference transaction hooks'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook gets all queued updates in prepared state' '
       	EOF
       	cat >expect <<-EOF &&
     @@ t/t1416-ref-transaction-hooks.sh: test_expect_success 'hook gets all queued upda
       	test_cmp expect actual
      
       ## t/t1430-bad-ref-name.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='Test handling of ref names that check-ref-format rejects'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1430-bad-ref-name.sh: test_expect_success 'fast-import: fail on invalid branch name ".badbranchname"'
       		corrupt
       		COMMIT
     @@ t/t1450-fsck.sh
       . ./test-lib.sh
      
       ## t/t1500-rev-parse.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test git rev-parse'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1500-rev-parse.sh: test_expect_success 'showing the superproject correctly' '
       	test_commit -C super/dir/sub branch1_commit &&
       	git -C super add dir/sub &&
     @@ t/t1500-rev-parse.sh: test_expect_success 'showing the superproject correctly' '
       	test_commit -C super branch2_commit &&
      
       ## t/t1503-rev-parse-verify.sh ##
     +@@ t/t1503-rev-parse-verify.sh: test_description='test git rev-parse --verify'
     + 
     + exec </dev/null
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1503-rev-parse-verify.sh: test_expect_success 'works with one good rev' '
       	test "$rev_hash3" = "$HASH3" &&
       	rev_hash4=$(git rev-parse --verify $HASH4) &&
     @@ t/t1503-rev-parse-verify.sh: test_expect_success 'no stdout output on error' '
       test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
      
       ## t/t1505-rev-parse-last.sh ##
     +@@
     + 
     + test_description='test @{-N} syntax'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1505-rev-parse-last.sh: test_expect_success 'setup' '
       	make_commit 3 &&
       	git checkout side &&
     @@ t/t1505-rev-parse-last.sh: test_expect_success '@{-1}@{1} works' '
       test_expect_success '@{-3} fails' '
      
       ## t/t1506-rev-parse-diagnosis.sh ##
     +@@ t/t1506-rev-parse-diagnosis.sh: test_description='test git rev-parse diagnosis for invalid argument'
     + 
     + exec </dev/null
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1506-rev-parse-diagnosis.sh: test_expect_success 'incorrect file in :path and :N:path' '
       '
       
     @@ t/t1506-rev-parse-diagnosis.sh: test_expect_success 'incorrect file in :path and
       '
      
       ## t/t1507-rev-parse-upstream.sh ##
     +@@
     + 
     + test_description='test <branch>@{upstream} syntax'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1507-rev-parse-upstream.sh: test_expect_success 'setup' '
       	test_commit 1 &&
       	git checkout -b side &&
     @@ t/t1507-rev-parse-upstream.sh: test_expect_success 'log -g other@{u}@{now}' '
       	Date:   Thu Apr 7 15:15:13 2005 -0700
      
       ## t/t1508-at-combinations.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test various @{X} syntax combinations together'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1508-at-combinations.sh: fail() {
       }
       
     @@ t/t1508-at-combinations.sh: check "@{-1}@{1}" commit old-one
       check "@@/at-test" ref refs/heads/@@/at-test
      
       ## t/t1511-rev-parse-caret.sh ##
     +@@
     + 
     + test_description='tests for ref^{stuff}'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1511-rev-parse-caret.sh: test_expect_success 'setup' '
       	git commit -m Initial &&
       	git tag -a -m commit commit-tag &&
     @@ t/t1511-rev-parse-caret.sh: test_expect_success 'ref^{tag}' '
       
      
       ## t/t1512-rev-parse-disambiguation.sh ##
     +@@ t/t1512-rev-parse-disambiguation.sh: one tagged as v1.0.0.  They all have one regular file each.
     + 
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1512-rev-parse-disambiguation.sh: test_expect_success 'more history' '
       	side=$(git rev-parse HEAD) &&
       
     @@ t/t1512-rev-parse-disambiguation.sh: test_expect_success 'more history' '
       	# clean up a0blgqsjc as well.  If you use resolve, merge will
      
       ## t/t1513-rev-parse-prefix.sh ##
     +@@
     + 
     + test_description='Tests for rev-parse --prefix'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1513-rev-parse-prefix.sh: test_expect_success 'disambiguate path with valid prefix' '
       '
       
     @@ t/t1513-rev-parse-prefix.sh: test_expect_success 'disambiguate path with valid p
       	test_cmp expected actual
      
       ## t/t1514-rev-parse-push.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test <branch>@{push} syntax'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1514-rev-parse-push.sh: test_expect_success 'setup' '
       	git remote add other other.git &&
       	test_commit base &&
     @@ t/t1514-rev-parse-push.sh: test_expect_success 'setup' '
       test_expect_success 'triangular @{push} fails with default=simple' '
      
       ## t/t1700-split-index.sh ##
     +@@
     + 
     + test_description='split index mode tests'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t1700-split-index.sh: test_expect_success 'do not refresh null base index' '
       		test_commit initial &&
       		git checkout -b side-branch &&
     @@ t/t1700-split-index.sh: test_expect_success 'do not refresh null base index' '
       		git update-index --split-index &&
       		test_commit more &&
       		# must not write a new shareindex, or we wont catch the problem
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TRASH_DIRECTORY" in
     -  *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
     - esac
     - 
     -+case "$TEST_NUMBER" in
     -+[01]*)
     -+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     -+	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     -+	;;
     -+esac
     -+
     - # If --stress was passed, run this test repeatedly in several parallel loops.
     - if test "$GIT_TEST_STRESS_STARTED" = "done"
     - then
  3:  0d4f1275f7 !  4:  f5dbc0d5bb t2*: adjust the references to the default branch name "main"
     @@ Metadata
       ## Commit message ##
          t2*: adjust the references to the default branch name "main"
      
     -    This trick was performed via
     +    Carefully excluding t2106, which sees independent development elsewhere
     +    at the time of writing, we transition above-mentioned tests to the
     +    default branch name `main`. This trick was performed via
      
                  $ (cd t &&
                     sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
     -                    -e 's/Master/Main/g' -- t2*.sh)
     +                    -e 's/Master/Main/g' -- t2*.sh &&
     +               git checkout HEAD -- t2106\*)
      
          This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
          for those tests.
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t2007-checkout-symlink.sh ##
     +@@
     + 
     + test_description='git checkout to switch between branches with symlink<->dir'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2007-checkout-symlink.sh: test_expect_success setup '
       	echo hello >frotz/filfre &&
       	git add frotz/filfre &&
     @@ t/t2007-checkout-symlink.sh: test_expect_success setup '
       test_expect_success 'switch from dir to symlink' '
      
       ## t/t2009-checkout-statinfo.sh ##
     +@@
     + 
     + test_description='checkout should leave clean stat info'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2009-checkout-statinfo.sh: test_expect_success 'branch switching' '
       	git reset --hard &&
       	test "$(git diff-files --raw)" = "" &&
     @@ t/t2009-checkout-statinfo.sh: test_expect_success 'path checkout' '
       '
      
       ## t/t2010-checkout-ambiguous.sh ##
     +@@
     + 
     + test_description='checkout and pathspecs/refspecs ambiguities'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2010-checkout-ambiguous.sh: test_expect_success 'reference must be a tree' '
       '
       
     @@ t/t2010-checkout-ambiguous.sh: test_expect_success 'disambiguate checking out fr
       '
      
       ## t/t2011-checkout-invalid-head.sh ##
     +@@
     + 
     + test_description='checkout switching away from an invalid branch'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2011-checkout-invalid-head.sh: test_expect_success 'setup' '
       '
       
     @@ t/t2011-checkout-invalid-head.sh: test_expect_success 'pack refs' '
       test_done
      
       ## t/t2012-checkout-last.sh ##
     +@@
     + 
     + test_description='checkout can switch to last branch and merge base'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2012-checkout-last.sh: test_expect_success 'first branch switch' '
       
       test_expect_success '"checkout -" switches back' '
     @@ t/t2012-checkout-last.sh: test_expect_success 'merge base test setup' '
       test_done
      
       ## t/t2015-checkout-unborn.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='checkout from unborn branch'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2015-checkout-unborn.sh: test_expect_success 'setup' '
       	 git add file &&
       	 git commit -m base
     @@ t/t2015-checkout-unborn.sh: test_expect_success 'setup' '
       test_expect_success 'checkout from unborn preserves untracked files' '
      
       ## t/t2017-checkout-orphan.sh ##
     +@@ t/t2017-checkout-orphan.sh: test_description='git checkout --orphan
     + 
     + Main Tests for --orphan functionality.'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2017-checkout-orphan.sh: test_expect_success '--orphan creates a new orphan branch from HEAD' '
       	test_tick &&
       	git commit -m "Third Commit" &&
     @@ t/t2017-checkout-orphan.sh: test_expect_success '--orphan with -l makes reflog w
       '
      
       ## t/t2020-checkout-detach.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='checkout into detached HEAD state'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2020-checkout-detach.sh: check_no_orphan_warning() {
       }
       
     @@ t/t2020-checkout-detach.sh: test_expect_success 'describe_detached_head prints n
       	cat >1st_detach <<-EOF &&
      
       ## t/t2022-checkout-paths.sh ##
     -@@ t/t2022-checkout-paths.sh: test_description='checkout $tree -- $paths'
     +@@
     + #!/bin/sh
     + 
     + test_description='checkout $tree -- $paths'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
       
       test_expect_success setup '
       	mkdir dir &&
     @@ t/t2022-checkout-paths.sh: test_expect_success 'do not touch unmerged entries ma
       '
      
       ## t/t2023-checkout-m.sh ##
     +@@ t/t2023-checkout-m.sh: test_description='checkout -m -- <conflicted path>
     + 
     + Ensures that checkout -m on a resolved file restores the conflicted file'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2023-checkout-m.sh: test_expect_success setup '
       	test_tick &&
       	test_commit both.txt both.txt initial &&
     @@ t/t2024-checkout-dwim.sh: test_expect_success 'loosely defined local base branch
       	status_uno_is_clean &&
      
       ## t/t2027-checkout-track.sh ##
     +@@
     + 
     + test_description='tests for git branch --track'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2027-checkout-track.sh: test_expect_success 'setup' '
       '
       
     @@ t/t2027-checkout-track.sh: test_expect_success 'setup' '
       
      
       ## t/t2030-unresolve-info.sh ##
     +@@
     + 
     + test_description='undoing resolution'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2030-unresolve-info.sh: test_expect_success setup '
       	test_commit fourth fi/le fourth &&
       	git checkout add-add &&
     @@ t/t2030-unresolve-info.sh: test_expect_success 'rerere forget (binary)' '
       	test_must_fail git merge fifth &&
      
       ## t/t2060-switch.sh ##
     +@@
     + 
     + test_description='switch basic functionality'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2060-switch.sh: test_expect_success 'switch branch' '
       '
       
     @@ t/t2060-switch.sh: test_expect_success 'switching ignores file of same branch na
       	test_must_fail git switch foo &&
      
       ## t/t2070-restore.sh ##
     +@@
     + 
     + test_description='restore basic functionality'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2070-restore.sh: test_expect_success 'setup' '
       	echo ignored >ignored &&
       	echo /ignored >.gitignore &&
     @@ t/t2070-restore.sh: test_expect_success 'restore --ignore-unmerged ignores unmer
       		git commit -am second &&
       		test_must_fail git merge first &&
      
     - ## t/t2106-update-index-assume-unchanged.sh ##
     -@@ t/t2106-update-index-assume-unchanged.sh: test_expect_success 'do not switch branches with dirty file' \
     - 	 git checkout other &&
     - 	 echo dirt >file &&
     - 	 git update-index --assume-unchanged file &&
     --	 test_must_fail git checkout master'
     -+	 test_must_fail git checkout main'
     - 
     - test_done
     -
       ## t/t2400-worktree-add.sh ##
     +@@
     + 
     + test_description='test git worktree add'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2400-worktree-add.sh: test_expect_success 'setup' '
       
       test_expect_success '"add" an existing worktree' '
     @@ t/t2400-worktree-add.sh: test_branch_upstream () {
       			"refs/heads/*:refs/remotes/$1/*" &&
      
       ## t/t2401-worktree-prune.sh ##
     +@@
     + 
     + test_description='prune $GIT_DIR/worktrees'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2401-worktree-prune.sh: test_expect_success 'not prune recent checkouts' '
       
       test_expect_success 'not prune proper checkouts' '
     @@ t/t2401-worktree-prune.sh: test_expect_success 'not prune recent checkouts' '
       '
      
       ## t/t2402-worktree-list.sh ##
     +@@
     + 
     + test_description='test git worktree list'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2402-worktree-list.sh: test_expect_success 'rev-parse --git-common-dir on main worktree' '
       test_expect_success 'rev-parse --git-path objects linked worktree' '
       	echo "$(git rev-parse --show-toplevel)/.git/objects" >expect &&
     @@ t/t2402-worktree-list.sh: test_expect_success '"list" all worktrees --porcelain
       	git -C there worktree list >out &&
      
       ## t/t2405-worktree-submodule.sh ##
     +@@
     + 
     + test_description='Combination of submodules and multiple worktrees'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t2405-worktree-submodule.sh: test_expect_success 'add superproject worktree' '
       '
       
     @@ t/t2405-worktree-submodule.sh: test_expect_success 'add superproject worktree an
       	grep "file1 updated" out
       '
       
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TRASH_DIRECTORY" in
     - esac
     - 
     - case "$TEST_NUMBER" in
     --[01]*)
     -+[0-2]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
  4:  aee29a0528 !  5:  090ac6e9a1 t3[0-3]*: adjust the references to the default branch name "main"
     @@ Metadata
       ## Commit message ##
          t3[0-3]*: adjust the references to the default branch name "main"
      
     -    This trick was performed via
     +    Carefully excluding t3040, which sees independent development elsewhere
     +    at the time of writing, we transition above-mentioned tests to the
     +    default branch name `main`. This trick was performed via
      
                  $ (cd t &&
                     sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
     -                    -e 's/Master/Main/g' -- t3[0-3]*.sh t3206/*)
     +                    -e 's/Master/Main/g' -- t3[0-3]*.sh t3206/* &&
     +               git checkout HEAD -- t3040\*)
      
          This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
          for those tests.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## t/t3040-subprojects-basic.sh ##
     -@@ t/t3040-subprojects-basic.sh: test_expect_success 'checkout in superproject' '
     - '
     + ## t/t3200-branch.sh ##
     +@@
       
     - # just interesting what happened...
     --# git diff --name-status -M save master
     -+# git diff --name-status -M save main
     + test_description='git branch assorted tests'
       
     - test_done
     -
     - ## t/t3200-branch.sh ##
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3200-branch.sh: test_expect_success 'branch -h in broken repository' '
       	(
       		cd broken &&
     @@ t/t3200-branch.sh: test_expect_success 'option override configured sort' '
       	)
      
       ## t/t3201-branch-contains.sh ##
     +@@
     + 
     + test_description='branch --contains <commit>, --no-contains <commit> --merged, and --no-merged'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3201-branch-contains.sh: test_expect_success setup '
       
       	echo 1 >file &&
     @@ t/t3201-branch-contains.sh: test_expect_success 'branch --merged combined with -
       	EOF
      
       ## t/t3202-show-branch-octopus.sh ##
     +@@
     + 
     + test_description='test show-branch with more than 8 heads'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3202-show-branch-octopus.sh: test_expect_success 'setup' '
       
       	for i in $numbers
     @@ t/t3202-show-branch-octopus.sh: test_expect_success 'setup' '
       		test_tick &&
      
       ## t/t3203-branch-output.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git branch display tests'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3203-branch-output.sh: test_expect_success 'make remote branches' '
       cat >expect <<'EOF'
         branch-one
     @@ t/t3203-branch-output.sh: test_expect_success '--color overrides auto-color' '
       	  ambiguous                    $one one
      
       ## t/t3204-branch-name-interpretation.sh ##
     +@@ t/t3204-branch-name-interpretation.sh: Branch name arguments are usually names which are taken to be inside of
     + refs/heads/, but we interpret some magic syntax like @{-1}, @{upstream}, etc.
     + This script aims to check the behavior of those corner cases.
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3204-branch-name-interpretation.sh: test_expect_success 'update branch via @{-1}' '
       	git branch previous one &&
       
     @@ t/t3204-branch-name-interpretation.sh: test_expect_success 'disallow deleting re
       	expect_branch refs/remotes/origin/previous one &&
      
       ## t/t3205-branch-color.sh ##
     -@@ t/t3205-branch-color.sh: test_description='basic branch output coloring'
     +@@
     + #!/bin/sh
     + 
     + test_description='basic branch output coloring'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
       
       test_expect_success 'set up some sample branches' '
       	test_commit foo &&
     @@ t/t3205-branch-color.sh: test_expect_success 'set up some color config' '
       	test_decode_color <actual.raw >actual &&
      
       ## t/t3206-range-diff.sh ##
     +@@
     + 
     + test_description='range-diff tests'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3206-range-diff.sh: test_expect_success 'setup' '
       '
       
     @@ t/t3206/history.export: mark :11
       committer Thomas Rast <trast@inf.ethz.ch> 1374485127 +0200
      
       ## t/t3210-pack-refs.sh ##
     +@@ t/t3210-pack-refs.sh: test_description='git pack-refs should not change the branch semantic
     + This test runs git pack-refs and git show-ref and checks that the branch
     + semantic is still the same.
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3210-pack-refs.sh: test_expect_success 'delete ref with dangling packed version' '
       	git commit --allow-empty -m "future garbage" &&
       	git pack-refs --all &&
     @@ t/t3210-pack-refs.sh: test_expect_success 'retry acquiring packed-refs.lock' '
       	ln -s my-deviant-packed-refs .git/packed-refs &&
      
       ## t/t3211-peel-ref.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='tests for the peel_ref optimization of packed-refs'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3211-peel-ref.sh: print_ref() {
       
       test_expect_success 'set up expected show-ref output' '
     @@ t/t3301-notes.sh: test_expect_success 'git notes copy diagnoses too many or too
       
      
       ## t/t3302-notes-index-expensive.sh ##
     +@@
     + 
     + test_description='Test commit notes index (expensive!)'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3302-notes-index-expensive.sh: create_repo () {
       			notemark=$(($mark+1))
       			test_tick &&
     @@ t/t3302-notes-index-expensive.sh: create_repo () {
       			data <<COMMIT
      
       ## t/t3303-notes-subtrees.sh ##
     +@@
     + 
     + test_description='Test commit notes organized in subtrees'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3303-notes-subtrees.sh: test_expect_success "setup: create $number_of_commits commits" '
       			nr=$(($nr+1)) &&
       			test_tick &&
     @@ t/t3303-notes-subtrees.sh: test_concatenated_notes () {
       			second_note_path=$(echo "$sha1" | sed "$2")
      
       ## t/t3304-notes-mixed.sh ##
     +@@
     + 
     + test_description='Test notes trees that also contain non-notes'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3304-notes-mixed.sh: test_expect_success "setup: create a couple of commits" '
       
       	test_tick &&
     @@ t/t3308-notes-merge.sh: test_expect_success 'fail to merge into various non-note
       	test_must_fail git -c "core.notesRef=refs/notes/foo^{bar" notes merge x
      
       ## t/t3320-notes-merge-worktrees.sh ##
     +@@
     + 
     + test_description='Test merging of notes trees in multiple worktrees'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3320-notes-merge-worktrees.sh: test_expect_success 'modify notes ref ourselves (x)' '
       '
       
     @@ t/t3320-notes-merge-worktrees.sh: test_expect_success 'modify notes ref ourselve
       '
       
       test_expect_success 'merge z into y fails and sets NOTES_MERGE_REF' '
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TRASH_DIRECTORY" in
     - esac
     - 
     - case "$TEST_NUMBER" in
     --[0-2]*)
     -+[0-2]*|3[0-3]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
  5:  041ad86e33 !  6:  c8494f4602 t3416: preemptively adjust alignment in a comment
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t3416-rebase-onto-threedots.sh ##
     -@@ t/t3416-rebase-onto-threedots.sh: test_description='git rebase --onto A...B'
     +@@ t/t3416-rebase-onto-threedots.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       #
       #	    F---G topic                             G'
       #	   /                                       /
  6:  2f62b3f469 !  7:  c0d02e4d9d t34*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t3400-rebase.sh ##
     +@@ t/t3400-rebase.sh: test_description='git rebase assorted tests
     + This test runs git rebase and checks that the author information is not lost
     + among other things.
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3400-rebase.sh: test_expect_success 'prepare repository with topic branches' '
       	git update-index --add Y &&
       	git commit -m "Add Y." &&
     @@ t/t3400-rebase.sh: test_expect_success 'rebase -c rebase.useBuiltin=false warnin
       
      
       ## t/t3402-rebase-merge.sh ##
     +@@
     + 
     + test_description='git rebase --merge test'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3402-rebase-merge.sh: test_expect_success setup '
       	git commit -m"initial" &&
       	git branch side &&
     @@ t/t3402-rebase-merge.sh: test_expect_success '--reapply-cherry-picks refrains fr
       	git -C client rev-list --objects --all --missing=print >missing_list &&
      
       ## t/t3403-rebase-skip.sh ##
     +@@
     + 
     + test_description='git rebase --merge --skip tests'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3403-rebase-skip.sh: test_expect_success setup '
       	'
       
     @@ t/t3403-rebase-skip.sh: test_expect_success 'rebase moves back to skip-reference
       test_expect_success 'rebase --skip with --merge' '
      
       ## t/t3405-rebase-malformed.sh ##
     +@@
     + 
     + test_description='rebase should handle arbitrary git message'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3405-rebase-malformed.sh: test_expect_success setup '
       	git add file3 &&
       	git commit --allow-empty-message -m "" &&
     @@ t/t3405-rebase-malformed.sh: test_expect_success 'rebase commit with multi-line
       test_expect_success 'rebase -i commit with empty message' '
      
       ## t/t3406-rebase-message.sh ##
     +@@
     + 
     + test_description='messages from rebase operation'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3406-rebase-message.sh: test_expect_success 'setup' '
       '
       
     @@ t/t3406-rebase-message.sh: test_expect_success 'rebase -i onto unrelated history
       	test_i18ngrep "5 files changed" actual
      
       ## t/t3407-rebase-abort.sh ##
     +@@
     + 
     + test_description='git rebase --abort tests'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3407-rebase-abort.sh: testrebase() {
       		cd "$work_dir" &&
       		# Clean up the state from the previous one
     @@ t/t3407-rebase-abort.sh: test_expect_success 'rebase --merge --quit' '
       	git rebase --quit &&
      
       ## t/t3408-rebase-multi-line.sh ##
     +@@
     + 
     + test_description='rebasing a commit with multi-line first paragraph.'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3408-rebase-multi-line.sh: But otherwise with a sane description." side2 &&
       test_expect_success rebase '
       
     @@ t/t3408-rebase-multi-line.sh: But otherwise with a sane description." side2 &&
       	test_cmp expect actual
      
       ## t/t3409-rebase-preserve-merges.sh ##
     +@@ t/t3409-rebase-preserve-merges.sh: test_description='git rebase -p should preserve merges
     + 
     + Run "git rebase -p" and check that merges are properly carried along
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3409-rebase-preserve-merges.sh: export GIT_AUTHOR_EMAIL
       
       # Clone 2 (conflicting merge):
     @@ t/t3409-rebase-preserve-merges.sh: test_expect_success 'setup for merge-preservi
       	git clone ./. clone3 &&
      
       ## t/t3412-rebase-root.sh ##
     +@@ t/t3412-rebase-root.sh: test_description='git rebase --root
     + 
     + Tests if git rebase --root --onto <newparent> can rebase the root commit.
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3412-rebase-root.sh: test_expect_success 'prepare repository' '
       
       test_expect_success 'rebase --root fails with too many args' '
     @@ t/t3412-rebase-root.sh: EOF
       
      
       ## t/t3413-rebase-hook.sh ##
     +@@
     + 
     + test_description='git rebase with its hook(s)'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3413-rebase-hook.sh: test_expect_success setup '
       	git add git &&
       	test_tick &&
     @@ t/t3413-rebase-hook.sh: test_expect_success 'rebase --no-verify overrides pre-re
       '
      
       ## t/t3415-rebase-autosquash.sh ##
     +@@
     + 
     + test_description='auto squash'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3415-rebase-autosquash.sh: test_expect_success 'wrapped original subject' '
       
       test_expect_success 'abort last squash' '
     @@ t/t3415-rebase-autosquash.sh: test_expect_success 'wrapped original subject' '
       	git commit --allow-empty -m first &&
      
       ## t/t3416-rebase-onto-threedots.sh ##
     -@@ t/t3416-rebase-onto-threedots.sh: test_description='git rebase --onto A...B'
     +@@
     + 
     + test_description='git rebase --onto A...B'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
       . ./test-lib.sh
       . "$TEST_DIRECTORY/lib-rebase.sh"
       
     @@ t/t3416-rebase-onto-threedots.sh: test_expect_success 'rebase -i --keep-base mas
       test_done
      
       ## t/t3418-rebase-continue.sh ##
     +@@
     + 
     + test_description='git rebase --continue tests'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3418-rebase-continue.sh: test_expect_success 'setup' '
       	git checkout -b topic HEAD^ &&
       	test_commit "commit-new-file-F2-on-topic-branch" F2 22 &&
     @@ t/t3418-rebase-continue.sh: test_rerere_autoupdate () {
       		git add F2 &&
      
       ## t/t3419-rebase-patch-id.sh ##
     +@@
     + 
     + test_description='git rebase - test patch id computation'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3419-rebase-patch-id.sh: test_expect_success 'setup' '
       
       test_expect_success 'setup: 500 lines' '
     @@ t/t3419-rebase-patch-id.sh: test_expect_success 'setup attributes' '
       	git commit -q -m squashed &&
      
       ## t/t3420-rebase-autostash.sh ##
     +@@
     + #
     + 
     + test_description='git rebase --autostash tests'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3420-rebase-autostash.sh: test_expect_success setup '
       	git add . &&
       	test_tick &&
     @@ t/t3423-rebase-reword.sh: test_expect_success 'reword after a conflict preserves
       	git add file-2 &&
      
       ## t/t3427-rebase-subtree.sh ##
     +@@ t/t3427-rebase-subtree.sh: test_description='git rebase tests for -Xsubtree
     + 
     + This test runs git rebase and tests the subtree strategy.
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3427-rebase-subtree.sh: commit_message() {
       #
       # topic_1 - topic_2 - topic_3
     @@ t/t3430-rebase-merges.sh: Initial setup:
          \    \       /
           \    F - G                (second)
            \
     +       Conflicting-G
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3430-rebase-merges.sh: test_expect_success 'setup' '
       	git checkout -b first &&
       	test_commit B &&
     @@ t/t3430-rebase-merges.sh: test_expect_success 'labels that are object IDs are re
       	git commit -m "Merge commit '\''$third'\'' into labels" &&
      
       ## t/t3431-rebase-fork-point.sh ##
     -@@ t/t3431-rebase-fork-point.sh: test_description='git rebase --fork-point test'
     +@@
     + 
     + test_description='git rebase --fork-point test'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       
       . ./test-lib.sh
       
     @@ t/t3431-rebase-fork-point.sh: test_rebase 'G F C E D B A' --no-fork-point
       	git tag one &&
      
       ## t/t3432-rebase-fast-forward.sh ##
     +@@
     + 
     + test_description='ensure rebase fast-forwards commits when possible'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3432-rebase-fast-forward.sh: test_rebase_same_head_ () {
       
       changes='no changes'
     @@ t/t3434-rebase-i18n.sh: test_description='rebase with changing encoding
        \
         3 - 4            first
          \
     +     5 - 6          second
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3434-rebase-i18n.sh: test_expect_success 'rebase --rebase-merges update encoding eucJP to UTF-8' '
       	git config i18n.commitencoding eucJP &&
       	git merge -F "$TEST_DIRECTORY/t3434/eucJP.txt" second &&
     @@ t/t3434-rebase-i18n.sh: test_rebase_continue_update_encode () {
       		git add two.t &&
      
       ## t/t3435-rebase-gpg-sign.sh ##
     +@@
     + 
     + test_description='test rebase --[no-]gpg-sign'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3435-rebase-gpg-sign.sh: test_expect_success 'setup: merge commit' '
       	test_commit fork-point &&
       	git switch -c side &&
     @@ t/t3436-rebase-more-options.sh: test_expect_success 'setup' '
       	rm foo &&
       	test_write_lines "line 1" "        line 2" "line 3" >file &&
       	git commit -am "add file" &&
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TRASH_DIRECTORY" in
     - esac
     - 
     - case "$TEST_NUMBER" in
     --[0-2]*|3[0-3]*)
     -+3404)
     -+	# Avoid conflicts with patch series that are cooking at the same time
     -+	# as the patch series changing the default of `init.defaultBranch`.
     -+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     -+	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     -+	;;
     -+[0-2]*|3[0-4]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
  7:  0cf754646e !  8:  db3a104750 t3[5-9]*: adjust the references to the default branch name "main"
     @@ t/t3500-cherry.sh
      +This test cherry-picks one local change of two into main branch, and
       checks that git cherry only returns the second patch in the local branch
       '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
       . ./test-lib.sh
      @@ t/t3500-cherry.sh: test_expect_success \
            test_tick &&
     @@ t/t3500-cherry.sh: test_expect_success \
       test_expect_success 'cherry ignores whitespace' '
      
       ## t/t3501-revert-cherry-pick.sh ##
     +@@ t/t3501-revert-cherry-pick.sh: test_description='test cherry-pick and revert with renames
     + 
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick on unborn branch' '
       test_expect_success 'cherry-pick "-" to pick from previous branch' '
       	git checkout unborn &&
     @@ t/t3501-revert-cherry-pick.sh: test_expect_success 'cherry-pick "-" is meaningle
       	git cat-file commit HEAD | grep ^Signed-off-by: >signoff &&
      
       ## t/t3502-cherry-pick-merge.sh ##
     +@@ t/t3502-cherry-pick-merge.sh: test_description='cherry picking and reverting a merge
     + 
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3502-cherry-pick-merge.sh: test_expect_success setup '
       	echo new line >B &&
       	git commit -m "add line to B" B &&
     @@ t/t3502-cherry-pick-merge.sh: test_expect_success setup '
       
      
       ## t/t3503-cherry-pick-root.sh ##
     +@@
     + 
     + test_description='test cherry-picking (and reverting) a root commit'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3503-cherry-pick-root.sh: test_expect_success setup '
       test_expect_success 'cherry-pick a root commit' '
       
     @@ t/t3503-cherry-pick-root.sh: test_expect_success 'cherry-pick two root commits'
       	test_cmp expect.file2 file2 &&
      
       ## t/t3504-cherry-pick-rerere.sh ##
     -@@ t/t3504-cherry-pick-rerere.sh: test_description='cherry-pick should rerere for conflicts'
     +@@
     + 
     + test_description='cherry-pick should rerere for conflicts'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
       
       test_expect_success setup '
       	test_commit foo &&
     @@ t/t3504-cherry-pick-rerere.sh: test_expect_success 'cherry-pick --continue rejec
       test_done
      
       ## t/t3505-cherry-pick-empty.sh ##
     +@@
     + 
     + test_description='test cherry-picking an empty commit'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3505-cherry-pick-empty.sh: test_expect_success setup '
       	test_tick &&
       	git commit --allow-empty-message -m "" &&
     @@ t/t3505-cherry-pick-empty.sh: test_expect_success 'cherry-pick a commit that bec
       
      
       ## t/t3506-cherry-pick-ff.sh ##
     +@@
     + 
     + test_description='test cherry-picking with --ff option'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3506-cherry-pick-ff.sh: test_expect_success setup '
       '
       
     @@ t/t3506-cherry-pick-ff.sh: test_expect_success 'merge setup' '
       	git checkout -b new A
      
       ## t/t3507-cherry-pick-conflict.sh ##
     +@@ t/t3507-cherry-pick-conflict.sh: test_description='test cherry-pick and revert with conflicts
     + 
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3507-cherry-pick-conflict.sh: test_expect_success setup '
       	test_commit redundant-pick foo c redundant &&
       	git commit --allow-empty --allow-empty-message &&
     @@ t/t3507-cherry-pick-conflict.sh: test_expect_success setup '
       '
      
       ## t/t3508-cherry-pick-many-commits.sh ##
     +@@
     + 
     + test_description='test cherry-picking many commits'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3508-cherry-pick-many-commits.sh: test_expect_success setup '
       '
       
     @@ t/t3508-cherry-pick-many-commits.sh: test_expect_success 'cherry-pick -3 fourth
       	git rev-list --reverse first..fourth | git cherry-pick --stdin &&
      
       ## t/t3509-cherry-pick-merge-df.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='Test cherry-pick with directory/file conflicts'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3509-cherry-pick-merge-df.sh: test_expect_success 'Setup rename across paths each below D/F conflicts' '
       
       test_expect_success 'Cherry-pick succeeds with rename across D/F conflicts' '
     @@ t/t3509-cherry-pick-merge-df.sh: test_expect_success 'Setup rename across paths
       
      
       ## t/t3512-cherry-pick-submodule.sh ##
     +@@
     + 
     + test_description='cherry-pick can handle submodules'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3512-cherry-pick-submodule.sh: test_expect_success 'unrelated submodule/file conflict is ignored' '
       		git add a_file &&
       		git commit -m "modify a file" &&
     @@ t/t3512-cherry-pick-submodule.sh: test_expect_success 'unrelated submodule/file
       		git submodule update sub &&
      
       ## t/t3600-rm.sh ##
     +@@
     + 
     + test_description='Test of the various options to git rm.'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3600-rm.sh: test_expect_success 'setup submodule conflict' '
       	echo 1 >nitfol &&
       	git add nitfol &&
     @@ t/t3600-rm.sh: test_expect_success 'checking out a commit after submodule remova
       	echo "?? submod/" >expected &&
      
       ## t/t3701-add-interactive.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='add -i basic tests'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3701-add-interactive.sh: test_expect_success 'patch mode ignores unmerged entries' '
       	test_commit non-conflict &&
       	git checkout -b side &&
     @@ t/t3701-add-interactive.sh: test_expect_success 'patch mode ignores unmerged ent
       	echo y | git add -p >output &&
      
       ## t/t3901-i18n-patch.sh ##
     +@@
     + 
     + test_description='i18n settings and format-patch | am pipe'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3901-i18n-patch.sh: test_expect_success setup '
       
       	# the first commit on the side branch is UTF-8
     @@ t/t3901-i18n-patch.sh: test_expect_success !MINGW 'am (L/U)' '
       	git am out-u1 out-u2 &&
      
       ## t/t3903-stash.sh ##
     +@@
     + 
     + test_description='Test git stash'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3903-stash.sh: test_expect_success 'stash branch' '
       	git commit file -m second &&
       	git stash branch stashbranch &&
     @@ t/t3903-stash.sh: test_expect_success 'create with multiple arguments for the me
       	git add foo &&
      
       ## t/t3910-mac-os-precompose.sh ##
     +@@
     + 
     + test_description='utf-8 decomposed (nfd) converted to precomposed (nfc)'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t3910-mac-os-precompose.sh: test_expect_success "git checkout link nfd" '
       	git checkout l.$Odiarnfd
       '
     @@ t/t3910-mac-os-precompose.sh: test_expect_success "Add long decomposed filename"
       	git reset --hard &&
       	git checkout -b mac_os_long_nfc_fn
       '
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TEST_NUMBER" in
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-2]*|3[0-4]*)
     -+[0-3]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
  8:  cf6c1d1d83 !  9:  0164eb9745 t4*: adjust the references to the default branch name "main"
     @@ Metadata
       ## Commit message ##
          t4*: adjust the references to the default branch name "main"
      
     -    Carefully excluding t4013, which sees independent development elsewhere
     -    at the time of writing, we use `main` as the default branch name in t4*.
     -    This trick was performed via
     +    Carefully excluding t4013 and t4015, which see independent development
     +    elsewhere at the time of writing, we use `main` as the default branch
     +    name in t4*. This trick was performed via
      
                  $ (cd t &&
                     sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t4014-format-patch.sh ##
     +@@
     + 
     + test_description='various format-patch tests'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4014-format-patch.sh: test_expect_success setup '
       	test_tick &&
       	git commit -m "Side changes #3 with \\n backslash-n in it." &&
     @@ t/t4014-format-patch.sh: test_expect_success 'format-patch --pretty=mboxrd' '
       	test_commit fleep blorp
       '
      
     - ## t/t4015-diff-whitespace.sh ##
     -@@ t/t4015-diff-whitespace.sh: test_expect_success 'combined diff with autocrlf conversion' '
     - 	echo >x goodbye &&
     - 	git commit -m "the other side" x &&
     - 	git config core.autocrlf true &&
     --	test_must_fail git merge master &&
     -+	test_must_fail git merge main &&
     - 
     - 	git diff >actual.raw &&
     - 	sed -e "1,/^@@@/d" actual.raw >actual &&
     -
       ## t/t4017-diff-retval.sh ##
     +@@
     + 
     + test_description='Return value of diffs'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4017-diff-retval.sh: test_expect_success 'check detects leftover conflict markers' '
       	git checkout HEAD^ &&
       	echo binary >>b &&
     @@ t/t4017-diff-retval.sh: test_expect_success 'check detects leftover conflict mar
       	test 3 = $(grep "conflict marker" test.out | wc -l) &&
      
       ## t/t4038-diff-combined.sh ##
     +@@
     + 
     + test_description='combined diff'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4038-diff-combined.sh: test_expect_success 'check --cc --raw with forty trees' '
       '
       
     @@ t/t4038-diff-combined.sh: test_expect_success 'combine diff gets tree sorting ri
       	printf "MM\tfoo\n" >expect &&
      
       ## t/t4041-diff-submodule-option.sh ##
     +@@ t/t4041-diff-submodule-option.sh: test_description='Support for verbose submodule differences in git diff
     + This test tries to verify the sanity of the --submodule option of git diff.
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4041-diff-submodule-option.sh: test_expect_success 'diff --submodule with objects referenced by alternates' '
       	(cd super &&
       		(cd sub &&
     @@ t/t4041-diff-submodule-option.sh: test_expect_success 'diff --submodule with obj
       	) &&
      
       ## t/t4048-diff-combined-binary.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='combined and merge diff handle binary files and textconv'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4048-diff-combined-binary.sh: test_expect_success 'setup binary merge conflict' '
       	echo threeQ3 | q_to_nul >binary &&
       	git commit -a -m three &&
     @@ t/t4048-diff-combined-binary.sh: index $three,$two..0000000
       '
      
       ## t/t4052-stat-output.sh ##
     +@@
     + 
     + test_description='test --stat output of various commands'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4052-stat-output.sh: cat >expect <<'EOF'
       EOF
       test_expect_success 'merge --stat respects COLUMNS (big change)' '
     @@ t/t4052-stat-output.sh: cat >expect <<'EOF'
       '
      
       ## t/t4056-diff-order.sh ##
     +@@
     + 
     + test_description='diff order'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4056-diff-order.sh: done
       test_expect_success 'setup for testing combine-diff order' '
       	git checkout -b tmp HEAD~ &&
     @@ t/t4056-diff-order.sh: done
       '
      
       ## t/t4057-diff-combined-paths.sh ##
     +@@
     + 
     + test_description='combined diff show only paths that are different to all parents'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4057-diff-combined-paths.sh: test_expect_success 'trivial merge - combine-diff empty' '
       		echo $i/2 >>$i.txt
       	done &&
     @@ t/t4057-diff-combined-paths.sh: test_expect_success 'merge removed a file' '
       	git commit --amend &&
      
       ## t/t4061-diff-indent.sh ##
     +@@
     + test_description='Test diff indent heuristic.
     + 
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4061-diff-indent.sh: test_expect_success 'diff-index: nice spaces with --indent-heuristic' '
       	git reset --soft HEAD~ &&
       	git diff-index --indent-heuristic -p old -- spaces.txt >out-diff-index-compacted &&
     @@ t/t4061-diff-indent.sh: test_expect_success 'diff-files: --no-indent-heuristic o
       test_done
      
       ## t/t4066-diff-emit-delay.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test combined/stat/moved interaction'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4066-diff-emit-delay.sh: test_expect_success 'set up history with a merge' '
       	test_commit B &&
       	git checkout -b side HEAD^ &&
     @@ t/t4066-diff-emit-delay.sh: test_expect_success 'set up history with a merge' '
       
      
       ## t/t4068-diff-symmetric-merge-base.sh ##
     -@@ t/t4068-diff-symmetric-merge-base.sh: test_description='behavior of diff with symmetric-diff setups and --merge-base'
     +@@
     + 
     + test_description='behavior of diff with symmetric-diff setups and --merge-base'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
       
       # build these situations:
       #  - normal merge with one merge base (br1...b2r);
     @@ t/t4068-diff-symmetric-merge-base.sh: do
       
      
       ## t/t4103-apply-binary.sh ##
     +@@
     + test_description='git apply handling binary patches
     + 
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4103-apply-binary.sh: test_expect_success 'setup' '
       	git update-index --add --remove file1 file2 file3 file4 &&
       	git commit -m "Second Version" &&
     @@ t/t4103-apply-binary.sh: test_expect_success 'check binary diff with replacement
       test_expect_success 'apply binary diff -- should fail.' \
      
       ## t/t4108-apply-threeway.sh ##
     +@@
     + 
     + test_description='git apply --3way'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4108-apply-threeway.sh: test_expect_success setup '
       	test_tick &&
       	test_write_lines 1 two 3 4 5 six 7 >one &&
     @@ t/t4108-apply-threeway.sh: test_expect_success 'apply with --3way with rerere en
       	# but rerere should have replayed the recorded resolution
      
       ## t/t4121-apply-diffs.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git apply for contextually independent diffs'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4121-apply-diffs.sh: test_expect_success 'setup' \
       	git commit -a -q -m 2 &&
       	echo 9 >>file &&
     @@ t/t4121-apply-diffs.sh: test_expect_success 'setup' \
       	'check if contextually independent diffs for the same file apply' \
      
       ## t/t4122-apply-symlink-inside.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='apply to deeper directory without getting fooled with symlink'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4122-apply-symlink-inside.sh: test_expect_success apply '
       
       test_expect_success 'check result' '
     @@ t/t4122-apply-symlink-inside.sh: test_expect_success apply '
       
      
       ## t/t4150-am.sh ##
     +@@
     + 
     + test_description='git am running'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4150-am.sh: test_expect_success setup '
       	test_tick &&
       	git commit -m "added another file" &&
     @@ t/t4200-rerere.sh: test_description='git rerere
      +++++++ [main] initial
       '
       
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
       . ./test-lib.sh
      @@ t/t4200-rerere.sh: test_expect_success 'setup' '
       	test_tick &&
     @@ t/t4200-rerere.sh: test_expect_success 'setup simple stage 1 handling' '
       	)
      
       ## t/t4201-shortlog.sh ##
     +@@
     + test_description='git shortlog
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4201-shortlog.sh: test_expect_success 'shortlog with revision pseudo options' '
       '
       
     @@ t/t4201-shortlog.sh: test_expect_success 'shortlog with revision pseudo options'
       '
      
       ## t/t4202-log.sh ##
     +@@
     + 
     + test_description='git log'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4202-log.sh: test_expect_success 'set up merge history' '
       	git checkout -b side HEAD~4 &&
       	test_commit side-1 1 1 &&
     @@ t/t4202-log.sh: test_expect_success 'log diagnoses bogus HEAD' '
       	echo "ref: refs/heads/invalid.lock" >empty/.git/HEAD &&
      
       ## t/t4203-mailmap.sh ##
     +@@
     + 
     + test_description='.mailmap configurations'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4203-mailmap.sh: test_expect_success 'No mailmap files, but configured' '
       
       test_expect_success 'setup mailmap blob tests' '
     @@ t/t4203-mailmap.sh: test_expect_success 'No mailmap files, but configured' '
       	EOF
      
       ## t/t4204-patch-id.sh ##
     +@@
     + 
     + test_description='git patch-id'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4204-patch-id.sh: test_expect_success 'setup' '
       	test_write_lines $as b >foo &&
       	test_write_lines $as b >bar &&
     @@ t/t4204-patch-id.sh: test_expect_success '--stable overrides patchid.stable = fa
       test_expect_success 'patch-id respects config from subdir' '
      
       ## t/t4207-log-decoration-colors.sh ##
     +@@
     + 
     + test_description='Test for "git log --decorate" colors'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4207-log-decoration-colors.sh: test_expect_success setup '
       
       cat >expected <<EOF
     @@ t/t4207-log-decoration-colors.sh: test_expect_success setup '
       
      
       ## t/t4208-log-magic-pathspec.sh ##
     +@@
     + 
     + test_description='magic pathspec tests using git-log'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4208-log-magic-pathspec.sh: test_expect_success '"git log :/a -- " should not be ambiguous' '
       '
       
     @@ t/t4208-log-magic-pathspec.sh: test_expect_success 'command line pathspec parsin
       	git log --merge -- a
       '
      
     + ## t/t4211-line-log.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test log -L'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
     +
       ## t/t4211/history.export ##
      @@ t/t4211/history.export: long f(long x)
       	return s;
     @@ t/t4211/history.export: long f(long x)
       committer Thomas Rast <trast@student.ethz.ch> 1362045024 +0100
      
       ## t/t4214-log-graph-octopus.sh ##
     +@@
     + 
     + test_description='git log --graph of skewed left octopus merge.'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4214-log-graph-octopus.sh: test_cmp_colored_graph () {
       test_expect_success 'set up merge history' '
       	test_commit initial &&
     @@ t/t4214-log-graph-octopus.sh: test_cmp_colored_graph () {
       		test_commit $i $i $i tag$i || return $?
      
       ## t/t4216-log-bloom.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git log for a path with Bloom filters'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4216-log-bloom.sh: test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
       	test_commit c10 file_to_be_deleted &&
       	git checkout -b side HEAD~4 &&
     @@ t/t4216-log-bloom.sh: do
       			test_bloom_filters_used "$option -- $path" &&
      
       ## t/t4253-am-keep-cr-dos.sh ##
     +@@
     + test_description='git-am mbox with dos line ending.
     + 
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t4253-am-keep-cr-dos.sh: test_expect_success 'setup repository with dos files' '
       
       test_expect_success 'am with dos files without --keep-cr' '
     @@ t/t4257-am-interactive.sh: test_expect_success 'set up patches to apply' '
       '
       
       # Sanity check our setup.
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TRASH_DIRECTORY" in
     - esac
     - 
     - case "$TEST_NUMBER" in
     --3404)
     -+3404|4013)
     - 	# Avoid conflicts with patch series that are cooking at the same time
     - 	# as the patch series changing the default of `init.defaultBranch`.
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-3]*)
     -+[0-4]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
  9:  6ff4594a28 = 10:  36d633a5ec t5323: prepare centered comment for `master` -> `main`
 10:  be29e07892 ! 11:  d9d1d14681 t5[0-4]*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t5150-request-pull.sh ##
     +@@
     + 
     + test_description='Test workflows involving pull request.'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5150-request-pull.sh: test_expect_success 'setup' '
       		test_tick &&
       		git commit -m "\"Thirty days\", a reminder of month lengths" &&
     @@ t/t5150-request-pull.sh: test_expect_success 'pull request with stale object' '
       		test_must_fail git request-pull initial "$downstream_url" tags/full \
      
       ## t/t5304-prune.sh ##
     +@@
     + #
     + 
     + test_description='prune'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5304-prune.sh: test_expect_success 'prune: do not prune detached HEAD with no reflog' '
       test_expect_success 'prune: prune former HEAD after checking out branch' '
       
     @@ t/t5304-prune.sh: test_expect_success 'prune: do not prune detached HEAD with no
       
      
       ## t/t5305-include-tag.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git pack-object --include-tag'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5305-include-tag.sh: test_expect_success 'check unpacked result (have all objects)' '
       
       test_expect_success 'single-branch clone can transfer tag' '
     @@ t/t5305-include-tag.sh: test_expect_success 'check unpacked result (have all obj
       
      
       ## t/t5312-prune-corruption.sh ##
     +@@ t/t5312-prune-corruption.sh: bail out or to proceed using it as a reachable tip, but it is _not_
     + OK to proceed as if it did not exist. Otherwise we might silently
     + delete objects that cannot be recovered.
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5312-prune-corruption.sh: test_expect_success 'disable reflogs' '
       '
       
     @@ t/t5312-prune-corruption.sh: test_expect_success 'pack-refs does not silently de
       
      
       ## t/t5317-pack-objects-filter-objects.sh ##
     +@@
     + 
     + test_description='git pack-objects using object filtering'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5317-pack-objects-filter-objects.sh: test_expect_success 'verify sparse:oid=oid-ish' '
       	awk -f print_2.awk ls_files_result |
       	sort >expected &&
     @@ t/t5317-pack-objects-filter-objects.sh: test_expect_success 'verify sparse:oid=o
       	git -C r4 index-pack ../filter.pack &&
      
       ## t/t5322-pack-objects-sparse.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='pack-objects object selection using sparse algorithm'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5322-pack-objects-sparse.sh: test_expect_success 'setup repo' '
       	git commit -m "Initialized trees" &&
       	for i in $(test_seq 1 3)
     @@ t/t5323-pack-redundant.sh: test_expect_success 'shared: one pack is redundant wi
       #     P1  | x x x x x x x                       x                   |
      
       ## t/t5400-send-pack.sh ##
     +@@
     + test_description='See why rewinding head breaks send-pack
     + 
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5400-send-pack.sh: test_expect_success 'pack the destination repository' '
       '
       
     @@ t/t5401-update-hooks.sh: test_expect_success 'pre-receive hook that forgets to r
       '
      
       ## t/t5402-post-merge-hook.sh ##
     +@@
     + #
     + 
     + test_description='Test the post-merge hook.'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5402-post-merge-hook.sh: test_expect_success setup '
       	git update-index a &&
       	tree1=$(git write-tree) &&
     @@ t/t5402-post-merge-hook.sh: test_expect_success setup '
       	git clone ./. clone2 &&
      
       ## t/t5403-post-checkout-hook.sh ##
     +@@
     + #
     + 
     + test_description='Test the post-checkout hook.'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5403-post-checkout-hook.sh: test_expect_success setup '
       
       test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
     @@ t/t5403-post-checkout-hook.sh: test_expect_success 'post-checkout receives the r
       	read old new flag <.git/post-checkout.args &&
      
       ## t/t5404-tracking-branches.sh ##
     +@@
     + 
     + test_description='tracking branch update checks for git push'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5404-tracking-branches.sh: test_expect_success 'prepare pushable branches' '
       	git checkout -b b2 origin/b2 &&
       	echo aa-b2 >>file &&
     @@ t/t5404-tracking-branches.sh: test_expect_success 'mixed-success push returns er
       test_expect_success 'check tracking branches not updated for failed refs' '
      
       ## t/t5405-send-pack-rewind.sh ##
     +@@
     + 
     + test_description='forced push to replace commit we do not have'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5405-send-pack-rewind.sh: test_expect_success setup '
       	mkdir another && (
       		cd another &&
     @@ t/t5405-send-pack-rewind.sh: test_expect_success 'forced push should succeed' '
       '
      
       ## t/t5407-post-rewrite-hook.sh ##
     +@@
     + #
     + 
     + test_description='Test the post-rewrite hook.'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5407-post-rewrite-hook.sh: test_expect_success 'setup' '
       	git checkout A^0 &&
       	test_commit E bar E &&
     @@ t/t5407-post-rewrite-hook.sh: test_expect_success 'setup' '
       mkdir .git/hooks
      
       ## t/t5410-receive-pack-alternates.sh ##
     -@@ t/t5410-receive-pack-alternates.sh: test_description='git receive-pack with alternate ref filtering'
     +@@
     + 
     + test_description='git receive-pack with alternate ref filtering'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
     +@@ t/t5410-receive-pack-alternates.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       test_expect_success 'setup' '
       	test_commit base &&
       	git clone -s --bare . fork &&
     @@ t/t5410-receive-pack-alternates.sh: test_description='git receive-pack with alte
       	test_commit private
       '
       
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TRASH_DIRECTORY" in
     - esac
     - 
     - case "$TEST_NUMBER" in
     --3404|4013)
     -+3404|4013|5310)
     - 	# Avoid conflicts with patch series that are cooking at the same time
     - 	# as the patch series changing the default of `init.defaultBranch`.
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-4]*)
     -+[0-4]*|5[0-4]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 11:  5126d90a32 ! 12:  f7a9bc07c7 t5503: prepare aligned comment for replacing `master` with `main`
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t5503-tagfollow.sh ##
     -@@ t/t5503-tagfollow.sh: test_description='test automatic tag following'
     +@@ t/t5503-tagfollow.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       #   L - A ------ O ------ B
       #    \   \                 \
       #     \   C - origin/cat    \
 12:  332677cbf9 ! 13:  4d7eb7dc28 t550*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t5500-fetch-pack.sh ##
     +@@
     + 
     + test_description='Testing multi_ack pack fetching'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5500-fetch-pack.sh: test_expect_success 'in_vain resetted upon ACK' '
       	rm -rf myserver myclient &&
       	git init myserver &&
     @@ t/t5500-fetch-pack.sh: test_expect_success 'fetching deepen' '
       	three
      
       ## t/t5501-fetch-push-alternates.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='fetch/push involving alternates'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5501-fetch-push-alternates.sh: test_expect_success setup '
       test_expect_success 'pushing into a repository with the same alternate' '
       	(
     @@ t/t5501-fetch-push-alternates.sh: test_expect_success 'pushing into a repository
       	test_cmp one.count fetcher.count
      
       ## t/t5502-quickfetch.sh ##
     +@@
     + 
     + test_description='test quickfetch from local'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5502-quickfetch.sh: test_expect_success 'quickfetch should not copy from alternate' '
       				q
       			}"
     @@ t/t5502-quickfetch.sh: test_expect_success 'quickfetch should not copy from alte
       
      
       ## t/t5503-tagfollow.sh ##
     -@@ t/t5503-tagfollow.sh: test_description='test automatic tag following'
     +@@
     + 
     + test_description='test automatic tag following'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
     +@@ t/t5503-tagfollow.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       #   L - A ------ O ------ B
       #    \   \                 \
       #     \   C - origin/cat    \
     @@ t/t5503-tagfollow.sh: test_expect_success 'new clone fetch master and tags' '
       		test $T = $(git rev-parse --verify tag1) &&
      
       ## t/t5504-fetch-receive-strict.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='fetch/receive strict mode'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5504-fetch-receive-strict.sh: test_expect_success 'fetch without strict' '
       		cd dst &&
       		git config fetch.fsckobjects false &&
     @@ t/t5504-fetch-receive-strict.sh: test_expect_success 'push with transfer.fsckobj
       
      
       ## t/t5505-remote.sh ##
     +@@
     + 
     + test_description='git remote porcelain-ish'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5505-remote.sh: setup_repository () {
       	git add elif &&
       	test_tick &&
     @@ t/t5505-remote.sh: test_expect_success 'unqualified <dst> refspec DWIM and advic
       	) &&
      
       ## t/t5506-remote-groups.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git remote group handling'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5506-remote-groups.sh: repo_fetched() {
       test_expect_success 'setup' '
       	mkdir one && (cd one && git init) &&
     @@ t/t5506-remote-groups.sh: repo_fetched() {
       test_expect_success 'no group updates all' '
      
       ## t/t5509-fetch-push-namespaces.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='fetch/push involving ref namespaces'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5509-fetch-push-namespaces.sh: test_expect_success setup '
       test_expect_success 'pushing into a repository using a ref namespace' '
       	(
     @@ t/t5509-fetch-push-namespaces.sh: test_expect_success 'denyCurrentBranch and unb
       	)
       '
       
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TEST_NUMBER" in
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-4]*|5[0-4]*)
     -+[0-4]*|5[0-4]*|550*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 13:  b7333ef201 ! 14:  88b2c30cc8 t551*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t5510-fetch.sh ##
     +@@ t/t5510-fetch.sh: test_description='Per branch config variables affects "git fetch".
     + 
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5510-fetch.sh: test_expect_success "clone and setup child repos" '
       	git clone . two &&
       	(
     @@ t/t5511-refspec.sh: test_refspec push 'refs/heads/master:refs/remotes/frotz/xyzz
       
      
       ## t/t5512-ls-remote.sh ##
     +@@
     + 
     + test_description='git ls-remote'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5512-ls-remote.sh: test_expect_success 'use branch.<name>.remote if possible' '
       	echo "From $URL" >exp_err &&
       
     @@ t/t5512-ls-remote.sh: test_expect_success 'ls-remote --sort fails gracefully out
       
      
       ## t/t5514-fetch-multiple.sh ##
     +@@
     + 
     + test_description='fetch --all works correctly'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5514-fetch-multiple.sh: setup_repository () {
       	git add elif &&
       	test_tick &&
     @@ t/t5514-fetch-multiple.sh: test_expect_success 'git fetch --all (skipFetchAll)'
       
      
       ## t/t5516-fetch-push.sh ##
     +@@ t/t5516-fetch-push.sh: This test checks the following functionality:
     + * reflogs
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5516-fetch-push.sh: test_expect_success setup '
       	git add path1 &&
       	test_tick &&
     @@ t/t5516-fetch-push.sh: test_expect_success 'updateInstead with push-to-checkout
       		git diff --quiet &&
      
       ## t/t5517-push-mirror.sh ##
     +@@
     + 
     + test_description='pushing to a mirror repository'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5517-push-mirror.sh: invert () {
       }
       
     @@ t/t5517-push-mirror.sh: test_expect_success 'remote.foo.mirror=no has no effect'
       
      
       ## t/t5518-fetch-exit-status.sh ##
     +@@
     + 
     + test_description='fetch exit status test'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5518-fetch-exit-status.sh: test_expect_success setup '
       	echo side >file &&
       	git commit -a -m side &&
     @@ t/t5518-fetch-exit-status.sh: test_expect_success setup '
       
      
       ## t/t5519-push-alternates.sh ##
     +@@
     + 
     + test_description='push to a repository that borrows from elsewhere'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5519-push-alternates.sh: test_expect_success setup '
       		>file &&
       		git add . &&
     @@ t/t5519-push-alternates.sh: test_expect_success 'alice works and pushes yet agai
       		# at a commit Bob does not fully know about, but
       		# he happens to have the commit object (but not the
       		# necessary tree) in his repository from Alice.
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TEST_NUMBER" in
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-4]*|5[0-4]*|550*)
     -+[0-4]*|5[0-4]*|55[01]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 14:  4b1b1ee51f ! 15:  3b73811af4 t55[23]*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t5520-pull.sh ##
     +@@
     + 
     + test_description='pulling into void'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5520-pull.sh: test_expect_success 'pulling into void' '
       	test_cmp file cloned/file
       '
     @@ t/t5520-pull.sh: test_expect_success 'setup for avoiding reapplying old patches'
       	rm -rf src &&
      
       ## t/t5521-pull-options.sh ##
     +@@
     + 
     + test_description='pull options'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5521-pull-options.sh: test_expect_success 'git pull --force' '
       	cat >>.git/config <<-\EOF &&
       	[remote "one"]
     @@ t/t5521-pull-options.sh: test_expect_success 'git pull --all --dry-run' '
       	)
      
       ## t/t5523-push-upstream.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='push with --set-upstream'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5523-push-upstream.sh: check_config() {
       	test_cmp expect.$1 actual.$1
       }
     @@ t/t5523-push-upstream.sh: test_expect_success TTY 'push --no-progress suppresses
       
      
       ## t/t5527-fetch-odd-refs.sh ##
     -@@ t/t5527-fetch-odd-refs.sh: test_description='test fetching of oddly-named refs'
     +@@
     + #!/bin/sh
     + 
     + test_description='test fetching of oddly-named refs'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
       
       # afterwards we will have:
       #  HEAD - two
     @@ t/t5527-fetch-odd-refs.sh: test_expect_success LONG_REF 'fetch handles extremely
       
      
       ## t/t5528-push-default.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='check various push.default settings'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5528-push-default.sh: test_push_failure () {
       
       # $1 = success or failure
     @@ t/t5530-upload-pack-error.sh: test_expect_success 'create empty repository' '
       
      
       ## t/t5531-deep-submodule-push.sh ##
     +@@
     + 
     + test_description='test push with submodules'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5531-deep-submodule-push.sh: test_expect_success setup '
       test_expect_success 'push works with recorded gitlink' '
       	(
     @@ t/t5531-deep-submodule-push.sh: test_expect_success 'push propagating refspec to
       	git -C submodule.git rev-parse branch2 >actual_submodule &&
      
       ## t/t5533-push-cas.sh ##
     +@@
     + 
     + test_description='compare & swap push force/delete safety'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5533-push-cas.sh: setup_src_dup_dst () {
       	(
       		cd dup &&
     @@ t/t5533-push-cas.sh: test_expect_success '"--force-if-includes" should allow for
       
      
       ## t/t5534-push-signed.sh ##
     +@@
     + 
     + test_description='signed push'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5534-push-signed.sh: prepare_dst () {
       	rm -fr dst &&
       	test_create_repo dst &&
     @@ t/t5534-push-signed.sh: prepare_dst () {
       
      
       ## t/t5537-fetch-shallow.sh ##
     +@@
     + 
     + test_description='fetch/clone from a shallow clone'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5537-fetch-shallow.sh: test_expect_success 'fetch from shallow clone' '
       	cd shallow2 &&
       	git fetch &&
     @@ t/t5537-fetch-shallow.sh: test_expect_success 'shallow fetches check connectivit
       	! test -e "$HTTPD_ROOT_PATH/one-time-perl" &&
      
       ## t/t5538-push-shallow.sh ##
     +@@
     + 
     + test_description='push from/to a shallow clone'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5538-push-shallow.sh: test_expect_success 'push from shallow clone' '
       	(
       	cd shallow &&
     @@ t/t5538-push-shallow.sh: EOF
       1
      
       ## t/t5539-fetch-http-shallow.sh ##
     +@@
     + 
     + test_description='fetch/clone from a shallow clone over http'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5539-fetch-http-shallow.sh: test_expect_success 'clone http repository' '
       	(
       	cd clone &&
     @@ t/t5539-fetch-http-shallow.sh: test_expect_success 'fetching deepen' '
       	cat >expected <<-\EOF &&
       	four
       	three
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TRASH_DIRECTORY" in
     - esac
     - 
     - case "$TEST_NUMBER" in
     --3404|4013|5310)
     -+3404|4013|5310|5526)
     - 	# Avoid conflicts with patch series that are cooking at the same time
     - 	# as the patch series changing the default of `init.defaultBranch`.
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-4]*|5[0-4]*|55[01]*)
     -+[0-4]*|5[0-4]*|55[0-3]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 15:  c37d97c2d8 ! 16:  5c57fbe695 t55[4-9]*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t5540-http-push-webdav.sh ##
     +@@ t/t5540-http-push-webdav.sh: test_description='test WebDAV http-push
     + 
     + This test runs various sanity checks on http-push.'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5540-http-push-webdav.sh: test_expect_success 'push already up-to-date' '
       test_expect_success 'push to remote repository with unpacked refs' '
       	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
     @@ t/t5540-http-push-webdav.sh: test_expect_success 'PUT and MOVE sends object to U
       	test_commit pw-user &&
      
       ## t/t5541-http-push-smart.sh ##
     +@@
     + #
     + 
     + test_description='test smart pushing over http via http-backend'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5541-http-push-smart.sh: test_expect_success 'used receive-pack service' '
       '
       
     @@ t/t5541-http-push-smart.sh: test_expect_success 'colorize errors/hints' '
       	test_i18ngrep "<RED>error: failed to push some refs" decoded &&
      
       ## t/t5542-push-http-shallow.sh ##
     +@@
     + 
     + test_description='push from/to a shallow clone over http'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5542-push-http-shallow.sh: test_expect_success 'push to shallow repo via http' '
       	(
       	cd full &&
     @@ t/t5542-push-http-shallow.sh: test_expect_success 'push from shallow repo via ht
       4
      
       ## t/t5543-atomic-push.sh ##
     +@@
     + 
     + test_description='pushing to a repository using the atomic push option'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5543-atomic-push.sh: test_expect_success 'atomic push works for a single branch' '
       		test_commit one &&
       		git push --mirror up &&
     @@ t/t5543-atomic-push.sh: test_expect_success 'atomic push reports (mirror, but re
       	test_cmp expect actual
      
       ## t/t5545-push-options.sh ##
     +@@
     + 
     + test_description='pushing to a repository using push options'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5545-push-options.sh: test_expect_success 'one push option works for a single branch' '
       		test_commit one &&
       		git push --mirror up &&
     @@ t/t5548-push-porcelain.sh: run_git_push_porcelain_output_test() {
       		test_cmp expect actual
      
       ## t/t5550-http-fetch-dumb.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test dumb fetching over http via static file'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'create http-accessible bare repository with loose objects'
       	 hooks/post-update
       	) &&
     @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'set up evil alternates scheme'
       # Here we'll just redirect via HTTP. In a real-world attack these would be on
      
       ## t/t5551-http-fetch-smart.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test smart fetching over http via http-backend'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5551-http-fetch-smart.sh: test_expect_success 'create http-accessible bare repository' '
       	 git --bare init
       	) &&
     @@ t/t5552-skipping-fetch-negotiator.sh: test_expect_success 'use ref advertisement
       	test_config -C client fetch.negotiationalgorithm skipping &&
      
       ## t/t5553-set-upstream.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='"git fetch/pull --set-upstream" basic tests.'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5553-set-upstream.sh: test_expect_success 'setup bare parent fetch' '
       	git remote add upstream parent
       '
     @@ t/t5553-set-upstream.sh: test_expect_success 'pull --set-upstream upstream tag d
       	check_config_missing other2
       '
      
     + ## t/t5560-http-backend-noserver.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test git-http-backend-noserver'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
     +
       ## t/t5561-http-backend.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test git-http-backend'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5561-http-backend.sh: POST() {
       
       grep '^[^#]' >exp <<EOF
     @@ t/t556x_common: get_static_files() {
       	get_static_files "200 OK"
      
       ## t/t5570-git-daemon.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test fetching over git protocol'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5570-git-daemon.sh: test_expect_success 'create git-accessible bare repository' '
       	 : >git-daemon-export-ok
       	) &&
     @@ t/t5570-git-daemon.sh: test_expect_success FAKENC 'hostname interpolation works
       
      
       ## t/t5571-pre-push-hook.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='check pre-push hooks'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5571-pre-push-hook.sh: EOF
       cat >expected <<EOF
       parent1
     @@ t/t5572-pull-submodule.sh: test_expect_success 'branch has no merge base with re
       	git -C child reset --hard "$OTHER" &&
      
       ## t/t5580-unc-paths.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='various Windows-only path tests'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5580-unc-paths.sh: test_expect_success fetch '
       	git init to-fetch &&
       	(
     @@ t/t5580-unc-paths.sh: test_expect_success fetch '
       
      
       ## t/t5581-http-curl-verbose.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test GIT_CURL_VERBOSE'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5581-http-curl-verbose.sh: test_expect_success 'setup repository' '
       	git add file &&
       	git commit -m one &&
     @@ t/t5581-http-curl-verbose.sh: test_expect_success 'setup repository' '
       test_expect_success 'failure in git-upload-pack is shown' '
      
       ## t/t5582-fetch-negative-refspec.sh ##
     +@@ t/t5582-fetch-negative-refspec.sh: test_description='"git fetch" with negative refspecs.
     + 
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5582-fetch-negative-refspec.sh: test_expect_success "clone and setup child repos" '
       		git switch -c alternate &&
       		echo >file updated again by one &&
     @@ t/t5582-fetch-negative-refspec.sh: test_expect_success "fetch with negative patt
       		cut -f -1 .git/FETCH_HEAD >actual &&
       		test_cmp expect actual
       	)
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TEST_NUMBER" in
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-4]*|5[0-4]*|55[0-3]*)
     -+[0-4]*|5[0-5]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 16:  dda6ce098c ! 17:  b2fda75261 t5[6-9]*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t5601-clone.sh ##
     +@@
     + 
     + test_description=clone
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5601-clone.sh: test_expect_success 'clone respects global branch.autosetuprebase' '
       		rm -fr dst &&
       		git clone src dst &&
     @@ t/t5601-clone.sh: test_expect_success 'clone from a repository with two identica
       	test "z$( cd target-11 && git symbolic-ref HEAD )" = zrefs/heads/another
      
       ## t/t5604-clone-reference.sh ##
     +@@
     + #
     + 
     + test_description='test clone --reference'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5604-clone-reference.sh: test_expect_success 'existence of info/alternates' '
       '
       
     @@ t/t5604-clone-reference.sh: test_expect_success 'fetch with incomplete alternate
       '
      
       ## t/t5605-clone-local.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test local clone'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5605-clone-local.sh: test_expect_success 'preparing origin repository' '
       	test "$(cd a.git && git config --bool core.bare)" = true &&
       	test "$(cd x && git config --bool core.bare)" = true &&
     @@ t/t5605-clone-local.sh: test_expect_success 'clone empty repository' '
       
      
       ## t/t5606-clone-options.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='basic clone options'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5606-clone-options.sh: test_expect_success 'setup' '
       test_expect_success 'clone -o' '
       
     @@ t/t5606-clone-options.sh: test_expect_success 'prefers config "clone.defaultRemo
       
      
       ## t/t5607-clone-bundle.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='some bundle related tests'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5607-clone-bundle.sh: test_expect_success 'setup' '
       '
       
     @@ t/t5608-clone-2gb.sh: test_expect_success 'setup' '
       	 echo "data 5" &&
      
       ## t/t5609-clone-branch.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='clone --branch option'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5609-clone-branch.sh: test_expect_success 'setup' '
       	 echo one >file && git add file && git commit -m one &&
       	 git checkout -b two &&
     @@ t/t5609-clone-branch.sh: test_expect_success 'clone -b sets up tracking' '
       	)
      
       ## t/t5610-clone-detached.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test cloning a repository with detached HEAD'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5610-clone-detached.sh: test_expect_success 'setup' '
       '
       
     @@ t/t5610-clone-detached.sh: test_expect_success 'cloned HEAD is detached' '
       	git clone "file://$PWD" detached-orphan
      
       ## t/t5611-clone-config.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='tests for git clone -c key=value'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5611-clone-config.sh: test_expect_success 'clone -c config is available during clone' '
       
       test_expect_success 'clone -c remote.origin.fetch=<refspec> works' '
     @@ t/t5611-clone-config.sh: test_expect_success 'clone -c remote.<remote>.fetch=<re
       '
      
       ## t/t5612-clone-refspec.sh ##
     -@@ t/t5612-clone-refspec.sh: test_description='test refspec written by clone-command'
     +@@
     + #!/bin/sh
     + 
     + test_description='test refspec written by clone-command'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
       . ./test-lib.sh
       
       test_expect_success 'setup' '
     @@ t/t5614-clone-submodules-shallow.sh: test_description='Test shallow cloning of r
       	mkdir sub &&
      
       ## t/t5616-partial-clone.sh ##
     +@@
     + 
     + test_description='git partial clone'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5616-partial-clone.sh: test_expect_success 'verify that .promisor file contains refs fetched' '
       	test_line_count = 1 promisorlist &&
       	git -C srv.bare rev-parse --verify HEAD >headhash &&
     @@ t/t5616-partial-clone.sh: test_expect_success 'fetch lazy-fetches only to resolv
       	grep "fetch< version 2" trace &&
      
       ## t/t5617-clone-submodules-remote.sh ##
     -@@ t/t5617-clone-submodules-remote.sh: test_description='Test cloning repos with submodules using remote-tracking branc
     +@@
     + 
     + test_description='Test cloning repos with submodules using remote-tracking branches'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
     +@@ t/t5617-clone-submodules-remote.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       pwd=$(pwd)
       
       test_expect_success 'setup' '
     @@ t/t5617-clone-submodules-remote.sh: test_expect_success 'clone with --single-bra
       '
      
       ## t/t5700-protocol-v1.sh ##
     +@@ t/t5700-protocol-v1.sh: TEST_NO_CREATE_REPO=1
     + GIT_TEST_PROTOCOL_VERSION=0
     + export GIT_TEST_PROTOCOL_VERSION
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5700-protocol-v1.sh: test_expect_success 'fetch with git:// using protocol v1' '
       	GIT_TRACE_PACKET=1 git -C daemon_child -c protocol.version=1 \
       		fetch 2>log &&
     @@ t/t5700-protocol-v1.sh: test_expect_success 'push with http:// using protocol v1
       
      
       ## t/t5701-git-serve.sh ##
     +@@
     + 
     + test_description='test protocol v2 server commands'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5701-git-serve.sh: test_expect_success 'wrong object-format' '
       #
       test_expect_success 'setup some refs and tags' '
     @@ t/t5701-git-serve.sh: test_expect_success 'symrefs parameter' '
       
      
       ## t/t5702-protocol-v2.sh ##
     +@@ t/t5702-protocol-v2.sh: test_description='test git wire-protocol version 2'
     + 
     + TEST_NO_CREATE_REPO=1
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5702-protocol-v2.sh: test_expect_success 'ref advertisement is filtered with ls-remote using protocol
       	test_when_finished "rm -f log" &&
       
     @@ t/t5702-protocol-v2.sh: test_expect_success 'push with http:// and a config of v
       
      
       ## t/t5703-upload-pack-ref-in-want.sh ##
     +@@
     + 
     + test_description='upload-pack ref-in-want'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5703-upload-pack-ref-in-want.sh: write_command () {
       
       # c(o/foo) d(o/bar)
     @@ t/t5703-upload-pack-ref-in-want.sh: test_expect_success 'server is initially beh
       
      
       ## t/t5801-remote-helpers.sh ##
     +@@
     + 
     + test_description='Test remote-helper import and export commands'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t5801-remote-helpers.sh: test_expect_success 'fetch multiple branches' '
       	(cd local &&
       	 git fetch
     @@ t/t5801-remote-helpers.sh: test_expect_success 'fetch HEAD' '
       	echo more >>file &&
       	git commit -a -m more
       	) &&
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TEST_NUMBER" in
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-4]*|5[0-5]*)
     -+[0-5]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 17:  27d7994933 ! 18:  dfbc93923b t6[0-3]*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t6000-rev-list-misc.sh ##
     +@@
     + 
     + test_description='miscellaneous rev-list tests'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6000-rev-list-misc.sh: test_expect_success 'propagate uninteresting flag down correctly' '
       '
       
     @@ t/t6000-rev-list-misc.sh: test_expect_success 'propagate uninteresting flag down
       	< that
      
       ## t/t6001-rev-list-graft.sh ##
     +@@
     + 
     + test_description='Revision traversal vs grafts and path limiter'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6001-rev-list-graft.sh: test_expect_success setup '
       	git commit -a -m "Third in one history." &&
       	A2=$(git rev-parse --verify HEAD) &&
     @@ t/t6004-rev-list-path-optim.sh: test_description='git rev-list trivial path opti
         /                        /
        o---------o----o----o----o side
        a0        c0   c1   a1   c2
     +@@ t/t6004-rev-list-path-optim.sh: test_description='git rev-list trivial path optimization test
     + 
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6004-rev-list-path-optim.sh: test_expect_success 'further setup' '
       	git add c &&
       	test_tick &&
     @@ t/t6004-rev-list-path-optim.sh: test_expect_success 'path optimization 2' '
       '
      
       ## t/t6006-rev-list-format.sh ##
     +@@
     + 
     + test_description='git rev-list --pretty=format test'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6006-rev-list-format.sh: test_expect_success 'setup' '
       test_format () {
       	cat >expect.$1
     @@ t/t6006-rev-list-format.sh: test_expect_success '"%h %gD: %gs" is same as git-re
       
      
       ## t/t6007-rev-list-cherry-pick-file.sh ##
     +@@
     + 
     + test_description='test git rev-list --cherry-pick -- file'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6007-rev-list-cherry-pick-file.sh: test_expect_success setup '
       	test_tick &&
       	git commit -m "E" &&
     @@ t/t6007-rev-list-cherry-pick-file.sh: test_expect_success '--cherry-pick with in
       cat >expect <<EOF
      
       ## t/t6008-rev-list-submodule.sh ##
     +@@
     + 
     + test_description='git rev-list involving submodules that this repo has'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6008-rev-list-submodule.sh: test_expect_success 'setup' '
       '
       
     @@ t/t6008-rev-list-submodule.sh: test_expect_success 'setup' '
       test_done
      
       ## t/t6009-rev-list-parent.sh ##
     +@@
     + 
     + test_description='ancestor culling and limiting by parent number'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6009-rev-list-parent.sh: test_expect_success 'setup roots, merges and octopuses' '
       	test_commit seven &&
       	git checkout -b yetanotherbranch four &&
     @@ t/t6009-rev-list-parent.sh: test_expect_success 'dodecapus' '
       	git tag dodecapus &&
      
       ## t/t6012-rev-list-simplify.sh ##
     +@@
     + 
     + test_description='merge simplification'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6012-rev-list-simplify.sh: test_expect_success setup '
       	git add side &&
       	test_tick && git commit -m "Side root" &&
     @@ t/t6012-rev-list-simplify.sh: test_expect_success setup '
       
      
       ## t/t6013-rev-list-reverse-parents.sh ##
     +@@
     + 
     + test_description='--reverse combines with --parents'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6013-rev-list-reverse-parents.sh: test_expect_success 'set up --reverse example' '
       	commit two &&
       	git checkout -b side HEAD^ &&
     @@ t/t6013-rev-list-reverse-parents.sh: test_expect_success 'set up --reverse examp
       
      
       ## t/t6016-rev-list-graph-simplify-history.sh ##
     +@@
     + 
     + test_description='--graph and simplified history'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6016-rev-list-graph-simplify-history.sh: test_expect_success 'set up rev-list --graph test' '
       	test_commit A1 foo.txt &&
       	test_commit A2 bar.txt &&
     @@ t/t6016-rev-list-graph-simplify-history.sh: test_expect_success 'set up rev-list
       	git checkout -b B A1 &&
      
       ## t/t6017-rev-list-stdin.sh ##
     +@@
     + 
     + test_description='log family learns --stdin'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6017-rev-list-stdin.sh: test_expect_success setup '
       		done &&
       		for i in $them
     @@ t/t6017-rev-list-stdin.sh: test_expect_success 'not only --stdin' '
       '
      
       ## t/t6018-rev-list-glob.sh ##
     +@@
     + 
     + test_description='rev-list/rev-parse --glob'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6018-rev-list-glob.sh: compare () {
       
       test_expect_success 'setup' '
     @@ t/t6018-rev-list-glob.sh: test_expect_success 'shortlog accepts --glob/--tags/--
       
      
       ## t/t6019-rev-list-ancestry-path.sh ##
     +@@ t/t6019-rev-list-ancestry-path.sh: test_description='--ancestry-path'
     + #  --ancestry-path G..M -- G.t == L
     + #  --ancestry-path --simplify-merges G^..M -- G.t == G L
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6019-rev-list-ancestry-path.sh: test_expect_success 'setup criss-cross' '
       	(cd criss-cross &&
       	 git init &&
     @@ t/t6019-rev-list-ancestry-path.sh: test_expect_success 'setup criss-cross' '
       # no commits in bc descend from cb
      
       ## t/t6030-bisect-porcelain.sh ##
     +@@ t/t6030-bisect-porcelain.sh: test_description='Tests git bisect functionality'
     + 
     + exec </dev/null
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6030-bisect-porcelain.sh: test_expect_success 'bisect start without -- takes unknown arg as pathspec' '
       	grep bar ".git/BISECT_NAMES"
       '
     @@ t/t6030-bisect-porcelain.sh: test_expect_success 'bisect: --no-checkout - target
       		git rev-list --objects BISECT_HEAD --not \$GOOD >tmp.\$\$ &&
      
       ## t/t6040-tracking-info.sh ##
     +@@
     + 
     + test_description='remote tracking stats'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6040-tracking-info.sh: test_expect_success setup '
       		git branch -d brokenbase &&
       		git checkout -b b6 origin
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
       '
      
       ## t/t6050-replace.sh ##
     +@@
     + #
     + test_description='Tests replace refs functionality'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6050-replace.sh: test_expect_success 'tag replaced commit' '
       '
       
     @@ t/t6050-replace.sh: test_expect_success GPG 'set up a merge commit with a merget
       	git cat-file commit $HASH10 | grep "^mergetag object"
      
       ## t/t6101-rev-parse-parents.sh ##
     +@@
     + 
     + test_description='Test git rev-parse with different parent options'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6101-rev-parse-parents.sh: test_expect_success 'setup' '
       	test_commit second &&
       	git checkout --orphan tmp &&
     @@ t/t6101-rev-parse-parents.sh: test_expect_success 'setup' '
       
      
       ## t/t6110-rev-list-sparse.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='operations that cull histories in unusual ways'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6110-rev-list-sparse.sh: test_expect_success setup '
       	git checkout -b side HEAD^ &&
       	test_commit D &&
     @@ t/t6110-rev-list-sparse.sh: test_expect_success setup '
       test_expect_success 'rev-list --first-parent --boundary' '
      
       ## t/t6111-rev-list-treesame.sh ##
     +@@
     + 
     + test_description='TREESAME and limiting'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6111-rev-list-treesame.sh: test_expect_success setup '
       	git checkout other-branch &&
       	test_commit "Added other" other "Hello" C &&
     @@ t/t6111-rev-list-treesame.sh: test_expect_success setup '
       
      
       ## t/t6112-rev-list-filters-objects.sh ##
     +@@
     + 
     + test_description='git rev-list using object filtering'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6112-rev-list-filters-objects.sh: test_expect_success 'verify sparse:oid=oid-ish omits top-level files' '
       	sort >expected &&
       
     @@ t/t6112-rev-list-filters-objects.sh: test_expect_success 'combine:... with more
       
      
       ## t/t6120-describe.sh ##
     +@@ t/t6120-describe.sh: test_description='test describe'
     + #
     + # First parent of a merge commit is on the same line, second parent below.
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6120-describe.sh: check_describe c-* --tags HEAD^^2
       check_describe B --tags HEAD^^2^
       check_describe e --tags HEAD^^^
     @@ t/t6120-describe.sh: test_expect_success 'describe commits with disjoint bases 2
       	)
      
       ## t/t6200-fmt-merge-msg.sh ##
     +@@
     + 
     + test_description='fmt-merge-msg test'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6200-fmt-merge-msg.sh: test_expect_success GPG 'set up a signed tag' '
       test_expect_success 'message for merging local branch' '
       	echo "Merge branch ${apos}left${apos}" >expected &&
     @@ t/t6200-fmt-merge-msg.sh: test_expect_success 'merge-msg with "merging" an annot
       test_done
      
       ## t/t6302-for-each-ref-filter.sh ##
     +@@
     + 
     + test_description='test for-each-refs usage of ref-filter APIs'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6302-for-each-ref-filter.sh: test_expect_success 'setup some history and refs' '
       	git tag $sign -m "A signed tag" signed-tag &&
       	git tag $sign -m "Signed doubly" doubly-signed-tag signed-tag &&
     @@ t/t6302-for-each-ref-filter.sh: test_expect_success '--merged is compatible with
       	git for-each-ref --format="%(refname:short): %(if)%(worktreepath)%(then)%(worktreepath)%(else)not checked out%(end)" refs/heads/ >actual &&
       	rm -r worktree_dir &&
       	git worktree prune &&
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TRASH_DIRECTORY" in
     - esac
     - 
     - case "$TEST_NUMBER" in
     --3404|4013|5310|5526)
     -+3404|4013|5310|5526|6300)
     - 	# Avoid conflicts with patch series that are cooking at the same time
     - 	# as the patch series changing the default of `init.defaultBranch`.
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-5]*)
     -+[0-5]*|6[0-3]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 18:  04878e2268 = 19:  0a4bc77dac t64*: preemptively adjust alignment to prepare for `master` -> `main`
 19:  f0fa12b577 ! 20:  3dbc83c6a1 t6[4-9]*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t6400-merge-df.sh ##
     +@@
     + #
     + 
     + test_description='Test merge with directory/file conflicts'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6400-merge-df.sh: test_expect_success 'prepare repository' '
       '
       
     @@ t/t6400-merge-df.sh: test_expect_success 'F/D conflict' '
       test_expect_success 'setup modify/delete + directory/file conflict' '
      
       ## t/t6402-merge-rename.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='Merge-recursive merging renames'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6402-merge-rename.sh: test_expect_success 'setup' '
       	git branch change &&
       	git branch change+rename &&
     @@ t/t6402-merge-rename.sh: test_expect_success 'setup spurious "refusing to lose u
       '
      
       ## t/t6404-recursive-merge.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='Test merge without common ancestors'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6404-recursive-merge.sh: test_expect_success 'setup tests' '
       	git add a1 &&
       	GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
     @@ t/t6404-recursive-merge.sh: test_expect_success 'setup tests' '
       
      
       ## t/t6405-merge-symlinks.sh ##
     +@@ t/t6405-merge-symlinks.sh: test_description='merging symlinks on filesystem w/o symlink support.
     + This tests that git merge-recursive writes merge results as plain files
     + if core.symlinks is false.'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6405-merge-symlinks.sh: test_expect_success 'setup' '
       	git branch b-file &&
       	l=$(printf file | git hash-object -t blob -w --stdin) &&
     @@ t/t6405-merge-symlinks.sh: test_expect_success 'setup' '
       
      
       ## t/t6406-merge-attr.sh ##
     +@@
     + 
     + test_description='per path merge controlled by merge attribute'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6406-merge-attr.sh: test_expect_success setup '
       	git branch side &&
       	for f in text binary union
     @@ t/t6406-merge-attr.sh: test_expect_success 'custom merge does not lock index' '
       test_done
      
       ## t/t6407-merge-binary.sh ##
     +@@
     + 
     + test_description='ask merge-recursive to merge binary files'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6407-merge-binary.sh: test_expect_success setup '
       	git ls-files -s a >E0 &&
       	git ls-files -s m | sed -e "s/ 0	/ 3	/" >E3 &&
     @@ t/t6407-merge-binary.sh: test_expect_success recursive '
       		false
      
       ## t/t6409-merge-subtree.sh ##
     +@@
     + 
     + test_description='subtree merge strategy'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6409-merge-subtree.sh: test_expect_success setup '
       	echo >>hello world &&
       	git add hello &&
     @@ t/t6409-merge-subtree.sh: test_expect_success 'merge update' '
       	git ls-files -s >actual &&
      
       ## t/t6411-merge-filemode.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='merge: handle file mode'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6411-merge-filemode.sh: test_expect_success 'set up mode change in one branch' '
       	: >file1 &&
       	git add file1 &&
     @@ t/t6411-merge-filemode.sh: do_both_modes resolve
       '
      
       ## t/t6412-merge-large-rename.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='merging with large rename matrix'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6412-merge-large-rename.sh: test_rename() {
       	test_expect_success "rename ($1, $2)" '
       	n='$1' &&
     @@ t/t6412-merge-large-rename.sh: test_rename() {
       }
      
       ## t/t6413-merge-crlf.sh ##
     +@@ t/t6413-merge-crlf.sh: test_description='merge conflict in crlf repo
     + 
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6413-merge-crlf.sh: test_expect_success setup '
       	echo line from b | append_cr >file &&
       	git commit -m "add line from b" file &&
     @@ t/t6413-merge-crlf.sh: test_expect_success setup '
       test_expect_success 'Check "ours" is CRLF' '
      
       ## t/t6414-merge-rename-nocruft.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='Merge-recursive merging renames'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6414-merge-rename-nocruft.sh: test_expect_success 'setup' '
       	git update-index A &&
       	git commit -m "blue modify A" &&
     @@ t/t6414-merge-rename-nocruft.sh: test_expect_success 'setup' '
       # This test broke in 65ac6e9c3f47807cb603af07a6a9e1a43bc119ae
      
       ## t/t6415-merge-dir-to-symlink.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='merging when a directory was replaced with a symlink'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6415-merge-dir-to-symlink.sh: test_expect_success 'create a commit where dir a/b changed to symlink' '
       
       test_expect_success 'checkout does not clobber untracked symlink' '
     @@ t/t6415-merge-dir-to-symlink.sh: test_expect_success 'do not lose modifications
       test_expect_success 'setup a merge where dir a/b-2 changed to symlink' '
      
       ## t/t6416-recursive-corner-cases.sh ##
     +@@
     + 
     + test_description='recursive merge corner cases involving criss-cross merges'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6416-recursive-corner-cases.sh: test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
       		test_line_count = 2 out &&
       
     @@ t/t6416-recursive-corner-cases.sh: test_expect_success 'check virtual merge base
       			base        \
      
       ## t/t6417-merge-ours-theirs.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='Merge-recursive ours and theirs variants'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6417-merge-ours-theirs.sh: test_expect_success setup '
       	sed -e "s/9/nueve/" >file <elif &&
       	git commit -a -m theirs &&
     @@ t/t6418-merge-text-auto.sh
       *+ [side^] Initial
       '
       
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6418-merge-text-auto.sh: test_expect_success setup '
       	git commit -m "add line from b" &&
       	git tag b &&
     @@ t/t6418-merge-text-auto.sh: test_expect_success 'Test delete/normalize conflict'
       	test_path_is_missing file
      
       ## t/t6419-merge-ignorecase.sh ##
     +@@
     + 
     + test_description='git-merge with case-changing rename on case-insensitive file system'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6419-merge-ignorecase.sh: test_expect_success 'merge with case-changing rename' '
       	>foo &&
       	git add foo &&
     @@ t/t6419-merge-ignorecase.sh: test_expect_success 'merge with case-changing renam
       
      
       ## t/t6422-merge-rename-corner-cases.sh ##
     +@@
     + test_description="recursive merge corner cases w/ renames but not criss-crosses"
     + # t6036 has corner cases that involve both criss-cross merges and renames
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6422-merge-rename-corner-cases.sh: test_conflicts_with_adds_and_renames() {
       	# Setup:
       	#          L
     @@ t/t6422-merge-rename-corner-cases.sh: test_expect_success 'check nested conflict
       		test_must_fail git merge-file    \
      
       ## t/t6425-merge-rename-delete.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='Merge-recursive rename/delete conflict message'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6425-merge-rename-delete.sh: test_expect_success 'rename/delete' '
       	git mv A B &&
       	git commit -m "rename" &&
     @@ t/t6425-merge-rename-delete.sh: test_expect_success 'rename/delete' '
       
      
       ## t/t6427-diff3-conflict-markers.sh ##
     +@@
     + 
     + test_description='recursive merge diff3 style conflict markers'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6427-diff3-conflict-markers.sh: test_expect_success 'check no merge base' '
       # Setup:
       #          L1
     @@ t/t6427-diff3-conflict-markers.sh: test_expect_success 'rebase --apply describes
       '
      
       ## t/t6430-merge-recursive.sh ##
     +@@
     + 
     + test_description='merge-recursive backend test'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6430-merge-recursive.sh: test_expect_success 'setup 1' '
       	git add a d/e &&
       
     @@ t/t6432-merge-recursive-space-options.sh
       *+ [remote^] Initial revision
       *   ok 1: setup
       '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6432-merge-recursive-space-options.sh: test_expect_success 'setup' '
       	mv text.txt+ text.txt &&
       	git commit -a -m "Remove cruft" &&
     @@ t/t6432-merge-recursive-space-options.sh: test_expect_success 'setup' '
       			s/Quite correct\(.*\)/It is too correct\1Q/
      
       ## t/t6433-merge-toplevel.sh ##
     -@@ t/t6433-merge-toplevel.sh: test_description='"git merge" top-level frontend'
     +@@
     + 
     + test_description='"git merge" top-level frontend'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
       . ./test-lib.sh
       
       t3033_reset () {
     @@ t/t6434-merge-recursive-rename-options.sh: test_description='merge-recursive ren
       D	0-old
       D	1-old
       D	2-old
     +@@ t/t6434-merge-recursive-rename-options.sh: they are rounded down (see, e.g., Documentation/diff-generate-patch.txt, which
     + mentions this in a different context).
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6434-merge-recursive-rename-options.sh: test_expect_success 'setup repo' '
       	get_expected_stages 2 &&
       	get_expected_stages 3 &&
     @@ t/t6434-merge-recursive-rename-options.sh: test_expect_success 'setup repo' '
       test_expect_success 'setup thresholds' '
      
       ## t/t6436-merge-overwrite.sh ##
     +@@ t/t6436-merge-overwrite.sh: test_description='git-merge
     + 
     + Do not overwrite changes.'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6436-merge-overwrite.sh: test_expect_success 'set up unborn branch and content' '
       '
       
     @@ t/t6436-merge-overwrite.sh: test_expect_success 'set up unborn branch and conten
       	grep foo expect &&
      
       ## t/t6437-submodule-merge.sh ##
     +@@
     + 
     + test_description='merging with submodules'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6437-submodule-merge.sh: test_expect_success setup '
       	test_tick &&
       	git commit -m root &&
     @@ t/t6437-submodule-merge.sh: test_expect_success 'setup for recursive merge with
       	 git commit -m c &&
      
       ## t/t6439-merge-co-error-msgs.sh ##
     +@@
     + 
     + test_description='unpack-trees error messages'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6439-merge-co-error-msgs.sh: test_expect_success 'setup' '
       	git add two three four five &&
       	git commit -m Second &&
     @@ t/t6439-merge-co-error-msgs.sh: test_expect_success 'not_uptodate_dir porcelain
       	test_must_fail git checkout branch 2>out &&
      
       ## t/t6501-freshen-objects.sh ##
     +@@
     + #      to refer to an existing tree).
     + 
     + test_description='check pruning of dependent objects'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t6501-freshen-objects.sh: for repack in '' true; do
       		git checkout -b experiment &&
       		commit abandon &&
     @@ t/t6501-freshen-objects.sh: for repack in '' true; do
       		git branch -D experiment
       	'
       
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TEST_NUMBER" in
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-5]*|6[0-3]*)
     -+[0-6]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 20:  f9c30dc516 ! 21:  2315a253f6 t7[0-4]*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t7003-filter-branch.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git filter-branch'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7003-filter-branch.sh: test_expect_success 'setup' '
       	mkdir dir &&
       	test_commit dir/D &&
     @@ t/t7003-filter-branch.sh: test_expect_success 'automatic remapping to ancestor w
       
      
       ## t/t7004-tag.sh ##
     +@@ t/t7004-tag.sh: test_description='git tag
     + 
     + Tests for operations with tags.'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7004-tag.sh: test_expect_success 'checking that branch head with --no-contains lists all but
       "
       
     @@ t/t7004-tag.sh: test_expect_success ULIMIT_STACK_SIZE '--contains and --no-conta
       	test_must_be_empty actual &&
      
       ## t/t7030-verify-tag.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='signed tag tests'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7030-verify-tag.sh: test_expect_success GPG 'create signed tags' '
       	echo 3 >elif && git add elif &&
       	test_tick && git commit -m "third on side" &&
     @@ t/t7030-verify-tag.sh: test_expect_success GPG 'create signed tags' '
       
      
       ## t/t7060-wtstatus.sh ##
     +@@
     + 
     + test_description='basic work tree status reporting'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7060-wtstatus.sh: EOF
       		git checkout -b side HEAD^ &&
       		git rm foo &&
     @@ t/t7060-wtstatus.sh: test_expect_success 'status --branch with detached HEAD' '
       	## HEAD (no branch)
      
       ## t/t7063-status-untracked-cache.sh ##
     +@@
     + 
     + test_description='test untracked cache'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7063-status-untracked-cache.sh: EOF
       test_expect_success 'set up sparse checkout' '
       	echo "done/[a-z]*" >.git/info/sparse-checkout &&
     @@ t/t7063-status-untracked-cache.sh: test_expect_success '"status" after file repl
       	status_is_clean
      
       ## t/t7102-reset.sh ##
     +@@ t/t7102-reset.sh: test_description='git reset
     + 
     + Documented tests for git reset'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7102-reset.sh: test_expect_success 'trying to do reset --soft with pending merge should fail' '
       	printf "1st line 2nd file\n2nd line 2nd file\n3rd line" >secondfile &&
       	git commit -a -m "the change in branch2" &&
     @@ t/t7102-reset.sh: test_expect_success '--hard reset to ORIG_HEAD should clear a
       '
      
       ## t/t7113-post-index-change-hook.sh ##
     +@@
     + 
     + test_description='post index change hook'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7113-post-index-change-hook.sh: test_expect_success 'test checkout and reset trigger the hook' '
       	EOF
       	: force index to be dirty &&
     @@ t/t7201-co.sh: Test switching across them.
       
       '
       
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7201-co.sh: test_expect_success setup '
       	fill a b c d e f >two &&
       	git commit -a -m "Renamer R one->uno, M two" &&
     @@ t/t7201-co.sh: test_expect_success 'checkout --conflict=diff3' '
       	! grep "^Previous HEAD" error.log
      
       ## t/t7400-submodule-basic.sh ##
     +@@ t/t7400-submodule-basic.sh: This test tries to verify basic sanity of the init, update and status
     + subcommands of git submodule.
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7400-submodule-basic.sh: inspect() {
       }
       
     @@ t/t7400-submodule-basic.sh: test_expect_success 'apply submodule diff' '
       
      
       ## t/t7403-submodule-sync.sh ##
     +@@ t/t7403-submodule-sync.sh: test_description='git submodule sync
     + These tests exercise the "git submodule sync" subcommand.
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7403-submodule-sync.sh: test_expect_success 'change submodule url' '
       	(
       		cd super &&
     @@ t/t7403-submodule-sync.sh: test_expect_success '"git submodule sync --recursive"
       '
      
       ## t/t7406-submodule-update.sh ##
     -@@ t/t7406-submodule-update.sh: submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
     +@@ t/t7406-submodule-update.sh: This test verifies that "git submodule update" detaches the HEAD of the
     + submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
     +@@ t/t7406-submodule-update.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       
       compare_head()
       {
     @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update places git-di
       	)
      
       ## t/t7407-submodule-foreach.sh ##
     +@@ t/t7407-submodule-foreach.sh: This test verifies that "git submodule foreach" correctly visits all submodules
     + that are currently checked out.
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7407-submodule-foreach.sh: sub1sha1_short=$(cd clone3/sub1 && git rev-parse --short HEAD)
       sub2sha1_short=$(cd clone3/sub2 && git rev-parse --short HEAD)
       
     @@ t/t7407-submodule-foreach.sh: test_expect_success 'ensure "status --cached --rec
       test_expect_success 'test "status --recursive" from sub directory' '
      
       ## t/t7409-submodule-detached-work-tree.sh ##
     +@@ t/t7409-submodule-detached-work-tree.sh: on detached working trees
     + '
     + 
     + TEST_NO_CREATE_REPO=1
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7409-submodule-detached-work-tree.sh: test_expect_success 'submodule on detached working tree' '
       			git rev-parse --verify HEAD >actual &&
       			test_cmp ../../../../expect actual
     @@ t/t7409-submodule-detached-work-tree.sh: test_expect_success 'submodule on detac
       		cd home &&
      
       ## t/t7417-submodule-path-url.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='check handling of .gitmodule path with dash'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7417-submodule-path-url.sh: test_expect_success MINGW 'submodule paths disallows trailing spaces' '
       	sed "s/sub/sub /" <tree >tree.new &&
       	tree=$(git -C super mktree <tree.new) &&
     @@ t/t7417-submodule-path-url.sh: test_expect_success MINGW 'submodule paths disall
       
       	test_must_fail git clone --recurse-submodules super dst 2>err &&
       	test_i18ngrep "sub " err
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TRASH_DIRECTORY" in
     - esac
     - 
     - case "$TEST_NUMBER" in
     --3404|4013|5310|5526|6300)
     -+3404|4013|5310|5526|6300|7064)
     - 	# Avoid conflicts with patch series that are cooking at the same time
     - 	# as the patch series changing the default of `init.defaultBranch`.
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-6]*)
     -+[0-6]*|7[0-4]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 21:  2b269ca983 ! 22:  20eef6cc97 t7[5-9]*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t7501-commit-basic-functionality.sh ##
     +@@
     + # signoff
     + 
     + test_description='git commit'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7501-commit-basic-functionality.sh: test_expect_success 'same tree (merge and amend merge)' '
       	echo zero >zero &&
       	git add zero &&
     @@ t/t7501-commit-basic-functionality.sh: test_expect_success 'same tree (merge and
       	git diff HEAD^ HEAD >actual &&
      
       ## t/t7502-commit-porcelain.sh ##
     +@@
     + 
     + test_description='git commit porcelain-ish'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7502-commit-porcelain.sh: test_expect_success 'output summary format for merges' '
       
       output_tests_cleanup() {
     @@ t/t7502-commit-porcelain.sh: git reset -q --hard
       	sed -n -e "s/^parent //p" -e "/^$/q" raw >actual &&
      
       ## t/t7503-pre-commit-and-pre-merge-commit-hooks.sh ##
     +@@
     + 
     + test_description='pre-commit and pre-merge-commit hooks'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success 'root commit' '
       	git add foo &&
       	git commit -m "make it non-ff" &&
     @@ t/t7503-pre-commit-and-pre-merge-commit-hooks.sh: test_expect_success POSIXPERM
       
      
       ## t/t7504-commit-msg-hook.sh ##
     +@@
     + 
     + test_description='commit-msg hook'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7504-commit-msg-hook.sh: test_expect_success '--no-verify with failing hook (editor)' '
       test_expect_success 'merge fails with failing hook' '
       
     @@ t/t7504-commit-msg-hook.sh: test_expect_success "hook doesn't edit commit messag
       	git add file2 &&
      
       ## t/t7505-prepare-commit-msg-hook.sh ##
     +@@
     + 
     + test_description='prepare-commit-msg hook'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7505-prepare-commit-msg-hook.sh: test_expect_success 'set up commits for rebasing' '
       	do
       		test_commit rebase-$i c $i
     @@ t/t7508-status.sh: test_expect_success 'git commit --dry-run will show a staged
         (use "git pull" to merge the remote branch into yours)
      
       ## t/t7510-signed-commit.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='signed commit tests'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7510-signed-commit.sh: test_expect_success GPG 'create signed commits' '
       	echo 3 >elif && git add elif &&
       	test_tick && git commit -m "third on side" &&
     @@ t/t7510-signed-commit.sh: test_expect_success GPG 'create signed commits' '
       
      
       ## t/t7512-status-help.sh ##
     +@@
     + 
     + test_description='git status advice'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7512-status-help.sh: test_expect_success 'prepare for conflicts' '
       	git config --global advice.statusuoption false &&
       	test_commit init main.txt init &&
     @@ t/t7512-status-help.sh: EOF
       	test_commit two_commit main.txt two &&
      
       ## t/t7517-per-repo-email.sh ##
     +@@
     + 
     + test_description='per-repo forced setting of email address'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7517-per-repo-email.sh: test_expect_success 'set up rebase scenarios' '
       
       test_expect_success 'fast-forward rebase does not care about ident' '
     @@ t/t7600-merge.sh: Testing basic merge operations/option parsing.
        +     * [c1] commit 1
             +  [c6] c6
            +   [c5] c5
     +@@ t/t7600-merge.sh: Testing basic merge operations/option parsing.
     + +++++++* [c0] commit 0
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7600-merge.sh: test_expect_success 'merge c0 with c1 with --ff-only' '
       test_debug 'git log --graph --decorate --oneline --all'
       
     @@ t/t7606-merge-custom.sh: test_description="git merge
       * | (tag: c1) c1
      
       ## t/t7608-merge-messages.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='test auto-generated merge messages'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7608-merge-messages.sh: check_oneline() {
       }
       
     @@ t/t7608-merge-messages.sh: check_oneline() {
       test_done
      
       ## t/t7610-mergetool.sh ##
     -@@ t/t7610-mergetool.sh: Testing basic merge tool invocation'
     +@@ t/t7610-mergetool.sh: test_description='git mergetool
     + 
     + Testing basic merge tool invocation'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
       . ./test-lib.sh
       
       # All the mergetool test work by checking out a temporary branch based
     @@ t/t7611-merge-abort.sh: Set up repo with conflicting and non-conflicting branche
       #             \
       #              --- foo/barf/bazf   <-- conflict_branch
       #               \
     +@@ t/t7611-merge-abort.sh: Next, test git merge --abort with the following variables:
     + - changed/unchanged worktree after merge
     + - changed/unchanged index after merge
     + '
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7611-merge-abort.sh: test_expect_success 'setup' '
       	git checkout -b clean_branch HEAD^ &&
       	echo bart > bar &&
     @@ t/t7611-merge-abort.sh: test_expect_success 'setup' '
       pre_merge_head="$(git rev-parse HEAD)"
      
       ## t/t7612-merge-verify-signatures.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='merge signature verification tests'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7612-merge-verify-signatures.sh: test_expect_success GPG 'create signed commits' '
       	echo 3 >baz && git add baz &&
       	test_tick && git commit -SB7227189 -m "untrusted on side" &&
     @@ t/t7612-merge-verify-signatures.sh: test_expect_success GPG 'create signed commi
       test_expect_success GPG 'merge unsigned commit with verification' '
      
       ## t/t7614-merge-signoff.sh ##
     -@@ t/t7614-merge-signoff.sh: This test runs git merge --signoff and makes sure that it works.
     +@@ t/t7614-merge-signoff.sh: test_description='git merge --signoff
     + This test runs git merge --signoff and makes sure that it works.
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
     +@@ t/t7614-merge-signoff.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       test_setup() {
       	# Expected commit message after merge --signoff
       	cat >expected-signed <<EOF &&
     @@ t/t7614-merge-signoff.sh: test_expect_success 'setup' '
       '
      
       ## t/t7701-repack-unpack-unreachable.sh ##
     +@@
     + 
     + test_description='git repack works correctly'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7701-repack-unpack-unreachable.sh: test_expect_success '-A with -d option leaves unreachable objects unpacked' '
       	git commit -a -m more_content &&
       	csha1=$(git rev-parse HEAD^{commit}) &&
     @@ t/t7701-repack-unpack-unreachable.sh: test_expect_success '-A with -d option lea
       	git commit -a -m even_more_content &&
      
       ## t/t7800-difftool.sh ##
     +@@ t/t7800-difftool.sh: test_description='git-difftool
     + Testing basic diff tool invocation
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7800-difftool.sh: test_expect_success 'basic usage requires no repo' '
       	test_i18ngrep ^usage: output
       '
     @@ t/t7800-difftool.sh: run_dir_diff_test 'difftool --dir-diff with unmerged files'
       	cat >expect <<-EOF &&
      
       ## t/t7810-grep.sh ##
     +@@
     + test_description='git grep various.
     + '
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t7810-grep.sh: test_expect_success 'grep -e -- -- path' '
       '
       
     @@ t/t7810-grep.sh: test_expect_success 'grep --no-index pattern -- path' '
       	test_cmp expect actual
       '
       
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TRASH_DIRECTORY" in
     - esac
     - 
     - case "$TEST_NUMBER" in
     --3404|4013|5310|5526|6300|7064)
     -+3404|4013|5310|5526|6300|7064|7817)
     - 	# Avoid conflicts with patch series that are cooking at the same time
     - 	# as the patch series changing the default of `init.defaultBranch`.
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-6]*|7[0-4]*)
     -+[0-7]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 22:  5cac0065c8 ! 23:  e37bc3c792 t8*: adjust the references to the default branch name "main"
     @@ t/annotate-tests.sh: test_expect_success 'blame --first-parent blames merge for
       test_expect_success 'setup evil merge' '
      
       ## t/t8001-annotate.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git annotate'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t8001-annotate.sh: PROG='git annotate'
       . "$TEST_DIRECTORY"/annotate-tests.sh
       
     @@ t/t8001-annotate.sh: PROG='git annotate'
       	test 2 = $(grep A <authors | wc -l) &&
       	test 2 = $(grep B <authors | wc -l)
      
     + ## t/t8002-blame.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git blame'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
     +
       ## t/t8003-blame-corner-cases.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git blame corner cases'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t8003-blame-corner-cases.sh: test_expect_success 'blame wholesale copy and more in the index' '
       
       test_expect_success 'blame during cherry-pick with file rename conflict' '
     @@ t/t8003-blame-corner-cases.sh: test_expect_success 'blame wholesale copy and mor
       	git add rodent &&
      
       ## t/t8004-blame-with-conflicts.sh ##
     +@@
     + # Based on a test case submitted by Björn Steinbrink.
     + 
     + test_description='git blame on conflicted files'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t8004-blame-with-conflicts.sh: test_expect_success 'setup first case' '
       	git add file2 &&
       	git commit --author "U Gly <ug@localhost>" -m ugly &&
     @@ t/t8004-blame-with-conflicts.sh: Even more" > file2 &&
       		exit 1
       	else
      
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TEST_NUMBER" in
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-7]*)
     -+[0-8]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     + ## t/t8012-blame-colors.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='colored git blame'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
 23:  57e90d459a ! 24:  3e81bc89a2 t9[0-4]*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t9001-send-email.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git send-email'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t9001-send-email.sh: test_expect_success $PREREQ '--compose-encoding adds correct MIME for subject' '
       '
       
     @@ t/t9001-send-email.sh: test_expect_success $PREREQ 'test that send-email works o
       test_expect_success $PREREQ 'test that sendmail config is rejected' '
      
       ## t/t9100-git-svn-basic.sh ##
     +@@
     + test_description='git svn basic tests'
     + GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-git-svn.sh
      @@ t/t9100-git-svn-basic.sh: test_expect_success 'dcommit $rev does not clobber current branch' '
       	test refs/heads/my-bar = $(git symbolic-ref HEAD) &&
       	git log refs/remotes/bar | grep "change 1" &&
     @@ t/t9145-git-svn-master-branch.sh
       # Copyright (c) 2009 Eric Wong
       #
      -test_description='git svn initial master branch is "trunk" if possible'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
      +test_description='git svn initial main branch is "trunk" if possible'
     - . ./lib-git-svn.sh
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       
     - test_expect_success 'setup test repository' '
     + . ./lib-git-svn.sh
      @@ t/t9145-git-svn-master-branch.sh: test_expect_success 'setup test repository' '
       	svn_cmd import -m b/b i "$svnrepo/branches/b"
       '
     @@ t/t9145-git-svn-master-branch.sh: test_expect_success 'setup test repository' '
       
      
       ## t/t9151-svn-mergeinfo.sh ##
     +@@
     + 
     + test_description='git-svn svn mergeinfo properties'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-git-svn.sh
      @@ t/t9151-svn-mergeinfo.sh: test_expect_success 'merging two branches in one commit is detected correctly' '
       	'
       
     @@ t/t9151-svn-mergeinfo.sh: test_expect_success 'merging two branches in one commi
       
      
       ## t/t9155-git-svn-fetch-deleted-tag.sh ##
     +@@
     + 
     + test_description='git svn fetch deleted tag'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-git-svn.sh
      @@ t/t9155-git-svn-fetch-deleted-tag.sh: test_expect_success 'fetch deleted tags from same revision with checksum error'
       	git svn fetch &&
       
     @@ t/t9155-git-svn-fetch-deleted-tag.sh: test_expect_success 'fetch deleted tags fr
       test_done
      
       ## t/t9156-git-svn-fetch-deleted-tag-2.sh ##
     +@@
     + 
     + test_description='git svn fetch deleted tag 2'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-git-svn.sh
      @@ t/t9156-git-svn-fetch-deleted-tag-2.sh: test_expect_success 'fetch deleted tags from same revision with no checksum erro
       	cd git_project &&
       	git svn fetch &&
     @@ t/t9156-git-svn-fetch-deleted-tag-2.sh: test_expect_success 'fetch deleted tags
       test_done
      
       ## t/t9163-git-svn-reset-clears-caches.sh ##
     +@@
     + #
     + 
     + test_description='git svn reset clears memoized caches'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-git-svn.sh
      @@ t/t9163-git-svn-reset-clears-caches.sh: test_expect_success 'fetch to merge-base (a)' '
       test_expect_success 'rebase looses SVN merge (m)' '
       	git svn rebase &&
     @@ t/t9163-git-svn-reset-clears-caches.sh: test_expect_success 'fetch to merge-base
       # git svn fetch creates correct history with merge commit
      
       ## t/t9169-git-svn-dcommit-crlf.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git svn dcommit CRLF'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-git-svn.sh
      @@ t/t9169-git-svn-dcommit-crlf.sh: test_expect_success 'setup commit repository' '
       		p=$(git rev-parse HEAD) &&
       		t=$(git write-tree) &&
     @@ t/t9169-git-svn-dcommit-crlf.sh: test_expect_success 'setup commit repository' '
       		git svn dcommit &&
      
       ## t/t9300-fast-import.sh ##
     +@@
     + #
     + 
     + test_description='test git fast-import utility'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t9300-fast-import.sh: test_expect_success 'A: create pack from stdin' '
       	mark :4
       	data $file4_len
     @@ t/t9300-fast-import.sh: test_expect_success 'Y: rewrite submodules' '
       
      
       ## t/t9301-fast-import-notes.sh ##
     -@@ t/t9301-fast-import-notes.sh: test_description='test git fast-import of notes objects'
     +@@
     + #
     + 
     + test_description='test git fast-import of notes objects'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
     +@@ t/t9301-fast-import-notes.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
       
       test_tick
       cat >input <<INPUT_END
     @@ t/t9302-fast-import-unpack-limit.sh: test_expect_success 'lookups after checkpoi
       		make sure from "unpacked sha1 reference" works, too
      
       ## t/t9350-fast-export.sh ##
     +@@
     + #
     + 
     + test_description='git fast-export'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t9350-fast-export.sh: test_expect_success 'setup' '
       	git commit -m sitzt file2 &&
       	test_tick &&
     @@ t/t9350-fast-export.sh: test_expect_success 'merge commit gets exported with --i
       '
      
       ## t/t9351-fast-export-anonymize.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='basic tests for fast-export --anonymize'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t9351-fast-export-anonymize.sh: test_expect_success 'stream retains other as refname' '
       '
       
     @@ t/t9351-fast-export-anonymize.sh: test_expect_success 'repo has original shape a
       '
      
       ## t/t9400-git-cvsserver-server.sh ##
     +@@ t/t9400-git-cvsserver-server.sh: test_description='git-cvsserver access
     + tests read access to a git repository with the
     + cvs CLI client via git-cvsserver server'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t9400-git-cvsserver-server.sh: test_expect_success 'setup' '
         touch secondrootfile &&
         git add secondrootfile &&
     @@ t/t9400-git-cvsserver-server.sh: test_expect_success 'cvs co -c (shows module da
       xbranch:
      
       ## t/t9401-git-cvsserver-crlf.sh ##
     +@@ t/t9401-git-cvsserver-crlf.sh: test_description='git-cvsserver -kb modes
     + tests -kb mode for binary files when accessing a git
     + repository using cvs CLI client via git-cvsserver server'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t9401-git-cvsserver-crlf.sh: test_expect_success 'setup' '
       '
       
     @@ t/t9401-git-cvsserver-crlf.sh: test_expect_success 'update subdir of other copy
           git add multilineTxt.c &&
      
       ## t/t9402-git-cvsserver-refs.sh ##
     +@@ t/t9402-git-cvsserver-refs.sh: test_description='git-cvsserver and git refspecs
     + tests ability for git-cvsserver to switch between and compare
     + tags, branches and other git refspecs'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./test-lib.sh
      @@ t/t9402-git-cvsserver-refs.sh: test_expect_success 'setup v1, b1' '
       
       rm -rf cvswork
     @@ t/t9402-git-cvsserver-refs.sh: test_expect_success 'setup simple b2' '
       	check_start_tree cvswork &&
       	check_file cvswork textfile.c v1 &&
       	check_file cvswork t2 v1 &&
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TEST_NUMBER" in
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-8]*)
     -+[0-8]*|9[0-4]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 24:  f9e01de17f ! 25:  cda06e253d t9[5-7]*: adjust the references to the default branch name "main"
     @@ t/lib-cvs.sh: setup_cvs_test_repository () {
       	else
      
       ## t/t9500-gitweb-standalone-no-errors.sh ##
     +@@ t/t9500-gitweb-standalone-no-errors.sh: commandline, and checks that it would not write any errors
     + or warnings to log.'
     + 
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./gitweb-lib.sh
      @@ t/t9500-gitweb-standalone-no-errors.sh: test_expect_success \
       	 echo "Branch" >>b &&
       	 git add b &&
     @@ t/t9500-gitweb-standalone-no-errors.sh: test_expect_success \
       test_done
      
       ## t/t9501-gitweb-standalone-http-status.sh ##
     +@@ t/t9501-gitweb-standalone-http-status.sh: commandline, and checks that it returns the expected HTTP status
     + code and message.'
     + 
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./gitweb-lib.sh
      @@ t/t9501-gitweb-standalone-http-status.sh: test_debug 'cat gitweb.headers'
       # snapshot hash ids
       
     @@ t/t9501-gitweb-standalone-http-status.sh: test_expect_success DATE_PARSER 'modif
       test_debug 'cat gitweb.headers'
      
       ## t/t9502-gitweb-standalone-parse-output.sh ##
     +@@ t/t9502-gitweb-standalone-parse-output.sh: commandline, and checks that it produces the correct output, either
     + in the HTTP header or the actual script output.'
     + 
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./gitweb-lib.sh
      @@ t/t9502-gitweb-standalone-parse-output.sh: test_expect_success 'snapshot: HEAD' '
       '
       test_debug 'cat gitweb.headers && cat file_list'
     @@ t/t9502-gitweb-standalone-parse-output.sh: test_expect_success 'snapshot: short
       
      
       ## t/t9600-cvsimport.sh ##
     +@@
     + #!/bin/sh
     + 
     + test_description='git cvsimport basic tests'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-cvs.sh
      @@ t/t9600-cvsimport.sh: test_expect_success PERL 'no .git/cvs-revisions created by default' '
       
       '
     @@ t/t9600-cvsimport.sh: test_expect_success PERL 'no .git/cvs-revisions created by
       test_done
      
       ## t/t9601-cvsimport-vendor-branch.sh ##
     +@@
     + #       tag has been removed.
     + 
     + test_description='git cvsimport handling of vendor branches'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-cvs.sh
      @@ t/t9601-cvsimport-vendor-branch.sh: test_expect_success PERL 'import a module with a vendor branch' '
       
       '
     @@ t/t9601-cvsimport-vendor-branch.sh: test_expect_success PERL 'import a module wi
       
      
       ## t/t9602-cvsimport-branches-tags.sh ##
     +@@
     + # t9602/README.
     + 
     + test_description='git cvsimport handling of branches and tags'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-cvs.sh
      @@ t/t9602-cvsimport-branches-tags.sh: test_expect_success PERL 'import module' '
       
       '
     @@ t/t9602-cvsimport-branches-tags.sh: test_expect_success PERL 'import module' '
       
      
       ## t/t9603-cvsimport-patchsets.sh ##
     +@@
     + # bug.
     + 
     + test_description='git cvsimport testing for correct patchset estimation'
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-cvs.sh
      @@ t/t9603-cvsimport-patchsets.sh: test_expect_failure PERL 'import with criss cross times on revisions' '
       	git cvsimport -p"-x" -C module-git module &&
       	(
     @@ t/t9603-cvsimport-patchsets.sh: test_expect_failure PERL 'import with criss cros
       
       	echo "Rev 5 Branch A Wed Mar 11 19:09:10 2009 +0000
       Rev 4 Branch A Wed Mar 11 19:03:52 2009 +0000" > expect-A &&
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TEST_NUMBER" in
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-8]*|9[0-4]*)
     -+[0-8]*|9[0-7]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 25:  4da4b69114 ! 26:  fb8584d993 tests(git-p4): transition to the default branch name `main`
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t9800-git-p4-basic.sh ##
     +@@
     + 
     + test_description='git p4 tests'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-git-p4.sh
      @@ t/t9800-git-p4-basic.sh: test_expect_success 'clone --bare should make a bare repository' '
       		git config --get --bool core.bare true &&
       		git rev-parse --verify refs/remotes/p4/master &&
     @@ t/t9800-git-p4-basic.sh: test_expect_success 'clone --bare should make a bare re
       '
      
       ## t/t9801-git-p4-branch.sh ##
     +@@
     + 
     + test_description='git p4 tests for p4 branches'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-git-p4.sh
      @@ t/t9801-git-p4-branch.sh: test_expect_success 'import main, no branch detection' '
       	(
       		cd "$git" &&
     @@ t/t9801-git-p4-branch.sh: test_expect_success 'use-client-spec detect-branches s
       		test_path_is_missing b3-file3_1
      
       ## t/t9806-git-p4-options.sh ##
     +@@
     + 
     + test_description='git p4 options'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-git-p4.sh
      @@ t/t9806-git-p4-options.sh: test_expect_success 'clone no --git-dir' '
       	test_must_fail git p4 clone --git-dir=xx //depot
       '
     @@ t/t9806-git-p4-options.sh: test_expect_success 'clone --use-client-spec' '
       		)
      
       ## t/t9807-git-p4-submit.sh ##
     +@@
     + 
     + test_description='git p4 submit'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-git-p4.sh
      @@ t/t9807-git-p4-submit.sh: test_expect_success 'submit with allowSubmit' '
       		git config git-p4.skipSubmitEdit true &&
       		git config git-p4.allowSubmit "nobranch" &&
     @@ t/t9807-git-p4-submit.sh: test_expect_success 'submit with allowSubmit' '
       '
      
       ## t/t9811-git-p4-label-import.sh ##
     +@@
     + 
     + test_description='git p4 label tests'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-git-p4.sh
      @@ t/t9811-git-p4-label-import.sh: test_expect_success 'tag that cannot be exported' '
       		git add main/f12 &&
       		git commit -m "adding f12" &&
     @@ t/t9811-git-p4-label-import.sh: test_expect_success 'tag that cannot be exported
       		git p4 submit --export-labels
       	) &&
       	(
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TEST_NUMBER" in
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-8]*|9[0-7]*)
     -+[0-8]*|9[0-8]*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 26:  cfa29c7f71 ! 27:  bbc17c8ee5 t99*: adjust the references to the default branch name "main"
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t9903-bash-prompt.sh ##
     +@@
     + 
     + test_description='test git-specific bash prompt functions'
     + 
     +-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
     + . ./lib-bash.sh
      @@ t/t9903-bash-prompt.sh: test_expect_success 'setup for prompt tests' '
       	echo 3 >file &&
       	git commit -m "third b1" file &&
     @@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - hide if pwd ignored - env
       	test_config bash.hideIfPwdIgnored false &&
       	(
       		cd ignored_dir &&
     -
     - ## t/test-lib.sh ##
     -@@ t/test-lib.sh: case "$TRASH_DIRECTORY" in
     - esac
     - 
     - case "$TEST_NUMBER" in
     --3404|4013|5310|5526|6300|7064|7817)
     -+3404|4013|5310|5526|6300|7064|7817|9902)
     - 	# Avoid conflicts with patch series that are cooking at the same time
     - 	# as the patch series changing the default of `init.defaultBranch`.
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
     --[0-8]*|9[0-8]*)
     -+*)
     - 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     - 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     - 	;;
 27:  fc0c1f6463 = 28:  ec9b9cab88 tests: drop prereq `PREPARE_FOR_MAIN_BRANCH` where no longer needed

-- 
gitgitgadget
