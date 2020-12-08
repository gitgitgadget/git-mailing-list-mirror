Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ECCC0018C
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2479B239EF
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 00:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgLHA2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgLHA2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 19:28:34 -0500
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C831FC0611E4
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 16:27:17 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id k9so964232oop.6
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 16:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+JU+H8odgkCR4y5wP1x8X+yM+DdAZrJ4ITDgCktrRo=;
        b=l9QjJQI9ZhJqSbyd8TaGpy3rs7WlDnrnE/fGkS4x4du9q35JY3LIg4Q2ltxOM9YnGw
         jJEP80V3kneBACN+awN8l/5SFJupQAh6nIEBKm8ocEitIvMy2DJRl6uR3MEw/cUoj8H7
         1G121C+BNtr3wRfM5EebdRExqNq3EQO3ZGsmOBiEe6DAkynOKmg46u8XSW2l8AJjIyeX
         KS81/2jY5XFFp+2mpWGB1JkKq7F+aJLRqNupI9G/obzSsTC/j/XmZpr8SsPKXBFSpJdi
         cEouZzPPHqmotkElmMmaAQi6iN6BooyTkGmw3NFhoUtuV4Nsl9K6AfhK2Bu5cmWvOB4r
         Frzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+JU+H8odgkCR4y5wP1x8X+yM+DdAZrJ4ITDgCktrRo=;
        b=WfcJunSTj4d4YkWWPkDT9m1fBzvLZO8TSVvHBSIfus3mG524HZ1mX1BwPyznZz8Mds
         OfYL26Bif1SkFegEEHxMiLZXiOcyrQKeAJHagoT6QJC1DhilEpcLKCZdnBCyX/6gpi4U
         9rvgE9Cl7temjIi8Q5tcwkRJKh0OyhGQXhLlfL4EObdhQkFOYNyEECCCOlx7I+d/0DYt
         h5uIicZ4KPKb4mLD0sScjRKTqHfak8Uj6X62Jcozl3cqWe9BjmaTIWw1P+5jXTFXcp9B
         TokT14E/LZZ9FZJOsy1gpEtG3gu2SVx+O3Bt6ZZwe7tT8/HWdJgTq6LdvOpIwPz4lfp8
         rXvA==
X-Gm-Message-State: AOAM531JMUbE8VsfCS05V3MPtROZLi7ep/iPJUxJf0Q7t64ay2BI0x5G
        DeMtTUX4/G6PDhK5iqY72Frx6i61/kSTcKBC
X-Google-Smtp-Source: ABdhPJxXSIyvPevKUsSVBsCISPR17PmE/wVOjkkjMaMpmE/2LZayn7Lo/lYhYkzPUyZe0H2S+J5Veg==
X-Received: by 2002:a4a:8606:: with SMTP id v6mr14458020ooh.37.1607387236745;
        Mon, 07 Dec 2020 16:27:16 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f10sm2702140oti.11.2020.12.07.16.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:27:16 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 16/19] pull: add pull.mode
Date:   Mon,  7 Dec 2020 18:26:45 -0600
Message-Id: <20201208002648.1370414-17-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208002648.1370414-1-felipe.contreras@gmail.com>
References: <20201208002648.1370414-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way we can add more modes and the default can be something else,
namely it can be set to "ff-only", so eventually we can reject
non-fast-forward merges by default.

Also 'branch.<name>.pullmode'.

For now we simply override the rebase mode.

And when any --rebase or --merge options are specified the mode is
updated accordingly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/branch.txt |  6 +++
 Documentation/config/pull.txt   |  6 +++
 builtin/pull.c                  | 70 +++++++++++++++++++++++++++++++--
 builtin/remote.c                | 19 ++++++++-
 rebase.c                        | 10 +++++
 rebase.h                        |  9 +++++
 t/t5520-pull.sh                 | 42 ++++++++++++++++++++
 t/t7601-merge-pull-config.sh    |  7 ++++
 8 files changed, 164 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index cc5f3249fc..b57bf2c308 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -96,6 +96,12 @@ mode.
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
 
