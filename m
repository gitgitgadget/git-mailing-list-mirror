Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D142C77B61
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 13:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbjDGN5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjDGN4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 09:56:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E311A6
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 06:56:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso870834wmb.1
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680875764;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bVNKJJEWP0HXn5Hc8SjAw0qysxWg/QtJkd3pBYzR3tQ=;
        b=QUVU+jJYk25Ygny6LuRdL5/3irYKZsILYsRVrGLeJSgxwniCzho4zZ4oFgtdn5xMLL
         RGNaUWuJOwHPThJetPMPj64q16M4y95r8/B3vxBXhA3TYutYlXJwtCyc7zBU5egCB0L9
         LXoLO7wc+DQVo499CFqwr+j2eG1rWSQPVqh6zoK4rNB3WS54Q6AM/8luK3cwnfxFdxFh
         35X75YrSHPdF+2kwO5EfO/dvx8f6ET+OE6se8aY3m4Iv/x1SLKVzh0JDQF0TG2jhpjvj
         KqzRkFN4a3RICzNkfuPXZj6HgcmiPZ3jU4qUl1L6D4/Xnt2JJExjq3aeh7ETSkM90Es3
         5lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680875764;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVNKJJEWP0HXn5Hc8SjAw0qysxWg/QtJkd3pBYzR3tQ=;
        b=nNKApCcmZwEIk+ajPL/ozQGja0MlKS/gZz3kLWgi0BSBj9sctJTYL7ouAcUItKYNZv
         HbLgZfe/sSSN2D3L4ri/Jxqc2+GrjqFjeIb/WamviS0lh/ckxB/O6G79mxMrJF+M7CPe
         5++8ecMMEYUggyx7D6VO0tw158jBOybgvVvC3V9LeSbdH+d9flIIA+QBBV586hgKX9hI
         3cYOxXh/oOwY4xEEFWETZXPsHXoPVE/8fbhHQeBm8Mn9Xrq944S+ysve346X6eyhUgJw
         mGz9OBfl244Z326gUV+0cI5G9yJOEMnIwP3XkbQM0dFsjoOUGWzKqxVO6psVIciJKVUg
         +I2w==
X-Gm-Message-State: AAQBX9coOvmdjAocQ9nGog3ktdBO1jMEsSIS3AY32LgU7puoX5qVXTkP
        ewxOSgof3WUKPdN4Aeu14GT8eidcfpM=
X-Google-Smtp-Source: AKy350b6OXJt279EsPpldguV0eJWcS9PqJxX1M65JSPjNI+g5Qyxs4YIODDFuv06YPFdZxCdweskmg==
X-Received: by 2002:a1c:c911:0:b0:3ed:d3a7:7077 with SMTP id f17-20020a1cc911000000b003edd3a77077mr1293921wmb.40.1680875764100;
        Fri, 07 Apr 2023 06:56:04 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id p15-20020a1c740f000000b003edc11c2ecbsm4742003wmc.4.2023.04.07.06.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:56:03 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 3/5] rebase -m: cleanup --strategy-option handling
Date:   Fri,  7 Apr 2023 14:55:33 +0100
Message-Id: <e98ef5ce8cb5245d432cc88f72aa9a7b160077e3.1680875701.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.670.g64ef305212.dirty
In-Reply-To: <cover.1680875701.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1680875701.git.phillip.wood@dunelm.org.uk>
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

Reviewed-by: Elijah Newren <newren@gmail.com>
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

