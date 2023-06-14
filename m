Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08814EB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 15:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbjFNPcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 11:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244279AbjFNPbw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 11:31:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1911FDD
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:31:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd7f0e5df8eso927862276.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686756709; x=1689348709;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NwdJPaSSvtxTdxTJdcUE8BJrvnCtl3PYJx7bJ65tn1Y=;
        b=hc9VfcF7YCfwAejXEF1nSfEja+TmarwA+ysa1DqHfnowNNGOHsZ1bTw8ew5yyvHQ0a
         MQUzc9WkPBx5DnLsvChtZoQlnBo/+u2xpZTzDl+to6SOGnNcL175lrwo6/BHuAXK9GaY
         +1k71hWa069XKPT7F3PGQXdw7xS98AUJn8rDmfVOGdvjbeo2MhroGKPnLr737IogTm1l
         05uo6FUQZW9bAH0H6P47ryqJcvPR38+D1z1uqhoUtFQXWwhWU9Jk/KWiRoU/otEOsgiz
         kd/B6f0vLiR+8G45ZQ3LP5OrWz5wYmIAbEml9CI08TNRrFNVX4qt8fplFwng0h+QHRdO
         kFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686756709; x=1689348709;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwdJPaSSvtxTdxTJdcUE8BJrvnCtl3PYJx7bJ65tn1Y=;
        b=FsZAajDWT8aJisv+BLW82Iolr/JJH1lnA9/8iZWqKziW6wMcytuDJkpDcz068if3Sw
         LRWUbbZOf1aH+P2I1wsdj62NGradYVNn5XjnovhtQu+YP37RfuJ3NQZDXdXZ+Pu0uezI
         5dfZ1Y4oXWCRDOuFXaNkRkChXG4z4TR+slTScr+nEAB7h6j92qIsI6m6/4mvP/NQhVPq
         g3RAgBOIsJgYnql/VPurfi7QEQpELmmXEJteBmJXPCPLlUvk4Sb8GIeEOAvfcGW2QAmx
         IZg9gRcIHgXkegH6FfcHlwPlbknRp7izyP15cuectRjGZQGnTW+5OvjI63SZ5+Ysxz/Y
         wT+g==
X-Gm-Message-State: AC+VfDxoLmYgk0uzaXjGRd99rWjAp38dChVLjjN7yIFwjjzEuedZ5gl+
        jPMrHcs6+UE+XLP66aKTsNM+82QB2xSHuJwR3YRRKZHmawXI3ZqxrcU9TQFGBwm4NCuZEBnYvhe
        qSIQ/OFDvZzj1hQJ0upmwVo1jixD3Hre6wD9peR4hAXLzAlD+TVbPIUWeJ/f7lz0=
X-Google-Smtp-Source: ACHHUZ5p1w+TInG73GXDu8BxkQQLCgCymcMTF6Rvr2kZRlG7Tb7wJjRKX7dSOFh+iWA5/62tPnl5/nncSdkCqg==
X-Received: from sokac.sfo.corp.google.com ([2620:15c:11a:202:d1e8:6e0c:96d0:4f23])
 (user=sokcevic job=sendgmr) by 2002:a25:20a:0:b0:bc6:3354:e65e with SMTP id
 10-20020a25020a000000b00bc63354e65emr364711ybc.7.1686756709734; Wed, 14 Jun
 2023 08:31:49 -0700 (PDT)
Date:   Wed, 14 Jun 2023 08:31:42 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614153142.3138028-1-sokcevic@google.com>
Subject: [PATCH v2] diff-lib: honor override_submodule_config flag bit
From:   Josip Sokcevic <sokcevic@google.com>
To:     git@vger.kernel.org
Cc:     Josip Sokcevic <sokcevic@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `diff.ignoreSubmodules = all` is set and submodule commits are
manually staged (e.g. via `git-update-index`), `git-commit` should
record the commit  with updated submodules.

`index_differs_from` is called from `prepare_to_commit` with flags set to
`override_submodule_config = 1`. `index_differs_from` then merges the
default diff flags and passed flags.

When `diff.ignoreSubmodules` is set to "all", `flags` ends up having
both `override_submodule_config` and `ignore_submodules` set to 1. This
results in `git-commit` ignoring staged commits.

This patch restores original `flags.ignore_submodule` if
`flags.override_submodule_config` is set.

Signed-off-by: Josip Sokcevic <sokcevic@google.com>
---
 diff-lib.c                  |  9 ++++++++-
 t/t7406-submodule-update.sh | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index 60e979dc1b..1918517ebd 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -669,8 +669,15 @@ int index_differs_from(struct repository *r,
 	setup_revisions(0, NULL, &rev, &opt);
 	rev.diffopt.flags.quick = 1;
 	rev.diffopt.flags.exit_with_status = 1;
-	if (flags)
+	if (flags) {
 		diff_flags_or(&rev.diffopt.flags, flags);
+		/*
+		 * Now that flags are merged, honor override_submodule_config
+		 * and ignore_submodules from passed flags.
+		 */
+		if (flags->override_submodule_config)
+			rev.diffopt.flags.ignore_submodules = flags->ignore_submodules;
+	}
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
 	has_changes = rev.diffopt.flags.has_changes;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f094e3d7f3..d5167d9ee6 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1179,4 +1179,27 @@ test_expect_success 'submodule update --recursive skip submodules with strategy=
 	test_cmp expect.err actual.err
 '
 
+add_submodule_commits_and_validate () {
+	HASH=$(git rev-parse HEAD) &&
+	git update-index --add --cacheinfo 160000,$HASH,sub &&
+	git commit -m "create submodule" &&
+	git ls-tree HEAD >output &&
+	test_when_finished "rm -f output" &&
+	grep "$HASH" output
+}
+
+test_expect_success 'commit with staged submodule change' '
+	add_submodule_commits_and_validate
+'
+
+test_expect_success 'commit with staged submodule change with ignoreSubmodules dirty' '
+	test_config diff.ignoreSubmodules dirty &&
+	add_submodule_commits_and_validate
+'
+
+test_expect_success 'commit with staged submodule change with ignoreSubmodules all' '
+	test_config diff.ignoreSubmodules all &&
+	add_submodule_commits_and_validate
+'
+
 test_done
-- 
2.41.0.162.gfafddb0af9-goog

