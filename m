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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C49AC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622A2246BB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lknhRnpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgKRXo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgKRXoy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:44:54 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA100C0617A7
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:53 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so4327271wrx.5
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fU0zbvBeoP9qbp1hNOaCjHZkryORAnoEaSqnYLdcKVg=;
        b=lknhRnpUN/ZhPruzkuMX1yi31/SxI8qqbckJMxHH+/M2SK3dplpxtzh6gM5FeMCPfZ
         LZgbzFpxZANS0O7qdoGS6alVWYUZNB1TkVWdBkR9Rfxrxma2HAtfWcaB3ynj9uXKq3qE
         yh0maLabBe8KsmM1gA+nQlcCJNWogPcXCoYZfh/4IvfA4rMSrGm8wienmcDyZKq3bFJU
         Jy+wtwzg67e0+WU+DYnJ4r7Uj+bMb/Js5goYaTU8s8J0/z3IUFx4uKQWgzCZ5em4y3i6
         GofvApDv7Aodff7yWCg/UfM+Aq6RVkKG4KoIFGGfQ2XZesvbNgiqgy1SgT8WtP+UxHve
         6m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fU0zbvBeoP9qbp1hNOaCjHZkryORAnoEaSqnYLdcKVg=;
        b=Hj7JyH1QkgZuf7vXTBxGp7UzH6zMk12McVI9CDcI7Ro7Qpp7AW7Oj5beoinykYmwIu
         HyxKs4BRemBvNRvIy5x7ujcXLU6/6wzsJcBgAsGx2fH8U/99uUjC/w4nBrFx16cE1avN
         mwBreEmBQ0EzcHw4iwGzFH1UiBflUxNlf0x+EV4sKFymSwYe4rcaZ0NtYZC5alGX0DLh
         MhGHfRJ706KEBraOp/CuWLFbjrLwHKTtXVGmbKcxl5AgQS1dorxeAcuZvlIkCL1azLbt
         Dcbg5vI4hM8VpmGJMAN6u33bJAdGYOX3ar9KyKskCxl+cR4xpVMHAySm0xqCMkY73XQl
         Sd2Q==
X-Gm-Message-State: AOAM532b+gMyO9sacL2KI/LW8TJb2afheAsPrataMiDbyVWUO86ystQT
        rkhY7iWaWfqpErp6FkkI2Ca6mlch/A8=
X-Google-Smtp-Source: ABdhPJwk/rlxXm40Qye/aoDsDYDPc2McKdF2/lYl4eMjHUK+JBFrI4SRMkoZL+1ZLBpd9yIc89a+xA==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr7527931wrt.358.1605743091205;
        Wed, 18 Nov 2020 15:44:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm6136976wmh.37.2020.11.18.15.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:50 -0800 (PST)
Message-Id: <e9ee22525a30709d4d8435a822d19be80c2f5529.1605743086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:19 +0000
Subject: [PATCH v3 01/28] tests: mark tests relying on the current default for
 `init.defaultBranch`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In addition to the manual adjustment to let the `linux-gcc` CI job run
