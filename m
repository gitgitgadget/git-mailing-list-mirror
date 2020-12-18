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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F63C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B6D23B8C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgLRVLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgLRVLv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:51 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CC1C0611CC
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:47 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d20so3266792otl.3
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=At4/fPLbLHQ0dYuXcHtVXoGbM1YL7nwX6kdmxalFtyM=;
        b=r7K4g/CM8gIv2YHEW4zQVU/L+ag044oRSgzmHA+K5EKGr1fP9lzNU+SG8Uf8fM9e+8
         Gf3nF1FWxlVYsLk/PItRUVUlzfoi14T3Fm+NOBuc0m+3IEcE1Dv5DnVG6bmASlUslK2r
         pL9lPKZf500PfL2NDAasr+hi4e9gpYKMVoa8XAn1BMEfcH6BbqIuKYKLm2egBU32XEaE
         dZCAFzmUkQWqZET2wZ12IaNYaVfaM3wfPJ+TWwtbj8gJzAyEfgMphWA7MQeZaqWv8QJl
         zfKMsR8Lb3AWcsgux0f6tMDqFS1qHH/VWPeF5RzY+loUeLDnJXSPpu3Bc/vkGjUFBJXQ
         th4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=At4/fPLbLHQ0dYuXcHtVXoGbM1YL7nwX6kdmxalFtyM=;
        b=ijYSrHkOP5gRbWI4wJ0DuLkjF+v9wskXQt8TDoCVQn47kWnS/yOEeqzfvACk+oAgZX
         JMsyNihrk73KQa2ctCSy4NXCiiuu+tlgpRdJAUsvQGjNZVWlxtnA/btOkACSfIsa0j9m
         KQ9qsx8IWAWPaQyGKexiKvlFZXrrdo0O3VEKdghsxUR0F/A9nPRVzN5A7s8xzU/G/yOB
         6NMzYs9zMlZAKHrJaQjm2Y5uko+kiCv/FalFZXf8GzadXGRrva3qNK4KdH2mYE/gKKgd
         3skScVcwEjffY+Bb/gGOIG4X1Y7qAW9zyzIm4a4giR7nX1Vpxi8alCo/v2QYCVRfb3de
         sEJg==
X-Gm-Message-State: AOAM532MFaILhzddTYtjt0DiLiIsV3VVcmf6ieBBnEF7wROgS+L+i7Cm
        zb9g62nx6apDKGYtyY53IA766gS60CQ+Cg==
X-Google-Smtp-Source: ABdhPJxeL7aCqvv5zPcPJX0MSuTk25oQCtFLHz2gRR2hlT3RAkWe6M3gSat2AG8PjG1nMgIVXiJ0jg==
X-Received: by 2002:a9d:17cb:: with SMTP id j69mr2762162otj.6.1608325846097;
        Fri, 18 Dec 2020 13:10:46 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q77sm2160234ooq.15.2020.12.18.13.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:45 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v2 10/13] pull: add pull.mode
Date:   Fri, 18 Dec 2020 15:10:23 -0600
Message-Id: <20201218211026.1937168-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The evolution of pull options has somewhat served most users, however,
they have been found lacking for a very needed trio: merge / rebase /
fast-forward-only.

Another thing that is missing is the possibility to specify pull options
on a per-repository basis, as Theodore Ts'o suggested long time ago
[1].

This patch adds a pull.mode option with two possible values (for now);
merge and rebase. If set, it overrides what the user has specified in
pull.rebase, and it's updated with either --merge, or --rebase.

In addition to pull.mode, a 'remote.<name>.pullmode' configuration is
introduced, so the user can specify the desired options based on the
source of the pull, rather than the destination.

And of course; new modes like fast-forward-only can be introduced later
on.

[1] https://lore.kernel.org/git/20130312212027.GE14792@thunk.org

Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/pull.txt   |  6 +++
 Documentation/config/remote.txt |  6 +++
 Documentation/git-pull.txt      |  3 +-
 builtin/pull.c                  | 81 +++++++++++++++++++++++++++++++--
 rebase.c                        | 10 ++++
 rebase.h                        |  9 ++++
 t/t5520-pull.sh                 | 54 ++++++++++++++++++++++
 t/t7601-merge-pull-config.sh    | 14 ++++++
 8 files changed, 178 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index 5404830609..f4385cde33 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -29,6 +29,12 @@ mode.
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
 
+pull.mode::
+	When "git pull" is run, this determines if it would either merge or
+	rebase the fetched branch. The possible values are 'merge',
+	and 'rebase'. See "branch.<name>.pullmode" for setting this on a
+	per-branch basis.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index a8e6437a90..a732c92cf5 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -84,3 +84,9 @@ remote.<name>.promisor::
 remote.<name>.partialclonefilter::
 	The filter that will be applied when fetching from this
 	promisor remote.
