Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BDBC433E2
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1285961990
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 11:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCVLtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhCVLtB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 07:49:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFFEC061756
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 04:49:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so11048819wma.0
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 04:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QhrP7J50SsKvLQYp9UL27Bu2wqM347pFXFg4QyYukSs=;
        b=FrwuKRaB7sKGyNd2vYXvxubJB5OOqHltLHKzx6qnFiMDiMBqt3at9fCq4uRxLCVICq
         QyL7U08kHEO4NBuUx2nCyIpFpTmnnnRlbc2+tiVTLj4o5Mt6KqBCsaAimPcBMcwDRBmQ
         GjfxlRVFwkQFM8z4Aj/eHA30cMO5EBaVaVnkenFAMrUK0vaC2LrpYjBX2waR9JT1fsD9
         xnfrhD8Klzs4bKvVnyi0fGuTAu/gxz/rrLsslS8lg4heG0h9uVGoAIsWx0WducRE+lEg
         pfWVGHsY7KN7VliiObk+PTKJSmLYCLhI+04dg71ZxlfX6RB03eC9UlxwQMgdN9m8zZSs
         DyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QhrP7J50SsKvLQYp9UL27Bu2wqM347pFXFg4QyYukSs=;
        b=XlVFFEQoaDP5aBUrP49GBc1IKupFARVCZMhpU9qS5qfJ0PYFyMw4VaHD5u1sB3HFoo
         5oo2hT0HMoDuXiBT9mc1g+OqeTPWLwFUTItFcZwCd9akndmDKioJFbE+0HefXcv1cD+O
         7ruAVHrGfezBG7/On6Q07CtMFxOPM+TD6/8swl5Nmzb5y0GD9+o8dMqY3C/0+W6+5AfW
         7V7nnNfa6aT3WHDusb5nldtt49CUd9faIwS2dJmyOqER8XpSenbc5TsPODodUxDFSHXU
         KfOTm3VuOgsLNQlMrp1vkDHulWdXW9yQqPlEzfiSH0EdeR3YLuwBRPWlnOVCDTyK2UD7
         EYIA==
X-Gm-Message-State: AOAM532gOcdPfCZmOtjmM9OWDynnVddeh9nf+sigWvRAJHZN/XRQuDIG
        GXgrILHjc3POPW3lotaGFarZ4RFSdQZUXA==
X-Google-Smtp-Source: ABdhPJzcJoRezVlxotI4l3I0OrU8I+9khZ9HvvQ4BAMcApKIYzFj04KyN05Dvo+zCYsPaX7WmhhR4w==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr15990620wmo.36.1616413738824;
        Mon, 22 Mar 2021 04:48:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm19768945wro.53.2021.03.22.04.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:48:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] rebase: don't override --no-reschedule-failed-exec with config
Date:   Mon, 22 Mar 2021 12:48:25 +0100
Message-Id: <e00300d58d4de4a6b440446a0054d34ad5a092f3.1616411973.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.285.gb40d23e604f
In-Reply-To: <cover.1616411973.git.avarab@gmail.com>
References: <873d1fda948855510b07f9cb75d374c03d60a94e.1544468695.git.gitgitgadget@gmail.com> <cover.1616411973.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in how --no-reschedule-failed-exec interacts with
rebase.rescheduleFailedExec=true being set in the config. Before this
change the --no-reschedule-failed-exec config option would be
overridden by the config.

This bug happened because of the particulars of how "rebase" works
v.s. most other git commands when it comes to parsing options and
config:

When we read the config and parse the CLI options we correctly prefer
the --no-reschedule-failed-exec option over
rebase.rescheduleFailedExec=true in the config. So far so good.

However the --reschedule-failed-exec option doesn't take effect when
the rebase starts (we'd just create a
".git/rebase-merge/reschedule-failed-exec" file if it was true). It
only takes effect when the exec command fails, and the user wants to
run "rebase --continue".

At that point we'll have forgotten that we asked for
--no-reschedule-failed-exec at the start, and will happily re-read the
config.

We'll then see that rebase.rescheduleFailedExec=true is set. At that
point we have no record of having set --no-reschedule-failed-exec
earlier. So the config will effectively override the user having
explicitly disabled the option on the command-line.