+branch.<name>.pullmode::
+	When "git pull" is run, this determines if it would either merge or
+	rebase the fetched branch. The possible values are 'merge', and
+	'rebase'. See "pull.mode" for doing this in a non
+	branch-specific manner.
+
 branch.<name>.description::
 	Branch description, can be edited with
 	`git branch --edit-description`. Branch description is
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
diff --git a/builtin/pull.c b/builtin/pull.c
index 118fbdeb62..7756c8aea1 100644
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
@@ -349,6 +372,29 @@ static enum rebase_type config_get_rebase(void)
 	return REBASE_DEFAULT;
 }
 
+static enum pull_mode_type config_get_pull_mode(void)
+{
+	struct branch *curr_branch = branch_get("HEAD");
+	const char *value;
+
+	if (curr_branch) {
+		char *key = xstrfmt("branch.%s.pullmode", curr_branch->name);
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
@@ -935,6 +981,22 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	opt_ff = xstrdup_or_null(config_get_ff());
 	opt_rebase = config_get_rebase();
+	mode = config_get_pull_mode();
+
+	if (!opt_rebase && mode) {
+		switch (mode) {
+		case PULL_MODE_MERGE:
+			opt_rebase = REBASE_FALSE;
+			break;
+		case PULL_MODE_REBASE:
+			opt_rebase = REBASE_TRUE;
+			break;
+		default:
+			break;
+		}
+	} else if (opt_rebase > 0) {
+		mode = opt_rebase >= REBASE_TRUE ? PULL_MODE_REBASE : PULL_MODE_MERGE;
+	}
 
 	if (!getenv("GIT_REFLOG_ACTION"))
 		set_reflog_message(argc, argv);
@@ -1031,8 +1093,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"you need to specify if you want a merge, or a rebase.\n"
 			"You can squelch this message by running one of the following commands:\n"
 			"\n"
-			"  git config pull.rebase false  # merge (the default strategy)\n"
-			"  git config pull.rebase true   # rebase\n"
+			"  git config pull.mode merge    # (the default strategy)\n"
+			"  git config pull.mode rebase\n"
 			"  git config pull.ff only       # fast-forward only\n"
 			"\n"
 			"You can replace \"git config\" with \"git config --global\" to set a default\n"
diff --git a/builtin/remote.c b/builtin/remote.c
index c1b211b272..51b1e675e3 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -269,7 +269,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 	char *name;
 	struct string_list_item *item;
 	struct branch_info *info;
-	enum { REMOTE, MERGE, REBASE, PUSH_REMOTE } type;
+	enum { REMOTE, MERGE, REBASE, PUSH_REMOTE, PULL_MODE } type;
 	size_t key_len;
 
 	if (!starts_with(key, "branch."))
@@ -284,6 +284,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		type = REBASE;
 	else if (strip_suffix(key, ".pushremote", &key_len))
 		type = PUSH_REMOTE;
+	else if (strip_suffix(key, ".pullmode", &key_len))
+		type = PULL_MODE;
 	else
 		return 0;
 	name = xmemdupz(key, key_len);
@@ -324,6 +326,21 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			warning(_("more than one %s"), orig_key);
 		info->push_remote_name = xstrdup(value);
 		break;
+	case PULL_MODE: {
+		int mode = pull_mode_parse_value(value);
+		switch (mode) {
+		case PULL_MODE_MERGE:
+			info->rebase = REBASE_FALSE;
+			break;
+		case PULL_MODE_REBASE:
+			info->rebase = REBASE_TRUE;
+			break;
+		default:
+			info->rebase = REBASE_INVALID;
+			break;
+		}
+		break;
+	}
 	default:
 		BUG("unexpected type=%d", type);
 	}
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
index 9fae07cdfa..eb0086bd1c 100755
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
@@ -523,6 +533,17 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
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
@@ -552,6 +573,16 @@ test_expect_success REBASE_P \
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
@@ -593,6 +624,17 @@ test_expect_success '--rebase=false create a new merge commit' '
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
index 8a6aae564a..25ca239c17 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -41,6 +41,13 @@ test_expect_success 'pull.rebase not set (fast-forward)' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
+test_expect_success 'pull.mode set' '
+	git reset --hard c2 &&
+	test_config pull.mode merge &&
+	git pull . c1 2>err &&
+	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+'
+
 test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
-- 
2.29.2

