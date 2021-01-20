Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5095C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 04:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C08123159
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 04:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbhATEuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 23:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbhATEpy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 23:45:54 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECC6C0613C1
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 20:45:10 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id c22so14349702pgg.13
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 20:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUib7HgpKvInkDCU+QfthFS1ViZVhRIegL2HNAvEROM=;
        b=PQsqxB7OvDpD7dqHzF7oHAk5SkNrauNYxktRRvQ+9LHDwuvu9hMjQNFigKtVVHr+nY
         PiOoUqfFoNs1oi2/GVc2DytwjO4QM1BHEVgqDGj/DRwrrS/679JEFZ4uWXwzW87Vjjqr
         bFCSW6ZQ7Vw0pl2TFrCrv+fzzkZBYMMf8I0Nb7cX/aT8ZhHIFjvp626UaQs0UsaRbMce
         Sdxm4fjqXam4MMaHWYSgRN3ydqIkK32d1RTYI1bPBpk7lJh3JSKmKvzndbeZvWLYIYDd
         n3/+aMrppLqOWMrU7hNa1a8XywgJx8/Y7qa4tRyEhN9b/wYNeqMakGsaZyUgQd+CooTD
         scdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUib7HgpKvInkDCU+QfthFS1ViZVhRIegL2HNAvEROM=;
        b=UDhs8Opp+dNVfqbBq/UzENfNVqOJjtvBKIS3nbVztHbtULuqK8zj1kr3ChzR5Les6G
         QaCLFaJSkJtuR/rEK79Y0NQkNaIz6VG/+n4kAPtayNSinsn/LwdQUuiiEAfvZxeDRm5Q
         mE2+qBMyhylzuZa+DnJeuYcTYZQWEjXMzHH0jt4ar12NfN8K/rTan/90p7U6LSpAsE7Q
         QzfRj3Vh1e0vaQD/Si9hFI6BQk9knCPmgzHsuE0K3NJjllkBqMPVCZ4+9PI5uauWGSh4
         q2PIfyHZ9SRG/rP7FByVAXUB8zsjUGfNkuuA21RwO9xa34xM41OgQXQ4R2j+/sgldI9v
         H5tA==
X-Gm-Message-State: AOAM5324AoIbxqT2q6xgYV1qiysIDJgjLcNtIl/M8mGxZ5NqXyRPCGT6
        4Gi85MbIEBUvRh8ukWg/4H7Tb7CE2Nzp1w==
X-Google-Smtp-Source: ABdhPJyEwwmLf+0BWb1ZEZvFBIT3Sh1Vmc5N58cKOmmZve6ppHbeCTg2Ixv7lXj0Jc62wOvlrm6NdQ==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr7507536pgg.196.1611117909563;
        Tue, 19 Jan 2021 20:45:09 -0800 (PST)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:5900:961c:3398:e348:1cc1:ced7])
        by smtp.gmail.com with ESMTPSA id o76sm651209pfg.164.2021.01.19.20.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 20:45:08 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] rebase: add a config option for --no-fork-point
Date:   Tue, 19 Jan 2021 21:44:35 -0700
Message-Id: <20210120044435.53509-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some users (myself included) would prefer to have this feature off by
default because it can silently drop commits.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/config/rebase.txt |  3 +++
 builtin/rebase.c                | 21 ++++++++++++++-------
 t/t3431-rebase-fork-point.sh    | 10 ++++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index 7f7a07d22f..8531a4b3f7 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -68,3 +68,6 @@ rebase.rescheduleFailedExec::
 	Automatically reschedule `exec` commands that failed. This only makes
 	sense in interactive mode (or when an `--exec` option was provided).
 	This is the same as specifying the `--reschedule-failed-exec` option.
+
+rebase.forkPoint:
+	If set to false set `--no-fork-point` option by default.
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 840dbd7eb7..1679acc649 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -102,6 +102,7 @@ struct rebase_options {
 	int reschedule_failed_exec;
 	int use_legacy_rebase;
 	int reapply_cherry_picks;
+	int fork_point;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
@@ -111,7 +112,8 @@ struct rebase_options {
 		.default_backend = "merge",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = STRVEC_INIT,		\
-		.git_format_patch_opt = STRBUF_INIT	\
+		.git_format_patch_opt = STRBUF_INIT,	\
+		.fork_point = -1,			\
 	}
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
@@ -1095,6 +1097,12 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.forkpoint")) {
+		if (!git_config_bool(var, value))
+			opts->fork_point = 0;
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.usebuiltin")) {
 		opts->use_legacy_rebase = !git_config_bool(var, value);
 		return 0;
@@ -1306,7 +1314,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
-	int fork_point = -1;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
@@ -1406,7 +1413,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
-		OPT_BOOL(0, "fork-point", &fork_point,
+		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
 			   N_("strategy"), N_("use the given merge strategy")),
@@ -1494,7 +1501,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("cannot combine '--keep-base' with '--root'"));
 	}
 
-	if (options.root && fork_point > 0)
+	if (options.root && options.fork_point > 0)
 		die(_("cannot combine '--root' with '--fork-point'"));
 
 	if (action != ACTION_NONE && !in_progress)
@@ -1840,8 +1847,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 								    NULL);
 			if (!options.upstream_name)
 				error_on_missing_default_upstream();
-			if (fork_point < 0)
-				fork_point = 1;
+			if (options.fork_point < 0)
+				options.fork_point = 1;
 		} else {
 			options.upstream_name = argv[0];
 			argc--;
@@ -1945,7 +1952,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else
 		BUG("unexpected number of arguments left to parse");
 
-	if (fork_point > 0) {
+	if (options.fork_point > 0) {
 		struct commit *head =
 			lookup_commit_reference(the_repository,
 						&options.orig_head);
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 172562789e..e48c4014cf 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -74,4 +74,14 @@ test_expect_success 'git rebase --fork-point with ambigous refname' '
 	test_must_fail git rebase --fork-point --onto D one
 '
 
+test_expect_success '--fork-point and --root both given' '
+	test_must_fail git rebase --fork-point --root 2>err &&
+	test_i18ngrep "cannot combine" err
+'
+
+test_expect_success 'rebase.forkPoint true and --root given' '
+	test_config rebase.forkPoint true &&
+	git rebase --root
+'
+
 test_done
-- 
2.30.0

