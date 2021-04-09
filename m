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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F734C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A100611AB
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 08:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhDIICF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 04:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbhDIICD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 04:02:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0EEC061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 01:01:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g17so4445867ejp.8
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 01:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TIXdfyQ6gubkX6i8iQWOcnuRj1I7vGktCSXcLBTbTd8=;
        b=G6LP+PBQp03T8rF0/l1zkz25KVAYVXQxSn/U0UTy5jDbc8wqsmAgM3huvtOAC4Qo/s
         P2NTbZbJv8nulQs0FIowFlad5iYdiG/Ivz1oIv9Pc50raV+z4A898gCT/8mS96eehp+K
         xspCfdhpQyaVycBKCZZMK1YSV2zkHw1iM3o01oTq+xaS+xqRcBMWdovjeRRG+GBs65CV
         WGtdqTBWegjzVi8TS+h78f7+eGi18i/8AX/tHlgOsaOtEhIEQ4cRI8ynhYibE1f9iugy
         i5jwaJQxd4uNS50GJr4wZqdrtb4uT5GxbPZgjMCT7K9ZPOuyXTFKdfxpRE9O+bqYLZJr
         J79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TIXdfyQ6gubkX6i8iQWOcnuRj1I7vGktCSXcLBTbTd8=;
        b=Pn8YzQ7UFyOdqIpPLa2O7cj9JfUrv9n1kYQ8bdtKbD2c5YKflYWB5YbJB6VtOXpgTF
         UAhPTi2HnK6LpbSAct049igaPiUnKWd+HalxsZwt+6i8PAy51wxKu262i4LD2l7YQicp
         E2F99EcEMA1AiOFx54zZ6+vnybbaXRFVHLriLSU4gjODJIG2t2TCM3JJEjUtjIYNw6NJ
         jvQnwqo5S1Pb0OFUOMhtKBOq/Z8301aRnFsCwIIM9Gn9TCzXjOh0peaoZULcrXxgnqgI
         86hVjrrr4WlVe3WE0v3DFb6lWY2rfUiIOtRn88fDaYoOxr5Enq3ExtXSBQ7GfvK01Ol4
         KMbw==
X-Gm-Message-State: AOAM531IUP1UOxBzV5yUtoO6oLedsGpoiwQlxOOfx98bM8wTxP9yKh2g
        ENYeuhSqFFWHfQm5XbztHyKrdRYF84dfxQ==
X-Google-Smtp-Source: ABdhPJxvlU6jxTEW1xvHoDJzQVy70YT4KUBGruWpJ2YHSYbSw1DMwgCSOyTuu4jXsUZUwal8Xfqojg==
X-Received: by 2002:a17:907:9709:: with SMTP id jg9mr14562274ejc.276.1617955308965;
        Fri, 09 Apr 2021 01:01:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k8sm955177edr.75.2021.04.09.01.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:01:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] rebase: don't override --no-reschedule-failed-exec with config
Date:   Fri,  9 Apr 2021 10:01:38 +0200
Message-Id: <patch-2.3-7991160de3-20210409T075713Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.584.gf4baedee75
In-Reply-To: <cover-0.3-0000000000-20210409T075713Z-avarab@gmail.com>
References: <cover.1616411973.git.avarab@gmail.com> <cover-0.3-0000000000-20210409T075713Z-avarab@gmail.com>
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
only takes effect when the exec command fails, at which point we'll
reschedule the failed "exec" command.

Since we only wrote out the positive
".git/rebase-merge/reschedule-failed-exec" under
--reschedule-failed-exec, but nothing with --no-reschedule-failed-exec
we'll forget that we asked not to reschedule failed "exec", and would
happily re-read the config and see that
rebase.rescheduleFailedExec=true is set.

So the config will effectively override the user having explicitly
disabled the option on the command-line.

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
 t/t3418-rebase-continue.sh   | 23 +++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f08ae27e2a..93afe5ce3c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -623,6 +623,14 @@ See also INCOMPATIBLE OPTIONS below.
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
index b4c63ae207..8a7e7414eb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -164,6 +164,7 @@ static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
 static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
 static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
+static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-merge/no-reschedule-failed-exec")
 static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
 static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
 
@@ -2854,6 +2855,8 @@ static int read_populate_opts(struct replay_opts *opts)
 
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
+		else if (file_exists(rebase_path_no_reschedule_failed_exec()))
+			opts->reschedule_failed_exec = 0;
 
 		if (file_exists(rebase_path_drop_redundant_commits()))
 			opts->drop_redundant_commits = 1;
@@ -2954,6 +2957,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_ignore_date(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
+	else
+		write_file(rebase_path_no_reschedule_failed_exec(), "%s", "");
 
 	return 0;
 }
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index fe407e63cf..f4c2ee02bc 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -290,4 +290,27 @@ test_expect_success 'rebase.rescheduleFailedExec only affects `rebase -i`' '
 	git rebase HEAD^
 '
 
+test_expect_success 'rebase.rescheduleFailedExec=true & --no-reschedule-failed-exec' '
+	test_when_finished "git rebase --abort" &&
+	test_config rebase.rescheduleFailedExec true &&
+	test_must_fail git rebase -x false --no-reschedule-failed-exec HEAD~2 &&
+	test_must_fail git rebase --continue 2>err &&
+	! grep "has been rescheduled" err
+'
+
+test_expect_success 'new rebase.rescheduleFailedExec=true setting in an ongoing rebase is ignored' '
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -x false HEAD~2 &&
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
2.31.1.584.gf4baedee75

