Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D64FC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D508964E35
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhBKB7r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 20:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhBKBzT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 20:55:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A22C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:54:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id t142so3562934wmt.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 17:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTCTri8MbYOTIVTBrOoIgPxRzEKvx44JVc9OoqS8+LM=;
        b=tXFqZLQM0TLlOlvGjvhHbQC9f2BIZzU0ulFHPEtoeIND17b+jQKop8+YgwDRgWU9K3
         /HGkgCc1UghlS3ALd6dvWj+Dtzq9HTC7a7mKfIUyyEq2bkpuyUfuBzOGcZbezWHwMq6N
         siwgazE1sSq7YVeaXlaxpKC93myFtqCYupgSziUv2PNzOwUfkT5cophdZ4de+aNoI5hW
         em0FGiz0CqphokUCMjJRQHjnItgoEV/6rDjVj8mgMGmlshuA+1znXYOlExeJy3uzFwga
         LVFok2AYR5iVfk+Bdvz86QpD+KqtiWPOvopZf4CgDFA6xKTdodHptZN63FijjfDfrWY/
         dvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTCTri8MbYOTIVTBrOoIgPxRzEKvx44JVc9OoqS8+LM=;
        b=qCMD1VaIx7kKVvNkSZghHrP/jN14cGpP74UA0TysZNblMOXxsQcM/K72qGjNx8T6e+
         yH+4X+R8V+I7JFgJrwXy1dmWxO6ewgqX0FIbx5ff0PBL3GMqkIJAK8XR5zFUBuQ0PLYb
         xrWZjnykO8zBPWnRe6oIMjPUsU+YuDu5dro47rgQ7yFo2FVl0JXN/xqrFu1Q2yV0JrYh
         nf+bwzaM8OSlBrZg5UQb1Qk5CE2ROP6TalRiNvHzy032uRd9G+TrFj0QValFK643GepV
         6zg/irpIMfkYppKCvP0eryZbQwjnEjGNnZFyFd2L49FUD646u16D33D+tK4Nhyis1pJv
         U0QA==
X-Gm-Message-State: AOAM530zh2fjLfpEnsEn95uV9NT2UhQ8h8SPKniJneoMF49Ioh7bCevx
        rAmslpGI2JrC4U1JpVqO++sPgwSXNCztNw==
X-Google-Smtp-Source: ABdhPJyR/OD2Pjbzr7nRryLyM1AaQpu6GPW1MD8IFf1cHfTR+RpwesPy6XDHepzsc4bKExvvTzoU/A==
X-Received: by 2002:a05:600c:4ec6:: with SMTP id g6mr2185477wmq.2.1613008447314;
        Wed, 10 Feb 2021 17:54:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2sm5362486wml.34.2021.02.10.17.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 17:54:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] More GETTEXT_POISON removal
Date:   Thu, 11 Feb 2021 02:53:49 +0100
Message-Id: <20210211015353.28680-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210120182759.31102-1-avarab@gmail.com>
References: <20210120182759.31102-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the removal of GETTEXT_POISON is in master follow-up [1] with
some more removal of now-dead code that assumed it still existed.

This leaves no uses of GIT_TEST_GETTEXT_POISON=false or
C_LOCALE_OUTPUT at the end, in 4/4 I'm removing most of test_i18ncmp,
but stopping short of conflicting with other in-flight topics, so once
those land we'll need another cleanup patch to clean up the
stragglers.

As with [1] I'm not touching test_i18ngrep since SZEDER expressed some
interest in retainng it as a generally useful grep with more verbose
debugging.