+
+remote.<name>.pullmode::
+	When "git pull" is run, this determines if it would either merge or
+	rebase the branches from this remote. The possible values are 'merge', and
+	'rebase'. See "pull.mode" for doing this in a non
+	repository-specific manner.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 195496e63d..65f8b16a7d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -72,7 +72,8 @@ synchronize the local, and remote brances.
 
 In these situations `git pull` will warn you about your possible
 options, which are either `--merge`, or `--rebase`. However, by default
-it will continue doing a merge.
+it will continue doing a merge (you can change that with the `pull.mode`
+configuration).
 
 A merge will create a new commit with two parent commits (`G` and `C`)
 and a log message describing the changes, which you can edit.
diff --git a/builtin/pull.c b/builtin/pull.c
index f1a03ccd14..bfadd585c7 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,6 +27,8 @@
 #include "commit-reach.h"
 #include "sequencer.h"
 
+static enum pull_mode_type mode;
+
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
@@ -49,6 +51,14 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 	return REBASE_INVALID;
 }
 
+static enum pull_mode_type parse_config_pull_mode(const char *key, const char *value)
+{
+	enum pull_mode_type v = pull_mode_parse_value(value);
+	if (v == PULL_MODE_INVALID)
+		die(_("Invalid value for %s: %s"), key, value);
+	return v;
+}
+
 /**
  * Callback for --rebase, which parses arg with parse_config_rebase().
  */
@@ -60,9 +70,21 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
 		*value = parse_config_rebase("--rebase", arg, 0);
 	else
 		*value = unset ? REBASE_FALSE : REBASE_TRUE;
+
+	if (*value > 0)
+		mode = *value >= REBASE_TRUE ? PULL_MODE_REBASE : PULL_MODE_MERGE;
+
 	return *value == REBASE_INVALID ? -1 : 0;
 }
 
+static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
+{
+	enum rebase_type *value = opt->value;
+	mode = PULL_MODE_MERGE;
+	*value = REBASE_FALSE;
+	return 0;
+}
+
 static const char * const pull_usage[] = {
 	N_("git pull [<options>] [<repository> [<refspec>...]]"),
 	NULL
@@ -129,8 +151,9 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
-	OPT_SET_INT('m', "merge", &opt_rebase,
-		N_("incorporate changes by merging"), REBASE_FALSE),
+	OPT_CALLBACK_F('m', "merge", &opt_rebase, NULL,
+		N_("incorporate changes by merging"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_merge),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -349,6 +372,31 @@ static enum rebase_type config_get_rebase(void)
 	return REBASE_DEFAULT;
 }
 
+static enum pull_mode_type config_get_pull_mode(const char *repo)
+{
+	const char *value;
+	struct remote *remote;
+
+	remote = remote_get(repo);
+
+	if (remote) {
+		char *key = xstrfmt("remote.%s.pullmode", remote->name);
+
+		if (!git_config_get_value(key, &value)) {
+			enum pull_mode_type ret = parse_config_pull_mode(key, value);
+			free(key);
+			return ret;
+		}
+
+		free(key);
+	}
+
+	if (!git_config_get_value("pull.mode", &value))
+		return parse_config_pull_mode("pull.mode", value);
+
+	return PULL_MODE_DEFAULT;
+}
+
 /**
  * Read config variables.
  */
@@ -935,8 +983,8 @@ static void show_advice_pull_non_ff(void)
 		 "\n"
 		 "You can squelch this message by running one of the following commands:\n"
 		 "\n"
-		 "  git config --global pull.rebase false  # merge\n"
-		 "  git config --global pull.rebase true   # rebase\n"
+		 "  git config --global pull.mode merge\n"
+		 "  git config --global pull.mode rebase\n"
 		 "  git config --global pull.ff only       # fast-forward only\n"
 		 "\n"
 		 "If unsure, run \"git pull --merge\".\n"
@@ -970,6 +1018,31 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
+	/*
+	 * If the user has not specified --merge or --rebase, fetch pull.mode to override
+	 * pull.rename.
+	 */
+	if (!mode) {
+		mode = config_get_pull_mode(repo);
+
+		switch (mode) {
+		case PULL_MODE_MERGE:
+			opt_rebase = REBASE_FALSE;
+			break;
+		case PULL_MODE_REBASE:
+			/* Do not oeverride other rebase modes */
+			if (opt_rebase < REBASE_TRUE)
+				opt_rebase = REBASE_TRUE;
+			break;
+		case PULL_MODE_DEFAULT:
+			if (opt_rebase > 0)
+				mode = opt_rebase >= REBASE_TRUE ? PULL_MODE_REBASE : PULL_MODE_MERGE;
+			break;
+		default:
+			break;
+		}
+	}
+
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
 
diff --git a/rebase.c b/rebase.c
index f8137d859b..bdfca49886 100644
--- a/rebase.c
+++ b/rebase.c
@@ -33,3 +33,13 @@ enum rebase_type rebase_parse_value(const char *value)
 
 	return REBASE_INVALID;
 }