the test suite with `master` and then with `main`, this patch makes sure
that GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME is set in all test scripts
that currently rely on the initial branch name being `master by default.

To determine which test scripts to mark up, the first step was to
force-set the default branch name to `master` in

- all test scripts that contain the keyword `master`,

- t4211, which expects `t/t4211/history.export` with a hard-coded ref to
  initialize the default branch,

- t5560 because it sources `t/t556x_common` which uses `master`,

- t8002 and t8012 because both source `t/annotate-tests.sh` which also
  uses `master`)

This trick was performed by this command:

	$ sed -i '/^ *\. \.\/\(test-lib\|lib-\(bash\|cvs\|git-svn\)\|gitweb-lib\)\.sh$/i\
	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master\
	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME\
	' $(git grep -l master t/t[0-9]*.sh) \
	t/t4211*.sh t/t5560*.sh t/t8002*.sh t/t8012*.sh

After that, careful, manual inspection revealed that some of the test
scripts containing the needle `master` do not actually rely on a
specific default branch name: either they mention `master` only in a
comment, or they initialize that branch specificially, or they do not
actually refer to the current default branch. Therefore, the
aforementioned modification was undone in those test scripts thusly:

	$ git checkout HEAD -- \
		t/t0027-auto-crlf.sh t/t0060-path-utils.sh \
		t/t1011-read-tree-sparse-checkout.sh \
		t/t1305-config-include.sh t/t1309-early-config.sh \
		t/t1402-check-ref-format.sh t/t1450-fsck.sh \
		t/t2024-checkout-dwim.sh \
		t/t2106-update-index-assume-unchanged.sh \
		t/t3040-subprojects-basic.sh t/t3301-notes.sh \
		t/t3308-notes-merge.sh t/t3423-rebase-reword.sh \
		t/t3436-rebase-more-options.sh \
		t/t4015-diff-whitespace.sh t/t4257-am-interactive.sh \
		t/t5323-pack-redundant.sh t/t5401-update-hooks.sh \
		t/t5511-refspec.sh t/t5526-fetch-submodules.sh \
		t/t5529-push-errors.sh t/t5530-upload-pack-error.sh \
		t/t5548-push-porcelain.sh \
		t/t5552-skipping-fetch-negotiator.sh \
		t/t5572-pull-submodule.sh t/t5608-clone-2gb.sh \
		t/t5614-clone-submodules-shallow.sh \
		t/t7508-status.sh t/t7606-merge-custom.sh \
		t/t9302-fast-import-unpack-limit.sh

We excluded one set of test scripts in these commands, though: the range
of `git p4` tests. The reason? `git p4` stores the (foreign) remote
branch in the branch called `p4/master`, which is obviously not the
default branch. Manual analysis revealed that only five of these tests
actually require a specific default branch name to pass; They were
modified thusly:

	$ sed -i '/^ *\. \.\/lib-git-p4\.sh$/i\
	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master\
	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME\
	' t/t980[0167]*.sh t/t9811*.sh

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/run-build-and-tests.sh                        | 2 ++
 t/t0002-gitfile.sh                               | 3 +++
 t/t0020-crlf.sh                                  | 3 +++
 t/t0021-conversion.sh                            | 3 +++
 t/t0028-working-tree-encoding.sh                 | 3 +++
 t/t0041-usage.sh                                 | 3 +++
 t/t0050-filesystem.sh                            | 3 +++
 t/t0100-previous.sh                              | 3 +++
 t/t1004-read-tree-m-u-wf.sh                      | 3 +++
 t/t1008-read-tree-overlay.sh                     | 3 +++
 t/t1009-read-tree-new-index.sh                   | 3 +++
 t/t1021-rerere-in-workdir.sh                     | 3 +++
 t/t1090-sparse-checkout-scope.sh                 | 3 +++
 t/t1091-sparse-checkout-builtin.sh               | 3 +++
 t/t1300-config.sh                                | 3 +++
 t/t1301-shared-repo.sh                           | 3 +++
 t/t1400-update-ref.sh                            | 3 +++
 t/t1403-show-ref.sh                              | 3 +++
 t/t1405-main-ref-store.sh                        | 3 +++
 t/t1406-submodule-ref-store.sh                   | 3 +++
 t/t1407-worktree-ref-store.sh                    | 3 +++
 t/t1408-packed-refs.sh                           | 3 +++
 t/t1410-reflog.sh                                | 3 +++
 t/t1411-reflog-show.sh                           | 3 +++
 t/t1413-reflog-detach.sh                         | 3 +++
 t/t1414-reflog-walk.sh                           | 3 +++
 t/t1416-ref-transaction-hooks.sh                 | 3 +++
 t/t1430-bad-ref-name.sh                          | 3 +++
 t/t1500-rev-parse.sh                             | 3 +++
 t/t1503-rev-parse-verify.sh                      | 3 +++
 t/t1505-rev-parse-last.sh                        | 3 +++
 t/t1506-rev-parse-diagnosis.sh                   | 3 +++
 t/t1507-rev-parse-upstream.sh                    | 3 +++
 t/t1508-at-combinations.sh                       | 3 +++
 t/t1511-rev-parse-caret.sh                       | 3 +++
 t/t1512-rev-parse-disambiguation.sh              | 3 +++
 t/t1513-rev-parse-prefix.sh                      | 3 +++
 t/t1514-rev-parse-push.sh                        | 3 +++
 t/t1700-split-index.sh                           | 3 +++
 t/t2007-checkout-symlink.sh                      | 3 +++
 t/t2009-checkout-statinfo.sh                     | 3 +++
 t/t2010-checkout-ambiguous.sh                    | 3 +++
 t/t2011-checkout-invalid-head.sh                 | 3 +++
 t/t2012-checkout-last.sh                         | 3 +++
 t/t2015-checkout-unborn.sh                       | 3 +++
 t/t2017-checkout-orphan.sh                       | 3 +++
 t/t2020-checkout-detach.sh                       | 3 +++
 t/t2022-checkout-paths.sh                        | 3 +++
 t/t2023-checkout-m.sh                            | 3 +++
 t/t2027-checkout-track.sh                        | 3 +++
 t/t2030-unresolve-info.sh                        | 3 +++
 t/t2060-switch.sh                                | 3 +++
 t/t2070-restore.sh                               | 3 +++
 t/t2400-worktree-add.sh                          | 3 +++
 t/t2401-worktree-prune.sh                        | 3 +++
 t/t2402-worktree-list.sh                         | 3 +++
 t/t2405-worktree-submodule.sh                    | 3 +++
 t/t3200-branch.sh                                | 3 +++
 t/t3201-branch-contains.sh                       | 3 +++
 t/t3202-show-branch-octopus.sh                   | 3 +++
 t/t3203-branch-output.sh                         | 3 +++
 t/t3204-branch-name-interpretation.sh            | 3 +++
 t/t3205-branch-color.sh                          | 3 +++
 t/t3206-range-diff.sh                            | 3 +++
 t/t3210-pack-refs.sh                             | 3 +++
 t/t3211-peel-ref.sh                              | 3 +++
 t/t3302-notes-index-expensive.sh                 | 3 +++
 t/t3303-notes-subtrees.sh                        | 3 +++
 t/t3304-notes-mixed.sh                           | 3 +++
 t/t3320-notes-merge-worktrees.sh                 | 3 +++
 t/t3400-rebase.sh                                | 3 +++
 t/t3402-rebase-merge.sh                          | 3 +++
 t/t3403-rebase-skip.sh                           | 3 +++
 t/t3404-rebase-interactive.sh                    | 3 +++
 t/t3405-rebase-malformed.sh                      | 3 +++
 t/t3406-rebase-message.sh                        | 3 +++
 t/t3407-rebase-abort.sh                          | 3 +++
 t/t3408-rebase-multi-line.sh                     | 3 +++
 t/t3409-rebase-preserve-merges.sh                | 3 +++
 t/t3412-rebase-root.sh                           | 3 +++
 t/t3413-rebase-hook.sh                           | 3 +++
 t/t3415-rebase-autosquash.sh                     | 3 +++
 t/t3416-rebase-onto-threedots.sh                 | 3 +++
 t/t3418-rebase-continue.sh                       | 3 +++
 t/t3419-rebase-patch-id.sh                       | 3 +++
 t/t3420-rebase-autostash.sh                      | 3 +++
 t/t3427-rebase-subtree.sh                        | 3 +++
 t/t3430-rebase-merges.sh                         | 3 +++
 t/t3431-rebase-fork-point.sh                     | 3 +++
 t/t3432-rebase-fast-forward.sh                   | 3 +++
 t/t3434-rebase-i18n.sh                           | 3 +++
 t/t3435-rebase-gpg-sign.sh                       | 3 +++
 t/t3500-cherry.sh                                | 3 +++
 t/t3501-revert-cherry-pick.sh                    | 3 +++
 t/t3502-cherry-pick-merge.sh                     | 3 +++
 t/t3503-cherry-pick-root.sh                      | 3 +++
 t/t3504-cherry-pick-rerere.sh                    | 3 +++
 t/t3505-cherry-pick-empty.sh                     | 3 +++
 t/t3506-cherry-pick-ff.sh                        | 3 +++
 t/t3507-cherry-pick-conflict.sh                  | 3 +++
 t/t3508-cherry-pick-many-commits.sh              | 3 +++
 t/t3509-cherry-pick-merge-df.sh                  | 3 +++
 t/t3512-cherry-pick-submodule.sh                 | 3 +++
 t/t3600-rm.sh                                    | 3 +++
 t/t3701-add-interactive.sh                       | 3 +++
 t/t3901-i18n-patch.sh                            | 3 +++
 t/t3903-stash.sh                                 | 3 +++
 t/t3910-mac-os-precompose.sh                     | 3 +++
 t/t4013-diff-various.sh                          | 3 +++
 t/t4014-format-patch.sh                          | 3 +++
 t/t4017-diff-retval.sh                           | 3 +++
 t/t4038-diff-combined.sh                         | 3 +++
 t/t4041-diff-submodule-option.sh                 | 3 +++
 t/t4048-diff-combined-binary.sh                  | 3 +++
 t/t4052-stat-output.sh                           | 3 +++
 t/t4056-diff-order.sh                            | 3 +++
 t/t4057-diff-combined-paths.sh                   | 3 +++
 t/t4061-diff-indent.sh                           | 3 +++
 t/t4066-diff-emit-delay.sh                       | 3 +++
 t/t4068-diff-symmetric-merge-base.sh             | 3 +++
 t/t4103-apply-binary.sh                          | 3 +++
 t/t4108-apply-threeway.sh                        | 3 +++
 t/t4121-apply-diffs.sh                           | 3 +++
 t/t4122-apply-symlink-inside.sh                  | 3 +++
 t/t4150-am.sh                                    | 3 +++
 t/t4200-rerere.sh                                | 3 +++
 t/t4201-shortlog.sh                              | 3 +++
 t/t4202-log.sh                                   | 3 +++
 t/t4203-mailmap.sh                               | 3 +++
 t/t4204-patch-id.sh                              | 3 +++
 t/t4207-log-decoration-colors.sh                 | 3 +++
 t/t4208-log-magic-pathspec.sh                    | 3 +++
 t/t4211-line-log.sh                              | 3 +++
 t/t4214-log-graph-octopus.sh                     | 3 +++
 t/t4216-log-bloom.sh                             | 3 +++
 t/t4253-am-keep-cr-dos.sh                        | 3 +++
 t/t5150-request-pull.sh                          | 3 +++
 t/t5304-prune.sh                                 | 3 +++
 t/t5305-include-tag.sh                           | 3 +++
 t/t5310-pack-bitmaps.sh                          | 3 +++
 t/t5312-prune-corruption.sh                      | 3 +++
 t/t5317-pack-objects-filter-objects.sh           | 3 +++
 t/t5322-pack-objects-sparse.sh                   | 3 +++
 t/t5400-send-pack.sh                             | 3 +++
 t/t5402-post-merge-hook.sh                       | 3 +++
 t/t5403-post-checkout-hook.sh                    | 3 +++
 t/t5404-tracking-branches.sh                     | 3 +++
 t/t5405-send-pack-rewind.sh                      | 3 +++
 t/t5407-post-rewrite-hook.sh                     | 3 +++
 t/t5410-receive-pack-alternates.sh               | 3 +++
 t/t5500-fetch-pack.sh                            | 3 +++
 t/t5501-fetch-push-alternates.sh                 | 3 +++
 t/t5502-quickfetch.sh                            | 3 +++
 t/t5503-tagfollow.sh                             | 3 +++
 t/t5504-fetch-receive-strict.sh                  | 3 +++
 t/t5505-remote.sh                                | 3 +++
 t/t5506-remote-groups.sh                         | 3 +++
 t/t5509-fetch-push-namespaces.sh                 | 3 +++
 t/t5510-fetch.sh                                 | 3 +++
 t/t5512-ls-remote.sh                             | 3 +++
 t/t5514-fetch-multiple.sh                        | 3 +++
 t/t5516-fetch-push.sh                            | 3 +++
 t/t5517-push-mirror.sh                           | 3 +++
 t/t5518-fetch-exit-status.sh                     | 3 +++
 t/t5519-push-alternates.sh                       | 3 +++
 t/t5520-pull.sh                                  | 3 +++
 t/t5521-pull-options.sh                          | 3 +++
 t/t5523-push-upstream.sh                         | 3 +++
 t/t5526-fetch-submodules.sh                      | 3 +++
 t/t5527-fetch-odd-refs.sh                        | 3 +++
 t/t5528-push-default.sh                          | 3 +++
 t/t5531-deep-submodule-push.sh                   | 3 +++
 t/t5533-push-cas.sh                              | 3 +++
 t/t5534-push-signed.sh                           | 3 +++
 t/t5537-fetch-shallow.sh                         | 3 +++
 t/t5538-push-shallow.sh                          | 3 +++
 t/t5539-fetch-http-shallow.sh                    | 3 +++
 t/t5540-http-push-webdav.sh                      | 3 +++
 t/t5541-http-push-smart.sh                       | 3 +++
 t/t5542-push-http-shallow.sh                     | 3 +++
 t/t5543-atomic-push.sh                           | 3 +++
 t/t5545-push-options.sh                          | 3 +++
 t/t5550-http-fetch-dumb.sh                       | 3 +++
 t/t5551-http-fetch-smart.sh                      | 3 +++
 t/t5553-set-upstream.sh                          | 3 +++
 t/t5560-http-backend-noserver.sh                 | 3 +++
 t/t5561-http-backend.sh                          | 3 +++
 t/t5570-git-daemon.sh                            | 3 +++
 t/t5571-pre-push-hook.sh                         | 3 +++
 t/t5580-unc-paths.sh                             | 3 +++
 t/t5581-http-curl-verbose.sh                     | 3 +++
 t/t5582-fetch-negative-refspec.sh                | 3 +++
 t/t5601-clone.sh                                 | 3 +++
 t/t5604-clone-reference.sh                       | 3 +++
 t/t5605-clone-local.sh                           | 3 +++
 t/t5606-clone-options.sh                         | 3 +++
 t/t5607-clone-bundle.sh                          | 3 +++
 t/t5609-clone-branch.sh                          | 3 +++
 t/t5610-clone-detached.sh                        | 3 +++
 t/t5611-clone-config.sh                          | 3 +++
 t/t5612-clone-refspec.sh                         | 3 +++
 t/t5616-partial-clone.sh                         | 3 +++
 t/t5617-clone-submodules-remote.sh               | 3 +++
 t/t5700-protocol-v1.sh                           | 3 +++
 t/t5701-git-serve.sh                             | 3 +++
 t/t5702-protocol-v2.sh                           | 3 +++
 t/t5703-upload-pack-ref-in-want.sh               | 3 +++
 t/t5801-remote-helpers.sh                        | 3 +++
 t/t6000-rev-list-misc.sh                         | 3 +++
 t/t6001-rev-list-graft.sh                        | 3 +++
 t/t6004-rev-list-path-optim.sh                   | 3 +++
 t/t6006-rev-list-format.sh                       | 3 +++
 t/t6007-rev-list-cherry-pick-file.sh             | 3 +++
 t/t6008-rev-list-submodule.sh                    | 3 +++
 t/t6009-rev-list-parent.sh                       | 3 +++
 t/t6012-rev-list-simplify.sh                     | 3 +++
 t/t6013-rev-list-reverse-parents.sh              | 3 +++
 t/t6016-rev-list-graph-simplify-history.sh       | 3 +++
 t/t6017-rev-list-stdin.sh                        | 3 +++
 t/t6018-rev-list-glob.sh                         | 3 +++
 t/t6019-rev-list-ancestry-path.sh                | 3 +++
 t/t6030-bisect-porcelain.sh                      | 3 +++
 t/t6040-tracking-info.sh                         | 3 +++
 t/t6050-replace.sh                               | 3 +++
 t/t6101-rev-parse-parents.sh                     | 3 +++
 t/t6110-rev-list-sparse.sh                       | 3 +++
 t/t6111-rev-list-treesame.sh                     | 3 +++
 t/t6112-rev-list-filters-objects.sh              | 3 +++
 t/t6120-describe.sh                              | 3 +++
 t/t6200-fmt-merge-msg.sh                         | 3 +++
 t/t6300-for-each-ref.sh                          | 3 +++
 t/t6302-for-each-ref-filter.sh                   | 3 +++
 t/t6400-merge-df.sh                              | 3 +++
 t/t6402-merge-rename.sh                          | 3 +++
 t/t6404-recursive-merge.sh                       | 3 +++
 t/t6405-merge-symlinks.sh                        | 3 +++
 t/t6406-merge-attr.sh                            | 3 +++
 t/t6407-merge-binary.sh                          | 3 +++
 t/t6409-merge-subtree.sh                         | 3 +++
 t/t6411-merge-filemode.sh                        | 3 +++
 t/t6412-merge-large-rename.sh                    | 3 +++
 t/t6413-merge-crlf.sh                            | 3 +++
 t/t6414-merge-rename-nocruft.sh                  | 3 +++
 t/t6415-merge-dir-to-symlink.sh                  | 3 +++
 t/t6416-recursive-corner-cases.sh                | 3 +++
 t/t6417-merge-ours-theirs.sh                     | 3 +++
 t/t6418-merge-text-auto.sh                       | 3 +++
 t/t6419-merge-ignorecase.sh                      | 3 +++
 t/t6422-merge-rename-corner-cases.sh             | 3 +++
 t/t6425-merge-rename-delete.sh                   | 3 +++
 t/t6427-diff3-conflict-markers.sh                | 3 +++
 t/t6430-merge-recursive.sh                       | 3 +++
 t/t6432-merge-recursive-space-options.sh         | 3 +++
 t/t6433-merge-toplevel.sh                        | 3 +++
 t/t6434-merge-recursive-rename-options.sh        | 3 +++
 t/t6436-merge-overwrite.sh                       | 3 +++
 t/t6437-submodule-merge.sh                       | 3 +++
 t/t6439-merge-co-error-msgs.sh                   | 3 +++
 t/t6501-freshen-objects.sh                       | 3 +++
 t/t7003-filter-branch.sh                         | 3 +++
 t/t7004-tag.sh                                   | 3 +++
 t/t7030-verify-tag.sh                            | 3 +++
 t/t7060-wtstatus.sh                              | 3 +++
 t/t7063-status-untracked-cache.sh                | 3 +++
 t/t7064-wtstatus-pv2.sh                          | 3 +++
 t/t7102-reset.sh                                 | 3 +++
 t/t7113-post-index-change-hook.sh                | 3 +++
 t/t7201-co.sh                                    | 3 +++
 t/t7400-submodule-basic.sh                       | 3 +++
 t/t7403-submodule-sync.sh                        | 3 +++
 t/t7406-submodule-update.sh                      | 3 +++
 t/t7407-submodule-foreach.sh                     | 3 +++
 t/t7409-submodule-detached-work-tree.sh          | 3 +++
 t/t7417-submodule-path-url.sh                    | 3 +++
 t/t7501-commit-basic-functionality.sh            | 3 +++
 t/t7502-commit-porcelain.sh                      | 3 +++
 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh | 3 +++
 t/t7504-commit-msg-hook.sh                       | 3 +++
 t/t7505-prepare-commit-msg-hook.sh               | 3 +++
 t/t7510-signed-commit.sh                         | 3 +++
 t/t7512-status-help.sh                           | 3 +++
 t/t7517-per-repo-email.sh                        | 3 +++
 t/t7600-merge.sh                                 | 3 +++
 t/t7608-merge-messages.sh                        | 3 +++
 t/t7610-mergetool.sh                             | 3 +++
 t/t7611-merge-abort.sh                           | 3 +++
 t/t7612-merge-verify-signatures.sh               | 3 +++
 t/t7614-merge-signoff.sh                         | 3 +++
 t/t7701-repack-unpack-unreachable.sh             | 3 +++
 t/t7800-difftool.sh                              | 3 +++
 t/t7810-grep.sh                                  | 3 +++
 t/t8001-annotate.sh                              | 3 +++
 t/t8002-blame.sh                                 | 3 +++
 t/t8003-blame-corner-cases.sh                    | 3 +++
 t/t8004-blame-with-conflicts.sh                  | 3 +++
 t/t8012-blame-colors.sh                          | 3 +++
 t/t9001-send-email.sh                            | 3 +++
 t/t9100-git-svn-basic.sh                         | 3 +++
 t/t9145-git-svn-master-branch.sh                 | 3 +++
 t/t9151-svn-mergeinfo.sh                         | 3 +++
 t/t9155-git-svn-fetch-deleted-tag.sh             | 3 +++
 t/t9156-git-svn-fetch-deleted-tag-2.sh           | 3 +++
 t/t9163-git-svn-reset-clears-caches.sh           | 3 +++
 t/t9169-git-svn-dcommit-crlf.sh                  | 3 +++
 t/t9300-fast-import.sh                           | 3 +++
 t/t9301-fast-import-notes.sh                     | 3 +++
 t/t9350-fast-export.sh                           | 3 +++
 t/t9351-fast-export-anonymize.sh                 | 3 +++
 t/t9400-git-cvsserver-server.sh                  | 3 +++
 t/t9401-git-cvsserver-crlf.sh                    | 3 +++
 t/t9402-git-cvsserver-refs.sh                    | 3 +++
 t/t9500-gitweb-standalone-no-errors.sh           | 3 +++
 t/t9501-gitweb-standalone-http-status.sh         | 3 +++
 t/t9502-gitweb-standalone-parse-output.sh        | 3 +++
 t/t9600-cvsimport.sh                             | 3 +++
 t/t9601-cvsimport-vendor-branch.sh               | 3 +++
 t/t9602-cvsimport-branches-tags.sh               | 3 +++
 t/t9603-cvsimport-patchsets.sh                   | 3 +++
 t/t9800-git-p4-basic.sh                          | 3 +++
 t/t9801-git-p4-branch.sh                         | 3 +++
 t/t9806-git-p4-options.sh                        | 3 +++
 t/t9807-git-p4-submit.sh                         | 3 +++
 t/t9811-git-p4-label-import.sh                   | 3 +++
 t/t9902-completion.sh                            | 3 +++
 t/t9903-bash-prompt.sh                           | 3 +++
 325 files changed, 974 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6c27b886b8..50e0b90073 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -13,6 +13,7 @@ esac
 make
 case "$jobname" in
 linux-gcc)
+	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	make test
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
@@ -22,6 +23,7 @@ linux-gcc)
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_ADD_I_USE_BUILTIN=1
+	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	make test
 	;;
 linux-clang)
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 960ed150cb..0a396c95e5 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -4,6 +4,9 @@ test_description='.git file
 
 Verify that plumbing commands work when .git is a file
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 objpath() {
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index b63ba62e5d..0d43189048 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -2,6 +2,9 @@
 
 test_description='CRLF conversion'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 has_cr() {
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index f6deaf498b..adf862aef1 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -2,6 +2,9 @@
 
 test_description='blob conversion via gitattributes'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 TEST_ROOT="$PWD"
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index bfc4fb9af5..ccdc91c41c 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -2,6 +2,9 @@
 
 test_description='working-tree-encoding conversion via gitattributes'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 GIT_TRACE_WORKING_TREE_ENCODING=1 && export GIT_TRACE_WORKING_TREE_ENCODING
diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index 5b927b76fe..068b784e72 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -2,6 +2,9 @@
 
 test_description='Test commands behavior when given invalid argument value'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 608673fb77..368f7d515b 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -2,6 +2,9 @@
 
 test_description='Various filesystem issues'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 auml=$(printf '\303\244')
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index 58c0b7e9b6..c3c2770ab3 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -2,6 +2,9 @@
 
 test_description='previous branch syntax @{-n}'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'branch -d @{-1}' '
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 181956b241..57caa3a73f 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -2,6 +2,9 @@
 
 test_description='read-tree -m -u checks working tree files'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1008-read-tree-overlay.sh b/t/t1008-read-tree-overlay.sh
index cf96016844..edb89447c7 100755
--- a/t/t1008-read-tree-overlay.sh
+++ b/t/t1008-read-tree-overlay.sh
@@ -2,6 +2,9 @@
 
 test_description='test multi-tree read-tree without merging'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1009-read-tree-new-index.sh b/t/t1009-read-tree-new-index.sh
index 59b3aa4bc4..b9bab37ac0 100755
--- a/t/t1009-read-tree-new-index.sh
+++ b/t/t1009-read-tree-new-index.sh
@@ -2,6 +2,9 @@
 
 test_description='test read-tree into a fresh index file'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1021-rerere-in-workdir.sh b/t/t1021-rerere-in-workdir.sh
index 301e071ff7..9177871c99 100755
--- a/t/t1021-rerere-in-workdir.sh
+++ b/t/t1021-rerere-in-workdir.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='rerere run in a workdir'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success SYMLINKS setup '
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index f35a73dd20..d731322633 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -2,6 +2,9 @@
 
 test_description='sparse checkout scope tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 84acfc48b6..25e68ca036 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -2,6 +2,9 @@
 
 test_description='sparse checkout builtin tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 list_files() {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 825d9a184f..67e201b5c1 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -5,6 +5,9 @@
 
 test_description='Test git config in different settings'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'clear default config' '
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 2dc853d1be..c573438f98 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -5,6 +5,9 @@
 
 test_description='Test shared repository initialization'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4c01e08551..4ae6f50c02 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='Test git update-ref and basic ref logging'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 Z=$ZERO_OID
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 5d955c3bff..aaf32f3b07 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='show-ref'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 74af927fba..531059b871 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -2,6 +2,9 @@
 
 test_description='test main ref store api'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 RUN="test-tool ref-store main"
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 36b7ef5046..126518c155 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -2,6 +2,9 @@
 
 test_description='test submodule ref store api'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 RUN="test-tool ref-store submodule:sub"
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 9a84858118..aede1c20d7 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -2,6 +2,9 @@
 
 test_description='test worktree ref store api'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 RWT="test-tool ref-store worktree:wt"
diff --git a/t/t1408-packed-refs.sh b/t/t1408-packed-refs.sh
index 1e44a17eea..fd58388232 100755
--- a/t/t1408-packed-refs.sh
+++ b/t/t1408-packed-refs.sh
@@ -2,6 +2,9 @@
 
 test_description='packed-refs entries are covered by loose refs'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 730a43d9dd..aa02ca488d 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='Test prune and reflog expiration'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check_have () {
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 985daf1def..f6fecff671 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='Test reflog display routines'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
index c730600d8a..140914aa29 100755
--- a/t/t1413-reflog-detach.sh
+++ b/t/t1413-reflog-detach.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='Test reflog interaction with detached HEAD'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 reset_state () {
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index 1181a9fb28..c463b5fc29 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='various tests of reflog walk (log -g) behavior'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'set up some reflog entries' '
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index f6e741c6c0..a26a6b782d 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -2,6 +2,9 @@
 
 test_description='reference transaction hooks'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index c7878a60ed..8c4353746b 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='Test handling of ref names that check-ref-format rejects'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 408b97d5af..d23da4e8de 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test git rev-parse'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # usage: [options] label is-bare is-inside-git is-inside-work prefix git-dir absolute-git-dir
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index dc9fe3cbf1..e4343c49b2 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -6,6 +6,9 @@ test_description='test git rev-parse --verify'
 
 exec </dev/null
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 add_line_into_file()
diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index 4969edb314..9bd0307b5d 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -2,6 +2,9 @@
 
 test_description='test @{-N} syntax'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index e2ae15a2cf..694d74fc01 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -4,6 +4,9 @@ test_description='test git rev-parse diagnosis for invalid argument'
 
 exec </dev/null
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_did_you_mean ()
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index dfc0d96d8a..521233a3c3 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -2,6 +2,9 @@
 
 test_description='test <branch>@{upstream} syntax'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 4a9964e9dc..8e73633761 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test various @{X} syntax combinations together'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check() {
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index e0a49a651f..cfb2ea5e04 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -2,6 +2,9 @@
 
 test_description='tests for ref^{stuff}'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 18fa6cf40d..2ef1f2b7e8 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -20,6 +20,9 @@ one tagged as v1.0.0.  They all have one regular file each.
 
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 if ! test_have_prereq SHA1
diff --git a/t/t1513-rev-parse-prefix.sh b/t/t1513-rev-parse-prefix.sh
index 87ec3ae714..d151ef9218 100755
--- a/t/t1513-rev-parse-prefix.sh
+++ b/t/t1513-rev-parse-prefix.sh
@@ -2,6 +2,9 @@
 
 test_description='Tests for rev-parse --prefix'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index 788cc91e45..173ba2792b 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test <branch>@{push} syntax'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 resolve () {
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 12a5568844..7d4a6f1e93 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -2,6 +2,9 @@
 
 test_description='split index mode tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # We need total control of index splitting here
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index fc9aad530e..8879a78b85 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -4,6 +4,9 @@
 
 test_description='git checkout to switch between branches with symlink<->dir'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2009-checkout-statinfo.sh b/t/t2009-checkout-statinfo.sh
index f3c2152087..9af4d6ca5e 100755
--- a/t/t2009-checkout-statinfo.sh
+++ b/t/t2009-checkout-statinfo.sh
@@ -2,6 +2,9 @@
 
 test_description='checkout should leave clean stat info'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 2e47fe01cf..3f5431e033 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -2,6 +2,9 @@
 
 test_description='checkout and pathspecs/refspecs ambiguities'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index 0e8d56aa76..fede33ff1f 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -2,6 +2,9 @@
 
 test_description='checkout switching away from an invalid branch'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index e7ba8c505f..16bf19f7ee 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -2,6 +2,9 @@
 
 test_description='checkout can switch to last branch and merge base'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
index 37bdcedcc9..669a70c76f 100755
--- a/t/t2015-checkout-unborn.sh
+++ b/t/t2015-checkout-unborn.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='checkout from unborn branch'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 655f278c5f..999e976c62 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -7,6 +7,9 @@ test_description='git checkout --orphan
 
 Main Tests for --orphan functionality.'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 TEST_FILE=foo
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index b748db9946..45d87c23b1 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='checkout into detached HEAD state'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check_detached () {
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index 6844afafc0..fc0f5b775c 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='checkout $tree -- $paths'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
index fca3f85824..f2f4f5b3ac 100755
--- a/t/t2023-checkout-m.sh
+++ b/t/t2023-checkout-m.sh
@@ -4,6 +4,9 @@ test_description='checkout -m -- <conflicted path>
 
 Ensures that checkout -m on a resolved file restores the conflicted file'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index bcba1bf90c..4e1419ca98 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -2,6 +2,9 @@
 
 test_description='tests for git branch --track'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 309199bca2..3fe29fc3ee 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -2,6 +2,9 @@
 
 test_description='undoing resolution'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check_resolve_undo () {
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 68c9101b02..4de9299705 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -2,6 +2,9 @@
 
 test_description='switch basic functionality'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 89e5a142c9..6941769c9a 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -2,6 +2,9 @@
 
 test_description='restore basic functionality'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 5a7495474a..35cef266e9 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -2,6 +2,9 @@
 
 test_description='test git worktree add'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index a6ce7f590b..e6fc27de1e 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -2,6 +2,9 @@
 
 test_description='prune $GIT_DIR/worktrees'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success initialize '
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 795ddca2e4..3b23b0fdb7 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -2,6 +2,9 @@
 
 test_description='test git worktree list'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index e1b2bfd87e..cca2aea658 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -2,6 +2,9 @@
 
 test_description='Combination of submodules and multiple worktrees'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 base_path=$(pwd -P)
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a0b832d59e..04b568cf21 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -5,6 +5,9 @@
 
 test_description='git branch assorted tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 3733cd0091..532cdbe9ae 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -2,6 +2,9 @@
 
 test_description='branch --contains <commit>, --no-contains <commit> --merged, and --no-merged'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3202-show-branch-octopus.sh b/t/t3202-show-branch-octopus.sh
index 6adf47869c..bbf7129dd8 100755
--- a/t/t3202-show-branch-octopus.sh
+++ b/t/t3202-show-branch-octopus.sh
@@ -2,6 +2,9 @@
 
 test_description='test show-branch with more than 8 heads'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 numbers="1 2 3 4 5 6 7 8 9 10"
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index d65586541d..a2144dd8e5 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git branch display tests'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 698d9cc4f3..dd315ebf04 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -6,6 +6,9 @@ Branch name arguments are usually names which are taken to be inside of
 refs/heads/, but we interpret some magic syntax like @{-1}, @{upstream}, etc.
 This script aims to check the behavior of those corner cases.
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 expect_branch() {
diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 289625c464..8b54a9252b 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='basic branch output coloring'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'set up some sample branches' '
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 6eb344be03..3813ddc85e 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -2,6 +2,9 @@
 
 test_description='range-diff tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Note that because of the range-diff's heuristics, test_commit does more
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index f41b2afb99..90eea19564 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -9,6 +9,9 @@ test_description='git pack-refs should not change the branch semantic
 This test runs git pack-refs and git show-ref and checks that the branch
 semantic is still the same.
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'enable reflogs' '
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index 3b7caca421..f3d9c6b6b6 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='tests for the peel_ref optimization of packed-refs'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'create annotated tag in refs/tags' '
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index 7217c5e222..1564befe00 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -5,6 +5,9 @@
 
 test_description='Test commit notes index (expensive!)'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 create_repo () {
diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index 704aee81ef..16f3438355 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -2,6 +2,9 @@
 
 test_description='Test commit notes organized in subtrees'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 number_of_commits=100
diff --git a/t/t3304-notes-mixed.sh b/t/t3304-notes-mixed.sh
index 1709e8c00b..6a7b8e2829 100755
--- a/t/t3304-notes-mixed.sh
+++ b/t/t3304-notes-mixed.sh
@@ -2,6 +2,9 @@
 
 test_description='Test notes trees that also contain non-notes'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 number_of_commits=100
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 823fdbda1f..f86975414c 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -5,6 +5,9 @@
 
 test_description='Test merging of notes trees in multiple worktrees'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup commit' '
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 40d2975995..61577591d0 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -8,6 +8,9 @@ test_description='git rebase assorted tests
 This test runs git rebase and checks that the author information is not lost
 among other things.
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 GIT_AUTHOR_NAME=author@name
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 6e032716a6..d79a11b686 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -5,6 +5,9 @@
 
 test_description='git rebase --merge test'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 T="A quick brown fox
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index a927774910..c9936cb1d9 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -5,6 +5,9 @@
 
 test_description='git rebase --merge --skip tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1e56696e4f..9c91524e12 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -25,6 +25,9 @@ Initial setup:
  where A, B, D and G all touch file1, and one, two, three, four all
  touch file "conflict".
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index 860e63e444..d8f6d2e3cb 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -2,6 +2,9 @@
 
 test_description='rebase should handle arbitrary git message'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 4afc528165..863db3ac4c 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -2,6 +2,9 @@
 
 test_description='messages from rebase operation'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 97efea0f56..e3c1851f40 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -2,6 +2,9 @@
 
 test_description='git rebase --abort tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 ### Test that we handle space characters properly
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index d2bd7c17b0..6dd56c4c15 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -2,6 +2,9 @@
 
 test_description='rebasing a commit with multi-line first paragraph.'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 3b340f1ece..609efc96f9 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -6,6 +6,9 @@ test_description='git rebase -p should preserve merges
 
 Run "git rebase -p" and check that merges are properly carried along
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 if ! test_have_prereq REBASE_P; then
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 21632a984e..07597643c5 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -4,6 +4,9 @@ test_description='git rebase --root
 
 Tests if git rebase --root --onto <newparent> can rebase the root commit.
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 log_with_names () {
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index b6833e9a5f..86a1b82d65 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -2,6 +2,9 @@
 
 test_description='git rebase with its hook(s)'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 7bab6000dc..35eb8e2bb2 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -2,6 +2,9 @@
 
 test_description='auto squash'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index 9c2548423b..0f5b814aaf 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -2,6 +2,9 @@
 
 test_description='git rebase --onto A...B'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 7a2da972fd..445cb843ba 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -2,6 +2,9 @@
 
 test_description='git rebase --continue tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 1f32faa4a4..c5fe58d68b 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -2,6 +2,9 @@
 
 test_description='git rebase - test patch id computation'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 scramble () {
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index ca331733fb..95facc49aa 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='git rebase --autostash tests'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 5839719ba1..254ed18452 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -4,6 +4,9 @@ test_description='git rebase tests for -Xsubtree
 
 This test runs git rebase and tests the subtree strategy.
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index b454f400eb..22d929bd31 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -18,6 +18,9 @@ Initial setup:
      \
       Conflicting-G
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 172562789e..af862e5bcc 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -5,6 +5,9 @@
 
 test_description='git rebase --fork-point test'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # A---B---D---E    (master)
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index a29eda87e9..112a18d630 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -5,6 +5,9 @@
 
 test_description='ensure rebase fast-forwards commits when possible'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index c7c835cde9..26fd33cbed 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -14,6 +14,9 @@ Initial setup:
     5 - 6          second
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 compare_msg () {
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index 54120b09d6..d169bc511d 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -5,6 +5,9 @@
 
 test_description='test rebase --[no-]gpg-sign'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 2b8d9cb38e..99905dd49a 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -8,6 +8,9 @@ test_description='git cherry should detect patches integrated upstream
 This test cherry-picks one local change of two into master branch, and
 checks that git cherry only returns the second patch in the local branch
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 GIT_AUTHOR_EMAIL=bogus_email_address
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 3669dfb1be..6a10714e22 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -10,6 +10,9 @@ test_description='test cherry-pick and revert with renames
 
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 8b635a196d..774ad9ce14 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -8,6 +8,9 @@ test_description='cherry picking and reverting a merge
 
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index e27f39d1e5..00c622d5dc 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -2,6 +2,9 @@
 
 test_description='test cherry-picking (and reverting) a root commit'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index 80a0d08706..860ba0b496 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -2,6 +2,9 @@
 
 test_description='cherry-pick should rerere for conflicts'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index 5f911bb529..20cd4052d4 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -2,6 +2,9 @@
 
 test_description='test cherry-picking an empty commit'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index 9d5adbc130..a105a782f6 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -2,6 +2,9 @@
 
 test_description='test cherry-picking with --ff option'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index a21adcf0e4..e94264e578 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -9,6 +9,9 @@ test_description='test cherry-pick and revert with conflicts
 
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 pristine_detach () {
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 23070a7b73..b967bf0639 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -2,6 +2,9 @@
 
 test_description='test cherry-picking many commits'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check_head_differs_from() {
diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index 1e5b3948df..83cab7b2ed 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='Test cherry-pick with directory/file conflicts'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'Initialize repository' '
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index 6ece1d8573..ff33c6d5c9 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -2,6 +2,9 @@
 
 test_description='cherry-pick can handle submodules'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index efec8d13b6..3baa64bf99 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -5,6 +5,9 @@
 
 test_description='Test of the various options to git rm.'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Setup some files to be removed, some with funny characters
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index ca04fac417..9be7527531 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='add -i basic tests'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 923eb01f0e..bde27227b6 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -5,6 +5,9 @@
 
 test_description='i18n settings and format-patch | am pipe'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check_encoding () {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 9f7ca98967..49d52c46ad 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -5,6 +5,9 @@
 
 test_description='Test git stash'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 diff_cmp () {
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index 54ce19e353..a2d1cdec6d 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -5,6 +5,9 @@
 
 test_description='utf-8 decomposed (nfd) converted to precomposed (nfc)'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 if ! test_have_prereq UTF8_NFD_TO_NFC
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index f72d456d3b..45f68ebcdb 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -5,6 +5,9 @@
 
 test_description='Various diff formatting options'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c5e5e0da3f..276aea32a6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -5,6 +5,9 @@
 
 test_description='various format-patch tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 95a7ca7070..0b379c307b 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -2,6 +2,9 @@
 
 test_description='Return value of diffs'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 94680836ce..e873abb1da 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -2,6 +2,9 @@
 
 test_description='combined diff'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index f852136585..8014cd684b 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -9,6 +9,9 @@ test_description='Support for verbose submodule differences in git diff
 This test tries to verify the sanity of the --submodule option of git diff.
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Tested non-UTF-8 encoding
diff --git a/t/t4048-diff-combined-binary.sh b/t/t4048-diff-combined-binary.sh
index 7f9ad9fa3d..e2780e697a 100755
--- a/t/t4048-diff-combined-binary.sh
+++ b/t/t4048-diff-combined-binary.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='combined and merge diff handle binary files and textconv'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup binary merge conflict' '
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 28c053849a..a9aef7f986 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -5,6 +5,9 @@
 
 test_description='test --stat output of various commands'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index 43dd474a12..723eee4e8e 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -2,6 +2,9 @@
 
 test_description='diff order'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 create_files () {
diff --git a/t/t4057-diff-combined-paths.sh b/t/t4057-diff-combined-paths.sh
index 0b78573733..71af157bf9 100755
--- a/t/t4057-diff-combined-paths.sh
+++ b/t/t4057-diff-combined-paths.sh
@@ -2,6 +2,9 @@
 
 test_description='combined diff show only paths that are different to all parents'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # verify that diffc.expect matches output of
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 0f7a6d97a8..cbe64d5f79 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -3,6 +3,9 @@
 test_description='Test diff indent heuristic.
 
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
diff --git a/t/t4066-diff-emit-delay.sh b/t/t4066-diff-emit-delay.sh
index 6331f63b12..1983f1ebbe 100755
--- a/t/t4066-diff-emit-delay.sh
+++ b/t/t4066-diff-emit-delay.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test combined/stat/moved interaction'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # This test covers a weird 3-way interaction between "--cc -p", which will run
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-merge-base.sh
index 03487cc945..55d47352ba 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -2,6 +2,9 @@
 
 test_description='behavior of diff with symmetric-diff setups and --merge-base'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # build these situations:
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 1b420e3b5f..ee4a74b132 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -6,6 +6,9 @@
 test_description='git apply handling binary patches
 
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index d7349ced6b..0a091dc5a0 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -2,6 +2,9 @@
 
 test_description='git apply --3way'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 print_sanitized_conflicted_diff () {
diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
index 66368effd5..60deb3bf78 100755
--- a/t/t4121-apply-diffs.sh
+++ b/t/t4121-apply-diffs.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git apply for contextually independent diffs'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 echo '1
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 4acb3f336e..71deaf779d 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='apply to deeper directory without getting fooled with symlink'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 3ecbef6f8e..e1ffc04852 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -2,6 +2,9 @@
 
 test_description='git am running'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup: messages' '
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index b12b43e9e9..1f1a809c60 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -22,6 +22,9 @@ test_description='git rerere
 ++++++ [master] initial
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 3d5c4a2086..ad6d3eebe5 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -6,6 +6,9 @@
 test_description='git shortlog
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 56d34ed465..6c7a3cfc2c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2,6 +2,9 @@
 
 test_description='git log'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 . "$TEST_DIRECTORY/lib-terminal.sh"
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 586c3a86b1..8a2f8984f6 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -2,6 +2,9 @@
 
 test_description='.mailmap configurations'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 fuzz_blame () {
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 8ff8bd84c7..46ecb777f4 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -2,6 +2,9 @@
 
 test_description='git patch-id'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 60f040cab8..6c868df38d 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -5,6 +5,9 @@
 
 test_description='Test for "git log --decorate" colors'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 6cdbe4747a..1938d4a58f 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -2,6 +2,9 @@
 
 test_description='magic pathspec tests using git-log'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 85d151423d..59c258429d 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test log -L'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup (import history)' '
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index a080325098..981b83513a 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -2,6 +2,9 @@
 
 test_description='git log --graph of skewed left octopus merge.'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index d11040ce41..b3f3820dbb 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git log for a path with Bloom filters'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 GIT_TEST_COMMIT_GRAPH=0
diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
index 6e1b73ec3a..ec7ba62d67 100755
--- a/t/t4253-am-keep-cr-dos.sh
+++ b/t/t4253-am-keep-cr-dos.sh
@@ -6,6 +6,9 @@
 test_description='git-am mbox with dos line ending.
 
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Three patches which will be added as files with dos line ending.
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index c1811ea0f4..752e1fb2d2 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -2,6 +2,9 @@
 
 test_description='Test workflows involving pull request.'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 if ! test_have_prereq PERL
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index df60f18fb8..bd5f71e396 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='prune'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 day=$((60*60*24))
diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index a5eca210b8..2e56887ed5 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git pack-object --include-tag'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 TRASH=$(pwd)
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 8318781d2b..7842eb0977 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='exercise basic bitmap functionality'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 objpath () {
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index da9d59940d..c70b5db2a0 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -8,6 +8,9 @@ bail out or to proceed using it as a reachable tip, but it is _not_
 OK to proceed as if it did not exist. Otherwise we might silently
 delete objects that cannot be recovered.
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'disable reflogs' '
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index dc0446574b..f19c521292 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -2,6 +2,9 @@
 
 test_description='git pack-objects using object filtering'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Test blob:none filter.
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index a581eaf529..c92658d026 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='pack-objects object selection using sparse algorithm'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup repo' '
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index cc86ef213e..6be028f3e2 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -6,6 +6,9 @@
 test_description='See why rewinding head breaks send-pack
 
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 cnt=64
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 4aeea8f5b7..27fc6ec4f3 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='Test the post-merge hook.'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index a39b3b5c78..ed91aadd95 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='Test the post-checkout hook.'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 2762f420bc..da37b22fc5 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -2,6 +2,9 @@
 
 test_description='tracking branch update checks for git push'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
index 235fb7686a..1f5b33b562 100755
--- a/t/t5405-send-pack-rewind.sh
+++ b/t/t5405-send-pack-rewind.sh
@@ -2,6 +2,9 @@
 
 test_description='forced push to replace commit we do not have'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 80750a817e..78bffa64d7 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='Test the post-rewrite hook.'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
index f00d0da860..30a4e6bb1a 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -2,6 +2,9 @@
 
 test_description='git receive-pack with alternate ref filtering'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 3557374312..4edb8c196e 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -5,6 +5,9 @@
 
 test_description='Testing multi_ack pack fetching'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Test fetch-pack/upload-pack pair.
diff --git a/t/t5501-fetch-push-alternates.sh b/t/t5501-fetch-push-alternates.sh
index 1bc57ac03f..96ce28b6ba 100755
--- a/t/t5501-fetch-push-alternates.sh
+++ b/t/t5501-fetch-push-alternates.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='fetch/push involving alternates'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 count_objects () {
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index 7a46cbdbe6..e15a472e4c 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -2,6 +2,9 @@
 
 test_description='test quickfetch from local'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 6041a4dd32..cd1f407174 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -2,6 +2,9 @@
 
 test_description='test automatic tag following'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # End state of the repository:
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 1a16ac4c0d..7fe21b176d 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='fetch/receive strict mode'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup and inject "corrupt or missing" object' '
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index eaa6e90220..2b6e1f50f8 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -2,6 +2,9 @@
 
 test_description='git remote porcelain-ish'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 setup_repository () {
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 83d5558c0e..bf3aa85da5 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git remote group handling'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 mark() {
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index a67f792adf..f234dba91a 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='fetch/push involving ref namespaces'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5d673358f9..4af490b6db 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -5,6 +5,9 @@ test_description='Per branch config variables affects "git fetch".
 
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index e98c3a0174..a892807de2 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -2,6 +2,9 @@
 
 test_description='git ls-remote'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 generate_references () {
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index bd202ec6f3..f12a83f82b 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -2,6 +2,9 @@
 
 test_description='fetch --all works correctly'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 setup_repository () {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index d11382f769..7003467523 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -14,6 +14,9 @@ This test checks the following functionality:
 * reflogs
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index e4edd56404..aa6405b452 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -2,6 +2,9 @@
 
 test_description='pushing to a mirror repository'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5518-fetch-exit-status.sh b/t/t5518-fetch-exit-status.sh
index c2060bb870..a94d0744d0 100755
--- a/t/t5518-fetch-exit-status.sh
+++ b/t/t5518-fetch-exit-status.sh
@@ -5,6 +5,9 @@
 
 test_description='fetch exit status test'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index 11fcd37700..0f199d0ccb 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -2,6 +2,9 @@
 
 test_description='push to a repository that borrows from elsewhere'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9fae07cdfa..b6b21c6cd1 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -2,6 +2,9 @@
 
 test_description='pulling into void'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 modify () {
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db1a381cd9..f0806f3eb5 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -2,6 +2,9 @@
 
 test_description='pull options'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index e47b5db5d6..0e6c7c251b 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='push with --set-upstream'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index dd8e423d25..40fb276e0e 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -3,6 +3,9 @@
 
 test_description='Recursive "git fetch" for submodules'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 pwd=$(pwd)
diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
index 3b0cb98422..4aa1fb7281 100755
--- a/t/t5527-fetch-odd-refs.sh
+++ b/t/t5527-fetch-odd-refs.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test fetching of oddly-named refs'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # afterwards we will have:
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index f0a287d97d..b39b5171dc 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='check various push.default settings'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup bare remotes' '
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 4ad059e6be..010f5a0207 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -2,6 +2,9 @@
 
 test_description='test push with submodules'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 7813e8470e..a7f0f098dd 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -2,6 +2,9 @@
 
 test_description='compare & swap push force/delete safety'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 setup_srcdst_basic () {
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index af0385fb89..6ab458684d 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -2,6 +2,9 @@
 
 test_description='signed push'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index a55202d2d3..6de384a5ea 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -2,6 +2,9 @@
 
 test_description='fetch/clone from a shallow clone'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 commit() {
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index ecbf84d21c..1253429d5d 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -2,6 +2,9 @@
 
 test_description='push from/to a shallow clone'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 commit() {
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 82aa99ae87..1da2a7533e 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -2,6 +2,9 @@
 
 test_description='fetch/clone from a shallow clone over http'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 450321fddb..751116e123 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -7,6 +7,9 @@ test_description='test WebDAV http-push
 
 This test runs various sanity checks on http-push.'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 187454f5dd..2836b87239 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='test smart pushing over http via http-backend'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 ROOT_PATH="$PWD"
diff --git a/t/t5542-push-http-shallow.sh b/t/t5542-push-http-shallow.sh
index ddc1db722d..0feec9c449 100755
--- a/t/t5542-push-http-shallow.sh
+++ b/t/t5542-push-http-shallow.sh
@@ -2,6 +2,9 @@
 
 test_description='push from/to a shallow clone over http'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 620c30d58f..16a8fc7535 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -2,6 +2,9 @@
 
 test_description='pushing to a repository using the atomic push option'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 mk_repo_pair () {
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 38e6f7340e..202d75aebe 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -2,6 +2,9 @@
 
 test_description='pushing to a repository using push options'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 mk_repo_pair () {
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 483578b2d7..9ec91792c3 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test dumb fetching over http via static file'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index e40e9ed52f..310b89dbab 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test smart fetching over http via http-backend'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 7622981cbf..e78a21881f 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='"git fetch/pull --set-upstream" basic tests.'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check_config () {
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index 9fafcf1945..5561b7d012 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test git-http-backend-noserver'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 HTTPD_DOCUMENT_ROOT_PATH="$TRASH_DIRECTORY"
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index 6eb0294978..cba2dffdb0 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test git-http-backend'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 8f69a7854f..2e99a331c5 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test fetching over git protocol'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index ac53d63869..971ed3da4b 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='check pre-push hooks'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Setup hook that always succeeds
diff --git a/t/t5580-unc-paths.sh b/t/t5580-unc-paths.sh
index cf768b3a27..da4c94cce1 100755
--- a/t/t5580-unc-paths.sh
+++ b/t/t5580-unc-paths.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='various Windows-only path tests'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 if test_have_prereq CYGWIN
diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
index 927aad0820..907bb062d6 100755
--- a/t/t5581-http-curl-verbose.sh
+++ b/t/t5581-http-curl-verbose.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test GIT_CURL_VERBOSE'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
index 8c61e28fec..608e9aa189 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -5,6 +5,9 @@ test_description='"git fetch" with negative refspecs.
 
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 7df3c5373a..e01c5fe02d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -2,6 +2,9 @@
 
 test_description=clone
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 X=
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 2f7be23044..20fbb1e9a3 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='test clone --reference'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 base_dir=$(pwd)
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index af23419ebf..94028044b0 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test local clone'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 repo_is_hardlinked() {
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 7f082fb23b..3893a49e6d 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='basic clone options'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 26985f4b44..6e2e4adbb4 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='some bundle related tests'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
index 6e7a7be052..e4d5124f89 100755
--- a/t/t5609-clone-branch.sh
+++ b/t/t5609-clone-branch.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='clone --branch option'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check_HEAD() {
diff --git a/t/t5610-clone-detached.sh b/t/t5610-clone-detached.sh
index 8b0d607df1..ba63ba8f42 100755
--- a/t/t5610-clone-detached.sh
+++ b/t/t5610-clone-detached.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test cloning a repository with detached HEAD'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 head_is_detached() {
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 8e0fd39823..be4ae10c82 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='tests for git clone -c key=value'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'clone -c sets config in cloned repo' '
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index e3b436d8ae..9e37f7fef7 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test refspec written by clone-command'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index f4d49d8335..b2c3ed4088 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -2,6 +2,9 @@
 
 test_description='git partial clone'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # create a normal "src" repo where we can later create new commits.
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index 1a041df10b..cba468fc53 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -2,6 +2,9 @@
 
 test_description='Test cloning repos with submodules using remote-tracking branches'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 pwd=$(pwd)
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 022901b9eb..7f0056c1ed 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -8,6 +8,9 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_PROTOCOL_VERSION=0
 export GIT_TEST_PROTOCOL_VERSION
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Test protocol v1 with 'git://' transport
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index a1f5fdc9fd..66c47e61d8 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -2,6 +2,9 @@
 
 test_description='test protocol v2 server commands'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'test capability advertisement' '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7d5b17909b..f1f77fe089 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -4,6 +4,9 @@ test_description='test git wire-protocol version 2'
 
 TEST_NO_CREATE_REPO=1
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Test protocol v2 with 'git://' transport
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index b46940b725..c3a52d478f 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -2,6 +2,9 @@
 
 test_description='upload-pack ref-in-want'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 get_actual_refs () {
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 0f04b6cddb..1ecefb57fe 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -5,6 +5,9 @@
 
 test_description='Test remote-helper import and export commands'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index fc4d55dcb2..664000adf0 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -2,6 +2,9 @@
 
 test_description='miscellaneous rev-list tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 7504ba4751..67c384f1e8 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -2,6 +2,9 @@
 
 test_description='Revision traversal vs grafts and path limiter'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6004-rev-list-path-optim.sh b/t/t6004-rev-list-path-optim.sh
index 3e8c42ee0b..ff788199e3 100755
--- a/t/t6004-rev-list-path-optim.sh
+++ b/t/t6004-rev-list-path-optim.sh
@@ -13,6 +13,9 @@ test_description='git rev-list trivial path optimization test
 
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 99a1eaf332..bbbd577f10 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -5,6 +5,9 @@
 
 test_description='git rev-list --pretty=format test'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index f0268372d2..51547ac3a5 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -2,6 +2,9 @@
 
 test_description='test git rev-list --cherry-pick -- file'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # A---B---D---F
diff --git a/t/t6008-rev-list-submodule.sh b/t/t6008-rev-list-submodule.sh
index c4af9ca0a7..871ace31e2 100755
--- a/t/t6008-rev-list-submodule.sh
+++ b/t/t6008-rev-list-submodule.sh
@@ -5,6 +5,9 @@
 
 test_description='git rev-list involving submodules that this repo has'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 916d9692bc..114f755d52 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -2,6 +2,9 @@
 
 test_description='ancestor culling and limiting by parent number'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check_revlist () {
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index fd202fcb94..d163c24859 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -2,6 +2,9 @@
 
 test_description='merge simplification'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 note () {
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
index 89458d370f..0298174956 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -2,6 +2,9 @@
 
 test_description='--reverse combines with --parents'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index f5e6e92f5b..3fb7ee0be4 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -7,6 +7,9 @@
 
 test_description='--graph and simplified history'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'set up rev-list --graph test' '
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index 667b37564e..e51fe7b9bc 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -5,6 +5,9 @@
 
 test_description='log family learns --stdin'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check () {
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index fe2f3cec3d..60a351c26a 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -2,6 +2,9 @@
 
 test_description='rev-list/rev-parse --glob'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 commit () {
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 353f84313f..aeb7defaa3 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -21,6 +21,9 @@ test_description='--ancestry-path'
 #  --ancestry-path G..M -- G.t == L
 #  --ancestry-path --simplify-merges G^..M -- G.t == G L
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_merge () {
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index aa226381be..7dc65c73cd 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -6,6 +6,9 @@ test_description='Tests git bisect functionality'
 
 exec </dev/null
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 add_line_into_file()
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 50a934e1b2..bc95ff6f54 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -2,6 +2,9 @@
 
 test_description='remote tracking stats'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 advance () {
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c80dc10b8f..0a53462a61 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -4,6 +4,9 @@
 #
 test_description='Tests replace refs functionality'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 7531262a5e..19a56f4a4d 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -5,6 +5,9 @@
 
 test_description='Test git rev-parse with different parent options'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_cmp_rev_output () {
diff --git a/t/t6110-rev-list-sparse.sh b/t/t6110-rev-list-sparse.sh
index 656ac7fe9d..69411862d6 100755
--- a/t/t6110-rev-list-sparse.sh
+++ b/t/t6110-rev-list-sparse.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='operations that cull histories in unusual ways'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index 4244638285..58b8d42bf3 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -13,6 +13,9 @@
 
 test_description='TREESAME and limiting'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 note () {
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index de0e5a5d36..5f39c3adb3 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -2,6 +2,9 @@
 
 test_description='git rev-list using object filtering'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Test the blob:none filter.
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index f822d5d328..360e65d3b9 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -11,6 +11,9 @@ test_description='test describe'
 #
 # First parent of a merge commit is on the same line, second parent below.
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check_describe () {
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index f3e66eaf9b..725b356d1e 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -5,6 +5,9 @@
 
 test_description='fmt-merge-msg test'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b359023189..b03740d634 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -5,6 +5,9 @@
 
 test_description='for-each-ref test'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 0a21669f56..0f3e6aa011 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -2,6 +2,9 @@
 
 test_description='test for-each-refs usage of ref-filter APIs'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 9da0838216..5fab2d2dd7 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='Test merge with directory/file conflicts'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'prepare repository' '
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 3f64f62224..227c2feb08 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='Merge-recursive merging renames'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 modify () {
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index b1c3d4dda4..bdf8169456 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='Test merge without common ancestors'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # This scenario is based on a real-world repository of Shawn Pearce.
diff --git a/t/t6405-merge-symlinks.sh b/t/t6405-merge-symlinks.sh
index 6c0a90d044..140e9e6ce6 100755
--- a/t/t6405-merge-symlinks.sh
+++ b/t/t6405-merge-symlinks.sh
@@ -8,6 +8,9 @@ test_description='merging symlinks on filesystem w/o symlink support.
 This tests that git merge-recursive writes merge results as plain files
 if core.symlinks is false.'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 76a55f838c..7fe4034d58 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -5,6 +5,9 @@
 
 test_description='per path merge controlled by merge attribute'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index 4e6c7cb77e..826deacfd7 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -2,6 +2,9 @@
 
 test_description='ask merge-recursive to merge binary files'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index b8e8b6f642..e2c1cfc9fe 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -2,6 +2,9 @@
 
 test_description='subtree merge strategy'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6411-merge-filemode.sh b/t/t6411-merge-filemode.sh
index 87741efad3..7b66abfdbb 100755
--- a/t/t6411-merge-filemode.sh
+++ b/t/t6411-merge-filemode.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='merge: handle file mode'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'set up mode change in one branch' '
diff --git a/t/t6412-merge-large-rename.sh b/t/t6412-merge-large-rename.sh
index 80777386dc..d6840078c4 100755
--- a/t/t6412-merge-large-rename.sh
+++ b/t/t6412-merge-large-rename.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='merging with large rename matrix'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 count() {
diff --git a/t/t6413-merge-crlf.sh b/t/t6413-merge-crlf.sh
index e8d65eefb5..3bd8e3e899 100755
--- a/t/t6413-merge-crlf.sh
+++ b/t/t6413-merge-crlf.sh
@@ -8,6 +8,9 @@ test_description='merge conflict in crlf repo
 
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6414-merge-rename-nocruft.sh b/t/t6414-merge-rename-nocruft.sh
index a25e730460..42824dcf49 100755
--- a/t/t6414-merge-rename-nocruft.sh
+++ b/t/t6414-merge-rename-nocruft.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='Merge-recursive merging renames'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
index 2eddcc7664..32c0b62496 100755
--- a/t/t6415-merge-dir-to-symlink.sh
+++ b/t/t6415-merge-dir-to-symlink.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='merging when a directory was replaced with a symlink'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'create a commit where dir a/b changed to symlink' '
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 887c2195a9..6a740771ed 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -2,6 +2,9 @@
 
 test_description='recursive merge corner cases involving criss-cross merges'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index 0aebc6c028..e7883f890a 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='Merge-recursive ours and theirs variants'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6418-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
index 30983d18b1..91b43de00d 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -12,6 +12,9 @@ test_description='CRLF merge conflict across text=auto change
 *+ [side^] Initial
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
diff --git a/t/t6419-merge-ignorecase.sh b/t/t6419-merge-ignorecase.sh
index 531850d834..9996a94431 100755
--- a/t/t6419-merge-ignorecase.sh
+++ b/t/t6419-merge-ignorecase.sh
@@ -2,6 +2,9 @@
 
 test_description='git-merge with case-changing rename on case-insensitive file system'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 if ! test_have_prereq CASE_INSENSITIVE_FS
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 78bfaf17f0..70c8af7f51 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -3,6 +3,9 @@
 test_description="recursive merge corner cases w/ renames but not criss-crosses"
 # t6036 has corner cases that involve both criss-cross merges and renames
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6425-merge-rename-delete.sh b/t/t6425-merge-rename-delete.sh
index f79d021590..e58e3dfba1 100755
--- a/t/t6425-merge-rename-delete.sh
+++ b/t/t6425-merge-rename-delete.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='Merge-recursive rename/delete conflict message'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'rename/delete' '
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index f4655bb358..c192ee4e42 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -2,6 +2,9 @@
 
 test_description='recursive merge diff3 style conflict markers'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Setup:
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index 9c08e63af2..acb2868260 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -2,6 +2,9 @@
 
 test_description='merge-recursive backend test'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6432-merge-recursive-space-options.sh b/t/t6432-merge-recursive-space-options.sh
index b56180ee4a..1333cbb148 100755
--- a/t/t6432-merge-recursive-space-options.sh
+++ b/t/t6432-merge-recursive-space-options.sh
@@ -11,6 +11,9 @@ test_description='merge-recursive space options
 *   ok 1: setup
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
diff --git a/t/t6433-merge-toplevel.sh b/t/t6433-merge-toplevel.sh
index e29c284b9b..2d51b2d08c 100755
--- a/t/t6433-merge-toplevel.sh
+++ b/t/t6433-merge-toplevel.sh
@@ -2,6 +2,9 @@
 
 test_description='"git merge" top-level frontend'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 t3033_reset () {
diff --git a/t/t6434-merge-recursive-rename-options.sh b/t/t6434-merge-recursive-rename-options.sh
index 3d9fae68c4..7e877e96e2 100755
--- a/t/t6434-merge-recursive-rename-options.sh
+++ b/t/t6434-merge-recursive-rename-options.sh
@@ -26,6 +26,9 @@ they are rounded down (see, e.g., Documentation/diff-generate-patch.txt, which
 mentions this in a different context).
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 get_expected_stages () {
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index dd9376842f..7d5691c1b4 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -4,6 +4,9 @@ test_description='git-merge
 
 Do not overwrite changes.'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 3ead2b726f..14fa46edf3 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -2,6 +2,9 @@
 
 test_description='merging with submodules'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 #
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 5c8894d94f..e5542ceb24 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -2,6 +2,9 @@
 
 test_description='unpack-trees error messages'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 8a3bb4105b..bda5069044 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -25,6 +25,9 @@
 #      to refer to an existing tree).
 
 test_description='check pruning of dependent objects'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # We care about reachability, so we do not want to use
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 36477cb1f4..db496fa039 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git filter-branch'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 05f411c821..0e3086c4a6 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -7,6 +7,9 @@ test_description='git tag
 
 Tests for operations with tags.'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 5c5bc32ccb..bcb3c4f035 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='signed tag tests'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index d5218743e9..e65ca019eb 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -2,6 +2,9 @@
 
 test_description='basic work tree status reporting'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index a682a3d826..ae60942347 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -2,6 +2,9 @@
 
 test_description='test untracked cache'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # On some filesystems (e.g. FreeBSD's ext2 and ufs) directory mtime
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 537787e598..07954b2142 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -5,6 +5,9 @@ test_description='git status --porcelain=v2
 This test exercises porcelain V2 output for git status.'
 
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index b1affb001f..4af43d26f1 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -7,6 +7,9 @@ test_description='git reset
 
 Documented tests for git reset'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 commit_msg () {
diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
index f011ad7eec..8872c32f94 100755
--- a/t/t7113-post-index-change-hook.sh
+++ b/t/t7113-post-index-change-hook.sh
@@ -2,6 +2,9 @@
 
 test_description='post index change hook'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b36a93056f..12567543c4 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -20,6 +20,9 @@ Test switching across them.
 
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index fec7e0299d..8addc0c8c9 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -9,6 +9,9 @@ This test tries to verify basic sanity of the init, update and status
 subcommands of git submodule.
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'submodule deinit works on empty repository' '
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 0726799e74..c95559bed5 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -8,6 +8,9 @@ test_description='git submodule sync
 These tests exercise the "git submodule sync" subcommand.
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index acb8766ac2..825b1a7e0c 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -9,6 +9,9 @@ This test verifies that "git submodule update" detaches the HEAD of the
 submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6b2aa917e1..632defc53b 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -9,6 +9,9 @@ This test verifies that "git submodule foreach" correctly visits all submodules
 that are currently checked out.
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 
diff --git a/t/t7409-submodule-detached-work-tree.sh b/t/t7409-submodule-detached-work-tree.sh
index fc018e3638..e9428e2b59 100755
--- a/t/t7409-submodule-detached-work-tree.sh
+++ b/t/t7409-submodule-detached-work-tree.sh
@@ -10,6 +10,9 @@ on detached working trees
 '
 
 TEST_NO_CREATE_REPO=1
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'submodule on detached working tree' '
diff --git a/t/t7417-submodule-path-url.sh b/t/t7417-submodule-path-url.sh
index f7e7e94d7b..0a514e951c 100755
--- a/t/t7417-submodule-path-url.sh
+++ b/t/t7417-submodule-path-url.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='check handling of .gitmodule path with dash'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'create submodule with dash in path' '
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 110b4bf459..9a1414f31d 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -7,6 +7,9 @@
 # signoff
 
 test_description='git commit'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY/diff-lib.sh"
 
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 14c92e4c25..c8c16bf1c9 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -2,6 +2,9 @@
 
 test_description='git commit porcelain-ish'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 commit_msg_is () {
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index b3485450a2..8d3f4ab0d7 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -2,6 +2,9 @@
 
 test_description='pre-commit and pre-merge-commit hooks'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 HOOKDIR="$(git rev-parse --git-dir)/hooks"
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 31b9c6a2c1..17fb1d8499 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -2,6 +2,9 @@
 
 test_description='commit-msg hook'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'with no hook' '
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 94f85cdf83..978c90abbb 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -2,6 +2,9 @@
 
 test_description='prepare-commit-msg hook'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'set up commits for rebasing' '
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 6baaa1ad91..a5a36cab85 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='signed commit tests'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 29518e0949..fbd760f7e6 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -7,6 +7,9 @@
 
 test_description='git status advice'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index b2401cec3e..344d72a5c0 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -6,6 +6,9 @@
 
 test_description='per-repo forced setting of email address'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup a likely user.useConfigOnly use case' '
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 1c85f75555..0ad866c08c 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -26,6 +26,9 @@ Testing basic merge operations/option parsing.
 +++++++* [c0] commit 0
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 8e7e0a5865..7059c2a54b 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='test auto-generated merge messages'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 check_oneline() {
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 70afdd06fa..e65645d5e9 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -7,6 +7,9 @@ test_description='git mergetool
 
 Testing basic merge tool invocation'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # All the mergetool test work by checking out a temporary branch based
diff --git a/t/t7611-merge-abort.sh b/t/t7611-merge-abort.sh
index 7c84a518aa..ed072bfb19 100755
--- a/t/t7611-merge-abort.sh
+++ b/t/t7611-merge-abort.sh
@@ -22,6 +22,9 @@ Next, test git merge --abort with the following variables:
 - changed/unchanged worktree after merge
 - changed/unchanged index after merge
 '
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index a426f3a89a..b4ec88f996 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='merge signature verification tests'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7614-merge-signoff.sh b/t/t7614-merge-signoff.sh
index c1b8446f49..ea4eeee35f 100755
--- a/t/t7614-merge-signoff.sh
+++ b/t/t7614-merge-signoff.sh
@@ -5,6 +5,9 @@ test_description='git merge --signoff
 This test runs git merge --signoff and makes sure that it works.
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Setup test files
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 48261ba080..375f43a721 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -2,6 +2,9 @@
 
 test_description='git repack works correctly'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 fsha1=
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index a578b35761..f938efa296 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -8,6 +8,9 @@ test_description='git-difftool
 Testing basic diff tool invocation
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 difftool_test_setup ()
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 991d5bd9c0..47ec993962 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -6,6 +6,9 @@
 test_description='git grep various.
 '
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 cat >hello.c <<EOF
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index 72176e42c1..f661007c85 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git annotate'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 PROG='git annotate'
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 015973e8fe..89a319d2c7 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git blame'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 PROG='git blame -c'
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index ba8013b002..0613d889db 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git blame corner cases'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
diff --git a/t/t8004-blame-with-conflicts.sh b/t/t8004-blame-with-conflicts.sh
index 9c353ab222..ffce1d1195 100755
--- a/t/t8004-blame-with-conflicts.sh
+++ b/t/t8004-blame-with-conflicts.sh
@@ -3,6 +3,9 @@
 # Based on a test case submitted by Björn Steinbrink.
 
 test_description='git blame on conflicted files'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup first case' '
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index ed38f74de9..d55b3e22c9 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='colored git blame'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 PROG='git blame -c'
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index a08f72596a..3d160d939e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git send-email'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # May be altered later in the test
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index e4bb22034e..9a6f2c38f1 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -6,6 +6,9 @@
 test_description='git svn basic tests'
 GIT_SVN_LC_ALL=${LC_ALL:-$LANG}
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-svn.sh
 
 case "$GIT_SVN_LC_ALL" in
diff --git a/t/t9145-git-svn-master-branch.sh b/t/t9145-git-svn-master-branch.sh
index 3bbf341f6a..053571ca5c 100755
--- a/t/t9145-git-svn-master-branch.sh
+++ b/t/t9145-git-svn-master-branch.sh
@@ -3,6 +3,9 @@
 # Copyright (c) 2009 Eric Wong
 #
 test_description='git svn initial master branch is "trunk" if possible'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-svn.sh
 
 test_expect_success 'setup test repository' '
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 4f6c06ecb2..9188c761de 100755
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -5,6 +5,9 @@
 
 test_description='git-svn svn mergeinfo properties'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-svn.sh
 
 test_expect_success 'load svn dump' "
diff --git a/t/t9155-git-svn-fetch-deleted-tag.sh b/t/t9155-git-svn-fetch-deleted-tag.sh
index 184336f346..9d6cc40add 100755
--- a/t/t9155-git-svn-fetch-deleted-tag.sh
+++ b/t/t9155-git-svn-fetch-deleted-tag.sh
@@ -2,6 +2,9 @@
 
 test_description='git svn fetch deleted tag'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-svn.sh
 
 test_expect_success 'setup svn repo' '
diff --git a/t/t9156-git-svn-fetch-deleted-tag-2.sh b/t/t9156-git-svn-fetch-deleted-tag-2.sh
index 7a6e33ba3c..ba78bfb676 100755
--- a/t/t9156-git-svn-fetch-deleted-tag-2.sh
+++ b/t/t9156-git-svn-fetch-deleted-tag-2.sh
@@ -2,6 +2,9 @@
 
 test_description='git svn fetch deleted tag 2'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-svn.sh
 
 test_expect_success 'setup svn repo' '
diff --git a/t/t9163-git-svn-reset-clears-caches.sh b/t/t9163-git-svn-reset-clears-caches.sh
index d6245cee08..e48faf92af 100755
--- a/t/t9163-git-svn-reset-clears-caches.sh
+++ b/t/t9163-git-svn-reset-clears-caches.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='git svn reset clears memoized caches'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-svn.sh
 
 svn_ver="$(svn --version --quiet)"
diff --git a/t/t9169-git-svn-dcommit-crlf.sh b/t/t9169-git-svn-dcommit-crlf.sh
index 54b1f61a2a..47ae51c54f 100755
--- a/t/t9169-git-svn-dcommit-crlf.sh
+++ b/t/t9169-git-svn-dcommit-crlf.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git svn dcommit CRLF'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-svn.sh
 
 test_expect_success 'setup commit repository' '
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 308c1ef42c..404a42999e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='test git fast-import utility'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
 
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 14c1baa739..0c5bfbde0e 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='test git fast-import of notes objects'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 1372842559..6c8830ece5 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -4,6 +4,9 @@
 #
 
 test_description='git fast-export'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index 5ac2c3b5ee..4130c8a837 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='basic tests for fast-export --anonymize'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 test_expect_success 'setup simple repo' '
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 4a46f31c41..7d23e6ba94 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -8,6 +8,9 @@ test_description='git-cvsserver access
 tests read access to a git repository with the
 cvs CLI client via git-cvsserver server'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 if ! test_have_prereq PERL; then
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index c7a0dd84a4..0062341dbf 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -9,6 +9,9 @@ test_description='git-cvsserver -kb modes
 tests -kb mode for binary files when accessing a git
 repository using cvs CLI client via git-cvsserver server'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 marked_as () {
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index 6436c91a3c..33b6db1648 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -5,6 +5,9 @@ test_description='git-cvsserver and git refspecs
 tests ability for git-cvsserver to switch between and compare
 tags, branches and other git refspecs'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 #########
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index b484e3e250..fa36bf5e83 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -10,6 +10,9 @@ commandline, and checks that it would not write any errors
 or warnings to log.'
 
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./gitweb-lib.sh
 
 # ----------------------------------------------------------------------
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 2a0ffed870..6b0adf28d2 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -10,6 +10,9 @@ commandline, and checks that it returns the expected HTTP status
 code and message.'
 
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./gitweb-lib.sh
 
 #
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index e38cbc97d3..76d90eccd8 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -10,6 +10,9 @@ commandline, and checks that it produces the correct output, either
 in the HTTP header or the actual script output.'
 
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./gitweb-lib.sh
 
 # ----------------------------------------------------------------------
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 251fdd66c4..9257d664f2 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -1,6 +1,9 @@
 #!/bin/sh
 
 test_description='git cvsimport basic tests'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-cvs.sh
 
 if ! test_have_prereq NOT_ROOT; then
diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-branch.sh
index 827d39f5bf..700c2688d2 100755
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -32,6 +32,9 @@
 #       tag has been removed.
 
 test_description='git cvsimport handling of vendor branches'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-cvs.sh
 
 setup_cvs_test_repository t9601
diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-branches-tags.sh
index e1db323f54..7b1fb36e67 100755
--- a/t/t9602-cvsimport-branches-tags.sh
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -4,6 +4,9 @@
 # t9602/README.
 
 test_description='git cvsimport handling of branches and tags'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-cvs.sh
 
 setup_cvs_test_repository t9602
diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index e7a91611dc..87cd8c0c6b 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -12,6 +12,9 @@
 # bug.
 
 test_description='git cvsimport testing for correct patchset estimation'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-cvs.sh
 
 setup_cvs_test_repository t9603
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index c98c1dfc23..c920b84778 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -2,6 +2,9 @@
 
 test_description='git p4 tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index a3abd778f9..ebfe9d8195 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -2,6 +2,9 @@
 
 test_description='git p4 tests for p4 branches'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 4e794a01bf..c7629b6c7d 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -2,6 +2,9 @@
 
 test_description='git p4 options'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index eaaae414a1..f12e6f7206 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -2,6 +2,9 @@
 
 test_description='git p4 submit'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index c1446f26ab..c53952ac14 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -2,6 +2,9 @@
 
 test_description='git p4 label tests'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 5c01c75d40..ac436df3b4 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -5,6 +5,9 @@
 
 test_description='test bash completion'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-bash.sh
 
 complete ()
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index ab5da2cabc..f5b5935c2c 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -5,6 +5,9 @@
 
 test_description='test git-specific bash prompt functions'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./lib-bash.sh
 
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
-- 
gitgitgadget

