Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C50BC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 15:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbjDEPWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbjDEPWT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 11:22:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA738E56
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 08:22:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m8so10204125wmq.5
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680708136;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eosEipxzrnjIgqIKnbXgdOeWgGfGStRuvUUv+Uwexb8=;
        b=j8Kz0/ppgK4X18ZRFjRdLePmEjz2ClDdLzujxHO4TujZF3g8ETzCyxcfWHpECrcLiv
         klbDRA1WXGVCIpaqwqk7dckPPMZMzX6tS6TWTZqP2nkc/NHTm+6yKOrF/aj3g5RrGJT4
         1liyl21364HTUwP2tG7F9ZcMAF6PnSiz4FqPZSCsybe87xqjA3ZjHhmtxRXnHTUkW+Mu
         Ys8voQes97dJCC3MDm9IE+JxxKOGhh2CtAU1oHww/ltnQBsVkCAPmGPt9Nv+G1nWwvA6
         cSyXFWSQ+cSDNx/82ivFpQzGokK2svfnwV4D93HNOnSW1dFypuKyxM8M9kQhUA3F22GV
         zhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680708136;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eosEipxzrnjIgqIKnbXgdOeWgGfGStRuvUUv+Uwexb8=;
        b=qPcDFlRJJpkE3v13Gw0q2Y1YAYkpYR4sdTwIv0VBWaLG5VkesffS+06kErPeESWDX2
         4IEgNIAKT/TYkYDdXiPZPDEsVyZl5PlqJ5boXJiFideX0q1GIHBF7FDvzRw6qYBIKY85
         dk8OWZTOTN+kyTSHS5Xo3Dj/PazYYPU53LgUc2iXv5P9dLGbJm83IGfoOnUjFaz/TNTi
         iYNSWtkFRrRSWzThQ1fBUwrSpF63kvQJ2i/bWPGmSEnjjSJOArNjOKmjrjCUCV+gxgsU
         OsT+ANHuT9KX3EKyhxPj7uBWNnvnuntjtQx8BcSI0zc2VfNRCID5AMgmx7Nb5pCPDIPr
         p/Ig==
X-Gm-Message-State: AAQBX9clJiH1jcrwx5CgUrPG/HP7wQfX1PStzvWXiM+V5aAklJR6qPUO
        SgCNWYvdFkwYY4WN/Suva02uH1KoWa0=
X-Google-Smtp-Source: AKy350Z9x88X3dKz/N3LdHzplOo8/+COKGZXCDGJ0i5Xd0HUML1hCZJS70vKCucnfCFE0y6Nt0u7XQ==
X-Received: by 2002:a1c:790c:0:b0:3ee:7022:5eda with SMTP id l12-20020a1c790c000000b003ee70225edamr5166334wme.7.1680708136129;
        Wed, 05 Apr 2023 08:22:16 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003edc11c2ecbsm2515610wmj.4.2023.04.05.08.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:22:15 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/5] rebase -m: cleanup --strategy-option handling
Date:   Wed,  5 Apr 2023 16:21:46 +0100
Message-Id: <ccef0e6f4bfc9a6c1ef378ec5974edec5d103fcd.1680708043.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.670.g64ef305212.dirty
In-Reply-To: <cover.1680708043.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1680708043.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When handling "--strategy-option" rebase collects the commands into a
struct string_list, then concatenates them into a string, prepending "--"
to each one before splitting the string and removing the "--" prefix.
This is an artifact of the scripted rebase and the need to support
"rebase --preserve-merges". Now that "--preserve-merges" no-longer
exists we can cleanup the way the argument is handled.

The tests for a bad strategy option are adjusted now that
parse_strategy_opts() is no-longer called when starting a rebase. The
fact that it only errors out when running "git rebase --continue" is a
mixed blessing but the next commit will fix the root cause of the
parsing problem so lets not worry about that here.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c               | 30 ++++++++++--------------------
 sequencer.c                    |  2 +-
 sequencer.h                    |  1 -
 t/t3436-rebase-more-options.sh | 10 ++++++++--
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 3bd215c771..511922c6fc 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -117,7 +117,8 @@ struct rebase_options {
 	struct string_list exec;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
-	char *strategy, *strategy_opts;
+	char *strategy;
+	struct string_list strategy_opts;
 	struct strbuf git_format_patch_opt;
 	int reschedule_failed_exec;
 	int reapply_cherry_picks;
@@ -143,6 +144,7 @@ struct rebase_options {
 		.config_autosquash = -1,                \
 		.update_refs = -1,                      \
 		.config_update_refs = -1,               \
+		.strategy_opts = STRING_LIST_INIT_NODUP,\
 	}
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
@@ -176,8 +178,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 		replay.default_strategy = NULL;
 	}
 