Even more confusingly: Since rebase accepts different options based on
its state there wasn't even a way to get around this with "rebase
--continue --no-reschedule-failed-exec" (but you could of course set
the config with "rebase -c ...").

I think the least bad way out of this is to declare that for such
options and config whatever we decide at the beginning of the rebase
goes. So we'll now always create either a "reschedule-failed-exec" or
a "no-reschedule-failed-exec file at the start, not just the former if
we decided we wanted the feature.

With this new worldview you can no longer change the setting once a
rebase has started except by manually removing the state files
discussed above. I think making it work like that is the the least
confusing thing we can do.

In the future we might want to learn to change the setting in the
middle by combining "--edit-todo" with
"--[no-]reschedule-failed-exec", we currently don't support combining
those options, or any other way to change the state in the middle of
the rebase short of manually editing the files in
".git/rebase-merge/*".

The bug being fixed here originally came about because of a
combination of the behavior of the code added in d421afa0c66 (rebase:
introduce --reschedule-failed-exec, 2018-12-10) and the addition of
the config variable in 969de3ff0e0 (rebase: add a config option to
default to --reschedule-failed-exec, 2018-12-10).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-rebase.txt |  8 ++++++++
 sequencer.c                  |  5 +++++
 t/t3418-rebase-continue.sh   | 25 +++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a0487b5cc58..b48e6225769 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -622,6 +622,14 @@ See also INCOMPATIBLE OPTIONS below.
 --no-reschedule-failed-exec::
 	Automatically reschedule `exec` commands that failed. This only makes
 	sense in interactive mode (or when an `--exec` option was provided).
++
+Even though this option applies once a rebase is started, it's set for
+the whole rebase at the start based on either the
+`rebase.rescheduleFailedExec` configuration (see linkgit:git-config[1]
+or "CONFIGURATION" below) or whether this option is
+provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
+start would be overridden by the presence of
+`rebase.rescheduleFailedExec=true` configuration.
 
 INCOMPATIBLE OPTIONS
 --------------------
diff --git a/sequencer.c b/sequencer.c
index 848204d3dc3..59735fdff62 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -164,6 +164,7 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
 static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
 static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
+static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-merge/no-reschedule-failed-exec")
 static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
 static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
 
@@ -2672,6 +2673,8 @@ static int read_populate_opts(struct replay_opts *opts)
 
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
+		else if (file_exists(rebase_path_no_reschedule_failed_exec()))
+			opts->reschedule_failed_exec = 0;
 
 		if (file_exists(rebase_path_drop_redundant_commits()))
 			opts->drop_redundant_commits = 1;
@@ -2772,6 +2775,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_ignore_date(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
+	else
+		write_file(rebase_path_no_reschedule_failed_exec(), "%s", "");
 
 	return 0;
 }
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index ea14ef496cb..9553d969646 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -291,4 +291,29 @@ test_expect_success 'rebase.rescheduleFailedExec only affects `rebase -i`' '
 	git rebase HEAD^
 '
 
+test_expect_success 'rebase.rescheduleFailedExec=true & --no-reschedule-failed-exec' '
+	test_when_finished "git rebase --abort" &&
+	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
+	test_config rebase.rescheduleFailedExec true &&
+	test_must_fail git rebase -x false --no-reschedule-failed-exec HEAD~2 &&
+	test_must_fail git rebase --continue 2>err &&
+	! grep "has been rescheduled" err
+'
+
+test_expect_success 'new rebase.rescheduleFailedExec=true setting in an ongoing rebase is ignored' '
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -x false HEAD~2 &&
+	test_when_finished "test_unconfig rebase.rescheduleFailedExec" &&
+	test_config rebase.rescheduleFailedExec true &&
+	test_must_fail git rebase --continue 2>err &&
+	! grep "has been rescheduled" err
+'
+
+test_expect_success 'there is no --no-reschedule-failed-exec in an ongoing rebase' '
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -x false HEAD~2 &&
+	test_expect_code 129 git rebase --continue --no-reschedule-failed-exec &&
+	test_expect_code 129 git rebase --edit-todo --no-reschedule-failed-exec
+'
+
 test_done
-- 
2.31.0.285.gb40d23e604f

