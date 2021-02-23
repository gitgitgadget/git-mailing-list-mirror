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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F3FC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B60264E25
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhBWHXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhBWHW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 02:22:59 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E597C061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 23:22:19 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id k13so4133842otn.13
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 23:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J73VcapF8awWIJSWIDo4iPogav4CKejijFLyGGBf9Wk=;
        b=hJzwyyn1cwa7/UzOb16lMUBdUB6svxSOv7I56AOQV9y7nFYMrnduCI/hr8B0lSI8Up
         Q28dlHL3sodxBJ3iKsSyigpQeYzmzowF1OkN6TLqKF2byTznDZeqq2ddymUlCgGsrA+Z
         brp5lkQAsc4zA4V3o4UUBh9hhJ/VKYsqrn/Ib5T09BQqrwhGwqOUmpLZ7PiARaWlMSav
         BHVA1QG5wGa59gkLKNia2KNslL2F5EhZHk1MfzO+03mKj7t5Xs4GfhefzLqQeONFUSu5
         ey5l+YIDyMrdqbBiBcmPdAKWTLAm2+206A27NNLf931aCEa6W58RPLerKkFttUBb0I/Q
         HHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J73VcapF8awWIJSWIDo4iPogav4CKejijFLyGGBf9Wk=;
        b=LI1MZA3P/NEfBljkIDKPP4s+UKY9tw97nz8Jj+oFHDrDC8XZu6xMmnwHaZjU2pA2SV
         P9c1lqh/ETcTNEoUI7kU83zl76BLF19Qqu0iv9/1NoW6QWdaJroxqzZXaWM77DC7W9Dt
         URzqxYAXevMJkoQJhU4qESGTGUrV2iKX8FG3EYrr/bfGrqxUlkuAyV6Sz+4OmZse6ysm
         pnpD+rIPbbmF7mo9LlhwA4e2faSjlFA/kiM8m3gUdwMWhtMW0oDZm5hIWJ7UfR7X42Zw
         Rdbm9iHkaBSLrpScTpfp6uDhEA+F7ldD33zs67nL/0YTRIz4DEymEsfUsm4djC8hHWDA
         2UtA==
X-Gm-Message-State: AOAM530VY9P6MS6zbLm/YSg5AT2j00cdMqTBxXYt6t40hc9M1bz2OTre
        SnKrG43iXiD7varnnB+hsb9H68qavhQjKQ==
X-Google-Smtp-Source: ABdhPJyLrqhvmoHNgTPXpj62DrlL8Eml+K+2xXT5OGLgwn2Zk5lhaOYbVaS5JaYbRyP40/GmB20GRQ==
X-Received: by 2002:a05:6830:10c6:: with SMTP id z6mr11062306oto.243.1614064938373;
        Mon, 22 Feb 2021 23:22:18 -0800 (PST)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:5900:961c:3398:e348:1cc1:ced7])
        by smtp.gmail.com with ESMTPSA id r205sm4186435oib.15.2021.02.22.23.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:22:17 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, liu.denton@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3] rebase: add a config option for --no-fork-point
Date:   Tue, 23 Feb 2021 00:18:40 -0700
Message-Id: <20210223071840.44267-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some users (myself included) would prefer to have this feature off by
default because it can silently drop commits.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v3: Avoid calling test_expect_success from test_expect_success
---
 Documentation/config/rebase.txt |  3 ++
 builtin/rebase.c                | 20 +++++++-----
 t/t3431-rebase-fork-point.sh    | 55 +++++++++++++++++++++++++++------
 3 files changed, 61 insertions(+), 17 deletions(-)

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
index 840dbd7eb7..de400f9a19 100644
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
@@ -1095,6 +1097,11 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.forkpoint")) {
+		opts->fork_point = git_config_bool(var, value) ? -1 : 0;
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.usebuiltin")) {
 		opts->use_legacy_rebase = !git_config_bool(var, value);
 		return 0;
@@ -1306,7 +1313,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
-	int fork_point = -1;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
@@ -1406,7 +1412,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
-		OPT_BOOL(0, "fork-point", &fork_point,
+		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
 			   N_("strategy"), N_("use the given merge strategy")),
@@ -1494,7 +1500,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("cannot combine '--keep-base' with '--root'"));
 	}
 
-	if (options.root && fork_point > 0)
+	if (options.root && options.fork_point > 0)
 		die(_("cannot combine '--root' with '--fork-point'"));
 
 	if (action != ACTION_NONE && !in_progress)
@@ -1840,8 +1846,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1945,7 +1951,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else
 		BUG("unexpected number of arguments left to parse");
 
-	if (fork_point > 0) {
+	if (options.fork_point > 0) {
 		struct commit *head =
 			lookup_commit_reference(the_repository,
 						&options.orig_head);
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 2dab893c75..4c98d99e7e 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -29,19 +29,23 @@ test_expect_success setup '
 	test_commit G
 '
 
+do_test_rebase () {
+	expected="$1" &&
+	shift &&
+	git checkout main &&
+	git reset --hard E &&
+	git checkout side &&
+	git reset --hard G &&
+	git rebase $* &&
+	test_write_lines $expected >expect &&
+	git log --pretty=%s >actual &&
+	test_cmp expect actual
+}
+
 test_rebase () {
 	expected="$1" &&
 	shift &&
-	test_expect_success "git rebase $*" "
-		git checkout main &&
-		git reset --hard E &&
-		git checkout side &&
-		git reset --hard G &&
-		git rebase $* &&
-		test_write_lines $expected >expect &&
-		git log --pretty=%s >actual &&
-		test_cmp expect actual
-	"
+	test_expect_success "git rebase $*" "do_test_rebase '$expected' $*"
 }
 
 test_rebase 'G F E D B A'
@@ -77,4 +81,35 @@ test_expect_success 'git rebase --fork-point with ambigous refname' '
 	test_must_fail git rebase --fork-point --onto D one
 '
 
+test_expect_success '--fork-point and --root both given' '
+	test_must_fail git rebase --fork-point --root 2>err &&
+	test_i18ngrep "cannot combine" err
+'
+
+test_expect_success 'rebase.forkPoint set to false' '
+	test_config rebase.forkPoint false &&
+	do_test_rebase "G F C E D B A"
+'
+
+test_expect_success 'rebase.forkPoint set to false and then to true' '
+	test_config_global rebase.forkPoint false &&
+	test_config rebase.forkPoint true &&
+	do_test_rebase "G F E D B A"
+'
+
+test_expect_success 'rebase.forkPoint set to false and command line says --fork-point' '
+	test_config rebase.forkPoint false &&
+	do_test_rebase "G F E D B A" --fork-point
+'
+
+test_expect_success 'rebase.forkPoint set to true and command line says --no-fork-point' '
+	test_config rebase.forkPoint true &&
+	do_test_rebase "G F C E D B A" --no-fork-point
+'
+
+test_expect_success 'rebase.forkPoint set to true and --root given' '
+	test_config rebase.forkPoint true &&
+	git rebase --root
+'
+
 test_done
-- 
2.30.1