-	if (opts->strategy_opts)
-		parse_strategy_opts(&replay, opts->strategy_opts);
+	for (size_t i = 0; i < opts->strategy_opts.nr; i++)
+		strvec_push(&replay.xopts, opts->strategy_opts.items[i].string);
 
 	if (opts->squash_onto) {
 		oidcpy(&replay.squash_onto, opts->squash_onto);
@@ -1013,7 +1015,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int ignore_whitespace = 0;
 	const char *gpg_sign = NULL;
 	const char *rebase_merges = NULL;
-	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
 	char *keep_base_onto_name = NULL;
@@ -1122,7 +1123,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
 			   N_("strategy"), N_("use the given merge strategy")),
-		OPT_STRING_LIST('X', "strategy-option", &strategy_options,
+		OPT_STRING_LIST('X', "strategy-option", &options.strategy_opts,
 				N_("option"),
 				N_("pass the argument through to the merge "
 				   "strategy")),
@@ -1436,23 +1437,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else {
 		/* REBASE_MERGE */
 		if (ignore_whitespace) {
-			string_list_append(&strategy_options,
+			string_list_append(&options.strategy_opts,
 					   "ignore-space-change");
 		}
 	}
 
-	if (strategy_options.nr) {
-		int i;
-
-		if (!options.strategy)
-			options.strategy = "ort";
-
-		strbuf_reset(&buf);
-		for (i = 0; i < strategy_options.nr; i++)
-			strbuf_addf(&buf, " --%s",
-				    strategy_options.items[i].string);
-		options.strategy_opts = xstrdup(buf.buf);
-	}
+	if (options.strategy_opts.nr && !options.strategy)
+		options.strategy = "ort";
 
 	if (options.strategy) {
 		options.strategy = xstrdup(options.strategy);
@@ -1827,10 +1818,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.gpg_sign_opt);
 	string_list_clear(&options.exec, 0);
 	free(options.strategy);
-	free(options.strategy_opts);
+	string_list_clear(&options.strategy_opts, 0);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
 	free(keep_base_onto_name);
-	string_list_clear(&strategy_options, 0);
 	return !!ret;
 }
diff --git a/sequencer.c b/sequencer.c
index 6e2f3357c8..045d549042 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2913,7 +2913,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	return 0;
 }
 
-void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
+static void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 {
 	int i;
 	int count;
diff --git a/sequencer.h b/sequencer.h
index 8a79d6b200..913a0f652d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -252,7 +252,6 @@ int read_oneliner(struct strbuf *buf,
 	const char *path, unsigned flags);
 int read_author_script(const char *path, char **name, char **email, char **date,
 		       int allow_missing);
-void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      struct commit *onto, const struct object_id *orig_head);
 void sequencer_post_commit_cleanup(struct repository *r, int verbose);
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index c3184c9ade..3adf42f47d 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -41,19 +41,25 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'bad -X <strategy-option> arguments: unclosed quote' '
+	test_when_finished "test_might_fail git rebase --abort" &&
 	cat >expect <<-\EOF &&
 	fatal: could not split '\''--bad'\'': unclosed quote
 	EOF
-	test_expect_code 128 git rebase -X"bad argument\"" side main >out 2>actual &&
+	GIT_SEQUENCE_EDITOR="echo break >" \
+		git rebase -i -X"bad argument\"" side main &&
+	test_expect_code 128 git rebase --continue >out 2>actual &&
 	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
 test_expect_success 'bad -X <strategy-option> arguments: bad escape' '
+	test_when_finished "test_might_fail git rebase --abort" &&
 	cat >expect <<-\EOF &&
 	fatal: could not split '\''--bad'\'': cmdline ends with \
 	EOF
-	test_expect_code 128 git rebase -X"bad escape \\" side main >out 2>actual &&
+	GIT_SEQUENCE_EDITOR="echo break >" \
+		git rebase -i -X"bad escape \\" side main &&
+	test_expect_code 128 git rebase --continue >out 2>actual &&
 	test_must_be_empty out &&
 	test_cmp expect actual
 '
-- 
2.40.0.670.g64ef305212.dirty

