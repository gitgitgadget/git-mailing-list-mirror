Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FA1C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 09:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDJJJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 05:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjDJJI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 05:08:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3EE49D2
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so2321778wms.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681117732;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YAXDtuxrkXDfAWYZZ3PsZAOb0yJupmeDY+Vzg+bzOP8=;
        b=NqyY9SAr88HbWHxwUBho8S6/MhZPgM1vGQ98ilaGPJZCiZ9mC0+KJHQ0tjJAvfmTfr
         AHOPeYwhX/Six9hW019PlKyO+A+pfXqogFR02e2oSPzK7S+3J7v/xbIJbvAgR8nuMZFX
         U23qV8BgbQYBvfTREM7+B9R42TZtFoqZSu1VvUGhjBwurJj//3rRyMs27y4AyMwc2rSs
         BLi3BID9Hfu9Xn0jPwd2IsoutpEqbXfKoD0+xPYQ/yowmVlGEKw7a9VH2SUzqakPwrbz
         PEsqrLsfLaHMW7PEV4ZlabiNuEKI0do7UDIVoWp0H6GH2svn65uWwEu42rjf2A7xvt4W
         qRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681117732;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YAXDtuxrkXDfAWYZZ3PsZAOb0yJupmeDY+Vzg+bzOP8=;
        b=oFrx4hHq/5Lftlkvth5/En/PtUvTtYxIyY42lWizY4lLdtcARdFcpo1KoxCNrzrN80
         57aDXPfHpo6MiMuUOW9a3OjX/zS6HFOcHCTyE65/FU71lczYfdTll9kz6lDZ2lTHAiTI
         iQVd20B2Ma7iQMcmtJN4Lst+8WIw6X5qI4mD5WRWjQhnOULuAyqdG4FGu0gjv18+kc5i
         R4OnLJU4mhD5aBcOGbgvrgqGrnyA6+4noFJxn1KmoAfqSnipQdgccDon/qGewb82g3tn
         TGEomOT8D38izNh0XBLonIU7e+BVOCp+39AHHWcEXnfDLo2r0io+094bNEtJt1vJ/w8Q
         FduA==
X-Gm-Message-State: AAQBX9fKGhNdSqXQxPo5DyDrOba88fZR3wUGTBLoyzf/rmHS4AoFajbv
        xyR+OuvS5CTUiq7Ix35h6l9tW9WVbiY=
X-Google-Smtp-Source: AKy350YNzSo+tNI38X2kmRI7tQxZJ0nF7UXnQtZGRZIw+wnhgPQB4A/vgMvV9hcm731cdVSnD6yRFw==
X-Received: by 2002:a7b:cd93:0:b0:3ea:e4f8:be09 with SMTP id y19-20020a7bcd93000000b003eae4f8be09mr4274119wmj.30.1681117731970;
        Mon, 10 Apr 2023 02:08:51 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b003f034c76e85sm17232568wmg.38.2023.04.10.02.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 02:08:51 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 3/5] rebase -m: cleanup --strategy-option handling
Date:   Mon, 10 Apr 2023 10:08:29 +0100
Message-Id: <4e040c1214e133be2a614eb85380f582118ff246.1681117706.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.672.gbd2d2ac924
In-Reply-To: <cover.1681117706.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1681117706.git.phillip.wood@dunelm.org.uk>
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
index 50d469812a..587a473d6e 100644
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
2.40.0.672.gbd2d2ac924

