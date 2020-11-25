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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865DFC64E7C
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3722075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n90SX3z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgKYD3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYD3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:29:55 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3537C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:54 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id l20so173517oot.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qbX0dpazZDMnxB/FzgCb382HO7VHSEimPclHstmiyik=;
        b=n90SX3z1FYW121Omf68wK4Sd7tr/z9sP8tg+SCjuLZIHpSsUprhIjr+YuZJIG3FHvr
         Ras9S57HkqFax3O3vbp7t9kl1q2ru3JZGP9IVRkINzSuiyRbhxZasmypwTdmFagSOJI4
         +GdzXnAsBkUfk+TtiOJNaTWICxxoDBtlzl/H+8TInLK3RtpmbhUjF6PuJ91HLwieAOPL
         zKx0OF20Jleo/R6VQ5AaKr8re8G4xqJqggnQF6bW0aiLyHAisJheqxSaW7q2lVGrX+yn
         ak+itLXqSlHu3okFKe3I327Mya2suaejVR7CYBI775WDZKRFzcA4IH65M5gq7IQGnaZk
         wK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qbX0dpazZDMnxB/FzgCb382HO7VHSEimPclHstmiyik=;
        b=pc3u6kS8jIgzodM0p+vKihrv81FRXdVQSAIB3o7uxadMpY2EfCpMHmOymlw/6rPd6U
         xtZ5/pax8RZIvXHwUfY+XEedLe0V/nKwH8bpuB15pBqYAH9T2FazNDq4AubJ44d2Q4+w
         srd3aBYUbSVz3DJTYyiMp6hwqNFTrB/bILAOkMNi3ANVG6zyb5o+bakQmcHbdnvEF4Su
         7b0AmvmDRXEkhHBgc7xLow012BFZBtbCzyVE15pwkIT3VHP7TcrvLVISlAmGwlMVzX6R
         QbQpLygUsN6Yg7LvbNPZQZ+M7iHGwj2qYjN+ZNXA/Ovnmwn48kaNLDDf4QdlcsqvTxaX
         BCQQ==
X-Gm-Message-State: AOAM531ShJ1hk3VBR2xsV23Z5obaT27RJkR83OgnDjy7jV0M9jCM7uj/
        Sz1XUoQr//6X555OdKTZZuAoaMbzfvyvGA==
X-Google-Smtp-Source: ABdhPJyVEZKu5eBYvdDeijcuS000nLZ9+/lqhyFOvR3T2e19yfhrKyp6yicA1hFLLPZm92+q+MuVXQ==
X-Received: by 2002:a4a:8582:: with SMTP id t2mr1268384ooh.89.1606274993885;
        Tue, 24 Nov 2020 19:29:53 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j8sm674287oif.55.2020.11.24.19.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 19:29:53 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v8 08/10] pull: add pull.mode
Date:   Tue, 24 Nov 2020 21:29:36 -0600
Message-Id: <20201125032938.786393-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125032938.786393-1-felipe.contreras@gmail.com>
References: <20201125032938.786393-1-felipe.contreras@gmail.com>
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

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/branch.txt |  6 ++++
 Documentation/config/pull.txt   |  6 ++++
 builtin/pull.c                  | 57 ++++++++++++++++++++++++++++++---
 builtin/remote.c                | 19 ++++++++++-
 rebase.c                        | 10 ++++++
 rebase.h                        |  9 ++++++
 t/t5520-pull.sh                 | 42 ++++++++++++++++++++++++
 t/t7601-merge-pull-config.sh    |  7 ++++
 8 files changed, 151 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index cc5f3249fc..94510a5184 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -96,6 +96,12 @@ mode.
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
 
+branch.<name>.pullmode::
+	When "git pull" is run, this determines if it would either merge or
+	rebase the fetched branch. The possible values are 'merge',
+	'rebase'. See "pull.mode" for doing this in a non
+	branch-specific manner.
+
 branch.<name>.description::
 	Branch description, can be edited with
 	`git branch --edit-description`. Branch description is
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index 5404830609..2606515fe4 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -29,6 +29,12 @@ mode.
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
 
+pull.mode::
+	When "git pull" is run, this determines if it would either merge or
+	rebase the fetched branch. The possible values are 'merge',
+	and 'rebase'. See "branch.<name>.pullmode" for doing
+	this in a non branch-specific manner.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/builtin/pull.c b/builtin/pull.c
index 0df7d27343..feb9a7f6ee 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -49,6 +49,14 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
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
@@ -75,6 +83,7 @@ static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 
 /* Options passed to git-merge or git-rebase */
 static enum rebase_type opt_rebase = -1;
+static enum pull_mode_type mode;
 static char *opt_diffstat;
 static char *opt_log;
 static char *opt_signoff;
@@ -347,6 +356,29 @@ static enum rebase_type config_get_rebase(void)
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
@@ -932,8 +964,25 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (!opt_ff)
 		opt_ff = xstrdup_or_null(config_get_ff());
 
-	if (opt_rebase < 0)
-		opt_rebase = config_get_rebase();
+	if (opt_rebase < 0) {
+		mode = config_get_pull_mode();
+		switch (mode) {
+		case PULL_MODE_MERGE:
+			opt_rebase = REBASE_FALSE;
+			break;
+		case PULL_MODE_REBASE:
+			opt_rebase = config_get_rebase();
+			if (!opt_rebase) opt_rebase = REBASE_TRUE;
+			break;
+		default:
+			opt_rebase = config_get_rebase();
+		}
+	}
+
+	if (!mode) {
+		if (opt_rebase)
+			mode = opt_rebase >= REBASE_TRUE ? PULL_MODE_REBASE : PULL_MODE_MERGE;
+	}
 
 	if (read_cache_unmerged())
 		die_resolve_conflict("pull");
@@ -1014,8 +1063,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"discouraged. You can squelch this message by running one of the following\n"
 			"commands sometime before your next pull:\n"
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
index 02e2a9b2c6..4a36ad30e2 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -39,6 +39,13 @@ test_expect_success 'pull.rebase not set (fast-forward)' '
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

