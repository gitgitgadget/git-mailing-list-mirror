Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7722D20A10
	for <e@80x24.org>; Mon,  6 Nov 2017 22:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753788AbdKFWIZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 17:08:25 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:53229 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753603AbdKFWIY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 17:08:24 -0500
Received: by mail-pg0-f66.google.com with SMTP id a192so9331636pge.9
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 14:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xdiNRV54Jp45OgWMdgadhlwWwebizx8ZaAXeAFQc7SU=;
        b=cW+kVAggwLbBWwKgI4fxC+p+YhcV3CeZtgW0tO+lgWrtyWlXo+R+OqHAtNj2hrMzVU
         QypJqoY5Hu8bFfcuOgcxlROTKtTMri9ecF1UQ4QOoo+wh2zOsSdU1p6J6rlBy6ip0uyZ
         LASclLgooZQNWM7xI+3uGSpn0vSTgd6ee74vxRzvcXbVpwVvCMA3pWTEdDI6Z7gpYdNK
         1A0iaVZPX9PLhNx/9WumoYf0qYvNoUSJ2KHyuz0WxEuWwfow5iPaL671Z0dmwQ/nxa+J
         lSPprG7B5g50hrV/l9a8q9wB3VfCe4cPdFT4Kwyj808N6I3y3SmdwHB6QhFWH4asx/XT
         dGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xdiNRV54Jp45OgWMdgadhlwWwebizx8ZaAXeAFQc7SU=;
        b=CRvHRGlbMsAejgD1acob9zzWSGv1dYZKKPSLXdBTF0EInbiRgyKxPwISvPxX0Ehqdw
         vwCeIn7jLrw5zKIdn9/b2HgyX+kxYmRCJBhvkAMfxn+cbIAyMopLLGsLU+tb7oR113oy
         s9Khr0NAXn2UXCLHv8L8QYx1rb9tOgxDDJ8CG9b5spT1ayIVgQj4oNDpYfkk76EHySNX
         kNjgKl0vL9FWTCV6zBziXFfNQXqYcAdI+B05SC9dFETdxurRX7GHFhnbDoaiKworwP06
         Nr7YxN2/H3QPq/dozCM0scpqkF/qx7FyoPtZup1gTBo+fiqQzOVoEPYfCwww8Ppg512P
         2OIQ==
X-Gm-Message-State: AMCzsaXi6WsGFG4zKtXC8imdfHMWy8pkBR/a/3tbLP+P0jLNSCH9ojFw
        sx58bWQl/v4+3TEG3ish4w4Xb/lygZM=
X-Google-Smtp-Source: ABhQp+RsJBU5FwQN7IYrPRAQ4p/NOsJieQbnymRrV/s7LBhSWVQL4E2P2Ox47xKJ/cjLkuDhoAH4FQ==
X-Received: by 10.101.80.200 with SMTP id s8mr16755477pgp.23.1510006103085;
        Mon, 06 Nov 2017 14:08:23 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 77sm26713099pfl.133.2017.11.06.14.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Nov 2017 14:08:22 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     orgads@gmail.com, Johannes.Schindelin@gmx.de, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH] wt-status: actually ignore submodules when requested
Date:   Mon,  6 Nov 2017 14:08:19 -0800
Message-Id: <20171106220819.178881-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a-goog
In-Reply-To: <CAGHpTB+jKiXr45tKVEVTtszN7OBTW7W_FqKu7aAjsB8Tmx9N3Q@mail.gmail.com>
References: <CAGHpTB+jKiXr45tKVEVTtszN7OBTW7W_FqKu7aAjsB8Tmx9N3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since ff6f1f564 (submodule-config: lazy-load a repository's .gitmodules
file, 2017-08-03) rebase interactive fails if there are any submodules
with unstaged changes which have been configured with a value for
'submodule.<name>.ignore' in the repository's config.

This is due to how configured values of 'submodule.<name>.ignore' are
handled in addition to a change in how the submodule config is loaded.
When the diff machinery hits a submodule (gitlink as well as a
corresponding entry in the submodule subsystem) it will read the value
of 'submodule.<name>.ignore' stored in the repository's config and if
the config is present it will clear the 'IGNORE_SUBMODULES' (which is
the flag explicitly requested by rebase interactive),
'IGNORE_UNTRACKED_IN_SUBMODULES', and 'IGNORE_DIRTY_SUBMODULES' diff
flags and then set one of them based on the configured value.

Historically this wasn't a problem because the submodule subsystem
wasn't initialized because the .gitmodules file wasn't explicitly loaded
by the rebase interactive command.  So when the diff machinery hit a
submodule it would skip over reading any configured values of
'submodule.<name>.ignore'.

In order to preserve the behavior of submodules being ignored by rebase
interactive, also set the 'OVERRIDE_SUBMODULE_CONFIG' diff flag when
submodules are requested to be ignored when checking for unstaged
changes.

Reported-by: Orgad Shaneh <orgads@gmail.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/t3426-rebase-submodule.sh | 16 ++++++++++++++++
 wt-status.c                 |  4 +++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index ebf4f5e4b..760c872e2 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -40,4 +40,20 @@ git_rebase_interactive () {
 
 test_submodule_switch "git_rebase_interactive"
 
+test_expect_success 'rebase interactive ignores modified submodules' '
+	test_when_finished "rm -rf super sub" &&
+	git init sub &&
+	git -C sub commit --allow-empty -m "Initial commit" &&
+	git init super &&
+	git -C super submodule add ../sub &&
+	git -C super config submodule.sub.ignore dirty &&
+	> super/foo &&
+	git -C super add foo &&
+	git -C super commit -m "Initial commit" &&
+	test_commit -C super a &&
+	test_commit -C super b &&
+	test_commit -C super/sub c &&
+	git -C super rebase -i HEAD^^
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 29bc64cc0..94e5ebaf8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2262,8 +2262,10 @@ int has_unstaged_changes(int ignore_submodules)
 	int result;
 
 	init_revisions(&rev_info, NULL);
-	if (ignore_submodules)
+	if (ignore_submodules) {
 		DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+		DIFF_OPT_SET(&rev_info.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+	}
 	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_files(&rev_info, 0);
-- 
2.15.0.448.gf294e3d99a-goog