+
+enum pull_mode_type pull_mode_parse_value(const char *value)
+{
+	if (!strcmp(value, "merge") || !strcmp(value, "m"))
+		return PULL_MODE_MERGE;
+	else if (!strcmp(value, "rebase") || !strcmp(value, "r"))
+		return PULL_MODE_REBASE;
+
+	return PULL_MODE_INVALID;
+}
diff --git a/rebase.h b/rebase.h
index 34d4acfd74..5ab8f4ddd5 100644
--- a/rebase.h
+++ b/rebase.h
@@ -13,4 +13,13 @@ enum rebase_type {
 
 enum rebase_type rebase_parse_value(const char *value);
 
+enum pull_mode_type {
+	PULL_MODE_INVALID = -1,
+	PULL_MODE_DEFAULT = 0,
+	PULL_MODE_MERGE,
+	PULL_MODE_REBASE
+};
+
+enum pull_mode_type pull_mode_parse_value(const char *value);
+
 #endif /* REBASE */
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9fae07cdfa..59799ac4d5 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -449,6 +449,16 @@ test_expect_success 'pull.rebase' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pull.mode rebase' '
+	git reset --hard before-rebase &&
+	test_config pull.mode rebase &&
+	git pull . copy &&
+	test_cmp_rev HEAD^ copy &&
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pull --autostash & pull.rebase=true' '
 	test_config pull.rebase true &&
 	test_pull_autostash 1 --autostash
@@ -480,6 +490,18 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test_cmp expect actual
 '
 
+test_expect_success 'remote..pullmode' '
+	git reset --hard before-rebase &&
+	git remote add test_remote . &&
+	test_when_finished "git remote remove test_remote" &&
+	test_config remote.test_remote.pullmode rebase &&
+	git pull test_remote copy &&
+	test_cmp_rev HEAD^ copy &&
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pull --rebase warns on --verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --verify-signatures . copy 2>err &&
@@ -523,6 +545,17 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
 	test_cmp expect actual
 '
 
+test_expect_success 'pull.mode=merge create a new merge commit' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.mode merge &&
+	git pull . copy &&
+	test_cmp_rev HEAD^1 before-preserve-rebase &&
+	test_cmp_rev HEAD^2 copy &&
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'pull.rebase=true flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
@@ -552,6 +585,16 @@ test_expect_success REBASE_P \
 	test_cmp_rev HEAD^2 keep-merge
 '
 
+test_expect_success REBASE_P \
+	'pull.rebase=preserve rebases and merges keep-merge with pull.mode' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.mode rebase &&
+	test_config pull.rebase preserve &&
+	git pull . copy &&
+	test_cmp_rev HEAD^^ copy &&
+	test_cmp_rev HEAD^2 keep-merge
+'
+
 test_expect_success 'pull.rebase=interactive' '
 	write_script "$TRASH_DIRECTORY/fake-editor" <<-\EOF &&
 	echo I was here >fake.out &&
@@ -593,6 +636,17 @@ test_expect_success '--rebase=false create a new merge commit' '
 	test_cmp expect actual
 '
 
+test_expect_success '--rebase=false create a new merge commit with pull.mode' '
+	git reset --hard before-preserve-rebase &&
+	test_config pull.mode rebase &&
+	git pull --rebase=false . copy &&
+	test_cmp_rev HEAD^1 before-preserve-rebase &&
+	test_cmp_rev HEAD^2 copy &&
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 7c4607191a..47fd2e2d05 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -33,6 +33,13 @@ test_expect_success 'pull.rebase not set' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
+test_expect_success 'pull.mode set' '
+	git reset --hard c0 &&
+	test_config pull.mode merge &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
 test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c0 &&
 	test_config pull.ff true &&
@@ -92,6 +99,13 @@ test_expect_success 'pull.rebase not set (not-fast-forward)' '
 	test_i18ngrep "Pulling without specifying how to reconcile" decoded
 '
 
+test_expect_success 'pull.mode set' '
+	git reset --hard c2 &&
+	test_config pull.mode merge &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
 test_expect_success 'pull.rebase not set and pull.ff=true (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
-- 
2.30.0.rc0