1. https://lore.kernel.org/git/20210120182759.31102-1-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (4):
  tests: remove last uses of GIT_TEST_GETTEXT_POISON=false
  tests: remove most uses of C_LOCALE_OUTPUT
  tests: remove last uses of C_LOCALE_OUTPUT
  tests: remove most uses of test_i18ncmp

 t/lib-credential.sh                       |   2 +-
 t/lib-log-graph.sh                        |   4 +-
 t/t0000-basic.sh                          |   2 +-
 t/t0006-date.sh                           |   4 +-
 t/t0008-ignores.sh                        |   2 +-
 t/t0012-help.sh                           |   2 +-
 t/t0018-advice.sh                         |   4 +-
 t/t0020-crlf.sh                           |   6 +-
 t/t0027-auto-crlf.sh                      |   2 +-
 t/t0040-parse-options.sh                  |   8 +-
 t/t0201-gettext-fallbacks.sh              |  16 ++--
 t/t0300-credentials.sh                    |   8 +-
 t/t0500-progress-display.sh               |  22 ++---
 t/t1011-read-tree-sparse-checkout.sh      |   2 +-
 t/t1308-config-set.sh                     |   4 +-
 t/t1400-update-ref.sh                     |   6 +-
 t/t1404-update-ref-errors.sh              |   2 +-
 t/t1430-bad-ref-name.sh                   |   2 +-
 t/t1450-fsck.sh                           |   6 +-
 t/t1502-rev-parse-parseopt.sh             |  10 +-
 t/t1506-rev-parse-diagnosis.sh            |   2 +-
 t/t1507-rev-parse-upstream.sh             |  10 +-
 t/t1509-root-work-tree.sh                 |   4 +-
 t/t1512-rev-parse-disambiguation.sh       |  14 +--
 t/t1600-index.sh                          |   6 +-
 t/t2018-checkout-branch.sh                |   2 +-
 t/t2020-checkout-detach.sh                |  20 ++--
 t/t2200-add-update.sh                     |   2 +-
 t/t2401-worktree-prune.sh                 |   4 +-
 t/t2402-worktree-list.sh                  |   2 +-
 t/t3005-ls-files-relative.sh              |   4 +-
 t/t3200-branch.sh                         |  26 ++---
 t/t3201-branch-contains.sh                |   2 +-
 t/t3203-branch-output.sh                  |  28 +++---
 t/t3300-funny-names.sh                    |   2 +-
 t/t3400-rebase.sh                         |   2 +-
 t/t3404-rebase-interactive.sh             |  38 ++++----
 t/t3415-rebase-autosquash.sh              |  10 +-
 t/t3420-rebase-autostash.sh               |   4 +-
 t/t3504-cherry-pick-rerere.sh             |   4 +-
 t/t3507-cherry-pick-conflict.sh           |  12 +--
 t/t3508-cherry-pick-many-commits.sh       |   4 +-
 t/t3510-cherry-pick-sequence.sh           |   8 +-
 t/t3600-rm.sh                             |  16 ++--
 t/t3700-add.sh                            |   8 +-
 t/t3701-add-interactive.sh                |   4 +-
 t/t3800-mktag.sh                          |  12 +--
 t/t3903-stash.sh                          |   8 +-
 t/t3905-stash-include-untracked.sh        |   2 +-
 t/t4006-diff-mode.sh                      |   8 +-
 t/t4012-diff-binary.sh                    |  10 +-
 t/t4013-diff-various.sh                   |   2 +-
 t/t4014-format-patch.sh                   |   6 +-
 t/t4016-diff-quote.sh                     |   2 +-
 t/t4030-diff-textconv.sh                  |   2 +-
 t/t4045-diff-relative.sh                  |   2 +-
 t/t4049-diff-stat-count.sh                |   6 +-
 t/t4100-apply-stat.sh                     |   4 +-
 t/t4150-am.sh                             |   2 +-
 t/t4153-am-resume-override-opts.sh        |   2 +-
 t/t4205-log-pretty-formats.sh             |   4 +-
 t/t4254-am-corrupt.sh                     |   2 +-
 t/t5150-request-pull.sh                   |   4 +-
 t/t5300-pack-object.sh                    |   4 +-
 t/t5316-pack-delta-depth.sh               |   4 +-
 t/t5500-fetch-pack.sh                     |   6 +-
 t/t5505-remote.sh                         |  30 +++---
 t/t5510-fetch.sh                          |   6 +-
 t/t5512-ls-remote.sh                      |   2 +-
 t/t5526-fetch-submodules.sh               |  38 ++++----
 t/t5541-http-push-smart.sh                |   2 +-
 t/t5601-clone.sh                          |   2 +-
 t/t6020-bundle-misc.sh                    |  28 +++---
 t/t6030-bisect-porcelain.sh               |   4 +-
 t/t6040-tracking-info.sh                  |  22 ++---
 t/t6120-describe.sh                       |   2 +-
 t/t6134-pathspec-in-submodule.sh          |   2 +-
 t/t6301-for-each-ref-errors.sh            |  10 +-
 t/t6423-merge-rename-directories.sh       |   2 +-
 t/t6436-merge-overwrite.sh                |   4 +-
 t/t6439-merge-co-error-msgs.sh            |  12 +--
 t/t7001-mv.sh                             |   2 +-
 t/t7004-tag.sh                            |   8 +-
 t/t7012-skip-worktree-writing.sh          |   4 +-
 t/t7060-wtstatus.sh                       |  14 +--
 t/t7063-status-untracked-cache.sh         |   2 +-
 t/t7102-reset.sh                          |   6 +-
 t/t7300-clean.sh                          |   6 +-
 t/t7400-submodule-basic.sh                |   4 +-
 t/t7401-submodule-summary.sh              |  12 +--
 t/t7406-submodule-update.sh               |  16 ++--
 t/t7407-submodule-foreach.sh              |  10 +-
 t/t7500-commit-template-squash-signoff.sh |   4 +-
 t/t7502-commit-porcelain.sh               |   6 +-
 t/t7505-prepare-commit-msg-hook.sh        |   4 +-
 t/t7508-status.sh                         | 110 +++++++++++-----------
 t/t7512-status-help.sh                    |  74 +++++++--------
 t/t7519-status-fsmonitor.sh               |   4 +-
 t/t7521-ignored-mode.sh                   |  22 ++---
 t/t7600-merge.sh                          |   4 +-
 t/t7602-merge-octopus-many.sh             |   6 +-
 t/t7810-grep.sh                           |   2 +-
 t/t9003-help-autocorrect.sh               |   7 +-
 t/test-lib.sh                             |   5 -
 104 files changed, 464 insertions(+), 478 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7

